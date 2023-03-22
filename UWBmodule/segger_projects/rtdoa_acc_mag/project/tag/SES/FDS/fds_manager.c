/*! ----------------------------------------------------------------------------
*  @file    fds_manager.c
*  @brief   Implementation of read and write function on flash storage to memorize
*           sensors calibration and filter data
*
* 
* @attention
*
*
* @authors	Matteo Albi:            matteo.albi@studenti.unitn.it
*/

#include "fds_manager.h"


#pragma region /* Private variables ----------------------------------------------*/

/* Keep track of the progress of a delete_all operation. */
static struct
{
    bool delete_next;   //!< Delete next record.
    bool pending;       //!< Waiting for an fds FDS_EVT_DEL_RECORD event, to delete the next record.
} man_fds_delete_all_struct;

// hendler functions flags
static bool volatile man_fds_init_flag = false;
static bool volatile man_fds_wait4event_flag = false;
static bool volatile man_fds_write_err_flag = false;
static bool volatile man_fds_update_err_flag = false;
static bool volatile man_fds_delete_err_flag = false;
static bool volatile man_fds_gc_err_flag = false;

// variable where store flash mem stats
static fds_stat_t man_fds_stat = {0};

#pragma region // string conversion variables

/* Array to map FDS return values to strings. */
// char const * man_fds_err_str[] =
// {
//     "FDS_SUCCESS",
//     "FDS_ERR_OPERATION_TIMEOUT",
//     "FDS_ERR_NOT_INITIALIZED",
//     "FDS_ERR_UNALIGNED_ADDR",
//     "FDS_ERR_INVALID_ARG",
//     "FDS_ERR_NULL_ARG",
//     "FDS_ERR_NO_OPEN_RECORDS",
//     "FDS_ERR_NO_SPACE_IN_FLASH",
//     "FDS_ERR_NO_SPACE_IN_QUEUES",
//     "FDS_ERR_RECORD_TOO_LARGE",
//     "FDS_ERR_NOT_FOUND",
//     "FDS_ERR_NO_PAGES",
//     "FDS_ERR_USER_LIMIT_REACHED",
//     "FDS_ERR_CRC_CHECK_FAILED",
//     "FDS_ERR_BUSY",
//     "FDS_ERR_INTERNAL",
// };

// /* Array to map FDS events to strings. */
// static char const * man_fds_evt_str[] =
// {
//     "FDS_EVT_INIT",
//     "FDS_EVT_WRITE",
//     "FDS_EVT_UPDATE",
//     "FDS_EVT_DEL_RECORD",
//     "FDS_EVT_DEL_FILE",
//     "FDS_EVT_GC",
// };

#pragma endregion

#pragma region // initialize data structures
static man_fds_acc_t man_fds_acc = {
  .bias = {0.0, 0.0, 0.0},
  .scale = {1.0, 1.0, 1.0},
  .unc = {0.1, 0.1, 0.1},
};

static man_fds_mag_t man_fds_mag = {
  .hard_iron = {0.0, 0.0, 0.0},
  .soft_iron = {1.0, 0.0, 0.0, 
                0.0, 1.0, 0.0,
                0.0, 0.0, 1.0},
  .unc = {0.1, 0.1, 0.1},
};

static man_fds_uwb_t man_fds_uwb = {
  .unc = {0.1, 0.1, 0.1},
};

#pragma endregion

#pragma region // initialize records
static fds_record_t const man_fds_acc_rec = {
  .file_id           = MAN_FDS_ACC_FILE,
  .key               = MAN_FDS_CONFIG_REC,
  .data.p_data       = &man_fds_acc,
  /* The length of a record is always expressed in 4-byte units (words). */
  .data.length_words = sizeof(man_fds_acc_t) / sizeof(uint32_t),
};

static fds_record_t const man_fds_mag_rec = {
  .file_id           = MAN_FDS_MAG_FILE,
  .key               = MAN_FDS_CONFIG_REC,
  .data.p_data       = &man_fds_mag,
  /* The length of a record is always expressed in 4-byte units (words). */
  .data.length_words = sizeof(man_fds_mag_t) / sizeof(uint32_t),
};

static fds_record_t const man_fds_uwb_rec = {
  .file_id           = MAN_FDS_UWB_FILE,
  .key               = MAN_FDS_CONFIG_REC,
  .data.p_data       = &man_fds_uwb,
  /* The length of a record is always expressed in 4-byte units (words). */
  .data.length_words = sizeof(man_fds_uwb_t) / sizeof(uint32_t),
};

#pragma endregion

#pragma endregion


#pragma region /* Functions --------------------------------------------------------*/

static void man_fds_power_manage(void) {
#ifdef SOFTDEVICE_PRESENT
    (void) sd_app_evt_wait();
#else
    __WFE();
#endif
}


