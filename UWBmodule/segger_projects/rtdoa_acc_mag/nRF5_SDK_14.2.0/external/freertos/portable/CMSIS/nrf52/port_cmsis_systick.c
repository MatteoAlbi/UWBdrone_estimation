///*
//    FreeRTOS V8.2.1 - Copyright (C) 2015 Real Time Engineers Ltd.
//    All rights reserved
//
//    VISIT http://www.FreeRTOS.org TO ENSURE YOU ARE USING THE LATEST VERSION.
//
//    This file is part of the FreeRTOS distribution.
//
//    FreeRTOS is free software; you can redistribute it and/or modify it under
//    the terms of the GNU General Public License (version 2) as published by the
//    Free Software Foundation >>!AND MODIFIED BY!<< the FreeRTOS exception.
//
//    ***************************************************************************
//    >>!   NOTE: The modification to the GPL is included to allow you to     !<<
//    >>!   distribute a combined work that includes FreeRTOS without being   !<<
//    >>!   obliged to provide the source code for proprietary components     !<<
//    >>!   outside of the FreeRTOS kernel.                                   !<<
//    ***************************************************************************
//
//    FreeRTOS is distributed in the hope that it will be useful, but WITHOUT ANY
//    WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
//    FOR A PARTICULAR PURPOSE.  Full license text is available on the following
//    link: http://www.freertos.org/a00114.html
//
//    ***************************************************************************
//     *                                                                       *
//     *    FreeRTOS provides completely free yet professionally developed,    *
//     *    robust, strictly quality controlled, supported, and cross          *
//     *    platform software that is more than just the market leader, it     *
//     *    is the industry's de facto standard.                               *
//     *                                                                       *
//     *    Help yourself get started quickly while simultaneously helping     *
//     *    to support the FreeRTOS project by purchasing a FreeRTOS           *
//     *    tutorial book, reference manual, or both:                          *
//     *    http://www.FreeRTOS.org/Documentation                              *
//     *                                                                       *
//    ***************************************************************************
//
//    http://www.FreeRTOS.org/FAQHelp.html - Having a problem?  Start by reading
//    the FAQ page "My application does not run, what could be wrong?".  Have you
//    defined configASSERT()?
//
//    http://www.FreeRTOS.org/support - In return for receiving this top quality
//    embedded software for free we request you assist our global community by
//    participating in the support forum.
//
//    http://www.FreeRTOS.org/training - Investing in training allows your team to
//    be as productive as possible as early as possible.  Now you can receive
//    FreeRTOS training directly from Richard Barry, CEO of Real Time Engineers
//    Ltd, and the world's leading authority on the world's leading RTOS.
//
//    http://www.FreeRTOS.org/plus - A selection of FreeRTOS ecosystem products,
//    including FreeRTOS+Trace - an indispensable productivity tool, a DOS
//    compatible FAT file system, and our tiny thread aware UDP/IP stack.
//
//    http://www.FreeRTOS.org/labs - Where new FreeRTOS products go to incubate.
//    Come and try FreeRTOS+TCP, our new open source TCP/IP stack for FreeRTOS.
//
//    http://www.OpenRTOS.com - Real Time Engineers ltd. license FreeRTOS to High
//    Integrity Systems ltd. to sell under the OpenRTOS brand.  Low cost OpenRTOS
//    licenses offer ticketed support, indemnification and commercial middleware.
//
//    http://www.SafeRTOS.com - High Integrity Systems also provide a safety
//    engineered and independently SIL3 certified version for use in safety and
//    mission critical applications that require provable dependability.
//
//    1 tab == 4 spaces!
//*/
//
///* Scheduler includes. */
//#include "FreeRTOS.h"
//#include "task.h"
//#include "app_util.h"
//#include "nrf_log.h"
//
//#ifdef SOFTDEVICE_PRESENT
//#include "nrf_soc.h"
//#include "nrf_sdh.h"
//#include "app_error.h"
//#include "app_util_platform.h"
//#endif
//
//#if (NRF_PWR_MGMT_CONFIG_FPU_SUPPORT_ENABLED && __FPU_PRESENT)
//    #define PWR_MGMT_FPU_SLEEP_PREPARE()     pwr_mgmt_fpu_sleep_prepare()
//
//     __STATIC_INLINE void pwr_mgmt_fpu_sleep_prepare(void)
//     {
//        uint32_t fpscr;
//        CRITICAL_REGION_ENTER();
//        fpscr = __get_FPSCR();
//        /*
//         * Clear FPU exceptions.
//         * Without this step, the FPU interrupt is marked as pending,
//         * preventing system from sleeping. Exceptions cleared:
//         * - IOC - Invalid Operation cumulative exception bit.
//         * - DZC - Division by Zero cumulative exception bit.
//         * - OFC - Overflow cumulative exception bit.
//         * - UFC - Underflow cumulative exception bit.
//         * - IXC - Inexact cumulative exception bit.
//         * - IDC - Input Denormal cumulative exception bit.
//         */
//        __set_FPSCR(fpscr & ~0x9Fu);
//        __DMB();
//        NVIC_ClearPendingIRQ(FPU_IRQn);
//        CRITICAL_REGION_EXIT();
//
//        /*
//         * Assert no critical FPU exception is signaled:
//         * - IOC - Invalid Operation cumulative exception bit.
//         * - DZC - Division by Zero cumulative exception bit.
//         * - OFC - Overflow cumulative exception bit.
//         */
//        ASSERT((fpscr & 0x07) == 0);
//     }
//#else
//    #define PWR_MGMT_FPU_SLEEP_PREPARE()
//#endif // NRF_PWR_MGMT_CONFIG_FPU_SUPPORT_ENABLED
//
///*-----------------------------------------------------------
// * Implementation of functions defined in portable.h for the ARM CM4F port.
// * CMSIS compatible layer to menage SysTick ticking source.
// *----------------------------------------------------------*/
//
//#if configTICK_SOURCE == FREERTOS_USE_SYSTICK
//
//
//#ifndef configSYSTICK_CLOCK_HZ
//    #define configSYSTICK_CLOCK_HZ configCPU_CLOCK_HZ
//    /* Ensure the SysTick is clocked at the same frequency as the core. */
//    #define portNVIC_SYSTICK_CLK_BIT    ( SysTick_CTRL_CLKSOURCE_Msk )
//#else
//    /* The way the SysTick is clocked is not modified in case it is not the same
//    as the core. */
//    #define portNVIC_SYSTICK_CLK_BIT    ( 0 )
//#endif
//
//
//#if configUSE_TICKLESS_IDLE == 1
//    #error SysTick port for RF52 does not support tickless idle. Use RTC mode instead.
//#endif /* configUSE_TICKLESS_IDLE */
//
///*-----------------------------------------------------------*/
//
//void xPortSysTickHandler( void )
//{
//    /* The SysTick runs at the lowest interrupt priority, so when this interrupt
//    executes all interrupts must be unmasked.  There is therefore no need to
//    save and then restore the interrupt mask value as its value is already
//    known. */
//    ( void ) portSET_INTERRUPT_MASK_FROM_ISR();
//    {
//        /* Increment the RTOS tick. */
//        if ( xTaskIncrementTick() != pdFALSE )
//        {
//            /* A context switch is required.  Context switching is performed in
//            the PendSV interrupt.  Pend the PendSV interrupt. */
//            SCB->ICSR = SCB_ICSR_PENDSVSET_Msk;
//            __SEV();
//        }
//    }
//    portCLEAR_INTERRUPT_MASK_FROM_ISR( 0 );
//}
//
///*-----------------------------------------------------------*/
//
///*
// * Setup the systick timer to generate the tick interrupts at the required
// * frequency.
// */
//void vPortSetupTimerInterrupt( void )
//{
//    /* Set interrupt priority */
//    NVIC_SetPriority(SysTick_IRQn, configKERNEL_INTERRUPT_PRIORITY);
//    /* Configure SysTick to interrupt at the requested rate. */
//    SysTick->LOAD = ROUNDED_DIV(configSYSTICK_CLOCK_HZ, configTICK_RATE_HZ) - 1UL;
//    SysTick->CTRL = ( portNVIC_SYSTICK_CLK_BIT | SysTick_CTRL_TICKINT_Msk | SysTick_CTRL_ENABLE_Msk );
//}
//
///*-----------------------------------------------------------*/
//
//#elif configTICK_SOURCE == FREERTOS_USE_RTC
//
//#if configUSE_16_BIT_TICKS == 1
//#error This port does not support 16 bit ticks.
//#endif
//
//#include "nrf_rtc.h"
//#include "nrf_drv_clock.h"
//
///*-----------------------------------------------------------*/
//
//void xPortSysTickHandler( void )
//{
//#if configUSE_TICKLESS_IDLE == 1
//    nrf_rtc_event_clear(portNRF_RTC_REG, NRF_RTC_EVENT_COMPARE_0);
//#endif
//
//    BaseType_t switch_req = pdFALSE;
//    uint32_t isrstate = portSET_INTERRUPT_MASK_FROM_ISR();
//
//    uint32_t systick_counter = nrf_rtc_counter_get(portNRF_RTC_REG);
//    nrf_rtc_event_clear(portNRF_RTC_REG, NRF_RTC_EVENT_TICK);
//
//    if (configUSE_DISABLE_TICK_AUTO_CORRECTION_DEBUG == 0)
//    {
//        /* check FreeRTOSConfig.h file for more details on configUSE_DISABLE_TICK_AUTO_CORRECTION_DEBUG */
//        TickType_t diff;
//        diff = (systick_counter - xTaskGetTickCount()) & portNRF_RTC_MAXTICKS;
//
//        /* At most 1 step if scheduler is suspended - the xTaskIncrementTick
//         * would return the tick state from the moment when suspend function was called. */
//        if ((diff > 1) && (xTaskGetSchedulerState() != taskSCHEDULER_RUNNING))
//        {
//            diff = 1;
//        }
//        while ((diff--) > 0)
//        {
//            switch_req |= xTaskIncrementTick();
//        }
//    }
//    else
//    {
//        switch_req = xTaskIncrementTick();
//    }
//
//    /* Increment the RTOS tick as usual which checks if there is a need for rescheduling */
//    if ( switch_req != pdFALSE )
//    {
//        /* A context switch is required.  Context switching is performed in
//        the PendSV interrupt.  Pend the PendSV interrupt. */
//        SCB->ICSR = SCB_ICSR_PENDSVSET_Msk;
//        __SEV();
//    }
//
//    portCLEAR_INTERRUPT_MASK_FROM_ISR( isrstate );
//}
//
///*
// * Setup the RTC time to generate the tick interrupts at the required
// * frequency.
// */
//void vPortSetupTimerInterrupt( void )
//{
//    /* Request LF clock */
//    nrf_drv_clock_lfclk_request(NULL);
//
//    /* Configure SysTick to interrupt at the requested rate. */
//    nrf_rtc_prescaler_set(portNRF_RTC_REG, portNRF_RTC_PRESCALER);
//    nrf_rtc_int_enable   (portNRF_RTC_REG, RTC_INTENSET_TICK_Msk);
//    nrf_rtc_task_trigger (portNRF_RTC_REG, NRF_RTC_TASK_CLEAR);
//    nrf_rtc_task_trigger (portNRF_RTC_REG, NRF_RTC_TASK_START);
//    nrf_rtc_event_enable(portNRF_RTC_REG, RTC_EVTEN_OVRFLW_Msk);
//
//    NVIC_SetPriority(portNRF_RTC_IRQn, configKERNEL_INTERRUPT_PRIORITY);
//    NVIC_EnableIRQ(portNRF_RTC_IRQn);
//}
//
//#if configUSE_TICKLESS_IDLE == 1
//
//void vPortSuppressTicksAndSleep( TickType_t xExpectedIdleTime )
//{
//    /*
//     * Implementation note:
//     *
//     * To help debugging the option configUSE_TICKLESS_IDLE_SIMPLE_DEBUG was presented.
//     * This option would make sure that even if program execution was stopped inside
//     * this function no more than expected number of ticks would be skipped.
//     *
//     * Normally RTC works all the time even if firmware execution was stopped
//     * and that may lead to skipping too much of ticks.
//     */
//    TickType_t enterTime;
//
//    /* Make sure the SysTick reload value does not overflow the counter. */
//    if ( xExpectedIdleTime > portNRF_RTC_MAXTICKS - configEXPECTED_IDLE_TIME_BEFORE_SLEEP )
//    {
//        xExpectedIdleTime = portNRF_RTC_MAXTICKS - configEXPECTED_IDLE_TIME_BEFORE_SLEEP;
//    }
//    /* Block all the interrupts globally */
//#ifdef SOFTDEVICE_PRESENT
//    do{
//        uint8_t dummy = 0;
//        uint32_t err_code = sd_nvic_critical_region_enter(&dummy);
//        APP_ERROR_CHECK(err_code);
//    }while (0);
//#else
//    __disable_irq();
//#endif
//
//    enterTime = nrf_rtc_counter_get(portNRF_RTC_REG);
//
//    if ( eTaskConfirmSleepModeStatus() != eAbortSleep )
//    {
//        TickType_t xModifiableIdleTime;
//        TickType_t wakeupTime = (enterTime + xExpectedIdleTime) & portNRF_RTC_MAXTICKS;
//
//        /* Stop tick events */
//        nrf_rtc_int_disable(portNRF_RTC_REG, NRF_RTC_INT_TICK_MASK);
//
//        /* Configure CTC interrupt */
//        nrf_rtc_cc_set(portNRF_RTC_REG, 0, wakeupTime);
//        nrf_rtc_event_clear(portNRF_RTC_REG, NRF_RTC_EVENT_COMPARE_0);
//        nrf_rtc_int_enable(portNRF_RTC_REG, NRF_RTC_INT_COMPARE0_MASK);
//
//        __DSB();
//
//        /* Sleep until something happens.  configPRE_SLEEP_PROCESSING() can
//         * set its parameter to 0 to indicate that its implementation contains
//         * its own wait for interrupt or wait for event instruction, and so wfi
//         * should not be executed again.  However, the original expected idle
//         * time variable must remain unmodified, so a copy is taken. */
//        xModifiableIdleTime = xExpectedIdleTime;
//        configPRE_SLEEP_PROCESSING( xModifiableIdleTime );
//        if ( xModifiableIdleTime > 0 )
//        {
//			PWR_MGMT_FPU_SLEEP_PREPARE();
//
//#ifdef SOFTDEVICE_PRESENT
//            if (nrf_sdh_is_enabled())
//            {
//                uint32_t err_code = sd_app_evt_wait();
//                APP_ERROR_CHECK(err_code);
//            }
//            else
//#endif
//            {
//                /* No SD -  we would just block interrupts globally.
//                * BASEPRI cannot be used for that because it would prevent WFE from wake up.
//                */
//                do{
//                    __WFE();
//                } while (0 == (NVIC->ISPR[0] | NVIC->ISPR[1]));
//            }
//        }
//
//        configPOST_SLEEP_PROCESSING( xExpectedIdleTime );
//
//        nrf_rtc_int_disable(portNRF_RTC_REG, NRF_RTC_INT_COMPARE0_MASK);
//        nrf_rtc_event_clear(portNRF_RTC_REG, NRF_RTC_EVENT_COMPARE_0);
//
//        /* Correct the system ticks */
//        {
//            TickType_t diff;
//            TickType_t exitTime;
//
//            nrf_rtc_event_clear(portNRF_RTC_REG, NRF_RTC_EVENT_TICK);
//            nrf_rtc_int_enable (portNRF_RTC_REG, NRF_RTC_INT_TICK_MASK);
//
//            exitTime = nrf_rtc_counter_get(portNRF_RTC_REG);
//            diff =  (exitTime - enterTime) & portNRF_RTC_MAXTICKS;
//
//            /* It is important that we clear pending here so that our corrections are latest and in sync with tick_interrupt handler */
//            NVIC_ClearPendingIRQ(portNRF_RTC_IRQn);
//
//            if ((configUSE_TICKLESS_IDLE_SIMPLE_DEBUG) && (diff > xExpectedIdleTime))
//            {
//                diff = xExpectedIdleTime;
//            }
//
//            if (diff > 0)
//            {
//                vTaskStepTick(diff);
//            }
//        }
//    }
//#ifdef SOFTDEVICE_PRESENT
//    uint32_t err_code = sd_nvic_critical_region_exit(0);
//    APP_ERROR_CHECK(err_code);
//#else
//    __enable_irq();
//#endif
//}
//
//#endif // configUSE_TICKLESS_IDLE
//
//#else // configTICK_SOURCE
//    #error  Unsupported configTICK_SOURCE value
//#endif // configTICK_SOURCE == FREERTOS_USE_SYSTICK


