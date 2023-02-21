/*! ----------------------------------------------------------------------------
*  @file    communication_python.c
*  @brief   Library to manage the communication with a python code
*           to command the tag tasks
*
* 
* @attention
*
*
* @authors	Matteo Albi:            matteo.albi@studenti.unitn.it
*/

#include "communication_python.h"


#pragma region /* Private variables ----------------------------------------------*/
static uint8_t pycom_uart_msg; // stores received bytes
static uint8_t pycom_uart_cmd_id; // store received pck command id
static uint8_t pycom_uart_pl_len; // store received pck pl length

static float pycom_uart_pl_f[6]; // store received float pck payload
static uint16_t pycom_uart_pl_uint16[3]; // store received uint16 pck payload

static float pycom_stream_buf_f[6]; // used to store floats during streaming mode
static uint32_t pycom_stream_window_ctr = 0; // used to track n of packages to send in stream
static float pycom_mag_si_buf[9]; // used to store the data received in three diff packages

//static bool new_byte;
//static bool pck_read_flag = false;
// static bool pycom_pck_write_flag = false;
//static bool wait_pck_flag = false;
static bool pycom_run_streaming_flag = false;
static bool pycom_run_routine_flag = false;
static bool pycom_menu_flag;
static uint8_t pycom_executing_cmd;

#pragma endregion


#pragma region /* Functions --------------------------------------------------------*/

void pycom_check_error(uint8_t err){
  if(err){
    uint8_t pck_err_pl[2] = {pycom_executing_cmd, err};
    pycom_write_pck_uint8(PYCOM_ERR, 2, pck_err_pl);
  }
  else pycom_write_pck_uint8(PYCOM_ACK, 1, &pycom_executing_cmd);
}


int32_t pycom_get_acc_mag(float *buf){
  int32_t err = lis2dh_get_acc_calibrated(&buf[0]);
  if(!err) err = lis2mdl_get_mag_calibrated(&buf[3]);
  return err;
}


#pragma region // -- communication write

uint32_t pycom_write_pck_f(uint8_t id, uint8_t len, float * pl){
  uint32_t err;
  pycom_f_B_conv converter;

  // pycom_pck_write_flag = false;

  err = app_uart_put(PYCOM_HEAD);
  if(err) return PYCOM_WRITE_ERR;
  err = app_uart_put(id);
  if(err) return PYCOM_WRITE_ERR;
  err = app_uart_put(len);
  if(err) return PYCOM_WRITE_ERR;
  
  // send payload
  for(uint8_t i=0; i<len; i++){
    // set float
    converter.f = pl[i];

    // send bytes
    for(uint8_t j=0; j<sizeof(float); j++){
 #ifdef PYCOM_LITTLE_ENDIAN
      err = app_uart_put(converter.buf[j]);
 #else
      err = app_uart_put(converter.buf[sizeof(float) - 1 - j]);
 #endif
      if(err) return PYCOM_WRITE_ERR;
    }
  }

  err = app_uart_put(PYCOM_TAIL);
  if(err) return PYCOM_WRITE_ERR;

  // pycom_pck_write_flag = true;

  return PYCOM_NO_ERROR;
}


uint32_t pycom_write_pck_uint16(uint8_t id, uint8_t len, uint16_t * pl){
  uint32_t err;
  pycom_f_uint16_conv converter;

  // pycom_pck_write_flag = false;

  err = app_uart_put(PYCOM_HEAD);
  if(err) return PYCOM_WRITE_ERR;
  err = app_uart_put(id);
  if(err) return PYCOM_WRITE_ERR;
  err = app_uart_put(len);
  if(err) return PYCOM_WRITE_ERR;
  
  // send payload
  for(uint8_t i=0; i<len; i++){
    // set float
    converter.u16 = pl[i];

    // send bytes
    for(uint8_t j=0; j<sizeof(uint16_t); j++){
 #ifdef PYCOM_LITTLE_ENDIAN
      err = app_uart_put(converter.buf[j]);
 #else
      err = app_uart_put(converter.buf[sizeof(float) - 1 - j]);
 #endif
      if(err) return PYCOM_WRITE_ERR;
    }
  }

  err = app_uart_put(PYCOM_TAIL);
  if(err) return PYCOM_WRITE_ERR;

  // pycom_pck_write_flag = true;

  return PYCOM_NO_ERROR;
}


