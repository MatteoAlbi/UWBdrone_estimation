/*! ----------------------------------------------------------------------------
*  @file    communication_python.h
*  @brief   This file contains all the functions prototypes for the
 *           communication_python.c library.
*
* 
* @attention
*
*
* @authors	Matteo Albi:            matteo.albi@studenti.unitn.it
*/

#ifndef PY_COM
#define PY_COM


#include <stdio.h>
#include <math.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>

#include "nrf_delay.h"
#include "linear_algebra.h"
#include "../common/config.h"
#include "lis2dh12_reg.h"
#include "lis2mdl_reg.h"
#include "app_uart.h"
#include "fds_manager.h"


#pragma region /* Macro ---------------------------------------------------------*/
// -- precompliation instruction
#define PYCOM_LITTLE_ENDIAN
#define PYCOM_DEBUG_ON

// -- package struct
#define   PYCOM_HEAD              0x55U
#define   PYCOM_TAIL              0x55U

// -- errors
#define   PYCOM_NO_ERROR                0
#define   PYCOM_NO_HEAD                 1
#define   PYCOM_NO_TAIL                 2
#define   PYCOM_CMD_ERR                 3
#define   PYCOM_CMD_NOT_FOUND           4
#define   PYCOM_PAYLOAD_LEN_ERR         5
#define   PYCOM_PAYLOAD_ERR             6
#define   PYCOM_REQUEST_CONFLICT_ERR    7
#define   PYCOM_STREAM_ERR              8
#define   PYCOM_WRITE_ERR               9

#define   PYCOM_TIMEOUT_B_ERR     11
#define   PYCOM_TIMEOUT_PCK_ERR   12
#define   PYCOM_TIMEOUT_CMD_ERR   13

// -- commands from master
#define   PYCOM_STOP_CMD          0x00U
#define   PYCOM_WAIT_CMD          0x01U
#define   PYCOM_STREAM_WIN        0x02U 
#define   PYCOM_START             0x03U
#define   PYCOM_EXIT              0x04U

#define   PYCOM_STREAM_FILTER     0x11U
#define   PYCOM_STREAM_ACC        0x12U
#define   PYCOM_STREAM_MAG        0x13U
#define   PYCOM_STREAM_RTDOA      0x14U
#define   PYCOM_STREAM_ACC_MAG    0x15U

#define   PYCOM_DEBUG_CMD         0x99U

// type of packages from master
#define   PYCOM_ACC_BIAS          0x21U
#define   PYCOM_ACC_SCALE         0x22U
#define   PYCOM_MAG_HI            0x23U
#define   PYCOM_MAG_SI1           0x24U
#define   PYCOM_MAG_SI2           0x25U
#define   PYCOM_MAG_SI3           0x26U
#define   PYCOM_ACC_UNC           0x27U
#define   PYCOM_MAG_UNC           0x28U
#define   PYCOM_POS_UNC           0x29U

// -- answers
#define   PYCOM_ACK               0x00U
#define   PYCOM_ERR               0xffU
#define   PYCOM_SEND_UINT16       0x01U
#define   PYCOM_SEND_FLOAT        0x02U
#define   PYCOM_SEND_STRING       0x03U

#pragma endregion


#pragma region /* Typedef --------------------------------------------------------*/
typedef int32_t (*pycom_get_float_pl_func_ptr)(float *);

typedef union{
  float f;
  uint8_t buf[4];
} pycom_f_B_conv;

typedef union{
  uint16_t u16;
  uint8_t buf[2];
} pycom_f_uint16_conv;

#pragma endregion


#pragma region /* Functions --------------------------------------------------------*/

/**
  * @brief  show error message
  * 
  * @param err          error to show
  *
  */
void pycom_check_error(uint8_t err);


/**
 * @brief Get the acc and mag data from sensors and assign them to passed 
 *        pointer (6 floa in total)
 * 
 * @param buf pointer to wich assign the data
 * @return int32_t error code
 */
