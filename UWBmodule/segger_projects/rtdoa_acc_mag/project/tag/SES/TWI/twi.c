/*!
* @brief Component name:	TWI
*
* Two Wire Interface (I2C) driver.
* Single threaded version blocks with CPU in
* sleep mode until TWI transfer complete event
* occurs.
*
* @file TWI.c
*/

#include <stdio.h>
#include "app_util_platform.h"
#include "app_error.h"
#include "nrf_drv_twi.h"
#include "nrf_drv_gpiote.h"
#include "twi.h"


// DWM1001 module TWI pin allocation, P0.28, P0.29
#define	TWI_SCL	28
#define	TWI_SDA	29

// Local symbolic constants
#define TWI_INSTANCE_ID		0

// Local variables
// TWI instance structure for Nordic nrf device driver.
static const nrf_drv_twi_t m_twi = NRF_DRV_TWI_INSTANCE(TWI_INSTANCE_ID);

// Semaphore: true if TWI transfer operation has completed
static volatile bool boTransferDone = false;

static ret_code_t twi_err_code;

// *** Local function declarations
static void vSetSubAdd		(uint8_t u8devAdrs, uint8_t u8RegAdrs);
static void vEventHandler	(nrf_drv_twi_evt_t const * p_event, void * p_context);
static void vWaitForEvent	(void);

// Public Interface Functions

/*!
* @brief Initialise the nRF52 TWI block
*
* Initialises the TWI bus connected to the LIS2DH12 accelerometer.
* No higher layer initialisation options supported.
* For RTOS version the interrupt priority level would need changing.
*/
void vTWI_Init(void)
{
	const nrf_drv_twi_config_t twi_config = {
		.scl                = TWI_SCL,
		.sda                = TWI_SDA,
		.frequency          = NRF_TWI_FREQ_400K,
		.interrupt_priority = APP_IRQ_PRIORITY_HIGHEST,
		.clear_bus_init     = false
	};

	twi_err_code = nrf_drv_twi_init(&m_twi, &twi_config, vEventHandler, NULL);
	APP_ERROR_CHECK(twi_err_code);

	nrf_drv_twi_enable(&m_twi);
}


/*
* void vTWI_Write (uint8_t u8devAdrs, uint8_t u8RegAdrs, uint8_t u8data)
* 
* Parameters.
* u8devAdrs: I2C device address where to write
* u8RegAdrs: address of the register where to write
* u8data: data to write at address
*
* !!! --- Does not work! Probably there is a problem with memcpy function or
*         or dynamic allocation (always write 0x00)
*
* Returns: void
*/
ret_code_t vTWI_Write(uint8_t u8devAdrs, uint8_t u8RegAdrs, const uint8_t *u8data, uint8_t u8length)
{
	uint8_t *au8addData;

	au8addData = (uint8_t*)calloc((u8length + 1), sizeof(uint8_t));

	if(au8addData == NULL) {

		return(1);

	} else {

		au8addData[0] = u8RegAdrs;
		memcpy(&au8addData[1], u8data, u8length);

		boTransferDone = false;
		twi_err_code = nrf_drv_twi_tx(&m_twi, u8devAdrs, au8addData, u8length + 1, false);

		APP_ERROR_CHECK(twi_err_code);

		free(au8addData);

		while (! boTransferDone);
		//vWaitForEvent();
		return(twi_err_code);
    }
}


/*
* void vTWI_Read (uint8_t u8subAdd, uint8_t *pu8readData)
* 
* Parameters.
* u8devAdrs: I2C device address where to write
* u8subAdd: address of the register where to read
* pu8readData: pointer to buffer for data read from address
*
* Returns: void
*/
ret_code_t vTWI_Read (uint8_t u8devAdrs, uint8_t u8RegAdrs, uint8_t *pu8readData, uint8_t u8length){       

  vSetSubAdd(u8devAdrs, u8RegAdrs);

  boTransferDone = false;
  twi_err_code = nrf_drv_twi_rx(&m_twi, u8devAdrs, pu8readData, u8length);
  APP_ERROR_CHECK(twi_err_code);


  while (! boTransferDone);
  //vWaitForEvent();
  return(twi_err_code);
}

/* --- Local scope functions */

// Sets sub address for read operation following initial TWI comand write.
static void vSetSubAdd(uint8_t u8devAdrs, uint8_t u8RegAdrs){

  boTransferDone = false; 
  twi_err_code = nrf_drv_twi_tx(&m_twi, u8devAdrs, &u8RegAdrs, 1, false);
  APP_ERROR_CHECK(twi_err_code);

  while (! boTransferDone);
  //vWaitForEvent();
}

/*
* Interrupt event handler for TWI.
* Expecting events for read and write transfers complete,
* anything else is an error condition.
* Transfer complete sets a semaphore (boTransferDone) to 
* release the MCU from __WFE sleep mode.
*/
static void vEventHandler(nrf_drv_twi_evt_t const * p_event, void * p_context)
{
  switch (p_event->type)
  {
    case NRF_DRV_TWI_EVT_DONE:
    {
      switch (p_event->xfer_desc.type)
      {
        case NRF_DRV_TWI_XFER_TX:
        case NRF_DRV_TWI_XFER_RX:{

          boTransferDone = true;
          break;
        }
        default:
          printf("unknown xfer_desc.type: %x\n", p_event->xfer_desc.type);
          break;
      }
      break;
    }
    default:
      printf("Unknown event type: %x\n", p_event->type);
      break;
  }
}

/*
* void vWaitForEvent(void)
*
* For single-threaded systems, this function blocks until the
* TWI transfer complete interrupt occurs. Whilst waiting, the
* CPU enters low-power sleep mode.
*
* For multi-threaded (RTOS) builds, this function would suspend
* the thread until the transfer complete event occurs.
*/

static void vWaitForEvent(void)
{
	do
	{
		__WFE();
	}
	while (! boTransferDone);
}


// ADD by Matteo Albi


// preallocate buffer to prepare package to send in write phase
static uint8_t vTWI_Write_buffer[8];
/*
* void vTWI_Write_my (uint8_t u8devAdrs, uint8_t u8RegAdrs, uint8_t u8data)
* 
* Parameters.
* u8devAdrs: I2C device address where to write
* u8RegAdrs: address of the register where to write
* u8data: data to write at address
*
* !!! -- General case does not work! Probably there is a problem with memcpy function
*
* Returns: void
*/
ret_code_t vTWI_Write_my(uint8_t u8devAdrs, uint8_t u8RegAdrs, const uint8_t *u8data, uint8_t u8length)
{
      /*
      * case u8length = 1
      *
      uint8_t au8addData[2];
      au8addData[0] = u8RegAdrs;
      au8addData[1] = *u8data;

      boTransferDone = false;
      twi_err_code = nrf_drv_twi_tx(&m_twi, u8devAdrs, au8addData, sizeof(au8addData), false);

      APP_ERROR_CHECK(twi_err_code);

      while (! boTransferDone);
      //vWaitForEvent();
      return(twi_err_code);
      */

      vTWI_Write_buffer[0] = u8RegAdrs;
      for(uint8_t i=0; i<u8length; i++) vTWI_Write_buffer[1 + i] = u8data[i];

      boTransferDone = false;
      twi_err_code = nrf_drv_twi_tx(&m_twi, u8devAdrs, vTWI_Write_buffer, u8length + 1, false);

      APP_ERROR_CHECK(twi_err_code);

      while (! boTransferDone);
      //vWaitForEvent();
      return(twi_err_code);

}