uint32_t pycom_write_pck_uint8(uint8_t id, uint8_t len, uint8_t * pl){
  uint32_t err;

  // pycom_pck_write_flag = false;

  err = app_uart_put(PYCOM_HEAD);
  if(err) return PYCOM_WRITE_ERR;
  err = app_uart_put(id);
  if(err) return PYCOM_WRITE_ERR;
  err = app_uart_put(len);
  if(err) return PYCOM_WRITE_ERR;
  
  // send payload
  for(uint8_t i=0; i<len; i++){
    // send byte
    err = app_uart_put(pl[i]);
    if(err) return PYCOM_WRITE_ERR;
  }

  err = app_uart_put(PYCOM_TAIL);
  if(err) return PYCOM_WRITE_ERR;

  // pycom_pck_write_flag = true;

  return PYCOM_NO_ERROR;
}


uint32_t pycom_write_pck_cmd(uint8_t id){
  return pycom_write_pck_uint8(id, 0, NULL);
}


uint32_t pycom_stream_pck_f(uint16_t stream_len, uint8_t pl_len, 
                      pycom_get_float_pl_func_ptr get_float_pl, 
                      uint16_t byte_timeout, uint16_t delay){
  uint32_t err = PYCOM_NO_ERROR;
  pycom_run_streaming_flag = true;

  pycom_stream_window_ctr = stream_len;
  
  while(pycom_stream_window_ctr > 0){

    // get data
    err = get_float_pl(pycom_stream_buf_f);
    if(err){
      pycom_stream_window_ctr = 0;
      pycom_run_streaming_flag = false;
      return err;
    }

    // send data
    err = pycom_write_pck_f(PYCOM_SEND_FLOAT, pl_len, pycom_stream_buf_f);
    if(err){
      pycom_stream_window_ctr = 0;
      pycom_run_streaming_flag = false;
      return err;
    }

    // check for commands (for stop, wait or increase stream window)
    err = pycom_wait_for_pck(byte_timeout, 0);
    if(err == PYCOM_TIMEOUT_PCK_ERR) err = PYCOM_NO_ERROR;
    // if error different from PYCOM_TIMEOUT_PCK_ERR -> stop
    // (comment following if-instruction to discard packages and continue stream) 
    if(err){
      pycom_stream_window_ctr = 0;
      pycom_run_streaming_flag = false;
      return err;
    }
    
    // transmission delay
    nrf_delay_ms(delay);

    pycom_stream_window_ctr --;
  }

  pycom_run_streaming_flag = false;
  return err;

}

#pragma endregion


#pragma region // -- communication read

uint32_t pycom_read_byte(uint16_t timeout){
  uint32_t err = NRF_ERROR_NOT_FOUND;
  uint16_t i = 0;
  
  while(err == NRF_ERROR_NOT_FOUND){
    nrf_delay_ms(1);

    //exit from idle
    if(i > timeout) err = PYCOM_TIMEOUT_B_ERR;
    else err = app_uart_get(&pycom_uart_msg);

    i++;
  }

  return err;
}


uint32_t pycom_read_payload_f(uint16_t byte_timeout){
  uint32_t err = PYCOM_NO_ERROR;
  pycom_f_B_conv converter;
  
  for(uint8_t i=0; i<pycom_uart_pl_len && !err; i++){

    // get a float
    for(uint8_t j=0; j<sizeof(float) && !err; j++){
      err = pycom_read_byte(byte_timeout);
      if(err) return err; // timeout
 #ifdef PYCOM_LITTLE_ENDIAN
      converter.buf[j] = pycom_uart_msg;
 #else
      converter.buf[sizeof(float) - 1 - j] = pycom_uart_msg;
 #endif
    }

    // add float to payload
    pycom_uart_pl_f[i] = converter.f;
  
  }

  return err;
}