int32_t pycom_get_acc_mag(float *buf);


#pragma region // -- communication write

/**
  * @brief  write a package with a float payload on the uart
  * 
  * @param id           id of the package command
  * @param len          n float to send
  * @param pl           pointer to array of float to send
  * @retval             NO_ERROR if write is successful
  *                     ERR (from function app_uart_put) if error
  *                         occured in writing process
  *
  */
uint32_t pycom_write_pck_f(uint8_t id, uint8_t len, float * pl);


/**
  * @brief  write a package with a uint16 payload on the uart
  * 
  * @param id           id of the package command
  * @param len          n float to send
  * @param pl           pointer to array of uint16 to send
  * @retval             NO_ERROR if write is successful
  *                     ERR (from function app_uart_put) if error
  *                         occured in writing process
  *
  */
uint32_t pycom_write_pck_uint16(uint8_t id, uint8_t len, uint16_t * pl);


/**
  * @brief  write a package with a uint8 payload on the uart
  * 
  * @param id           id of the package command
  * @param len          n float to send
  * @param pl           pointer to array of uint8 to send
  * @retval             NO_ERROR if write is successful
  *                     ERR (from function app_uart_put) if error
  *                         occured in writing process
  *
  */
uint32_t pycom_write_pck_uint8(uint8_t id, uint8_t len, uint8_t * pl);


/**
  * @brief write a package with only the command (no payload)
  * 
  * @param id           id of the package command
  * @retval             NO_ERROR if write is successful
  *                     ERR (from function app_uart_put) if error
  *                         occured in writing process
  *
  */
uint32_t pycom_write_pck_cmd(uint8_t id);


/**
 * @brief function to send a stream of packages with float payload.
 *        The function starts sending a number of packages equal to stream_len.
 *        During execution, read packages at every cycle and parse them. If 
 *        the package is a STREAM_CMD, it increases the stream_len, if it's a 
 *        STOP_CMD, the stream is stopped.
 * 
 * @param stream_len      initial number of packages to be sent 
 * @param pl_len          length of the payload to send in each package
 * @param get_float_pl    pointer to function used to get the float data to send
 * @param byte_timeout    timeout when reading a byte
 * @param delay           dealy between each sent package [ms]
 * @return uint32_t       NO_ERROR if write is successful
 *                        ERR (from function app_uart_put) if error
 *                            occured in writing/reading process
 */
uint32_t pycom_stream_pck_f(uint16_t stream_len, uint8_t pl_len, 
                      pycom_get_float_pl_func_ptr get_float_pl, 
                      uint16_t byte_timeout, uint16_t delay);

#pragma endregion


#pragma region // -- communication read

/**
  * @brief  read a byte from the uart, with a defined timeout [ms]
  *         saves the byte in global variable pycom_uart_msg
  * 
  * @param timeout      timeout of the byte reading process
  * @retval             NRF_SUCCESS if byte has been read successfully
  *                     ERR (from function app_uart_get) if error
  *                         occured in reading byte
  *                     TIMEOUT_B_ERR if after waiting "timeout" no
  *                         byte has been recevied
  *
  */
uint32_t pycom_read_byte(uint16_t timeout);


/**
  * @brief  read the uint16 payload bytes of the package, convert and saves
  *         them in float and saves it in the private variable pck_pl_f
  * 
  * @param byte_timeout     timeout of the byte reading process
  * @retval                 NRF_SUCCESS if payload has been read successfully
  *                         ERR (from function app_uart_get) if error
  *                             occured in reading byte
  *                         TIMEOUT_B_ERR if after waiting "timeout" no
  *                             byte has been recevied
  *
  */
uint32_t pycom_read_payload_f(uint16_t byte_timeout);