/*
 * FreeRTOS Kernel V10.0.0
 * Copyright (C) 2017 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software. If you wish to use our Amazon
 * FreeRTOS name, please do so in a fair use way that does not cause confusion.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * http://www.FreeRTOS.org
 * http://aws.amazon.com/freertos
 *
 * 1 tab == 4 spaces!
 */

/* Scheduler includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "app_util.h"
#include "nrf_log.h"

#ifdef SOFTDEVICE_PRESENT
#include "nrf_soc.h"
#include "nrf_sdh.h"
#include "app_error.h"
#include "app_util_platform.h"
#endif


#define PROFILE_TICKLESS_IDLE    0

#if PROFILE_TICKLESS_IDLE == 1

#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))

struct {
    /* Total number of times the idle wait loop is entered. */
    uint32_t n_idle_loops;

    /* The number of time the CPU is woken from sd_app_evt_wait() due to an event
     * where the event hasn't cause a reschedule or the tickless idle time has elapsed.
     */
    uint32_t n_cpu_wake_no_rtc_or_sched;

    /* Number of time an exit from idle occurs during a scheduling event.
     * Also extract number of time this occurs based on how many times the
     * CPU wakes up (loop variables).
     */
    uint32_t n_sched_idle_wakeup;
    uint32_t n_sched_idle_wakeup_loop[10];

    /* Number of time an exit from idle occurs during RTC time elapsed.
     * Also extract number of time this occurs based on how many times the
     * CPU wakes up (loop variables).
     */
    uint32_t n_rtc_idle_wakeup;
    uint32_t n_rtc_idle_wakeup_loop[10];

    /* Number of times sd_app_evt_wait is called. */
    uint32_t n_sd_app_evt_wait;
} profile_tickless_g;