uint32_t pycom_read_payload_uint16(uint16_t byte_timeout){
  uint32_t err = PYCOM_NO_ERROR;
  uint8_t first_b, second_b;

  for(uint8_t i=0; i<pycom_uart_pl_len && !err; i++){

    // get 2 bytes
    err = pycom_read_byte(byte_timeout);
    if(err) return err; // timeout
    first_b = pycom_uart_msg;

    err = pycom_read_byte(byte_timeout);
    if(err) return err; // timeout
    second_b = pycom_uart_msg;
      
    // convert and add uint16 to payload
 #ifdef PYCOM_LITTLE_ENDIAN
    pycom_uart_pl_uint16[i] = (uint16_t)(second_b * 256) + (uint16_t)first_b;
 #else
    pycom_uart_pl_uint16[i] = (uint16_t)(first_b * 256) + (uint16_t)second_b;
 #endif
  
  }

  return err;
}


uint32_t pycom_read_pck(uint16_t byte_timeout){
  uint32_t err;

  //pck_read_flag = false;

  // read buffer until find an header
  err = pycom_read_byte(byte_timeout);
  while(pycom_uart_msg != PYCOM_HEAD && !err) err = pycom_read_byte(byte_timeout);
  if(err) return err; // timeout

  // read cmd id
  err = pycom_read_byte(byte_timeout);
  if(err) return err; // timeout
  pycom_uart_cmd_id = pycom_uart_msg;

  // read payload length
  err = pycom_read_byte(byte_timeout);
  if(err) return err; // timeout
  pycom_uart_pl_len = pycom_uart_msg;
  
  // read payload
  if(pycom_uart_pl_len > 0){
    if(pycom_uart_cmd_id == PYCOM_STREAM_WIN)
    {
      if(pycom_uart_pl_len != 1) return PYCOM_PAYLOAD_LEN_ERR;
      err = pycom_read_payload_uint16(byte_timeout);
    }

    else if(pycom_uart_cmd_id == PYCOM_STREAM_ACC || 
            pycom_uart_cmd_id == PYCOM_STREAM_MAG ||
            pycom_uart_cmd_id == PYCOM_STREAM_ACC_MAG)
    {
      if(pycom_uart_pl_len != 3) return PYCOM_PAYLOAD_LEN_ERR;
      err = pycom_read_payload_uint16(byte_timeout);
    }

    else if(pycom_uart_cmd_id == PYCOM_ACC_BIAS ||
            pycom_uart_cmd_id == PYCOM_ACC_SCALE ||
            pycom_uart_cmd_id == PYCOM_MAG_HI ||
            pycom_uart_cmd_id == PYCOM_MAG_SI1 ||
            pycom_uart_cmd_id == PYCOM_MAG_SI2 ||
            pycom_uart_cmd_id == PYCOM_MAG_SI3 ||
            pycom_uart_cmd_id == PYCOM_ACC_UNC ||
            pycom_uart_cmd_id == PYCOM_MAG_UNC ||
            pycom_uart_cmd_id == PYCOM_POS_UNC)
    {
      if(pycom_uart_pl_len != 3) return PYCOM_PAYLOAD_LEN_ERR;
      err = pycom_read_payload_f(byte_timeout);
    }

    //else if (pycom_uart_cmd_id == PYCOM_MAG_SI)
    //{
    //  if(pycom_uart_pl_len != 9) return PYCOM_PAYLOAD_LEN_ERR;
    //  err = pycom_read_payload_f(byte_timeout);
    //}

    else if(pycom_uart_cmd_id == PYCOM_DEBUG_CMD){
      err = pycom_read_payload_f(byte_timeout);
    }

    else return PYCOM_CMD_ERR;
  }
  if(err) return err; // timeout

  // read PYCOM_TAIL
  err = pycom_read_byte(byte_timeout);
  if(err) return err; // timeout
  if(pycom_uart_msg != PYCOM_TAIL) return PYCOM_NO_TAIL; // last byte not a PYCOM_TAIL

  //pck_read_flag = true;
  return PYCOM_NO_ERROR;

}


