/*
*
*	Component name:	TWI
*
*	File name: TWI.h
*
* Description: Two Wire Interface (I2C) public interface declarations.
*
*/

#include "sdk_errors.h"

void vTWI_Init		(void);
ret_code_t vTWI_Write   (uint8_t u8devAdrs, uint8_t u8RegAdrs, uint8_t *u8data, uint8_t u8length);
ret_code_t vTWI_Read    (uint8_t u8devAdrs, uint8_t u8RegAdrs, uint8_t *pu8readData, uint8_t u8length);