#endif


/*-----------------------------------------------------------
 * Implementation of functions defined in portable.h for the ARM CM4F port.
 * CMSIS compatible layer to menage SysTick ticking source.
 *----------------------------------------------------------*/

#if configTICK_SOURCE == FREERTOS_USE_SYSTICK


#ifndef configSYSTICK_CLOCK_HZ
    #define configSYSTICK_CLOCK_HZ configCPU_CLOCK_HZ
    /* Ensure the SysTick is clocked at the same frequency as the core. */
    #define portNVIC_SYSTICK_CLK_BIT    ( SysTick_CTRL_CLKSOURCE_Msk )
#else
    /* The way the SysTick is clocked is not modified in case it is not the same
    as the core. */
    #define portNVIC_SYSTICK_CLK_BIT    ( 0 )
#endif


#if configUSE_TICKLESS_IDLE == 1
    #error SysTick port for RF52 does not support tickless idle. Use RTC mode instead.
#endif /* configUSE_TICKLESS_IDLE */

/*-----------------------------------------------------------*/

void xPortSysTickHandler( void )
{
    /* The SysTick runs at the lowest interrupt priority, so when this interrupt
    executes all interrupts must be unmasked.  There is therefore no need to
    save and then restore the interrupt mask value as its value is already
    known. */
    ( void ) portSET_INTERRUPT_MASK_FROM_ISR();
    {
        /* Increment the RTOS tick. */
        if ( xTaskIncrementTick() != pdFALSE )
        {
            /* A context switch is required.  Context switching is performed in
            the PendSV interrupt.  Pend the PendSV interrupt. */
            SCB->ICSR = SCB_ICSR_PENDSVSET_Msk;
        }
    }
    portCLEAR_INTERRUPT_MASK_FROM_ISR( 0 );
}