uint32_t pycom_parse_pck(){
  uint32_t err = PYCOM_NO_ERROR;

  switch (pycom_uart_cmd_id){
    case PYCOM_STOP_CMD:
      if(!pycom_run_streaming_flag) return PYCOM_STREAM_ERR;
      pycom_stream_window_ctr = 1;
      pycom_run_streaming_flag = false;
      // err = pycom_write_pck_uint8(PYCOM_ACK, 1, &pycom_uart_cmd_id);
      break;

    case PYCOM_WAIT_CMD:
      //wait_pck_flag = true;
      //build wait routine for new package
      // err = pycom_write_pck_uint8(PYCOM_ACK, 1, &pycom_uart_cmd_id);
      break;

    case PYCOM_STREAM_WIN:
      if(!pycom_run_streaming_flag) return PYCOM_STREAM_ERR;
      pycom_stream_window_ctr += pycom_uart_pl_uint16[0];
      err = pycom_write_pck_uint8(PYCOM_ACK, 1, &pycom_uart_cmd_id);
      break;

    case PYCOM_START:
      if(pycom_run_streaming_flag || pycom_run_routine_flag) return PYCOM_REQUEST_CONFLICT_ERR;
      pycom_menu_flag = true;
      break;

    case PYCOM_EXIT:
      if(pycom_run_streaming_flag || pycom_run_routine_flag) return PYCOM_REQUEST_CONFLICT_ERR;
      pycom_executing_cmd = pycom_uart_cmd_id;
      pycom_menu_flag = false;
      break;

    case PYCOM_STREAM_ACC:
      if(pycom_run_streaming_flag || pycom_run_routine_flag) return PYCOM_REQUEST_CONFLICT_ERR;
      pycom_run_routine_flag = true;
      pycom_executing_cmd = pycom_uart_cmd_id;

      // raw data
      if(pycom_uart_pl_uint16[2]) err = pycom_stream_pck_f(pycom_uart_pl_uint16[0], 3, &lis2dh_get_acc, 10, pycom_uart_pl_uint16[1]);
      // calibrated data
      else err = pycom_stream_pck_f(pycom_uart_pl_uint16[0], 3, &lis2dh_get_acc_calibrated, 10, pycom_uart_pl_uint16[1]);
      
      pycom_run_routine_flag = false;
      break;

    case PYCOM_STREAM_MAG:
      if(pycom_run_streaming_flag || pycom_run_routine_flag) return PYCOM_REQUEST_CONFLICT_ERR;
      pycom_run_routine_flag = true;
      pycom_executing_cmd = pycom_uart_cmd_id;

      // raw data
      if(pycom_uart_pl_uint16[2]) err = pycom_stream_pck_f(pycom_uart_pl_uint16[0], 3, &lis2mdl_get_mag, 10, pycom_uart_pl_uint16[1]);
      // calibrated data
      else err = pycom_stream_pck_f(pycom_uart_pl_uint16[0], 3, &lis2mdl_get_mag_calibrated, 10, pycom_uart_pl_uint16[1]);
      
      pycom_run_routine_flag = false;
      break;

    case PYCOM_STREAM_ACC_MAG: 
      if(pycom_run_streaming_flag || pycom_run_routine_flag) return PYCOM_REQUEST_CONFLICT_ERR;
      pycom_run_routine_flag = true;
      pycom_executing_cmd = pycom_uart_cmd_id;

      err = pycom_stream_pck_f(pycom_uart_pl_uint16[0], 6, &pycom_get_acc_mag, 10, pycom_uart_pl_uint16[1]);
     
      pycom_run_routine_flag = false;
      break;

    case PYCOM_STREAM_RTDOA:
      if(pycom_run_streaming_flag || pycom_run_routine_flag) return PYCOM_REQUEST_CONFLICT_ERR;
      //err = rtdoa_routine();
      break;

    case PYCOM_STREAM_FILTER:
      if(pycom_run_streaming_flag || pycom_run_routine_flag) return PYCOM_REQUEST_CONFLICT_ERR;
      //err = filter_routine();
      break;

    case PYCOM_ACC_BIAS:
      if(pycom_run_streaming_flag || pycom_run_routine_flag) return PYCOM_REQUEST_CONFLICT_ERR;
      pycom_run_routine_flag = true;
      pycom_executing_cmd = pycom_uart_cmd_id;
      err = man_fds_set_acc_bias(pycom_uart_pl_f);
      pycom_run_routine_flag = false;
      // err = pycom_write_pck_uint8(PYCOM_ACK, 1, &pycom_uart_cmd_id);
      break;

    case PYCOM_ACC_SCALE:
      if(pycom_run_streaming_flag || pycom_run_routine_flag) return PYCOM_REQUEST_CONFLICT_ERR;
      pycom_run_routine_flag = true;
      pycom_executing_cmd = pycom_uart_cmd_id;
      err = man_fds_set_acc_scale(pycom_uart_pl_f);
      pycom_run_routine_flag = false;
      // err = pycom_write_pck_uint8(PYCOM_ACK, 1, &pycom_uart_cmd_id);
      break;

    case PYCOM_MAG_HI:
      if(pycom_run_streaming_flag || pycom_run_routine_flag) return PYCOM_REQUEST_CONFLICT_ERR;
      pycom_run_routine_flag = true;
      pycom_executing_cmd = pycom_uart_cmd_id;
      err = man_fds_set_mag_hi(pycom_uart_pl_f);
      pycom_run_routine_flag = false;
      // err = pycom_write_pck_uint8(PYCOM_ACK, 1, &pycom_uart_cmd_id);
      break;

    //case PYCOM_MAG_SI:
    //  if(pycom_run_streaming_flag || pycom_run_routine_flag) return PYCOM_REQUEST_CONFLICT_ERR;
    //  pycom_run_routine_flag = true;
    //  pycom_executing_cmd = pycom_uart_cmd_id;
    //  err = man_fds_set_mag_si(pycom_uart_pl_f);
    //  pycom_run_routine_flag = false;
    //  // err = pycom_write_pck_uint8(PYCOM_ACK, 1, &pycom_uart_cmd_id);
    //  //nrf_delay_ms(100);
    //  break;

    case PYCOM_MAG_SI1:
      if(pycom_run_streaming_flag || pycom_run_routine_flag) return PYCOM_REQUEST_CONFLICT_ERR;
      pycom_run_routine_flag = true;
      pycom_executing_cmd = pycom_uart_cmd_id;
      // save first triplet of values in buffer
      memcpy(&pycom_mag_si_buf[0], pycom_uart_pl_f, sizeof(float)*3);
      pycom_run_routine_flag = false;
      // err = pycom_write_pck_uint8(PYCOM_ACK, 1, &pycom_uart_cmd_id);
      //nrf_delay_ms(100);
      break;

    case PYCOM_MAG_SI2:
      if(pycom_run_streaming_flag || pycom_run_routine_flag) return PYCOM_REQUEST_CONFLICT_ERR;
      pycom_run_routine_flag = true;
      pycom_executing_cmd = pycom_uart_cmd_id;
      // save second triplet of values in buffer
      memcpy(&pycom_mag_si_buf[3], pycom_uart_pl_f, sizeof(float)*3);
      pycom_run_routine_flag = false;
      // err = pycom_write_pck_uint8(PYCOM_ACK, 1, &pycom_uart_cmd_id);
      //nrf_delay_ms(100);
      break;

    case PYCOM_MAG_SI3:
      if(pycom_run_streaming_flag || pycom_run_routine_flag) return PYCOM_REQUEST_CONFLICT_ERR;
      pycom_run_routine_flag = true;
      pycom_executing_cmd = pycom_uart_cmd_id;
      // save third triplet of values in buffer
      memcpy(&pycom_mag_si_buf[6], pycom_uart_pl_f, sizeof(float)*3);
      // write on flash
      err = man_fds_set_mag_si(pycom_mag_si_buf);
      pycom_run_routine_flag = false;
      // err = pycom_write_pck_uint8(PYCOM_ACK, 1, &pycom_uart_cmd_id);
      //nrf_delay_ms(100);
      break;

    case PYCOM_ACC_UNC:
      if(pycom_run_streaming_flag || pycom_run_routine_flag) return PYCOM_REQUEST_CONFLICT_ERR;
      pycom_run_routine_flag = true;
      pycom_executing_cmd = pycom_uart_cmd_id;
      err = man_fds_set_acc_unc(pycom_uart_pl_f);
      pycom_run_routine_flag = false;
      // err = pycom_write_pck_uint8(PYCOM_ACK, 1, &pycom_uart_cmd_id);
      break;

    case PYCOM_MAG_UNC:
      if(pycom_run_streaming_flag || pycom_run_routine_flag) return PYCOM_REQUEST_CONFLICT_ERR;
      pycom_run_routine_flag = true;
      pycom_executing_cmd = pycom_uart_cmd_id;
      err = man_fds_set_mag_unc(pycom_uart_pl_f);
      pycom_run_routine_flag = false;
      // err = pycom_write_pck_uint8(PYCOM_ACK, 1, &pycom_uart_cmd_id);
      break;

    case PYCOM_POS_UNC:
      if(pycom_run_streaming_flag || pycom_run_routine_flag) return PYCOM_REQUEST_CONFLICT_ERR;
      pycom_run_routine_flag = true;
      pycom_executing_cmd = pycom_uart_cmd_id;
      err = man_fds_set_uwb_unc(pycom_uart_pl_f);
      pycom_run_routine_flag = false;
      // err = pycom_write_pck_uint8(PYCOM_ACK, 1, &pycom_uart_cmd_id);
      break;

    case PYCOM_DEBUG_CMD: 
      if(pycom_run_streaming_flag || pycom_run_routine_flag) return PYCOM_REQUEST_CONFLICT_ERR;
      pycom_run_routine_flag = true;
      pycom_executing_cmd = pycom_uart_cmd_id;
      err = pycom_write_pck_f(PYCOM_SEND_FLOAT, pycom_uart_pl_len, pycom_uart_pl_f);
      pycom_run_routine_flag = false;
      break;

    default:
      err =  PYCOM_CMD_NOT_FOUND;
      break;
  }

  return err;
}