static void man_fds_evt_handler(fds_evt_t const * p_evt) {

    switch (p_evt->id) {
        case FDS_EVT_INIT:
            if (p_evt->result == FDS_SUCCESS) man_fds_init_flag = true;
            else man_fds_init_flag = false;
            break;

        case FDS_EVT_WRITE:
            if (p_evt->result != FDS_SUCCESS) man_fds_write_err_flag = true;
            else man_fds_write_err_flag = false;
            break;

        case FDS_EVT_UPDATE:
            if (p_evt->result != FDS_SUCCESS) man_fds_update_err_flag = true;
            else man_fds_update_err_flag = false;
            break;

        case FDS_EVT_DEL_RECORD:
            if (p_evt->result != FDS_SUCCESS) man_fds_delete_err_flag = true;
            else man_fds_delete_err_flag = false;

            man_fds_delete_all_struct.pending = false;
            break;

        case FDS_EVT_GC:
            if (p_evt->result != FDS_SUCCESS) man_fds_gc_err_flag = true;
            else man_fds_gc_err_flag = false;
            break;

        default:
            break;
    }
    man_fds_wait4event_flag = false;
}


ret_code_t man_fds_load_config (const fds_record_t * p_record){
    // variables for find function
    fds_record_desc_t desc = {0};
    fds_find_token_t  tok  = {0};
    // variable for open function
    fds_flash_record_t open_record = {0};

    // find record in flash
    ret_code_t err = fds_record_find(p_record->file_id, p_record->key, &desc, &tok);
    
    if(err == FDS_ERR_NOT_FOUND){ // not found -> init with current data

        // write current data 
        man_fds_wait4event_flag = true;
        err = fds_record_write(&desc, p_record);
        // wait for write to finish
        while(man_fds_wait4event_flag) man_fds_power_manage();

        if(err == FDS_ERR_NO_SPACE_IN_FLASH){ // no space
            // call garbage collector
            err = man_fds_gc();
            if(err) return err;

            // retry the write
            man_fds_wait4event_flag = true;
            err = fds_record_write(&desc, p_record);
            // wait for write to finish
            while(man_fds_wait4event_flag) man_fds_power_manage();

            if(err) return err;
        }
        else if(err != FDS_SUCCESS) return err; // other errors
    } 
    else if(err == FDS_SUCCESS){ // found -> read data
        err = fds_record_open(&desc, &open_record);
        if (err) return err;

        // copy data from flash in private variable
        memcpy(p_record->data.p_data, open_record.p_data, p_record->data.length_words * sizeof(uint32_t));

        // close the record
        err = fds_record_close(&desc);
        if(err) return err;
    }
    else return err; // other errors

    return FDS_SUCCESS;
}


ret_code_t man_fds_update_config (const fds_record_t * p_record){
    // variables for find function
    fds_record_desc_t desc = {0};
    fds_find_token_t  tok  = {0};
    // variable for open function
    fds_flash_record_t open_record = {0};

    // find record in flash
    ret_code_t err = fds_record_find(p_record->file_id, p_record->key, &desc, &tok);
    if(err == FDS_ERR_NOT_FOUND) { // write new record
        // write current data 
        man_fds_wait4event_flag = true;
        err = fds_record_write(&desc, p_record);
        // wait for write to finish
        while(man_fds_wait4event_flag) man_fds_power_manage();

        if(err == FDS_ERR_NO_SPACE_IN_FLASH){ // no space
            // call garbage collector
            err = man_fds_gc();
            if(err) return err;

            // retry the write
            man_fds_wait4event_flag = true;
            err = fds_record_write(&desc, p_record);
            // wait for write to finish
            while(man_fds_wait4event_flag) man_fds_power_manage();

            if(err) return err;
        }
        else if(err != FDS_SUCCESS) return err; // other errors
    }
    else if(err == FDS_SUCCESS) { // update record
        // update record in flash
        man_fds_wait4event_flag = true;
        err = fds_record_update(&desc, p_record);
        // wait for update to finish
        while(man_fds_wait4event_flag) man_fds_power_manage();

        if(err == FDS_ERR_NO_SPACE_IN_FLASH){ // no space
            // call garbage collector
            err = man_fds_gc();
            if(err) return err;

            // retry the update
            man_fds_wait4event_flag = true;
            err = fds_record_update(&desc, p_record);
            // wait for write to finish
            while(man_fds_wait4event_flag) man_fds_power_manage();

            if(err) return err;
        }
        else if(err != FDS_SUCCESS) return err; // other errors
    }
    else return err;

    return FDS_SUCCESS;
}


