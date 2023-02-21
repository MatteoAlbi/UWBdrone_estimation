/*! ----------------------------------------------------------------------------
 *  @file    fds_manager.h
 *  @brief   This file contains all the functions prototypes for the
 *           fds_manager.c library.
 *
 * 
 * @attention Record keys should be in the range 0x0001 - 0xBFFF
 *            File IDs should be in the range 0x0000 - 0xBFFF
 *
 *
 * @authors	Matteo Albi:            matteo.albi@studenti.unitn.it
 */

#ifndef FDS_MAN
#define FDS_MAN

#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>

#include "fds.h"
#include "nrf_fstorage.h"

#include "nrf_delay.h"
#include "../common/config.h"
#include "bsp.h"
#include "app_error.h"
#include "nrf_soc.h"


#pragma region /* Macros -----------------------------------------------------------*/
// file IDs
#define MAN_FDS_ACC_FILE    0x1111U
#define MAN_FDS_MAG_FILE    0x1112U
#define MAN_FDS_UWB_FILE    0x1113U
// record keys
#define MAN_FDS_CONFIG_REC  0x1111U

#pragma endregion


#pragma region /* Structs ----------------------------------------------------------*/

// data structures to save in flash
typedef struct {
    float     bias[3];
    float     scale[3];
    float     unc[3];
} man_fds_acc_t;

typedef struct {
    float     hard_iron[3];
    float     soft_iron[9];
    float     unc[3];
} man_fds_mag_t;

typedef struct {
    float     unc[3];
} man_fds_uwb_t;

#pragma endregion


#pragma region /* Functions --------------------------------------------------------*/

/**
  * @brief Function for the Power manager. Sleep until an event is received.
  */
static void man_fds_power_manage(void);


/**
  * @brief Flash storage event handler
  */
static void man_fds_evt_handler(fds_evt_t const * p_evt);


/**
 * @brief select data in flash memory on file_id and key specified in p_record, and load
 *        data in p_record->data.pdata. If no record with given file_id and key is found,
 *        the data in p_record is written on flash instead
 * 
 * @param p_record      pointer to record variable 
 * @return ret_code_t   FDS_SUCCESS if operation compelted successfully
 *                      fds_error_code if during find/open/close/write processes an error 
 *                              occured
 */
ret_code_t man_fds_load_config (const fds_record_t * p_record);


/**
 * @brief update data in flash memory with data stored in p_record
 * 
 * @param p_record      pointer to record variable 
 * @return ret_code_t   FDS_SUCCESS if operation compelted successfully
 *                      fds_error_code if during find/open/close/write/update processes
 *                              an error occured
 */
ret_code_t man_fds_update_config (const fds_record_t * p_record);


/**
  * @brief Flash storage manager init: initialize the module,
  *         run the garbage collector if needed, and load sensors config
  *         data from flash to local variables
  * 
  * @return ret_code_t error code
  */
ret_code_t man_fds_init(void);


/**
 * @brief Load all sensors configurations from flash memory to local variables
 * 
 * @return ret_code_t error code from man_fds_load_config
 */
ret_code_t man_fds_load_config_all(void);


#pragma region // -- delete function

/**
  * @brief using an interator, delete next record (wrt previous iteration)
  * 
  * @return ret_code_t error code
  */
ret_code_t record_delete_next(void);


/**
 * @brief function to manage the iterative call of record_delete_next.
 * 
 * @return ret_code_t error code
 */
ret_code_t man_fds_delete_all_process(void);


/**
 * @brief delete all records in flash memory looping the man_fds_delete_all_process function.
 *        Always wait for every delete request to finish
 * 
 * @return ret_code_t error code
 */
ret_code_t man_fds_delete_all(void);


/**
 * @brief call the garbage collector and wait for process to finish
 * 
 * @return ret_code_t error code
 */
ret_code_t man_fds_gc(void);

#pragma endregion


#pragma region // -- accelerometer

/**
 * @brief return a const pointer to local static variable man_fds_acc
 * 
 * @return const man_fds_acc_t* const  
 */
const man_fds_acc_t * const man_fds_get_acc_config (void);


/**
 * @brief set the bias value of the local static variable man_fds_acc 
 *        to the passed values
 * 
 * @param ab value at which set the bias
 * @return ret_code_t error code from man_fds_update_config
 */
ret_code_t man_fds_set_acc_bias(float* ab);


/**
 * @brief set the uncertainty value of the local static variable man_fds_acc 
 *        to the passed values
 * 
 * @param au value at which set the uncertainty
 * @return ret_code_t error code from man_fds_update_config
 */
ret_code_t man_fds_set_acc_unc(float* au);

#pragma endregion


#pragma region // -- magnetometer

/**
 * @brief return a const pointer to local static variable man_fds_mag
 * 
 * @return const man_fds_mag_t* const  
 */
const man_fds_mag_t * const man_fds_get_mag_config (void);


/**
 * @brief set the hard_iron value of the local static variable man_fds_mag 
 *        to the passed values
 * 
 * @param si value at which set the hard_iron
 * @return ret_code_t error code from man_fds_update_config
 */
ret_code_t man_fds_set_mag_hi(float* hi);


/**
 * @brief set the soft_iron value of the local static variable man_fds_mag 
 *        to the passed values
 * 
 * @param si value at which set the soft_iron
 * @return ret_code_t error code from man_fds_update_config
 */
ret_code_t man_fds_set_mag_si(float* si);


/**
 * @brief set the uncertainty value of the local static variable man_fds_mag 
 *        to the passed values
 * 
 * @param mu value at which set the uncertainty
 * @return ret_code_t error code from man_fds_update_config
 */
ret_code_t man_fds_set_mag_unc(float* mu);

#pragma endregion


#pragma region // -- uwb

/**
 * @brief return a const pointer to local static variable man_fds_uwb
 * 
 * @return const man_fds_uwb_t* const 
 */
const man_fds_uwb_t * const man_fds_get_uwb_config (void);


/**
 * @brief set the uncertainty value of the local static variable man_fds_uwb 
 *        to the passed values
 * 
 * @param uu value at which set the uncertainty
 * @return ret_code_t error code from man_fds_update_config
 */
ret_code_t man_fds_set_uwb_unc(float* uu);

#pragma endregion


#pragma endregion


#endif