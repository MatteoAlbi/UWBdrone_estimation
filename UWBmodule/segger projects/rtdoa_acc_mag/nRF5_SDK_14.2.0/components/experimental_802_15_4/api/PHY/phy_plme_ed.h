/**
 * Copyright (c) 2016 - 2017 Nordic Semiconductor ASA and Luxoft Global Operations Gmbh.
 * 
 * All Rights Reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 * 
 * 
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form, except as embedded into a Nordic
 *    Semiconductor ASA integrated circuit in a product or a software update for
 *    such product, must reproduce the above copyright notice, this list of
 *    conditions and the following disclaimer in the documentation and/or other
 *    materials provided with the distribution.
 * 
 * 3. Neither the name of Nordic Semiconductor ASA nor the names of its
 *    contributors may be used to endorse or promote products derived from this
 *    software without specific prior written permission.
 * 
 * 4. This software, with or without modification, must only be used with a
 *    Nordic Semiconductor ASA integrated circuit.
 * 
 * 5. Any software provided in binary form under this license must not be reverse
 *    engineered, decompiled, modified and/or disassembled.
 * 
 * 
 * THIS SOFTWARE IS PROVIDED BY NORDIC SEMICONDUCTOR ASA "AS IS" AND ANY EXPRESS
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY, NONINFRINGEMENT, AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL NORDIC SEMICONDUCTOR ASA OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 * GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
 * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 */
#ifndef PHY_PLME_ED_H_INCLUDED
#define PHY_PLME_ED_H_INCLUDED

#include <stdint.h>
#include "phy_common.h"

/** @file
 * This file contains declarations of Energy Detection PHY routines and necessary types.
 *
 * @defgroup phy_ed PHY ED API
 * @{
 * @brief Module to declare PHY ED API
 */

/**@brief Describes the current state of the ED algorithm. */
typedef enum
{
    PHY_PLME_ED_STATE_IDLE, /**< Algorithm is idle. */
    PHY_PLME_ED_STATE_BUSY  /**< Currently performing ED. */
} phy_plme_ed_state_t;

/**@brief This structure holds static data of this module. */
typedef struct
{
    phy_plme_ed_state_t  state;
} phy_plme_ed_mem_t;

/**@brief   PLME-ED.confirm parameters.
 *
 * @details The PLME-ED.confirm primitive is generated by the PLME and issued
 *          to its next higher layer in response to an PLME-ED.request primitive.
 *
 *          In accordance with IEEE Std 802.15.4-2006, section 6.2.2.4.1.
 */
typedef struct
{
    /** One of PHY_SUCCESS, PHY_TRX_OFF or PHY_TX_ON. */
    phy_enum_t status;

    /** Energy level for the current channel, if status is SUCCESS. */
    uint8_t    energy_level;
} plme_ed_conf_t;


/**@brief   PLME-ED.request.
 *
 * @details Request ED measurement for the current channel.
 *          In accordance with IEEE Std 802.15.4-2006, section 6.2.2.3.
 */
void plme_ed_req(void);


/**@brief   The PLME-ED.confirm callback function, implemented by the next higher layer.
 *
 * @details The PLME-ED.confirm primitive is generated by the PLME and issued
 *          to its next higher layer in response to an PLME-ED.request primitive.
 *          In accordance with IEEE Std 802.15.4-2006, section 6.2.2.4.
 *
 * @param[out] conf Pointer to PLME-ED.confirm parameters
 */
void plme_ed_conf(plme_ed_conf_t * conf);

/** @} */

#endif // PHY_PLME_ED_H_INCLUDED