ret_code_t man_fds_init (void){
  // assign event handler
  ret_code_t err = fds_register(man_fds_evt_handler);
  if (err) return err;
  
  // init module
  err = fds_init();
  // Wait for fds to initialize
  while (!man_fds_init_flag) man_fds_power_manage();
  if (err) return err;
 
  // get stat of flash memory
  err = fds_stat(&man_fds_stat);
  if (err) return err;
  
  // if there are dirty records run garbage collector
  if(man_fds_stat.dirty_records > 0) err = man_fds_gc();

  return NRF_SUCCESS;
}


ret_code_t man_fds_load_config_all(void){
    // load/initialize sensors config data
    ret_code_t err = man_fds_load_config(&man_fds_acc_rec);
    if (err) return err;
    err = man_fds_load_config(&man_fds_mag_rec);
    if (err) return err;
    err = man_fds_load_config(&man_fds_uwb_rec);
    if (err) return err;

    return NRF_SUCCESS;
}


#pragma region // -- delete function

ret_code_t record_delete_next(void) {
    fds_record_desc_t desc  = {0};
    fds_find_token_t  tok = {0};

    // iterate over all records
    ret_code_t rc = fds_record_iterate(&desc, &tok);
    if (rc == FDS_SUCCESS) {
        man_fds_delete_all_struct.pending = true;
        rc = fds_record_delete(&desc);
        // wait for delete to be complete
        while(man_fds_delete_all_struct.pending) man_fds_power_manage();
    }
    return rc;
}


ret_code_t man_fds_delete_all_process(void) {
    if (man_fds_delete_all_struct.delete_next) {

        ret_code_t err = record_delete_next();
        switch (err) {
        case FDS_ERR_NOT_FOUND: // no more records to delete
            man_fds_delete_all_struct.delete_next = false;
            break;

        case FDS_SUCCESS: // record deleted successfully
            man_fds_delete_all_struct.delete_next = true;
            break;
        
        default: // other errors
            man_fds_delete_all_struct.delete_next = false;
            return err;
            break;
        }
    }
    return FDS_SUCCESS;
}


ret_code_t man_fds_delete_all(void) {
    ret_code_t err = FDS_SUCCESS;
    man_fds_delete_all_struct.delete_next = true;
    // reset iterator token
    //record_iterator_tok = {0};

    while(!err && man_fds_delete_all_struct.delete_next){
        // delete one record
        err = man_fds_delete_all_process();
    }
    if(err) return err;
    err = man_fds_gc();
    return err;
}


ret_code_t man_fds_gc(void){
    man_fds_wait4event_flag = true;
    ret_code_t err = fds_gc();
    // sleeping mode until process is completed
    while (man_fds_wait4event_flag) man_fds_power_manage();

    return err;
}

#pragma endregion


#pragma region // -- accelerometer

const man_fds_acc_t * const man_fds_get_acc_config (void){
    return (const man_fds_acc_t * const)&man_fds_acc;
}


ret_code_t man_fds_set_acc_bias(float* ab){
    memcpy(man_fds_acc.bias, ab, sizeof(float) * 3);
    return man_fds_update_config(&man_fds_acc_rec);
}


ret_code_t man_fds_set_acc_scale(float* as){
    memcpy(man_fds_acc.scale, as, sizeof(float) * 3);
    return man_fds_update_config(&man_fds_acc_rec);
}


ret_code_t man_fds_set_acc_unc(float* au){
    memcpy(man_fds_acc.unc, au, sizeof(float) * 3);
    return man_fds_update_config(&man_fds_acc_rec);
}

#pragma endregion


#pragma region // -- magnetometer

const man_fds_mag_t * const man_fds_get_mag_config (void){
    return (const man_fds_mag_t * const)&man_fds_mag;
}


ret_code_t man_fds_set_mag_hi(float* hi){
    memcpy(man_fds_mag.hard_iron, hi, sizeof(float) * 3);
    return man_fds_update_config(&man_fds_mag_rec);
}


ret_code_t man_fds_set_mag_si(float* si){
    memcpy(man_fds_mag.soft_iron, si, sizeof(float) * 9);
    return man_fds_update_config(&man_fds_mag_rec);
}


ret_code_t man_fds_set_mag_unc(float* mu){
    memcpy(man_fds_mag.unc, mu, sizeof(float) * 3);
    return man_fds_update_config(&man_fds_mag_rec);
}

#pragma endregion


#pragma region // -- uwb

const man_fds_uwb_t * const man_fds_get_uwb_config (void){
    return (const man_fds_uwb_t * const)&man_fds_uwb;
}


ret_code_t man_fds_set_uwb_unc(float* uu){
    memcpy(man_fds_uwb.unc, uu, sizeof(float) * 3);
    return man_fds_update_config(&man_fds_uwb_rec);
}

#pragma endregion


#pragma endregion