uint32_t pycom_wait_for_pck(uint16_t byte_timeout, uint16_t pck_timeout){
  uint16_t time_ratio;
  uint16_t i = 0;
  uint32_t err = PYCOM_TIMEOUT_B_ERR;

  if(byte_timeout == 0) time_ratio = pck_timeout;
  else time_ratio = pck_timeout / byte_timeout;

  while(err == PYCOM_TIMEOUT_B_ERR){
    //exit from idle
    if(i > time_ratio) err = PYCOM_TIMEOUT_PCK_ERR;
    else err = pycom_read_pck(byte_timeout);

    i++;
  }

  if(!err){
    err = pycom_parse_pck();
  }

  return err;
}


uint32_t pycom_wait_for_command(uint16_t byte_timeout, uint16_t pck_timeout, uint16_t cmd_timeout){
  uint16_t time_ratio;
  uint16_t i = 0;
  uint32_t err = PYCOM_TIMEOUT_PCK_ERR;

  pycom_run_routine_flag = false;
  pycom_run_streaming_flag = false;

  if(byte_timeout == 0) time_ratio = cmd_timeout;
  else time_ratio = cmd_timeout / pck_timeout;

  while(err == PYCOM_TIMEOUT_PCK_ERR){
    //exit from idle
    if(i > time_ratio) err = PYCOM_TIMEOUT_CMD_ERR;
    else  err = pycom_wait_for_pck(byte_timeout, pck_timeout);

    i++;
  }

  return err;
}

#pragma endregion


void pycom_start(uint16_t byte_timeout, uint16_t pck_timeout, uint16_t menu_timeout){
  uint16_t time_ratio, err;
  uint16_t i = 0;
  pycom_run_routine_flag = false;
  pycom_run_streaming_flag = false;

  // trigger communication python side
  printf("START_PYCOM\n");
  
  // wait for ack from master
  //pycom_menu_flag = true;
  err = pycom_wait_for_pck(byte_timeout, pck_timeout);
  pycom_check_error(err);


  if(byte_timeout == 0) time_ratio = menu_timeout;
  else time_ratio = menu_timeout / pck_timeout;

  while(pycom_menu_flag){
    // read package
    err = pycom_wait_for_pck(byte_timeout, pck_timeout);
    pycom_check_error(err);

    if(err == PYCOM_TIMEOUT_PCK_ERR) i++;
    else i = 0;

    if(i > time_ratio) pycom_menu_flag = false;

  }

}


#pragma endregion