/*-----------------------------------------------------------*/

/*
 * Setup the systick timer to generate the tick interrupts at the required
 * frequency.
 */
void vPortSetupTimerInterrupt( void )
{
    /* Set interrupt priority */
    NVIC_SetPriority(SysTick_IRQn, configKERNEL_INTERRUPT_PRIORITY);
    /* Configure SysTick to interrupt at the requested rate. */
    SysTick->LOAD = ROUNDED_DIV(configSYSTICK_CLOCK_HZ, configTICK_RATE_HZ) - 1UL;
    SysTick->CTRL = ( portNVIC_SYSTICK_CLK_BIT | SysTick_CTRL_TICKINT_Msk | SysTick_CTRL_ENABLE_Msk );
}

/*-----------------------------------------------------------*/

#elif configTICK_SOURCE == FREERTOS_USE_RTC

#if configUSE_16_BIT_TICKS == 1
#error This port does not support 16 bit ticks.
#endif

#include "nrf_rtc.h"
#include "nrf_drv_clock.h"

/*-----------------------------------------------------------*/

void xPortSysTickHandler( void )
{
#if configUSE_TICKLESS_IDLE == 1
    nrf_rtc_event_clear(portNRF_RTC_REG, NRF_RTC_EVENT_COMPARE_0);
#endif

    BaseType_t switch_req = pdFALSE;
    uint32_t isrstate = portSET_INTERRUPT_MASK_FROM_ISR();

    uint32_t systick_counter = nrf_rtc_counter_get(portNRF_RTC_REG);
    nrf_rtc_event_clear(portNRF_RTC_REG, NRF_RTC_EVENT_TICK);

    if (configUSE_DISABLE_TICK_AUTO_CORRECTION_DEBUG == 0)
    {
        /* check FreeRTOSConfig.h file for more details on configUSE_DISABLE_TICK_AUTO_CORRECTION_DEBUG */
        TickType_t diff;
        diff = (systick_counter - xTaskGetTickCount()) & portNRF_RTC_MAXTICKS;

        /* At most 1 step if scheduler is suspended - the xTaskIncrementTick
         * would return the tick state from the moment when suspend function was called. */
        if ((diff > 1) && (xTaskGetSchedulerState() != taskSCHEDULER_RUNNING))
        {
            diff = 1;
        }
        while ((diff--) > 0)
        {
            switch_req |= xTaskIncrementTick();
        }
    }
    else
    {
        switch_req = xTaskIncrementTick();
    }

    /* Increment the RTOS tick as usual which checks if there is a need for rescheduling */
    if ( switch_req != pdFALSE )
    {
        /* A context switch is required.  Context switching is performed in
        the PendSV interrupt.  Pend the PendSV interrupt. */
        SCB->ICSR = SCB_ICSR_PENDSVSET_Msk;
    }

    portCLEAR_INTERRUPT_MASK_FROM_ISR( isrstate );
}