/**
 * @brief  read the uint16 payload bytes of the package, convert and saves
 *         them in uint16 and saves it in the private variable pck_pl_uint16
 * 
 * @param byte_timeout      timeout of the byte reading process
 * @return uint32_t         NRF_SUCCESS if payload has been read successfully
 *                          ERR (from function app_uart_get) if error
 *                              occured in reading byte
 *                          TIMEOUT_B_ERR if after waiting "timeout" no
 *                              byte has been recevied
 */
uint32_t pycom_read_payload_uint16(uint16_t byte_timeout);


/**
  * @brief  read a package from the uart, with a defined byte_timeout [ms]
  *         to read each byte. It keeps reading bytes until HEAD is found,
  *         then saves the following bytes in the global variables cmd_id
  *         and pck_len. If needed (pck_len>0) also read the payload using
  *         function pycom_read_payload_f (if the package has float payload). Then,
  *         if the last byte corresponds to TAIL, set the global variable 
  *         pck_read_flag = true;
  * 
  * @param byte_timeout     timeout to read each package byte
  * @retval                 NRF_SUCCESS if package has been read successfully
  *                         ERR (from function app_uart_get) if error
  *                             occured in reading byte
  *                         TIMEOUT_B_ERR if after waiting "timeout" no
  *                             byte has been recevied
  *                         PAYLOAD_LEN_ERR if the extracted pck_len doesn't
  *                             match the expected lenght of the cmd_id
  *                         CMD_ERR if pck_len != 0 even if the cmd_id doesn't
  *                             expect any payload
  *                         NO_TAIL if after payload, the read byte is not a tail
  *
  */
uint32_t pycom_read_pck(uint16_t byte_timeout);


/**
  * @brief  parse the pck data after a pck has been fully read (pck_read_flag = true)
  *         and launch the correct routine/action
  * 
  * @retval                 NRF_SUCCESS routine/action completed successfully
  *                         ERR (from routine) if error occured during routine/action
  *                         CMD_ERR if id not recognised
  *                         MAN_FDS_ERROR definition, in an error occures during the 
  *                             tthe setting of the sensors config
  *
  */
uint32_t pycom_parse_pck();


/**
  * @brief  wait for a package to be read until pck_timeout has been reached.
  *         Iteratively tries to read a package while the returned error is a 
  *         TIMEOUT_B_ERR, otherwise return the error. Upon reaching timeout, 
  *         return TIMEOUT_PCK_ERR.
  *         If the full package has been correctly received, it starts the parsing.
  * 
  * @param byte_timeout     timeout to read each package byte
  * @param pck_timeout      timeout to receive the pck
  * @retval                 NO_ERROR if package parsed correctly
  *                         TIMEOUT_PCK_ERR if pck timeout has been reached
  *                         ERR from pycom_read_pck (if error in rading phase)
  *                         ERR from pycom_parse_pck (if error in parsing phase)
  *
  */
uint32_t pycom_wait_for_pck(uint16_t byte_timeout, uint16_t pck_timeout);


/**
  * @brief  wait for a package to be parsed and an action/routine selected
  *         until cmd_timeout has been reached.
  *         Iteratively waits for a package while the returned error is a 
  *         TIMEOUT_PCK_ERR, otherwise return the error. Upon reaching timeout, 
  *         return TIMEOUT_CMD_ERR.
  * 
  * @param byte_timeout     timeout to read each package byte
  * @param pck_timeout      timeout to read the pck
  * @param cmd_timeout      timeout to receive a command
  * @retval                 NO_ERROR if command received and executed
  *                         TIMEOUT_CMD_ERR if pck timeout has been reached
  *                         ERR from pycom_read_pck (if error in rading phase)
  *                         ERR from pycom_parse_pck (if error in parsing phase)
  *
  */
uint32_t pycom_wait_for_command(uint16_t byte_timeout, uint16_t pck_timeout, uint16_t cmd_timeout);

#pragma endregion


void pycom_start(uint16_t byte_timeout, uint16_t pck_timeout, uint16_t menu_timeout);


#pragma endregion

#endif