/*
 * Setup the RTC time to generate the tick interrupts at the required
 * frequency.
 */
void vPortSetupTimerInterrupt( void )
{
    /* Request LF clock */
    nrf_drv_clock_lfclk_request(NULL);

    /* Configure SysTick to interrupt at the requested rate. */
    nrf_rtc_prescaler_set(portNRF_RTC_REG, portNRF_RTC_PRESCALER);
    nrf_rtc_int_enable   (portNRF_RTC_REG, RTC_INTENSET_TICK_Msk);
    nrf_rtc_task_trigger (portNRF_RTC_REG, NRF_RTC_TASK_CLEAR);
    nrf_rtc_task_trigger (portNRF_RTC_REG, NRF_RTC_TASK_START);
    nrf_rtc_event_enable(portNRF_RTC_REG, RTC_EVTEN_OVRFLW_Msk);

    NVIC_SetPriority(portNRF_RTC_IRQn, configKERNEL_INTERRUPT_PRIORITY);
    NVIC_EnableIRQ(portNRF_RTC_IRQn);
}

#if configUSE_TICKLESS_IDLE == 1


#ifdef SOFTDEVICE_PRESENT

static inline void waitCpuCoreEvent()
{
#ifdef TRACE_LOW_POWER
    /* When tracing entry/exit to WFE MCU sleep mode use an additional critical section.
     * Interrupts are normally enabled when MCU is sleeping so interrupt handlers run immediately
     * on wake from WFE.  Without an additional critical section the interrupt handler that woke
     * MCU would have already run before the trace pin is changed resulting in an inaccurate
     * representation of the time the MCU spends asleep.
     */
    CRITICAL_REGION_ENTER();
    traceLOW_POWER_WFE_BEGIN();
#endif
    if (nrf_sdh_is_enabled()) {
        uint32_t err_code = sd_app_evt_wait();
        APP_ERROR_CHECK(err_code);
    }
    else {
        __WFE();
    }
#ifdef TRACE_LOW_POWER
    traceLOW_POWER_WFE_END();
    CRITICAL_REGION_EXIT();
#endif
}

#else

static inline void waitCpuCoreEvent()
{
    __WFE();
}

#endif

#if __FPU_PRESENT
    #define PWR_MGMT_FPU_SLEEP_PREPARE()     pwr_mgmt_fpu_sleep_prepare()

     __STATIC_INLINE void pwr_mgmt_fpu_sleep_prepare(void)
     {
        uint32_t fpscr;
        CRITICAL_REGION_ENTER();
        fpscr = __get_FPSCR();
        /*
         * Clear FPU exceptions.
         * Without this step, the FPU interrupt is marked as pending,
         * preventing system from sleeping. Exceptions cleared:
         * - IOC - Invalid Operation cumulative exception bit.
         * - DZC - Division by Zero cumulative exception bit.
         * - OFC - Overflow cumulative exception bit.
         * - UFC - Underflow cumulative exception bit.
         * - IXC - Inexact cumulative exception bit.
         * - IDC - Input Denormal cumulative exception bit.
         */
        __set_FPSCR(fpscr & ~0x9Fu);
        __DMB();
        NVIC_ClearPendingIRQ(FPU_IRQn);
        CRITICAL_REGION_EXIT();
     }
#else
    #define PWR_MGMT_FPU_SLEEP_PREPARE()
#endif


void vPortSuppressTicksAndSleep( TickType_t xExpectedIdleTime )
{
    /* Upon entry the scheduler is suspended, RTC is still generating tick interrupts. */

    /* Choose a maximum idle time much less than available maximum to allow for safe RTC counter
     * bounds checking after wakeup from sleep.
     */
    TickType_t maxIdleTime = portNRF_RTC_MAXTICKS / 2 - configEXPECTED_IDLE_TIME_BEFORE_SLEEP;
    if ( xExpectedIdleTime > maxIdleTime )
    {
        xExpectedIdleTime = maxIdleTime;
    }


    /* Block RTC interrupts only.  All other interrupt remain active so that they
     * can execute directly after WFE and possibly schedule RTOS tasks.
     */
#ifdef SOFTDEVICE_PRESENT
    do{
        uint32_t err_code = sd_nvic_DisableIRQ(portNRF_RTC_IRQn);
        APP_ERROR_CHECK(err_code);
    }while (0);
#else
    NVIC_DisableIRQ(portNRF_RTC_IRQn);
#endif

    /*
     * Implementation note:
     *
     * To help debugging the option configUSE_TICKLESS_IDLE_SIMPLE_DEBUG was presented.
     * This option would make sure that even if program execution was stopped inside
     * this function no more than expected number of ticks would be skipped.
     *
     * Normally RTC works all the time even if firmware execution was stopped
     * and that may lead to skipping too much of ticks.
     */
    TickType_t enterTime;
    enterTime = nrf_rtc_counter_get(portNRF_RTC_REG);


    if ( eTaskConfirmSleepModeStatus() != eAbortSleep )
    {
        TickType_t xModifiableIdleTime;
        TickType_t wakeupTime = (enterTime + xExpectedIdleTime) & portNRF_RTC_MAXTICKS;

        /* Stop tick events */
        nrf_rtc_int_disable(portNRF_RTC_REG, NRF_RTC_INT_TICK_MASK);

        /* Configure CTC interrupt */
        nrf_rtc_cc_set(portNRF_RTC_REG, 0, wakeupTime);
        nrf_rtc_event_clear(portNRF_RTC_REG, NRF_RTC_EVENT_COMPARE_0);
        nrf_rtc_int_enable(portNRF_RTC_REG, NRF_RTC_INT_COMPARE0_MASK);

        /* Ensure NVIC->ISPR[RTC] (Pending interrupt) for RTC is clear before entering wait loop.
         * Exit from WFE relies on generation of an event from NVIC->ISPR[RTC] transitioning from
         * 0->1 as a result of tickless timeout coming from RTC COMPARE0 interrupt event.
         */
#ifdef SOFTDEVICE_PRESENT
        {
            uint32_t err_code = sd_nvic_ClearPendingIRQ(portNRF_RTC_IRQn);
            APP_ERROR_CHECK(err_code);
        }
#else
        NVIC_ClearPendingIRQ(portNRF_RTC_IRQn);
#endif
        __DSB();

        /* Sleep until something happens.  configPRE_SLEEP_PROCESSING() can
         * set its parameter to 0 to indicate that its implementation contains
         * its own wait for interrupt or wait for event instruction, and so wfi
         * should not be executed again.  However, the original expected idle
         * time variable must remain unmodified, so a copy is taken. */
        xModifiableIdleTime = xExpectedIdleTime;
        configPRE_SLEEP_PROCESSING( xModifiableIdleTime );
        if ( xModifiableIdleTime > 0 )
        {
            {

#if PROFILE_TICKLESS_IDLE == 1
                uint32_t loopCounter = 0;
#endif

                while (1) {
                    uint32_t currentTime;

#if PROFILE_TICKLESS_IDLE == 1
                    ++profile_tickless_g.n_idle_loops;
#endif

                    /* Clear prior pending CPU events to ensure that sd_app_evt_wait() will wait
                     * on useful wakeup event rather than wakeup immediately due to events which
                     * have occurred since we last went to sleep.
                     * The only reasons to exit from idle are:
                     *  - There is a task scheduled to run
                     *  - The expected idle time has elapsed
                     */
                    __SEV();
                    __WFE();

                    if (eTaskConfirmSleepModeStatus() == eAbortSleep) {
#if PROFILE_TICKLESS_IDLE == 1
                        if (loopCounter < ARRAY_SIZE(profile_tickless_g.n_sched_idle_wakeup_loop)) {
                            ++profile_tickless_g.n_sched_idle_wakeup_loop[loopCounter];
                        }
                        ++profile_tickless_g.n_sched_idle_wakeup;
#endif
                        break;
                    }

                    currentTime = nrf_rtc_counter_get(portNRF_RTC_REG);

                    /* Is current RTC count outside of the window that CPU is expected to sleep?
                     * Account for case where RTC wakeup time may overflow.
                     */
                    if (wakeupTime < enterTime) {
                        if (currentTime >= wakeupTime && currentTime < enterTime) {
#if PROFILE_TICKLESS_IDLE == 1
                            if (loopCounter < ARRAY_SIZE(profile_tickless_g.n_rtc_idle_wakeup_loop)) {
                                ++profile_tickless_g.n_rtc_idle_wakeup_loop[loopCounter];
                            }
                            ++profile_tickless_g.n_rtc_idle_wakeup;
#endif
                            break;
                        }
                    }
                    else {
                        if (currentTime < enterTime || currentTime >= wakeupTime) {
#if PROFILE_TICKLESS_IDLE == 1
                            if (loopCounter < ARRAY_SIZE(profile_tickless_g.n_rtc_idle_wakeup_loop)) {
                                ++profile_tickless_g.n_rtc_idle_wakeup_loop[loopCounter];
                            }
                            ++profile_tickless_g.n_rtc_idle_wakeup;
#endif
                            break;
                        }
                    }

#if PROFILE_TICKLESS_IDLE == 1
                    ++profile_tickless_g.n_sd_app_evt_wait;
                    if (loopCounter != 0) {
                        ++profile_tickless_g.n_cpu_wake_no_rtc_or_sched;
                    }
#endif
                    PWR_MGMT_FPU_SLEEP_PREPARE();
                    waitCpuCoreEvent();

#if PROFILE_TICKLESS_IDLE == 1
                    ++loopCounter;
#endif
                }
            }
        }
        configPOST_SLEEP_PROCESSING( xExpectedIdleTime );

        nrf_rtc_int_disable(portNRF_RTC_REG, NRF_RTC_INT_COMPARE0_MASK);
        nrf_rtc_event_clear(portNRF_RTC_REG, NRF_RTC_EVENT_COMPARE_0);

        /* Correct the system ticks */
        {
            TickType_t diff;
            TickType_t exitTime;

            nrf_rtc_event_clear(portNRF_RTC_REG, NRF_RTC_EVENT_TICK);
            nrf_rtc_int_enable (portNRF_RTC_REG, NRF_RTC_INT_TICK_MASK);

            exitTime = nrf_rtc_counter_get(portNRF_RTC_REG);
            diff =  (exitTime - enterTime) & portNRF_RTC_MAXTICKS;

            /* It is important that we clear pending here so that our corrections are latest and in sync with tick_interrupt handler */
#ifdef SOFTDEVICE_PRESENT
            {
              uint32_t err_code = sd_nvic_ClearPendingIRQ(portNRF_RTC_IRQn);
              APP_ERROR_CHECK(err_code);
            }
#else
            NVIC_ClearPendingIRQ(portNRF_RTC_IRQn);
#endif

            if ((configUSE_TICKLESS_IDLE_SIMPLE_DEBUG) && (diff > xExpectedIdleTime))
            {
                diff = xExpectedIdleTime;
            }

            if (diff > 0)
            {
                vTaskStepTick(diff);
            }
        }
    }

#ifdef SOFTDEVICE_PRESENT
    uint32_t err_code = sd_nvic_EnableIRQ(portNRF_RTC_IRQn);
    APP_ERROR_CHECK(err_code);
#else
    NVIC_EnableIRQ(portNRF_RTC_IRQn);
#endif
}

#endif // configUSE_TICKLESS_IDLE

#else // configTICK_SOURCE
    #error  Unsupported configTICK_SOURCE value
#endif // configTICK_SOURCE == FREERTOS_USE_SYSTICK