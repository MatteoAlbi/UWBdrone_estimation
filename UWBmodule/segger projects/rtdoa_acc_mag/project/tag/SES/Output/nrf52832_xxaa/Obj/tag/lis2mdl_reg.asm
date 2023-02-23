	.cpu cortex-m4
	.arch armv7e-m
	.fpu fpv4-sp-d16
	.eabi_attribute 27, 1
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 38, 1
	.eabi_attribute 18, 4
	.file	"lis2mdl_reg.c"
	.text
.Ltext0:
	.section	.text.sd_mutex_new,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_mutex_new, %function
sd_mutex_new:
.LFB124:
	.file 1 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h"
	.loc 1 391 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 391 1
	.syntax unified
@ 391 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #43
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE124:
	.size	sd_mutex_new, .-sd_mutex_new
	.section	.text.sd_mutex_acquire,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_mutex_acquire, %function
sd_mutex_acquire:
.LFB125:
	.loc 1 400 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 400 1
	.syntax unified
@ 400 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #44
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE125:
	.size	sd_mutex_acquire, .-sd_mutex_acquire
	.section	.text.sd_mutex_release,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_mutex_release, %function
sd_mutex_release:
.LFB126:
	.loc 1 408 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 408 1
	.syntax unified
@ 408 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #45
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE126:
	.size	sd_mutex_release, .-sd_mutex_release
	.section	.text.sd_rand_application_pool_capacity_get,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_rand_application_pool_capacity_get, %function
sd_rand_application_pool_capacity_get:
.LFB127:
	.loc 1 416 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 416 1
	.syntax unified
@ 416 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #46
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE127:
	.size	sd_rand_application_pool_capacity_get, .-sd_rand_application_pool_capacity_get
	.section	.text.sd_rand_application_bytes_available_get,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_rand_application_bytes_available_get, %function
sd_rand_application_bytes_available_get:
.LFB128:
	.loc 1 424 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 424 1
	.syntax unified
@ 424 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #47
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE128:
	.size	sd_rand_application_bytes_available_get, .-sd_rand_application_bytes_available_get
	.section	.text.sd_rand_application_vector_get,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_rand_application_vector_get, %function
sd_rand_application_vector_get:
.LFB129:
	.loc 1 434 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 434 1
	.syntax unified
@ 434 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #48
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE129:
	.size	sd_rand_application_vector_get, .-sd_rand_application_vector_get
	.section	.text.sd_power_reset_reason_get,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_power_reset_reason_get, %function
sd_power_reset_reason_get:
.LFB130:
	.loc 1 442 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 442 1
	.syntax unified
@ 442 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #51
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE130:
	.size	sd_power_reset_reason_get, .-sd_power_reset_reason_get
	.section	.text.sd_power_reset_reason_clr,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_power_reset_reason_clr, %function
sd_power_reset_reason_clr:
.LFB131:
	.loc 1 450 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 450 1
	.syntax unified
@ 450 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #52
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE131:
	.size	sd_power_reset_reason_clr, .-sd_power_reset_reason_clr
	.section	.text.sd_power_mode_set,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_power_mode_set, %function
sd_power_mode_set:
.LFB132:
	.loc 1 459 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 459 1
	.syntax unified
@ 459 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #49
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE132:
	.size	sd_power_mode_set, .-sd_power_mode_set
	.section	.text.sd_power_system_off,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_power_system_off, %function
sd_power_system_off:
.LFB133:
	.loc 1 465 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 465 1
	.syntax unified
@ 465 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #50
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE133:
	.size	sd_power_system_off, .-sd_power_system_off
	.section	.text.sd_power_pof_enable,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_power_pof_enable, %function
sd_power_pof_enable:
.LFB134:
	.loc 1 476 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 476 1
	.syntax unified
@ 476 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #53
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE134:
	.size	sd_power_pof_enable, .-sd_power_pof_enable
	.section	.text.sd_power_pof_threshold_set,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_power_pof_threshold_set, %function
sd_power_pof_threshold_set:
.LFB135:
	.loc 1 485 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 485 1
	.syntax unified
@ 485 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #54
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE135:
	.size	sd_power_pof_threshold_set, .-sd_power_pof_threshold_set
	.section	.text.sd_power_ram_power_set,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_power_ram_power_set, %function
sd_power_ram_power_set:
.LFB136:
	.loc 1 494 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 494 1
	.syntax unified
@ 494 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #55
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE136:
	.size	sd_power_ram_power_set, .-sd_power_ram_power_set
	.section	.text.sd_power_ram_power_clr,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_power_ram_power_clr, %function
sd_power_ram_power_clr:
.LFB137:
	.loc 1 503 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 503 1
	.syntax unified
@ 503 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #56
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE137:
	.size	sd_power_ram_power_clr, .-sd_power_ram_power_clr
	.section	.text.sd_power_ram_power_get,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_power_ram_power_get, %function
sd_power_ram_power_get:
.LFB138:
	.loc 1 512 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 512 1
	.syntax unified
@ 512 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #57
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE138:
	.size	sd_power_ram_power_get, .-sd_power_ram_power_get
	.section	.text.sd_power_gpregret_set,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_power_gpregret_set, %function
sd_power_gpregret_set:
.LFB139:
	.loc 1 521 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 521 1
	.syntax unified
@ 521 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #58
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE139:
	.size	sd_power_gpregret_set, .-sd_power_gpregret_set
	.section	.text.sd_power_gpregret_clr,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_power_gpregret_clr, %function
sd_power_gpregret_clr:
.LFB140:
	.loc 1 530 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 530 1
	.syntax unified
@ 530 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #59
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE140:
	.size	sd_power_gpregret_clr, .-sd_power_gpregret_clr
	.section	.text.sd_power_gpregret_get,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_power_gpregret_get, %function
sd_power_gpregret_get:
.LFB141:
	.loc 1 539 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 539 1
	.syntax unified
@ 539 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #60
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE141:
	.size	sd_power_gpregret_get, .-sd_power_gpregret_get
	.section	.text.sd_power_dcdc_mode_set,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_power_dcdc_mode_set, %function
sd_power_dcdc_mode_set:
.LFB142:
	.loc 1 550 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 550 1
	.syntax unified
@ 550 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #61
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE142:
	.size	sd_power_dcdc_mode_set, .-sd_power_dcdc_mode_set
	.section	.text.sd_clock_hfclk_request,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_clock_hfclk_request, %function
sd_clock_hfclk_request:
.LFB143:
	.loc 1 562 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 562 1
	.syntax unified
@ 562 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #63
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE143:
	.size	sd_clock_hfclk_request, .-sd_clock_hfclk_request
	.section	.text.sd_clock_hfclk_release,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_clock_hfclk_release, %function
sd_clock_hfclk_release:
.LFB144:
	.loc 1 573 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 573 1
	.syntax unified
@ 573 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #64
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE144:
	.size	sd_clock_hfclk_release, .-sd_clock_hfclk_release
	.section	.text.sd_clock_hfclk_is_running,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_clock_hfclk_is_running, %function
sd_clock_hfclk_is_running:
.LFB145:
	.loc 1 584 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 584 1
	.syntax unified
@ 584 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #65
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE145:
	.size	sd_clock_hfclk_is_running, .-sd_clock_hfclk_is_running
	.section	.text.sd_app_evt_wait,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_app_evt_wait, %function
sd_app_evt_wait:
.LFB146:
	.loc 1 612 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 612 1
	.syntax unified
@ 612 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #62
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE146:
	.size	sd_app_evt_wait, .-sd_app_evt_wait
	.section	.text.sd_ppi_channel_enable_get,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_ppi_channel_enable_get, %function
sd_ppi_channel_enable_get:
.LFB147:
	.loc 1 620 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 620 1
	.syntax unified
@ 620 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #32
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE147:
	.size	sd_ppi_channel_enable_get, .-sd_ppi_channel_enable_get
	.section	.text.sd_ppi_channel_enable_set,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_ppi_channel_enable_set, %function
sd_ppi_channel_enable_set:
.LFB148:
	.loc 1 628 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 628 1
	.syntax unified
@ 628 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #33
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE148:
	.size	sd_ppi_channel_enable_set, .-sd_ppi_channel_enable_set
	.section	.text.sd_ppi_channel_enable_clr,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_ppi_channel_enable_clr, %function
sd_ppi_channel_enable_clr:
.LFB149:
	.loc 1 636 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 636 1
	.syntax unified
@ 636 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #34
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE149:
	.size	sd_ppi_channel_enable_clr, .-sd_ppi_channel_enable_clr
	.section	.text.sd_ppi_channel_assign,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_ppi_channel_assign, %function
sd_ppi_channel_assign:
.LFB150:
	.loc 1 647 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 647 1
	.syntax unified
@ 647 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #35
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE150:
	.size	sd_ppi_channel_assign, .-sd_ppi_channel_assign
	.section	.text.sd_ppi_group_task_enable,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_ppi_group_task_enable, %function
sd_ppi_group_task_enable:
.LFB151:
	.loc 1 656 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 656 1
	.syntax unified
@ 656 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #36
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE151:
	.size	sd_ppi_group_task_enable, .-sd_ppi_group_task_enable
	.section	.text.sd_ppi_group_task_disable,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_ppi_group_task_disable, %function
sd_ppi_group_task_disable:
.LFB152:
	.loc 1 665 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 665 1
	.syntax unified
@ 665 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #37
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE152:
	.size	sd_ppi_group_task_disable, .-sd_ppi_group_task_disable
	.section	.text.sd_ppi_group_assign,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_ppi_group_assign, %function
sd_ppi_group_assign:
.LFB153:
	.loc 1 675 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 675 1
	.syntax unified
@ 675 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #38
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE153:
	.size	sd_ppi_group_assign, .-sd_ppi_group_assign
	.section	.text.sd_ppi_group_get,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_ppi_group_get, %function
sd_ppi_group_get:
.LFB154:
	.loc 1 685 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 685 1
	.syntax unified
@ 685 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #39
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE154:
	.size	sd_ppi_group_get, .-sd_ppi_group_get
	.section	.text.sd_radio_notification_cfg_set,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_radio_notification_cfg_set, %function
sd_radio_notification_cfg_set:
.LFB155:
	.loc 1 716 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 716 1
	.syntax unified
@ 716 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #66
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE155:
	.size	sd_radio_notification_cfg_set, .-sd_radio_notification_cfg_set
	.section	.text.sd_ecb_block_encrypt,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_ecb_block_encrypt, %function
sd_ecb_block_encrypt:
.LFB156:
	.loc 1 732 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 732 1
	.syntax unified
@ 732 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #67
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE156:
	.size	sd_ecb_block_encrypt, .-sd_ecb_block_encrypt
	.section	.text.sd_ecb_blocks_encrypt,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_ecb_blocks_encrypt, %function
sd_ecb_blocks_encrypt:
.LFB157:
	.loc 1 749 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 749 1
	.syntax unified
@ 749 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #68
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE157:
	.size	sd_ecb_blocks_encrypt, .-sd_ecb_blocks_encrypt
	.section	.text.sd_evt_get,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_evt_get, %function
sd_evt_get:
.LFB158:
	.loc 1 760 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 760 1
	.syntax unified
@ 760 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #72
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE158:
	.size	sd_evt_get, .-sd_evt_get
	.section	.text.sd_temp_get,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_temp_get, %function
sd_temp_get:
.LFB159:
	.loc 1 771 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 771 1
	.syntax unified
@ 771 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #73
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE159:
	.size	sd_temp_get, .-sd_temp_get
	.section	.text.sd_flash_write,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_flash_write, %function
sd_flash_write:
.LFB160:
	.loc 1 806 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 806 1
	.syntax unified
@ 806 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #41
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE160:
	.size	sd_flash_write, .-sd_flash_write
	.section	.text.sd_flash_page_erase,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_flash_page_erase, %function
sd_flash_page_erase:
.LFB161:
	.loc 1 836 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 836 1
	.syntax unified
@ 836 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #40
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE161:
	.size	sd_flash_page_erase, .-sd_flash_page_erase
	.section	.text.sd_flash_protect,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_flash_protect, %function
sd_flash_protect:
.LFB162:
	.loc 1 858 1
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 858 1
	.syntax unified
@ 858 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #42
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE162:
	.size	sd_flash_protect, .-sd_flash_protect
	.section	.text.sd_radio_session_open,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_radio_session_open, %function
sd_radio_session_open:
.LFB163:
	.loc 1 880 2
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 880 2
	.syntax unified
@ 880 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #69
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE163:
	.size	sd_radio_session_open, .-sd_radio_session_open
	.section	.text.sd_radio_session_close,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_radio_session_close, %function
sd_radio_session_close:
.LFB164:
	.loc 1 893 2
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 893 2
	.syntax unified
@ 893 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #70
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE164:
	.size	sd_radio_session_close, .-sd_radio_session_close
	.section	.text.sd_radio_request,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	sd_radio_request, %function
sd_radio_request:
.LFB165:
	.loc 1 925 2
	@ Naked Function: prologue and epilogue provided by programmer.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 925 2
	.syntax unified
@ 925 "../../../nRF5_SDK_14.2.0/components/softdevice/s132/headers/nrf_soc.h" 1
	svc #71
bx r14
@ 0 "" 2
	.thumb
	.syntax unified
	nop
	mov	r0, r3
.LFE165:
	.size	sd_radio_request, .-sd_radio_request
	.section	.data.config,"aw"
	.align	2
	.type	config, %object
	.size	config, 12
config:
	.byte	5
	.byte	2
	.byte	36
	.byte	1
	.byte	10
	.byte	10
	.byte	0
	.byte	2
	.byte	0
	.space	1
	.short	249
	.section	.text.lis2mdl_read_reg,"ax",%progbits
	.align	1
	.global	lis2mdl_read_reg
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_read_reg, %function
lis2mdl_read_reg:
.LFB232:
	.file 2 "E:\\matte\\Documents\\uni\\master EIT\\1st year\\2nd semester\\UV\\UWBdrone_estimation\\UWBmodule\\segger projects\\rtdoa_acc_mag\\project\\tag\\SES\\LIS2MDL\\lis2mdl_reg.c"
	.loc 2 47 66
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI0:
	sub	sp, sp, #12
.LCFI1:
	mov	r3, r0
	str	r1, [sp]
	strb	r3, [sp, #7]
	mov	r3, r2
	strb	r3, [sp, #6]
	.loc 2 49 10
	ldrb	r3, [sp, #6]	@ zero_extendqisi2
	ldrb	r1, [sp, #7]	@ zero_extendqisi2
	ldr	r2, [sp]
	movs	r0, #30
	bl	vTWI_Read
	mov	r3, r0
	.loc 2 51 1
	mov	r0, r3
	add	sp, sp, #12
.LCFI2:
	@ sp needed
	ldr	pc, [sp], #4
.LFE232:
	.size	lis2mdl_read_reg, .-lis2mdl_read_reg
	.section	.text.lis2mdl_write_reg,"ax",%progbits
	.align	1
	.global	lis2mdl_write_reg
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_write_reg, %function
lis2mdl_write_reg:
.LFB233:
	.loc 2 61 67
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI3:
	sub	sp, sp, #12
.LCFI4:
	mov	r3, r0
	str	r1, [sp]
	strb	r3, [sp, #7]
	mov	r3, r2
	strb	r3, [sp, #6]
	.loc 2 64 11
	ldrb	r3, [sp, #6]	@ zero_extendqisi2
	ldrb	r1, [sp, #7]	@ zero_extendqisi2
	ldr	r2, [sp]
	movs	r0, #30
	bl	vTWI_Write_my
	mov	r3, r0
	.loc 2 66 1
	mov	r0, r3
	add	sp, sp, #12
.LCFI5:
	@ sp needed
	ldr	pc, [sp], #4
.LFE233:
	.size	lis2mdl_write_reg, .-lis2mdl_write_reg
	.section	.text.lis2mdl_from_lsb_to_mgauss,"ax",%progbits
	.align	1
	.global	lis2mdl_from_lsb_to_mgauss
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_from_lsb_to_mgauss, %function
lis2mdl_from_lsb_to_mgauss:
.LFB234:
	.loc 2 79 48
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #8
.LCFI6:
	mov	r3, r0
	strh	r3, [sp, #6]	@ movhi
	.loc 2 81 11
	ldrsh	r3, [sp, #6]
	vmov	s15, r3	@ int
	vcvt.f32.s32	s15, s15
	.loc 2 81 24
	vmov.f32	s14, #1.5e+0
	vmul.f32	s15, s15, s14
	.loc 2 82 1
	vmov.f32	s0, s15
	add	sp, sp, #8
.LCFI7:
	@ sp needed
	bx	lr
.LFE234:
	.size	lis2mdl_from_lsb_to_mgauss, .-lis2mdl_from_lsb_to_mgauss
	.section	.text.lis2mdl_from_lsb_to_celsius,"ax",%progbits
	.align	1
	.global	lis2mdl_from_lsb_to_celsius
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_from_lsb_to_celsius, %function
lis2mdl_from_lsb_to_celsius:
.LFB235:
	.loc 2 84 49
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #8
.LCFI8:
	mov	r3, r0
	strh	r3, [sp, #6]	@ movhi
	.loc 2 86 12
	ldrsh	r3, [sp, #6]
	vmov	s15, r3	@ int
	vcvt.f32.s32	s14, s15
	.loc 2 86 25
	vmov.f32	s13, #8.0e+0
	vdiv.f32	s15, s14, s13
	.loc 2 86 33
	vmov.f32	s14, #2.5e+1
	vadd.f32	s15, s15, s14
	.loc 2 87 1
	vmov.f32	s0, s15
	add	sp, sp, #8
.LCFI9:
	@ sp needed
	bx	lr
.LFE235:
	.size	lis2mdl_from_lsb_to_celsius, .-lis2mdl_from_lsb_to_celsius
	.section	.text.lis2mdl_mag_user_offset_set,"ax",%progbits
	.align	1
	.global	lis2mdl_mag_user_offset_set
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_mag_user_offset_set, %function
lis2mdl_mag_user_offset_set:
.LFB236:
	.loc 2 113 50
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI10:
	sub	sp, sp, #20
.LCFI11:
	str	r0, [sp, #4]
	.loc 2 116 36
	ldr	r3, [sp, #4]
	ldrsh	r3, [r3]
	.loc 2 116 23
	uxth	r3, r3
	.loc 2 116 13
	lsrs	r3, r3, #8
	uxth	r3, r3
	uxtb	r3, r3
	.loc 2 116 11
	strb	r3, [sp, #9]
	.loc 2 117 36
	ldr	r3, [sp, #4]
	ldrsh	r3, [r3]
	.loc 2 117 13
	uxtb	r3, r3
	.loc 2 117 11
	strb	r3, [sp, #8]
	.loc 2 118 36
	ldr	r3, [sp, #4]
	adds	r3, r3, #2
	ldrsh	r3, [r3]
	.loc 2 118 23
	uxth	r3, r3
	.loc 2 118 13
	lsrs	r3, r3, #8
	uxth	r3, r3
	uxtb	r3, r3
	.loc 2 118 11
	strb	r3, [sp, #11]
	.loc 2 119 36
	ldr	r3, [sp, #4]
	adds	r3, r3, #2
	ldrsh	r3, [r3]
	.loc 2 119 13
	uxtb	r3, r3
	.loc 2 119 11
	strb	r3, [sp, #10]
	.loc 2 120 36
	ldr	r3, [sp, #4]
	adds	r3, r3, #4
	ldrsh	r3, [r3]
	.loc 2 120 23
	uxth	r3, r3
	.loc 2 120 13
	lsrs	r3, r3, #8
	uxth	r3, r3
	uxtb	r3, r3
	.loc 2 120 11
	strb	r3, [sp, #13]
	.loc 2 121 36
	ldr	r3, [sp, #4]
	adds	r3, r3, #4
	ldrsh	r3, [r3]
	.loc 2 121 13
	uxtb	r3, r3
	.loc 2 121 11
	strb	r3, [sp, #12]
	.loc 2 123 10
	add	r3, sp, #8
	movs	r2, #6
	mov	r1, r3
	movs	r0, #69
	bl	lis2mdl_write_reg
	mov	r3, r0
	.loc 2 124 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI12:
	@ sp needed
	ldr	pc, [sp], #4
.LFE236:
	.size	lis2mdl_mag_user_offset_set, .-lis2mdl_mag_user_offset_set
	.section	.text.lis2mdl_mag_user_offset_get,"ax",%progbits
	.align	1
	.global	lis2mdl_mag_user_offset_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_mag_user_offset_get, %function
lis2mdl_mag_user_offset_get:
.LFB237:
	.loc 2 137 50
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI13:
	sub	sp, sp, #28
.LCFI14:
	str	r0, [sp, #4]
	.loc 2 142 9
	add	r3, sp, #12
	movs	r2, #6
	mov	r1, r3
	movs	r0, #69
	bl	lis2mdl_read_reg
	str	r0, [sp, #20]
	.loc 2 144 25
	ldrb	r3, [sp, #13]	@ zero_extendqisi2
	.loc 2 144 12
	sxth	r2, r3
	.loc 2 144 10
	ldr	r3, [sp, #4]
	strh	r2, [r3]	@ movhi
	.loc 2 145 16
	ldr	r3, [sp, #4]
	ldrsh	r3, [r3]
	uxth	r3, r3
	.loc 2 145 20
	lsls	r3, r3, #8
	uxth	r2, r3
	.loc 2 145 42
	ldrb	r3, [sp, #12]	@ zero_extendqisi2
	uxth	r3, r3
	.loc 2 145 27
	add	r3, r3, r2
	uxth	r3, r3
	sxth	r2, r3
	.loc 2 145 10
	ldr	r3, [sp, #4]
	strh	r2, [r3]	@ movhi
	.loc 2 146 25
	ldrb	r2, [sp, #15]	@ zero_extendqisi2
	.loc 2 146 6
	ldr	r3, [sp, #4]
	adds	r3, r3, #2
	.loc 2 146 12
	sxth	r2, r2
	.loc 2 146 10
	strh	r2, [r3]	@ movhi
	.loc 2 147 16
	ldr	r3, [sp, #4]
	adds	r3, r3, #2
	ldrsh	r3, [r3]
	uxth	r3, r3
	.loc 2 147 20
	lsls	r3, r3, #8
	uxth	r2, r3
	.loc 2 147 42
	ldrb	r3, [sp, #14]	@ zero_extendqisi2
	uxth	r3, r3
	.loc 2 147 27
	add	r3, r3, r2
	uxth	r2, r3
	.loc 2 147 6
	ldr	r3, [sp, #4]
	adds	r3, r3, #2
	.loc 2 147 27
	sxth	r2, r2
	.loc 2 147 10
	strh	r2, [r3]	@ movhi
	.loc 2 148 25
	ldrb	r2, [sp, #17]	@ zero_extendqisi2
	.loc 2 148 6
	ldr	r3, [sp, #4]
	adds	r3, r3, #4
	.loc 2 148 12
	sxth	r2, r2
	.loc 2 148 10
	strh	r2, [r3]	@ movhi
	.loc 2 149 16
	ldr	r3, [sp, #4]
	adds	r3, r3, #4
	ldrsh	r3, [r3]
	uxth	r3, r3
	.loc 2 149 20
	lsls	r3, r3, #8
	uxth	r2, r3
	.loc 2 149 42
	ldrb	r3, [sp, #16]	@ zero_extendqisi2
	uxth	r3, r3
	.loc 2 149 27
	add	r3, r3, r2
	uxth	r2, r3
	.loc 2 149 6
	ldr	r3, [sp, #4]
	adds	r3, r3, #4
	.loc 2 149 27
	sxth	r2, r2
	.loc 2 149 10
	strh	r2, [r3]	@ movhi
	.loc 2 151 10
	ldr	r3, [sp, #20]
	.loc 2 152 1
	mov	r0, r3
	add	sp, sp, #28
.LCFI15:
	@ sp needed
	ldr	pc, [sp], #4
.LFE237:
	.size	lis2mdl_mag_user_offset_get, .-lis2mdl_mag_user_offset_get
	.section	.text.lis2mdl_operating_mode_set,"ax",%progbits
	.align	1
	.global	lis2mdl_operating_mode_set
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_operating_mode_set, %function
lis2mdl_operating_mode_set:
.LFB238:
	.loc 2 161 53
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI16:
	sub	sp, sp, #20
.LCFI17:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 2 165 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #96
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 167 6
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L56
	.loc 2 169 14
	ldrb	r3, [sp, #7]
	and	r3, r3, #3
	uxtb	r2, r3
	.loc 2 169 12
	ldrb	r3, [sp, #8]
	bfi	r3, r2, #0, #2
	strb	r3, [sp, #8]
	.loc 2 170 11
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #96
	bl	lis2mdl_write_reg
	str	r0, [sp, #12]
.L56:
	.loc 2 173 10
	ldr	r3, [sp, #12]
	.loc 2 174 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI18:
	@ sp needed
	ldr	pc, [sp], #4
.LFE238:
	.size	lis2mdl_operating_mode_set, .-lis2mdl_operating_mode_set
	.section	.text.lis2mdl_operating_mode_get,"ax",%progbits
	.align	1
	.global	lis2mdl_operating_mode_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_operating_mode_get, %function
lis2mdl_operating_mode_get:
.LFB239:
	.loc 2 183 54
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI19:
	sub	sp, sp, #20
.LCFI20:
	str	r0, [sp, #4]
	.loc 2 188 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #96
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 190 14
	ldrb	r3, [sp, #8]
	ubfx	r3, r3, #0, #2
	uxtb	r3, r3
	.loc 2 190 3
	cmp	r3, #2
	beq	.L59
	cmp	r3, #2
	bgt	.L60
	cmp	r3, #0
	beq	.L61
	cmp	r3, #1
	beq	.L62
	b	.L60
.L59:
	.loc 2 193 12
	ldr	r3, [sp, #4]
	movs	r2, #2
	strb	r2, [r3]
	.loc 2 194 7
	b	.L63
.L61:
	.loc 2 197 12
	ldr	r3, [sp, #4]
	movs	r2, #0
	strb	r2, [r3]
	.loc 2 198 7
	b	.L63
.L62:
	.loc 2 201 12
	ldr	r3, [sp, #4]
	movs	r2, #1
	strb	r2, [r3]
	.loc 2 202 7
	b	.L63
.L60:
	.loc 2 205 12
	ldr	r3, [sp, #4]
	movs	r2, #2
	strb	r2, [r3]
	.loc 2 206 7
	nop
.L63:
	.loc 2 209 10
	ldr	r3, [sp, #12]
	.loc 2 211 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI21:
	@ sp needed
	ldr	pc, [sp], #4
.LFE239:
	.size	lis2mdl_operating_mode_get, .-lis2mdl_operating_mode_get
	.section	.text.lis2mdl_data_rate_set,"ax",%progbits
	.align	1
	.global	lis2mdl_data_rate_set
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_data_rate_set, %function
lis2mdl_data_rate_set:
.LFB240:
	.loc 2 220 49
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI22:
	sub	sp, sp, #20
.LCFI23:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 2 224 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #96
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 226 6
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L66
	.loc 2 228 15
	ldrb	r3, [sp, #7]
	and	r3, r3, #3
	uxtb	r2, r3
	.loc 2 228 13
	ldrb	r3, [sp, #8]
	bfi	r3, r2, #2, #2
	strb	r3, [sp, #8]
	.loc 2 229 11
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #96
	bl	lis2mdl_write_reg
	str	r0, [sp, #12]
.L66:
	.loc 2 232 10
	ldr	r3, [sp, #12]
	.loc 2 233 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI24:
	@ sp needed
	ldr	pc, [sp], #4
.LFE240:
	.size	lis2mdl_data_rate_set, .-lis2mdl_data_rate_set
	.section	.text.lis2mdl_data_rate_get,"ax",%progbits
	.align	1
	.global	lis2mdl_data_rate_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_data_rate_get, %function
lis2mdl_data_rate_get:
.LFB241:
	.loc 2 242 50
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI25:
	sub	sp, sp, #20
.LCFI26:
	str	r0, [sp, #4]
	.loc 2 246 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #96
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 248 14
	ldrb	r3, [sp, #8]
	ubfx	r3, r3, #2, #2
	uxtb	r3, r3
	.loc 2 248 3
	cmp	r3, #3
	bhi	.L69
	adr	r2, .L71
	ldr	pc, [r2, r3, lsl #2]
	.p2align 2
.L71:
	.word	.L74+1
	.word	.L73+1
	.word	.L72+1
	.word	.L70+1
	.p2align 1
.L74:
	.loc 2 251 12
	ldr	r3, [sp, #4]
	movs	r2, #0
	strb	r2, [r3]
	.loc 2 252 7
	b	.L75
.L73:
	.loc 2 255 12
	ldr	r3, [sp, #4]
	movs	r2, #1
	strb	r2, [r3]
	.loc 2 256 7
	b	.L75
.L72:
	.loc 2 259 12
	ldr	r3, [sp, #4]
	movs	r2, #2
	strb	r2, [r3]
	.loc 2 260 7
	b	.L75
.L70:
	.loc 2 263 12
	ldr	r3, [sp, #4]
	movs	r2, #3
	strb	r2, [r3]
	.loc 2 264 7
	b	.L75
.L69:
	.loc 2 267 12
	ldr	r3, [sp, #4]
	movs	r2, #0
	strb	r2, [r3]
	.loc 2 268 7
	nop
.L75:
	.loc 2 271 10
	ldr	r3, [sp, #12]
	.loc 2 272 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI27:
	@ sp needed
	ldr	pc, [sp], #4
.LFE241:
	.size	lis2mdl_data_rate_get, .-lis2mdl_data_rate_get
	.section	.text.lis2mdl_power_mode_set,"ax",%progbits
	.align	1
	.global	lis2mdl_power_mode_set
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_power_mode_set, %function
lis2mdl_power_mode_set:
.LFB242:
	.loc 2 281 49
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI28:
	sub	sp, sp, #20
.LCFI29:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 2 286 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #96
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 288 6
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L78
	.loc 2 290 14
	ldrb	r3, [sp, #7]
	and	r3, r3, #1
	uxtb	r2, r3
	.loc 2 290 12
	ldrb	r3, [sp, #8]
	bfi	r3, r2, #4, #1
	strb	r3, [sp, #8]
	.loc 2 291 11
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #96
	bl	lis2mdl_write_reg
	str	r0, [sp, #12]
.L78:
	.loc 2 294 10
	ldr	r3, [sp, #12]
	.loc 2 295 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI30:
	@ sp needed
	ldr	pc, [sp], #4
.LFE242:
	.size	lis2mdl_power_mode_set, .-lis2mdl_power_mode_set
	.section	.text.lis2mdl_power_mode_get,"ax",%progbits
	.align	1
	.global	lis2mdl_power_mode_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_power_mode_get, %function
lis2mdl_power_mode_get:
.LFB243:
	.loc 2 304 51
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI31:
	sub	sp, sp, #20
.LCFI32:
	str	r0, [sp, #4]
	.loc 2 309 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #96
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 311 14
	ldrb	r3, [sp, #8]
	ubfx	r3, r3, #4, #1
	uxtb	r3, r3
	.loc 2 311 3
	cmp	r3, #0
	beq	.L81
	cmp	r3, #1
	beq	.L82
	b	.L86
.L81:
	.loc 2 314 12
	ldr	r3, [sp, #4]
	movs	r2, #0
	strb	r2, [r3]
	.loc 2 315 7
	b	.L84
.L82:
	.loc 2 318 12
	ldr	r3, [sp, #4]
	movs	r2, #1
	strb	r2, [r3]
	.loc 2 319 7
	b	.L84
.L86:
	.loc 2 322 12
	ldr	r3, [sp, #4]
	movs	r2, #0
	strb	r2, [r3]
	.loc 2 323 7
	nop
.L84:
	.loc 2 326 10
	ldr	r3, [sp, #12]
	.loc 2 327 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI33:
	@ sp needed
	ldr	pc, [sp], #4
.LFE243:
	.size	lis2mdl_power_mode_get, .-lis2mdl_power_mode_get
	.section	.text.lis2mdl_offset_temp_comp_set,"ax",%progbits
	.align	1
	.global	lis2mdl_offset_temp_comp_set
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_offset_temp_comp_set, %function
lis2mdl_offset_temp_comp_set:
.LFB244:
	.loc 2 337 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI34:
	sub	sp, sp, #20
.LCFI35:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 2 341 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #96
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 343 6
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L88
	.loc 2 345 22
	ldrb	r3, [sp, #7]
	and	r3, r3, #1
	uxtb	r2, r3
	ldrb	r3, [sp, #8]
	bfi	r3, r2, #7, #1
	strb	r3, [sp, #8]
	.loc 2 346 11
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #96
	bl	lis2mdl_write_reg
	str	r0, [sp, #12]
.L88:
	.loc 2 349 10
	ldr	r3, [sp, #12]
	.loc 2 350 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI36:
	@ sp needed
	ldr	pc, [sp], #4
.LFE244:
	.size	lis2mdl_offset_temp_comp_set, .-lis2mdl_offset_temp_comp_set
	.section	.text.lis2mdl_offset_temp_comp_get,"ax",%progbits
	.align	1
	.global	lis2mdl_offset_temp_comp_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_offset_temp_comp_get, %function
lis2mdl_offset_temp_comp_get:
.LFB245:
	.loc 2 359 51
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI37:
	sub	sp, sp, #20
.LCFI38:
	str	r0, [sp, #4]
	.loc 2 364 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #96
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 366 13
	ldrb	r3, [sp, #8]
	ubfx	r3, r3, #7, #1
	uxtb	r3, r3
	mov	r2, r3
	.loc 2 366 8
	ldr	r3, [sp, #4]
	strb	r2, [r3]
	.loc 2 368 10
	ldr	r3, [sp, #12]
	.loc 2 369 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI39:
	@ sp needed
	ldr	pc, [sp], #4
.LFE245:
	.size	lis2mdl_offset_temp_comp_get, .-lis2mdl_offset_temp_comp_get
	.section	.text.lis2mdl_low_pass_bandwidth_set,"ax",%progbits
	.align	1
	.global	lis2mdl_low_pass_bandwidth_set
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_low_pass_bandwidth_set, %function
lis2mdl_low_pass_bandwidth_set:
.LFB246:
	.loc 2 378 59
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI40:
	sub	sp, sp, #20
.LCFI41:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 2 383 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #97
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 385 6
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L93
	.loc 2 387 15
	ldrb	r3, [sp, #7]
	and	r3, r3, #1
	uxtb	r2, r3
	.loc 2 387 13
	ldrb	r3, [sp, #8]
	bfi	r3, r2, #0, #1
	strb	r3, [sp, #8]
	.loc 2 388 11
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #97
	bl	lis2mdl_write_reg
	str	r0, [sp, #12]
.L93:
	.loc 2 391 10
	ldr	r3, [sp, #12]
	.loc 2 393 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI42:
	@ sp needed
	ldr	pc, [sp], #4
.LFE246:
	.size	lis2mdl_low_pass_bandwidth_set, .-lis2mdl_low_pass_bandwidth_set
	.section	.text.lis2mdl_low_pass_bandwidth_get,"ax",%progbits
	.align	1
	.global	lis2mdl_low_pass_bandwidth_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_low_pass_bandwidth_get, %function
lis2mdl_low_pass_bandwidth_get:
.LFB247:
	.loc 2 402 59
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI43:
	sub	sp, sp, #20
.LCFI44:
	str	r0, [sp, #4]
	.loc 2 407 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #97
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 409 14
	ldrb	r3, [sp, #8]
	ubfx	r3, r3, #0, #1
	uxtb	r3, r3
	.loc 2 409 3
	cmp	r3, #0
	beq	.L96
	cmp	r3, #1
	beq	.L97
	b	.L101
.L96:
	.loc 2 412 12
	ldr	r3, [sp, #4]
	movs	r2, #0
	strb	r2, [r3]
	.loc 2 413 7
	b	.L99
.L97:
	.loc 2 416 12
	ldr	r3, [sp, #4]
	movs	r2, #1
	strb	r2, [r3]
	.loc 2 417 7
	b	.L99
.L101:
	.loc 2 420 12
	ldr	r3, [sp, #4]
	movs	r2, #0
	strb	r2, [r3]
	.loc 2 421 7
	nop
.L99:
	.loc 2 424 10
	ldr	r3, [sp, #12]
	.loc 2 425 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI45:
	@ sp needed
	ldr	pc, [sp], #4
.LFE247:
	.size	lis2mdl_low_pass_bandwidth_get, .-lis2mdl_low_pass_bandwidth_get
	.section	.text.lis2mdl_set_rst_mode_set,"ax",%progbits
	.align	1
	.global	lis2mdl_set_rst_mode_set
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_set_rst_mode_set, %function
lis2mdl_set_rst_mode_set:
.LFB248:
	.loc 2 434 56
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI46:
	sub	sp, sp, #20
.LCFI47:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 2 439 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #97
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 441 6
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L103
	.loc 2 443 19
	ldrb	r3, [sp, #7]
	and	r3, r3, #3
	uxtb	r2, r3
	.loc 2 443 17
	ldrb	r3, [sp, #8]
	bfi	r3, r2, #1, #2
	strb	r3, [sp, #8]
	.loc 2 444 11
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #97
	bl	lis2mdl_write_reg
	str	r0, [sp, #12]
.L103:
	.loc 2 447 10
	ldr	r3, [sp, #12]
	.loc 2 448 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI48:
	@ sp needed
	ldr	pc, [sp], #4
.LFE248:
	.size	lis2mdl_set_rst_mode_set, .-lis2mdl_set_rst_mode_set
	.section	.text.lis2mdl_set_rst_mode_get,"ax",%progbits
	.align	1
	.global	lis2mdl_set_rst_mode_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_set_rst_mode_get, %function
lis2mdl_set_rst_mode_get:
.LFB249:
	.loc 2 457 57
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI49:
	sub	sp, sp, #20
.LCFI50:
	str	r0, [sp, #4]
	.loc 2 462 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #97
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 464 14
	ldrb	r3, [sp, #8]
	ubfx	r3, r3, #1, #2
	uxtb	r3, r3
	.loc 2 464 3
	cmp	r3, #2
	beq	.L106
	cmp	r3, #2
	bgt	.L107
	cmp	r3, #0
	beq	.L108
	cmp	r3, #1
	beq	.L109
	b	.L107
.L108:
	.loc 2 467 12
	ldr	r3, [sp, #4]
	movs	r2, #0
	strb	r2, [r3]
	.loc 2 468 7
	b	.L110
.L109:
	.loc 2 471 12
	ldr	r3, [sp, #4]
	movs	r2, #1
	strb	r2, [r3]
	.loc 2 472 7
	b	.L110
.L106:
	.loc 2 475 12
	ldr	r3, [sp, #4]
	movs	r2, #2
	strb	r2, [r3]
	.loc 2 476 7
	b	.L110
.L107:
	.loc 2 479 12
	ldr	r3, [sp, #4]
	movs	r2, #0
	strb	r2, [r3]
	.loc 2 480 7
	nop
.L110:
	.loc 2 483 10
	ldr	r3, [sp, #12]
	.loc 2 484 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI51:
	@ sp needed
	ldr	pc, [sp], #4
.LFE249:
	.size	lis2mdl_set_rst_mode_get, .-lis2mdl_set_rst_mode_get
	.section	.text.lis2mdl_set_rst_sensor_single_set,"ax",%progbits
	.align	1
	.global	lis2mdl_set_rst_sensor_single_set
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_set_rst_sensor_single_set, %function
lis2mdl_set_rst_sensor_single_set:
.LFB250:
	.loc 2 497 55
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI52:
	sub	sp, sp, #20
.LCFI53:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 2 502 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #97
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 504 6
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L113
	.loc 2 506 27
	ldrb	r3, [sp, #7]
	and	r3, r3, #1
	uxtb	r2, r3
	ldrb	r3, [sp, #8]
	bfi	r3, r2, #4, #1
	strb	r3, [sp, #8]
	.loc 2 507 11
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #97
	bl	lis2mdl_write_reg
	str	r0, [sp, #12]
.L113:
	.loc 2 510 10
	ldr	r3, [sp, #12]
	.loc 2 511 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI54:
	@ sp needed
	ldr	pc, [sp], #4
.LFE250:
	.size	lis2mdl_set_rst_sensor_single_set, .-lis2mdl_set_rst_sensor_single_set
	.section	.text.lis2mdl_set_rst_sensor_single_get,"ax",%progbits
	.align	1
	.global	lis2mdl_set_rst_sensor_single_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_set_rst_sensor_single_get, %function
lis2mdl_set_rst_sensor_single_get:
.LFB251:
	.loc 2 524 56
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI55:
	sub	sp, sp, #20
.LCFI56:
	str	r0, [sp, #4]
	.loc 2 529 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #97
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 530 13
	ldrb	r3, [sp, #8]
	ubfx	r3, r3, #4, #1
	uxtb	r3, r3
	mov	r2, r3
	.loc 2 530 8
	ldr	r3, [sp, #4]
	strb	r2, [r3]
	.loc 2 532 10
	ldr	r3, [sp, #12]
	.loc 2 534 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI57:
	@ sp needed
	ldr	pc, [sp], #4
.LFE251:
	.size	lis2mdl_set_rst_sensor_single_get, .-lis2mdl_set_rst_sensor_single_get
	.section	.text.lis2mdl_block_data_update_set,"ax",%progbits
	.align	1
	.global	lis2mdl_block_data_update_set
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_block_data_update_set, %function
lis2mdl_block_data_update_set:
.LFB252:
	.loc 2 543 51
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI58:
	sub	sp, sp, #20
.LCFI59:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 2 548 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #98
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 550 6
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L118
	.loc 2 552 13
	ldrb	r3, [sp, #7]
	and	r3, r3, #1
	uxtb	r2, r3
	ldrb	r3, [sp, #8]
	bfi	r3, r2, #4, #1
	strb	r3, [sp, #8]
	.loc 2 553 11
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #98
	bl	lis2mdl_write_reg
	str	r0, [sp, #12]
.L118:
	.loc 2 556 10
	ldr	r3, [sp, #12]
	.loc 2 557 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI60:
	@ sp needed
	ldr	pc, [sp], #4
.LFE252:
	.size	lis2mdl_block_data_update_set, .-lis2mdl_block_data_update_set
	.section	.text.lis2mdl_block_data_update_get,"ax",%progbits
	.align	1
	.global	lis2mdl_block_data_update_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_block_data_update_get, %function
lis2mdl_block_data_update_get:
.LFB253:
	.loc 2 566 51
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI61:
	sub	sp, sp, #20
.LCFI62:
	str	r0, [sp, #4]
	.loc 2 571 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #98
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 572 13
	ldrb	r3, [sp, #8]
	ubfx	r3, r3, #4, #1
	uxtb	r3, r3
	sxtb	r2, r3
	.loc 2 572 8
	ldr	r3, [sp, #4]
	strb	r2, [r3]
	.loc 2 574 10
	ldr	r3, [sp, #12]
	.loc 2 575 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI63:
	@ sp needed
	ldr	pc, [sp], #4
.LFE253:
	.size	lis2mdl_block_data_update_get, .-lis2mdl_block_data_update_get
	.section	.text.lis2mdl_mag_data_ready_get,"ax",%progbits
	.align	1
	.global	lis2mdl_mag_data_ready_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_mag_data_ready_get, %function
lis2mdl_mag_data_ready_get:
.LFB254:
	.loc 2 584 49
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI64:
	sub	sp, sp, #20
.LCFI65:
	str	r0, [sp, #4]
	.loc 2 589 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #103
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 590 13
	ldrb	r3, [sp, #8]
	ubfx	r3, r3, #3, #1
	uxtb	r3, r3
	mov	r2, r3
	.loc 2 590 8
	ldr	r3, [sp, #4]
	strb	r2, [r3]
	.loc 2 592 10
	ldr	r3, [sp, #12]
	.loc 2 593 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI66:
	@ sp needed
	ldr	pc, [sp], #4
.LFE254:
	.size	lis2mdl_mag_data_ready_get, .-lis2mdl_mag_data_ready_get
	.section	.text.lis2mdl_mag_data_ovr_get,"ax",%progbits
	.align	1
	.global	lis2mdl_mag_data_ovr_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_mag_data_ovr_get, %function
lis2mdl_mag_data_ovr_get:
.LFB255:
	.loc 2 602 47
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI67:
	sub	sp, sp, #20
.LCFI68:
	str	r0, [sp, #4]
	.loc 2 607 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #103
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 608 13
	ldrb	r3, [sp, #8]
	ubfx	r3, r3, #7, #1
	uxtb	r3, r3
	mov	r2, r3
	.loc 2 608 8
	ldr	r3, [sp, #4]
	strb	r2, [r3]
	.loc 2 610 10
	ldr	r3, [sp, #12]
	.loc 2 611 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI69:
	@ sp needed
	ldr	pc, [sp], #4
.LFE255:
	.size	lis2mdl_mag_data_ovr_get, .-lis2mdl_mag_data_ovr_get
	.section	.text.lis2mdl_magnetic_raw_get,"ax",%progbits
	.align	1
	.global	lis2mdl_magnetic_raw_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_magnetic_raw_get, %function
lis2mdl_magnetic_raw_get:
.LFB256:
	.loc 2 620 47
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI70:
	sub	sp, sp, #28
.LCFI71:
	str	r0, [sp, #4]
	.loc 2 625 9
	add	r3, sp, #12
	movs	r2, #6
	mov	r1, r3
	movs	r0, #104
	bl	lis2mdl_read_reg
	str	r0, [sp, #20]
	.loc 2 626 25
	ldrb	r3, [sp, #13]	@ zero_extendqisi2
	.loc 2 626 12
	sxth	r2, r3
	.loc 2 626 10
	ldr	r3, [sp, #4]
	strh	r2, [r3]	@ movhi
	.loc 2 627 16
	ldr	r3, [sp, #4]
	ldrsh	r3, [r3]
	uxth	r3, r3
	.loc 2 627 20
	lsls	r3, r3, #8
	uxth	r2, r3
	.loc 2 627 42
	ldrb	r3, [sp, #12]	@ zero_extendqisi2
	uxth	r3, r3
	.loc 2 627 27
	add	r3, r3, r2
	uxth	r3, r3
	sxth	r2, r3
	.loc 2 627 10
	ldr	r3, [sp, #4]
	strh	r2, [r3]	@ movhi
	.loc 2 628 25
	ldrb	r2, [sp, #15]	@ zero_extendqisi2
	.loc 2 628 6
	ldr	r3, [sp, #4]
	adds	r3, r3, #2
	.loc 2 628 12
	sxth	r2, r2
	.loc 2 628 10
	strh	r2, [r3]	@ movhi
	.loc 2 629 16
	ldr	r3, [sp, #4]
	adds	r3, r3, #2
	ldrsh	r3, [r3]
	uxth	r3, r3
	.loc 2 629 20
	lsls	r3, r3, #8
	uxth	r2, r3
	.loc 2 629 42
	ldrb	r3, [sp, #14]	@ zero_extendqisi2
	uxth	r3, r3
	.loc 2 629 27
	add	r3, r3, r2
	uxth	r2, r3
	.loc 2 629 6
	ldr	r3, [sp, #4]
	adds	r3, r3, #2
	.loc 2 629 27
	sxth	r2, r2
	.loc 2 629 10
	strh	r2, [r3]	@ movhi
	.loc 2 630 25
	ldrb	r2, [sp, #17]	@ zero_extendqisi2
	.loc 2 630 6
	ldr	r3, [sp, #4]
	adds	r3, r3, #4
	.loc 2 630 12
	sxth	r2, r2
	.loc 2 630 10
	strh	r2, [r3]	@ movhi
	.loc 2 631 16
	ldr	r3, [sp, #4]
	adds	r3, r3, #4
	ldrsh	r3, [r3]
	uxth	r3, r3
	.loc 2 631 20
	lsls	r3, r3, #8
	uxth	r2, r3
	.loc 2 631 42
	ldrb	r3, [sp, #16]	@ zero_extendqisi2
	uxth	r3, r3
	.loc 2 631 27
	add	r3, r3, r2
	uxth	r2, r3
	.loc 2 631 6
	ldr	r3, [sp, #4]
	adds	r3, r3, #4
	.loc 2 631 27
	sxth	r2, r2
	.loc 2 631 10
	strh	r2, [r3]	@ movhi
	.loc 2 633 10
	ldr	r3, [sp, #20]
	.loc 2 634 1
	mov	r0, r3
	add	sp, sp, #28
.LCFI72:
	@ sp needed
	ldr	pc, [sp], #4
.LFE256:
	.size	lis2mdl_magnetic_raw_get, .-lis2mdl_magnetic_raw_get
	.section	.text.lis2mdl_temperature_raw_get,"ax",%progbits
	.align	1
	.global	lis2mdl_temperature_raw_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_temperature_raw_get, %function
lis2mdl_temperature_raw_get:
.LFB257:
	.loc 2 643 50
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI73:
	sub	sp, sp, #20
.LCFI74:
	str	r0, [sp, #4]
	.loc 2 648 9
	add	r3, sp, #8
	movs	r2, #2
	mov	r1, r3
	movs	r0, #110
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 649 23
	ldrb	r3, [sp, #9]	@ zero_extendqisi2
	.loc 2 649 10
	sxth	r2, r3
	.loc 2 649 8
	ldr	r3, [sp, #4]
	strh	r2, [r3]	@ movhi
	.loc 2 650 11
	ldr	r3, [sp, #4]
	ldrsh	r3, [r3]
	uxth	r3, r3
	.loc 2 650 16
	lsls	r3, r3, #8
	uxth	r2, r3
	.loc 2 650 38
	ldrb	r3, [sp, #8]	@ zero_extendqisi2
	uxth	r3, r3
	.loc 2 650 23
	add	r3, r3, r2
	uxth	r3, r3
	sxth	r2, r3
	.loc 2 650 8
	ldr	r3, [sp, #4]
	strh	r2, [r3]	@ movhi
	.loc 2 652 10
	ldr	r3, [sp, #12]
	.loc 2 653 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI75:
	@ sp needed
	ldr	pc, [sp], #4
.LFE257:
	.size	lis2mdl_temperature_raw_get, .-lis2mdl_temperature_raw_get
	.section	.text.lis2mdl_device_id_get,"ax",%progbits
	.align	1
	.global	lis2mdl_device_id_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_device_id_get, %function
lis2mdl_device_id_get:
.LFB258:
	.loc 2 675 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI76:
	sub	sp, sp, #20
.LCFI77:
	str	r0, [sp, #4]
	.loc 2 678 9
	movs	r2, #1
	ldr	r1, [sp, #4]
	movs	r0, #79
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 680 10
	ldr	r3, [sp, #12]
	.loc 2 681 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI78:
	@ sp needed
	ldr	pc, [sp], #4
.LFE258:
	.size	lis2mdl_device_id_get, .-lis2mdl_device_id_get
	.section	.text.lis2mdl_reset_set,"ax",%progbits
	.align	1
	.global	lis2mdl_reset_set
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_reset_set, %function
lis2mdl_reset_set:
.LFB259:
	.loc 2 690 39
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI79:
	sub	sp, sp, #20
.LCFI80:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 2 695 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #96
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 697 6
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L133
	.loc 2 699 18
	ldrb	r3, [sp, #7]
	and	r3, r3, #1
	uxtb	r2, r3
	ldrb	r3, [sp, #8]
	bfi	r3, r2, #5, #1
	strb	r3, [sp, #8]
	.loc 2 700 11
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #96
	bl	lis2mdl_write_reg
	str	r0, [sp, #12]
.L133:
	.loc 2 703 10
	ldr	r3, [sp, #12]
	.loc 2 704 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI81:
	@ sp needed
	ldr	pc, [sp], #4
.LFE259:
	.size	lis2mdl_reset_set, .-lis2mdl_reset_set
	.section	.text.lis2mdl_reset_get,"ax",%progbits
	.align	1
	.global	lis2mdl_reset_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_reset_get, %function
lis2mdl_reset_get:
.LFB260:
	.loc 2 713 40
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI82:
	sub	sp, sp, #20
.LCFI83:
	str	r0, [sp, #4]
	.loc 2 718 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #96
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 719 13
	ldrb	r3, [sp, #8]
	ubfx	r3, r3, #5, #1
	uxtb	r3, r3
	mov	r2, r3
	.loc 2 719 8
	ldr	r3, [sp, #4]
	strb	r2, [r3]
	.loc 2 721 10
	ldr	r3, [sp, #12]
	.loc 2 722 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI84:
	@ sp needed
	ldr	pc, [sp], #4
.LFE260:
	.size	lis2mdl_reset_get, .-lis2mdl_reset_get
	.section	.text.lis2mdl_boot_set,"ax",%progbits
	.align	1
	.global	lis2mdl_boot_set
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_boot_set, %function
lis2mdl_boot_set:
.LFB261:
	.loc 2 731 38
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI85:
	sub	sp, sp, #20
.LCFI86:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 2 736 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #96
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 738 6
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L138
	.loc 2 740 16
	ldrb	r3, [sp, #7]
	and	r3, r3, #1
	uxtb	r2, r3
	ldrb	r3, [sp, #8]
	bfi	r3, r2, #6, #1
	strb	r3, [sp, #8]
	.loc 2 741 11
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #96
	bl	lis2mdl_write_reg
	str	r0, [sp, #12]
.L138:
	.loc 2 744 10
	ldr	r3, [sp, #12]
	.loc 2 745 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI87:
	@ sp needed
	ldr	pc, [sp], #4
.LFE261:
	.size	lis2mdl_boot_set, .-lis2mdl_boot_set
	.section	.text.lis2mdl_boot_get,"ax",%progbits
	.align	1
	.global	lis2mdl_boot_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_boot_get, %function
lis2mdl_boot_get:
.LFB262:
	.loc 2 754 39
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI88:
	sub	sp, sp, #20
.LCFI89:
	str	r0, [sp, #4]
	.loc 2 759 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #96
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 760 13
	ldrb	r3, [sp, #8]
	ubfx	r3, r3, #6, #1
	uxtb	r3, r3
	mov	r2, r3
	.loc 2 760 8
	ldr	r3, [sp, #4]
	strb	r2, [r3]
	.loc 2 762 10
	ldr	r3, [sp, #12]
	.loc 2 763 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI90:
	@ sp needed
	ldr	pc, [sp], #4
.LFE262:
	.size	lis2mdl_boot_get, .-lis2mdl_boot_get
	.section	.text.lis2mdl_self_test_set,"ax",%progbits
	.align	1
	.global	lis2mdl_self_test_set
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_self_test_set, %function
lis2mdl_self_test_set:
.LFB263:
	.loc 2 772 43
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI91:
	sub	sp, sp, #20
.LCFI92:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 2 777 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #98
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 779 6
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L143
	.loc 2 781 19
	ldrb	r3, [sp, #7]
	and	r3, r3, #1
	uxtb	r2, r3
	ldrb	r3, [sp, #8]
	bfi	r3, r2, #1, #1
	strb	r3, [sp, #8]
	.loc 2 782 11
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #98
	bl	lis2mdl_write_reg
	str	r0, [sp, #12]
.L143:
	.loc 2 785 10
	ldr	r3, [sp, #12]
	.loc 2 786 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI93:
	@ sp needed
	ldr	pc, [sp], #4
.LFE263:
	.size	lis2mdl_self_test_set, .-lis2mdl_self_test_set
	.section	.text.lis2mdl_self_test_get,"ax",%progbits
	.align	1
	.global	lis2mdl_self_test_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_self_test_get, %function
lis2mdl_self_test_get:
.LFB264:
	.loc 2 795 44
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI94:
	sub	sp, sp, #20
.LCFI95:
	str	r0, [sp, #4]
	.loc 2 800 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #98
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 801 13
	ldrb	r3, [sp, #8]
	ubfx	r3, r3, #1, #1
	uxtb	r3, r3
	mov	r2, r3
	.loc 2 801 8
	ldr	r3, [sp, #4]
	strb	r2, [r3]
	.loc 2 803 10
	ldr	r3, [sp, #12]
	.loc 2 804 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI96:
	@ sp needed
	ldr	pc, [sp], #4
.LFE264:
	.size	lis2mdl_self_test_get, .-lis2mdl_self_test_get
	.section	.text.lis2mdl_data_format_set,"ax",%progbits
	.align	1
	.global	lis2mdl_data_format_set
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_data_format_set, %function
lis2mdl_data_format_set:
.LFB265:
	.loc 2 813 51
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI97:
	sub	sp, sp, #20
.LCFI98:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 2 818 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #98
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 820 6
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L148
	.loc 2 822 15
	ldrb	r3, [sp, #7]
	and	r3, r3, #1
	uxtb	r2, r3
	.loc 2 822 13
	ldrb	r3, [sp, #8]
	bfi	r3, r2, #3, #1
	strb	r3, [sp, #8]
	.loc 2 823 11
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #98
	bl	lis2mdl_write_reg
	str	r0, [sp, #12]
.L148:
	.loc 2 826 10
	ldr	r3, [sp, #12]
	.loc 2 827 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI99:
	@ sp needed
	ldr	pc, [sp], #4
.LFE265:
	.size	lis2mdl_data_format_set, .-lis2mdl_data_format_set
	.section	.text.lis2mdl_data_format_get,"ax",%progbits
	.align	1
	.global	lis2mdl_data_format_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_data_format_get, %function
lis2mdl_data_format_get:
.LFB266:
	.loc 2 836 52
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI100:
	sub	sp, sp, #20
.LCFI101:
	str	r0, [sp, #4]
	.loc 2 841 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #98
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 843 14
	ldrb	r3, [sp, #8]
	ubfx	r3, r3, #3, #1
	uxtb	r3, r3
	.loc 2 843 3
	cmp	r3, #0
	beq	.L151
	cmp	r3, #1
	beq	.L152
	b	.L156
.L151:
	.loc 2 846 12
	ldr	r3, [sp, #4]
	movs	r2, #0
	strb	r2, [r3]
	.loc 2 847 7
	b	.L154
.L152:
	.loc 2 850 12
	ldr	r3, [sp, #4]
	movs	r2, #1
	strb	r2, [r3]
	.loc 2 851 7
	b	.L154
.L156:
	.loc 2 854 12
	ldr	r3, [sp, #4]
	movs	r2, #0
	strb	r2, [r3]
	.loc 2 855 7
	nop
.L154:
	.loc 2 858 10
	ldr	r3, [sp, #12]
	.loc 2 859 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI102:
	@ sp needed
	ldr	pc, [sp], #4
.LFE266:
	.size	lis2mdl_data_format_get, .-lis2mdl_data_format_get
	.section	.text.lis2mdl_status_get,"ax",%progbits
	.align	1
	.global	lis2mdl_status_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_status_get, %function
lis2mdl_status_get:
.LFB267:
	.loc 2 868 54
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI103:
	sub	sp, sp, #20
.LCFI104:
	str	r0, [sp, #4]
	.loc 2 872 9
	movs	r2, #1
	ldr	r1, [sp, #4]
	movs	r0, #103
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 874 10
	ldr	r3, [sp, #12]
	.loc 2 875 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI105:
	@ sp needed
	ldr	pc, [sp], #4
.LFE267:
	.size	lis2mdl_status_get, .-lis2mdl_status_get
	.section	.text.lis2mdl_offset_int_conf_set,"ax",%progbits
	.align	1
	.global	lis2mdl_offset_int_conf_set
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_offset_int_conf_set, %function
lis2mdl_offset_int_conf_set:
.LFB268:
	.loc 2 897 66
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI106:
	sub	sp, sp, #20
.LCFI107:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 2 901 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #97
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 903 6
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L160
	.loc 2 905 26
	ldrb	r3, [sp, #7]
	and	r3, r3, #1
	uxtb	r2, r3
	.loc 2 905 24
	ldrb	r3, [sp, #8]
	bfi	r3, r2, #3, #1
	strb	r3, [sp, #8]
	.loc 2 906 11
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #97
	bl	lis2mdl_write_reg
	str	r0, [sp, #12]
.L160:
	.loc 2 909 10
	ldr	r3, [sp, #12]
	.loc 2 910 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI108:
	@ sp needed
	ldr	pc, [sp], #4
.LFE268:
	.size	lis2mdl_offset_int_conf_set, .-lis2mdl_offset_int_conf_set
	.section	.text.lis2mdl_offset_int_conf_get,"ax",%progbits
	.align	1
	.global	lis2mdl_offset_int_conf_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_offset_int_conf_get, %function
lis2mdl_offset_int_conf_get:
.LFB269:
	.loc 2 920 67
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI109:
	sub	sp, sp, #20
.LCFI110:
	str	r0, [sp, #4]
	.loc 2 925 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #97
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 927 14
	ldrb	r3, [sp, #8]
	ubfx	r3, r3, #3, #1
	uxtb	r3, r3
	.loc 2 927 3
	cmp	r3, #0
	beq	.L163
	cmp	r3, #1
	beq	.L164
	b	.L168
.L163:
	.loc 2 930 12
	ldr	r3, [sp, #4]
	movs	r2, #0
	strb	r2, [r3]
	.loc 2 931 7
	b	.L166
.L164:
	.loc 2 934 12
	ldr	r3, [sp, #4]
	movs	r2, #1
	strb	r2, [r3]
	.loc 2 935 7
	b	.L166
.L168:
	.loc 2 938 12
	ldr	r3, [sp, #4]
	movs	r2, #0
	strb	r2, [r3]
	.loc 2 939 7
	nop
.L166:
	.loc 2 942 10
	ldr	r3, [sp, #12]
	.loc 2 943 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI111:
	@ sp needed
	ldr	pc, [sp], #4
.LFE269:
	.size	lis2mdl_offset_int_conf_get, .-lis2mdl_offset_int_conf_get
	.section	.text.lis2mdl_drdy_on_pin_set,"ax",%progbits
	.align	1
	.global	lis2mdl_drdy_on_pin_set
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_drdy_on_pin_set, %function
lis2mdl_drdy_on_pin_set:
.LFB270:
	.loc 2 952 45
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI112:
	sub	sp, sp, #20
.LCFI113:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 2 957 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #98
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 959 6
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L170
	.loc 2 961 21
	ldrb	r3, [sp, #7]
	and	r3, r3, #1
	uxtb	r2, r3
	ldrb	r3, [sp, #8]
	bfi	r3, r2, #0, #1
	strb	r3, [sp, #8]
	.loc 2 962 11
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #98
	bl	lis2mdl_write_reg
	str	r0, [sp, #12]
.L170:
	.loc 2 966 10
	ldr	r3, [sp, #12]
	.loc 2 967 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI114:
	@ sp needed
	ldr	pc, [sp], #4
.LFE270:
	.size	lis2mdl_drdy_on_pin_set, .-lis2mdl_drdy_on_pin_set
	.section	.text.lis2mdl_drdy_on_pin_get,"ax",%progbits
	.align	1
	.global	lis2mdl_drdy_on_pin_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_drdy_on_pin_get, %function
lis2mdl_drdy_on_pin_get:
.LFB271:
	.loc 2 976 46
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI115:
	sub	sp, sp, #20
.LCFI116:
	str	r0, [sp, #4]
	.loc 2 981 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #98
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 982 13
	ldrb	r3, [sp, #8]
	ubfx	r3, r3, #0, #1
	uxtb	r3, r3
	mov	r2, r3
	.loc 2 982 8
	ldr	r3, [sp, #4]
	strb	r2, [r3]
	.loc 2 984 10
	ldr	r3, [sp, #12]
	.loc 2 985 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI117:
	@ sp needed
	ldr	pc, [sp], #4
.LFE271:
	.size	lis2mdl_drdy_on_pin_get, .-lis2mdl_drdy_on_pin_get
	.section	.text.lis2mdl_int_on_pin_set,"ax",%progbits
	.align	1
	.global	lis2mdl_int_on_pin_set
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_int_on_pin_set, %function
lis2mdl_int_on_pin_set:
.LFB272:
	.loc 2 994 44
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI118:
	sub	sp, sp, #20
.LCFI119:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 2 998 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #98
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 1000 6
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L175
	.loc 2 1002 20
	ldrb	r3, [sp, #7]
	and	r3, r3, #1
	uxtb	r2, r3
	ldrb	r3, [sp, #8]
	bfi	r3, r2, #6, #1
	strb	r3, [sp, #8]
	.loc 2 1003 11
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #98
	bl	lis2mdl_write_reg
	str	r0, [sp, #12]
.L175:
	.loc 2 1006 10
	ldr	r3, [sp, #12]
	.loc 2 1007 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI120:
	@ sp needed
	ldr	pc, [sp], #4
.LFE272:
	.size	lis2mdl_int_on_pin_set, .-lis2mdl_int_on_pin_set
	.section	.text.lis2mdl_int_on_pin_get,"ax",%progbits
	.align	1
	.global	lis2mdl_int_on_pin_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_int_on_pin_get, %function
lis2mdl_int_on_pin_get:
.LFB273:
	.loc 2 1016 45
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI121:
	sub	sp, sp, #20
.LCFI122:
	str	r0, [sp, #4]
	.loc 2 1021 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #98
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 1022 13
	ldrb	r3, [sp, #8]
	ubfx	r3, r3, #6, #1
	uxtb	r3, r3
	mov	r2, r3
	.loc 2 1022 8
	ldr	r3, [sp, #4]
	strb	r2, [r3]
	.loc 2 1024 10
	ldr	r3, [sp, #12]
	.loc 2 1025 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI123:
	@ sp needed
	ldr	pc, [sp], #4
.LFE273:
	.size	lis2mdl_int_on_pin_get, .-lis2mdl_int_on_pin_get
	.section	.text.lis2mdl_int_gen_conf_set,"ax",%progbits
	.align	1
	.global	lis2mdl_int_gen_conf_set
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_int_gen_conf_set, %function
lis2mdl_int_gen_conf_set:
.LFB274:
	.loc 2 1034 62
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI124:
	sub	sp, sp, #20
.LCFI125:
	str	r0, [sp, #4]
	.loc 2 1038 9
	movs	r2, #1
	ldr	r1, [sp, #4]
	movs	r0, #99
	bl	lis2mdl_write_reg
	str	r0, [sp, #12]
	.loc 2 1040 10
	ldr	r3, [sp, #12]
	.loc 2 1041 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI126:
	@ sp needed
	ldr	pc, [sp], #4
.LFE274:
	.size	lis2mdl_int_gen_conf_set, .-lis2mdl_int_gen_conf_set
	.section	.text.lis2mdl_int_gen_conf_get,"ax",%progbits
	.align	1
	.global	lis2mdl_int_gen_conf_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_int_gen_conf_get, %function
lis2mdl_int_gen_conf_get:
.LFB275:
	.loc 2 1050 62
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI127:
	sub	sp, sp, #20
.LCFI128:
	str	r0, [sp, #4]
	.loc 2 1054 9
	movs	r2, #1
	ldr	r1, [sp, #4]
	movs	r0, #99
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 1056 10
	ldr	r3, [sp, #12]
	.loc 2 1057 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI129:
	@ sp needed
	ldr	pc, [sp], #4
.LFE275:
	.size	lis2mdl_int_gen_conf_get, .-lis2mdl_int_gen_conf_get
	.section	.text.lis2mdl_int_gen_source_get,"ax",%progbits
	.align	1
	.global	lis2mdl_int_gen_source_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_int_gen_source_get, %function
lis2mdl_int_gen_source_get:
.LFB276:
	.loc 2 1067 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI130:
	sub	sp, sp, #20
.LCFI131:
	str	r0, [sp, #4]
	.loc 2 1070 9
	movs	r2, #1
	ldr	r1, [sp, #4]
	movs	r0, #100
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 1072 10
	ldr	r3, [sp, #12]
	.loc 2 1073 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI132:
	@ sp needed
	ldr	pc, [sp], #4
.LFE276:
	.size	lis2mdl_int_gen_source_get, .-lis2mdl_int_gen_source_get
	.section	.text.lis2mdl_int_gen_treshold_set,"ax",%progbits
	.align	1
	.global	lis2mdl_int_gen_treshold_set
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_int_gen_treshold_set, %function
lis2mdl_int_gen_treshold_set:
.LFB277:
	.loc 2 1084 51
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI133:
	sub	sp, sp, #20
.LCFI134:
	mov	r3, r0
	strh	r3, [sp, #6]	@ movhi
	.loc 2 1089 13
	ldrh	r3, [sp, #6]
	lsrs	r3, r3, #8
	uxth	r3, r3
	uxtb	r3, r3
	.loc 2 1089 11
	strb	r3, [sp, #9]
	.loc 2 1090 13
	ldrh	r3, [sp, #6]	@ movhi
	uxtb	r3, r3
	.loc 2 1090 11
	strb	r3, [sp, #8]
	.loc 2 1091 9
	add	r3, sp, #8
	movs	r2, #2
	mov	r1, r3
	movs	r0, #101
	bl	lis2mdl_write_reg
	str	r0, [sp, #12]
	.loc 2 1093 10
	ldr	r3, [sp, #12]
	.loc 2 1094 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI135:
	@ sp needed
	ldr	pc, [sp], #4
.LFE277:
	.size	lis2mdl_int_gen_treshold_set, .-lis2mdl_int_gen_treshold_set
	.section	.text.lis2mdl_int_gen_treshold_get,"ax",%progbits
	.align	1
	.global	lis2mdl_int_gen_treshold_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_int_gen_treshold_get, %function
lis2mdl_int_gen_treshold_get:
.LFB278:
	.loc 2 1105 52
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI136:
	sub	sp, sp, #20
.LCFI137:
	str	r0, [sp, #4]
	.loc 2 1110 9
	add	r3, sp, #8
	movs	r2, #2
	mov	r1, r3
	movs	r0, #101
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 1111 14
	ldrb	r3, [sp, #9]	@ zero_extendqisi2
	uxth	r2, r3
	.loc 2 1111 8
	ldr	r3, [sp, #4]
	strh	r2, [r3]	@ movhi
	.loc 2 1112 11
	ldr	r3, [sp, #4]
	ldrh	r3, [r3]
	.loc 2 1112 16
	lsls	r3, r3, #8
	uxth	r2, r3
	.loc 2 1112 31
	ldrb	r3, [sp, #8]	@ zero_extendqisi2
	uxth	r3, r3
	.loc 2 1112 24
	add	r3, r3, r2
	uxth	r2, r3
	.loc 2 1112 8
	ldr	r3, [sp, #4]
	strh	r2, [r3]	@ movhi
	.loc 2 1114 10
	ldr	r3, [sp, #12]
	.loc 2 1115 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI138:
	@ sp needed
	ldr	pc, [sp], #4
.LFE278:
	.size	lis2mdl_int_gen_treshold_get, .-lis2mdl_int_gen_treshold_get
	.section	.text.lis2mdl_spi_mode_set,"ax",%progbits
	.align	1
	.global	lis2mdl_spi_mode_set
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_spi_mode_set, %function
lis2mdl_spi_mode_set:
.LFB279:
	.loc 2 1137 48
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI139:
	sub	sp, sp, #20
.LCFI140:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 2 1141 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #98
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 1143 6
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L190
	.loc 2 1145 18
	ldrb	r3, [sp, #7]
	and	r3, r3, #1
	uxtb	r2, r3
	.loc 2 1145 16
	ldrb	r3, [sp, #8]
	bfi	r3, r2, #2, #1
	strb	r3, [sp, #8]
	.loc 2 1146 11
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #98
	bl	lis2mdl_write_reg
	str	r0, [sp, #12]
.L190:
	.loc 2 1149 10
	ldr	r3, [sp, #12]
	.loc 2 1150 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI141:
	@ sp needed
	ldr	pc, [sp], #4
.LFE279:
	.size	lis2mdl_spi_mode_set, .-lis2mdl_spi_mode_set
	.section	.text.lis2mdl_spi_mode_get,"ax",%progbits
	.align	1
	.global	lis2mdl_spi_mode_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_spi_mode_get, %function
lis2mdl_spi_mode_get:
.LFB280:
	.loc 2 1159 49
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI142:
	sub	sp, sp, #20
.LCFI143:
	str	r0, [sp, #4]
	.loc 2 1164 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #98
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 1166 14
	ldrb	r3, [sp, #8]
	ubfx	r3, r3, #2, #1
	uxtb	r3, r3
	.loc 2 1166 3
	cmp	r3, #0
	beq	.L193
	cmp	r3, #1
	bne	.L194
	.loc 2 1169 12
	ldr	r3, [sp, #4]
	movs	r2, #1
	strb	r2, [r3]
	.loc 2 1170 7
	b	.L195
.L193:
	.loc 2 1173 12
	ldr	r3, [sp, #4]
	movs	r2, #0
	strb	r2, [r3]
	.loc 2 1174 7
	b	.L195
.L194:
	.loc 2 1177 12
	ldr	r3, [sp, #4]
	movs	r2, #0
	strb	r2, [r3]
	.loc 2 1178 7
	nop
.L195:
	.loc 2 1181 10
	ldr	r3, [sp, #12]
	.loc 2 1182 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI144:
	@ sp needed
	ldr	pc, [sp], #4
.LFE280:
	.size	lis2mdl_spi_mode_get, .-lis2mdl_spi_mode_get
	.section	.text.lis2mdl_i2c_interface_set,"ax",%progbits
	.align	1
	.global	lis2mdl_i2c_interface_set
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_i2c_interface_set, %function
lis2mdl_i2c_interface_set:
.LFB281:
	.loc 2 1192 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI145:
	sub	sp, sp, #20
.LCFI146:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 2 1196 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #98
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 1198 6
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L198
	.loc 2 1200 19
	ldrb	r3, [sp, #7]
	and	r3, r3, #1
	uxtb	r2, r3
	.loc 2 1200 17
	ldrb	r3, [sp, #8]
	bfi	r3, r2, #5, #1
	strb	r3, [sp, #8]
	.loc 2 1201 11
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #98
	bl	lis2mdl_write_reg
	str	r0, [sp, #12]
.L198:
	.loc 2 1204 10
	ldr	r3, [sp, #12]
	.loc 2 1205 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI147:
	@ sp needed
	ldr	pc, [sp], #4
.LFE281:
	.size	lis2mdl_i2c_interface_set, .-lis2mdl_i2c_interface_set
	.section	.text.lis2mdl_i2c_interface_get,"ax",%progbits
	.align	1
	.global	lis2mdl_i2c_interface_get
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_i2c_interface_get, %function
lis2mdl_i2c_interface_get:
.LFB282:
	.loc 2 1215 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI148:
	sub	sp, sp, #20
.LCFI149:
	str	r0, [sp, #4]
	.loc 2 1219 9
	add	r3, sp, #8
	movs	r2, #1
	mov	r1, r3
	movs	r0, #98
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 1221 14
	ldrb	r3, [sp, #8]
	ubfx	r3, r3, #5, #1
	uxtb	r3, r3
	.loc 2 1221 3
	cmp	r3, #0
	beq	.L201
	cmp	r3, #1
	beq	.L202
	b	.L206
.L201:
	.loc 2 1224 12
	ldr	r3, [sp, #4]
	movs	r2, #0
	strb	r2, [r3]
	.loc 2 1225 7
	b	.L204
.L202:
	.loc 2 1228 12
	ldr	r3, [sp, #4]
	movs	r2, #1
	strb	r2, [r3]
	.loc 2 1229 7
	b	.L204
.L206:
	.loc 2 1232 12
	ldr	r3, [sp, #4]
	movs	r2, #0
	strb	r2, [r3]
	.loc 2 1233 7
	nop
.L204:
	.loc 2 1236 10
	ldr	r3, [sp, #12]
	.loc 2 1237 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI150:
	@ sp needed
	ldr	pc, [sp], #4
.LFE282:
	.size	lis2mdl_i2c_interface_get, .-lis2mdl_i2c_interface_get
	.section	.bss.data_raw_magnetic,"aw",%nobits
	.align	2
	.type	data_raw_magnetic, %object
	.size	data_raw_magnetic, 6
data_raw_magnetic:
	.space	6
	.section	.bss.lis2mdl_data_raw_temperature,"aw",%nobits
	.align	1
	.type	lis2mdl_data_raw_temperature, %object
	.size	lis2mdl_data_raw_temperature, 2
lis2mdl_data_raw_temperature:
	.space	2
	.section	.bss.magnetic_mG,"aw",%nobits
	.align	2
	.type	magnetic_mG, %object
	.size	magnetic_mG, 12
magnetic_mG:
	.space	12
	.section	.bss.lis2mdl_temperature_degC,"aw",%nobits
	.align	2
	.type	lis2mdl_temperature_degC, %object
	.size	lis2mdl_temperature_degC, 4
lis2mdl_temperature_degC:
	.space	4
	.section	.bss.mag_whoamI,"aw",%nobits
	.type	mag_whoamI, %object
	.size	mag_whoamI, 1
mag_whoamI:
	.space	1
	.section	.bss.mag_device_found,"aw",%nobits
	.type	mag_device_found, %object
	.size	mag_device_found, 1
mag_device_found:
	.space	1
	.section	.bss.mag_config,"aw",%nobits
	.align	2
	.type	mag_config, %object
	.size	mag_config, 4
mag_config:
	.space	4
	.section .rodata
	.align	2
.LC0:
	.ascii	"Register 0x%02x value: 0x%02x\015\012\000"
	.align	2
.LC1:
	.ascii	"Unable to read register 0x%02x\015\012\000"
	.section	.text.lis2mdl_print_reg,"ax",%progbits
	.align	1
	.global	lis2mdl_print_reg
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_print_reg, %function
lis2mdl_print_reg:
.LFB283:
	.loc 2 1265 40
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI151:
	sub	sp, sp, #20
.LCFI152:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 2 1269 9
	add	r1, sp, #11
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	movs	r2, #1
	mov	r0, r3
	bl	lis2mdl_read_reg
	str	r0, [sp, #12]
	.loc 2 1271 6
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L208
	.loc 2 1273 5
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	ldrb	r2, [sp, #11]	@ zero_extendqisi2
	mov	r1, r3
	ldr	r0, .L211
	bl	printf
	.loc 2 1279 1
	b	.L210
.L208:
	.loc 2 1276 5
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	mov	r1, r3
	ldr	r0, .L211+4
	bl	printf
.L210:
	.loc 2 1279 1
	nop
	add	sp, sp, #20
.LCFI153:
	@ sp needed
	ldr	pc, [sp], #4
.L212:
	.align	2
.L211:
	.word	.LC0
	.word	.LC1
.LFE283:
	.size	lis2mdl_print_reg, .-lis2mdl_print_reg
	.section	.text.lis2mdl_magnetic_raw_get_my,"ax",%progbits
	.align	1
	.global	lis2mdl_magnetic_raw_get_my
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_magnetic_raw_get_my, %function
lis2mdl_magnetic_raw_get_my:
.LFB284:
	.loc 2 1282 50
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI154:
	sub	sp, sp, #28
.LCFI155:
	str	r0, [sp, #4]
	.loc 2 1287 7
	movs	r3, #0
	str	r3, [sp, #20]
	.loc 2 1290 9
	add	r3, sp, #15
	movs	r2, #1
	mov	r1, r3
	movs	r0, #104
	bl	lis2mdl_read_reg
	str	r0, [sp, #16]
	.loc 2 1291 7
	ldr	r2, [sp, #20]
	ldr	r3, [sp, #16]
	orrs	r3, r3, r2
	str	r3, [sp, #20]
	.loc 2 1292 9
	add	r3, sp, #14
	movs	r2, #1
	mov	r1, r3
	movs	r0, #105
	bl	lis2mdl_read_reg
	str	r0, [sp, #16]
	.loc 2 1293 7
	ldr	r2, [sp, #20]
	ldr	r3, [sp, #16]
	orrs	r3, r3, r2
	str	r3, [sp, #20]
	.loc 2 1294 39
	ldrb	r3, [sp, #14]	@ zero_extendqisi2
	uxth	r3, r3
	lsls	r3, r3, #8
	uxth	r2, r3
	ldrb	r3, [sp, #15]	@ zero_extendqisi2
	uxth	r3, r3
	add	r3, r3, r2
	uxth	r3, r3
	sxth	r2, r3
	.loc 2 1294 10
	ldr	r3, [sp, #4]
	strh	r2, [r3]	@ movhi
	.loc 2 1297 9
	add	r3, sp, #15
	movs	r2, #1
	mov	r1, r3
	movs	r0, #106
	bl	lis2mdl_read_reg
	str	r0, [sp, #16]
	.loc 2 1298 7
	ldr	r2, [sp, #20]
	ldr	r3, [sp, #16]
	orrs	r3, r3, r2
	str	r3, [sp, #20]
	.loc 2 1299 9
	add	r3, sp, #14
	movs	r2, #1
	mov	r1, r3
	movs	r0, #107
	bl	lis2mdl_read_reg
	str	r0, [sp, #16]
	.loc 2 1300 7
	ldr	r2, [sp, #20]
	ldr	r3, [sp, #16]
	orrs	r3, r3, r2
	str	r3, [sp, #20]
	.loc 2 1301 39
	ldrb	r3, [sp, #14]	@ zero_extendqisi2
	uxth	r3, r3
	lsls	r3, r3, #8
	uxth	r2, r3
	ldrb	r3, [sp, #15]	@ zero_extendqisi2
	uxth	r3, r3
	add	r3, r3, r2
	uxth	r2, r3
	.loc 2 1301 6
	ldr	r3, [sp, #4]
	adds	r3, r3, #2
	.loc 2 1301 39
	sxth	r2, r2
	.loc 2 1301 10
	strh	r2, [r3]	@ movhi
	.loc 2 1304 9
	add	r3, sp, #15
	movs	r2, #1
	mov	r1, r3
	movs	r0, #108
	bl	lis2mdl_read_reg
	str	r0, [sp, #16]
	.loc 2 1305 7
	ldr	r2, [sp, #20]
	ldr	r3, [sp, #16]
	orrs	r3, r3, r2
	str	r3, [sp, #20]
	.loc 2 1306 9
	add	r3, sp, #14
	movs	r2, #1
	mov	r1, r3
	movs	r0, #109
	bl	lis2mdl_read_reg
	str	r0, [sp, #16]
	.loc 2 1307 7
	ldr	r2, [sp, #20]
	ldr	r3, [sp, #16]
	orrs	r3, r3, r2
	str	r3, [sp, #20]
	.loc 2 1308 39
	ldrb	r3, [sp, #14]	@ zero_extendqisi2
	uxth	r3, r3
	lsls	r3, r3, #8
	uxth	r2, r3
	ldrb	r3, [sp, #15]	@ zero_extendqisi2
	uxth	r3, r3
	add	r3, r3, r2
	uxth	r2, r3
	.loc 2 1308 6
	ldr	r3, [sp, #4]
	adds	r3, r3, #4
	.loc 2 1308 39
	sxth	r2, r2
	.loc 2 1308 10
	strh	r2, [r3]	@ movhi
	.loc 2 1310 10
	ldr	r3, [sp, #20]
	.loc 2 1311 1
	mov	r0, r3
	add	sp, sp, #28
.LCFI156:
	@ sp needed
	ldr	pc, [sp], #4
.LFE284:
	.size	lis2mdl_magnetic_raw_get_my, .-lis2mdl_magnetic_raw_get_my
	.section	.text.lis2mdl_temperature_raw_get_my,"ax",%progbits
	.align	1
	.global	lis2mdl_temperature_raw_get_my
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_temperature_raw_get_my, %function
lis2mdl_temperature_raw_get_my:
.LFB285:
	.loc 2 1314 53
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI157:
	sub	sp, sp, #28
.LCFI158:
	str	r0, [sp, #4]
	.loc 2 1318 7
	movs	r3, #0
	str	r3, [sp, #20]
	.loc 2 1319 9
	add	r3, sp, #15
	movs	r2, #1
	mov	r1, r3
	movs	r0, #110
	bl	lis2mdl_read_reg
	str	r0, [sp, #16]
	.loc 2 1320 7
	ldr	r2, [sp, #20]
	ldr	r3, [sp, #16]
	orrs	r3, r3, r2
	str	r3, [sp, #20]
	.loc 2 1321 9
	add	r3, sp, #14
	movs	r2, #1
	mov	r1, r3
	movs	r0, #111
	bl	lis2mdl_read_reg
	str	r0, [sp, #16]
	.loc 2 1322 7
	ldr	r2, [sp, #20]
	ldr	r3, [sp, #16]
	orrs	r3, r3, r2
	str	r3, [sp, #20]
	.loc 2 1323 37
	ldrb	r3, [sp, #14]	@ zero_extendqisi2
	uxth	r3, r3
	lsls	r3, r3, #8
	uxth	r2, r3
	ldrb	r3, [sp, #15]	@ zero_extendqisi2
	uxth	r3, r3
	add	r3, r3, r2
	uxth	r3, r3
	sxth	r2, r3
	.loc 2 1323 8
	ldr	r3, [sp, #4]
	strh	r2, [r3]	@ movhi
	.loc 2 1325 10
	ldr	r3, [sp, #20]
	.loc 2 1328 1
	mov	r0, r3
	add	sp, sp, #28
.LCFI159:
	@ sp needed
	ldr	pc, [sp], #4
.LFE285:
	.size	lis2mdl_temperature_raw_get_my, .-lis2mdl_temperature_raw_get_my
	.section .rodata
	.align	2
.LC2:
	.ascii	"\015\012Error in reading device id at LIS2MDL_I2C_A"
	.ascii	"DD = 0x%02x\015\012\000"
	.align	2
.LC3:
	.ascii	"\015\012LIS2MDL device found, ID = 0x%02x\015\012\000"
	.align	2
.LC4:
	.ascii	"Error in resetting the registers\015\000"
	.align	2
.LC5:
	.ascii	"Error in setting operating mode\015\000"
	.align	2
.LC6:
	.ascii	"Error in enabling temperature compensation\015\000"
	.align	2
.LC7:
	.ascii	"Error in setting resolution\015\000"
	.align	2
.LC8:
	.ascii	"Error in setting strem frequency\015\000"
	.align	2
.LC9:
	.ascii	"Error in enabling block data update\015\000"
	.align	2
.LC10:
	.ascii	"Error in disabling self test\015\000"
	.align	2
.LC11:
	.ascii	"Configuration of LIS2MDL successful\015\000"
	.section	.text.lis2mdl_init,"ax",%progbits
	.align	1
	.global	lis2mdl_init
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_init, %function
lis2mdl_init:
.LFB286:
	.loc 2 1333 24
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI160:
	sub	sp, sp, #12
.LCFI161:
	.loc 2 1337 9
	ldr	r0, .L229
	bl	lis2mdl_device_id_get
	str	r0, [sp, #4]
	.loc 2 1339 6
	ldr	r3, [sp, #4]
	cmp	r3, #0
	bne	.L218
	.loc 2 1339 25 discriminator 1
	ldr	r3, .L229
	ldrb	r3, [r3]	@ zero_extendqisi2
	.loc 2 1339 11 discriminator 1
	cmp	r3, #64
	beq	.L219
.L218:
	.loc 2 1340 22
	ldr	r3, .L229+4
	movs	r2, #0
	strb	r2, [r3]
	.loc 2 1341 5
	movs	r1, #30
	ldr	r0, .L229+8
	bl	printf
	.loc 2 1389 1
	b	.L228
.L219:
	.loc 2 1344 22
	ldr	r3, .L229+4
	movs	r2, #1
	strb	r2, [r3]
	.loc 2 1345 5
	ldr	r3, .L229
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r1, r3
	ldr	r0, .L229+12
	bl	printf
	.loc 2 1349 11
	movs	r0, #1
	bl	lis2mdl_reset_set
	str	r0, [sp, #4]
	.loc 2 1350 7
	ldr	r3, [sp, #4]
	cmp	r3, #0
	beq	.L221
	.loc 2 1350 13 discriminator 1
	ldr	r0, .L229+16
	bl	puts
.L221:
	.loc 2 1353 11
	movs	r0, #0
	bl	lis2mdl_operating_mode_set
	str	r0, [sp, #4]
	.loc 2 1354 7
	ldr	r3, [sp, #4]
	cmp	r3, #0
	beq	.L222
	.loc 2 1354 13 discriminator 1
	ldr	r0, .L229+20
	bl	puts
.L222:
	.loc 2 1357 11
	movs	r0, #1
	bl	lis2mdl_offset_temp_comp_set
	str	r0, [sp, #4]
	.loc 2 1358 7
	ldr	r3, [sp, #4]
	cmp	r3, #0
	beq	.L223
	.loc 2 1358 13 discriminator 1
	ldr	r0, .L229+24
	bl	puts
.L223:
	.loc 2 1361 11
	movs	r0, #0
	bl	lis2mdl_power_mode_set
	str	r0, [sp, #4]
	.loc 2 1362 7
	ldr	r3, [sp, #4]
	cmp	r3, #0
	beq	.L224
	.loc 2 1362 13 discriminator 1
	ldr	r0, .L229+28
	bl	puts
.L224:
	.loc 2 1365 11
	movs	r0, #3
	bl	lis2mdl_data_rate_set
	str	r0, [sp, #4]
	.loc 2 1366 7
	ldr	r3, [sp, #4]
	cmp	r3, #0
	beq	.L225
	.loc 2 1366 13 discriminator 1
	ldr	r0, .L229+32
	bl	puts
.L225:
	.loc 2 1370 11
	movs	r0, #1
	bl	lis2mdl_block_data_update_set
	str	r0, [sp, #4]
	.loc 2 1371 7
	ldr	r3, [sp, #4]
	cmp	r3, #0
	beq	.L226
	.loc 2 1371 13 discriminator 1
	ldr	r0, .L229+36
	bl	puts
.L226:
	.loc 2 1374 11
	movs	r0, #0
	bl	lis2mdl_self_test_set
	str	r0, [sp, #4]
	.loc 2 1375 7
	ldr	r3, [sp, #4]
	cmp	r3, #0
	beq	.L227
	.loc 2 1375 13 discriminator 1
	ldr	r0, .L229+40
	bl	puts
.L227:
	.loc 2 1383 18
	bl	man_fds_get_mag_config
	mov	r3, r0
	.loc 2 1383 16
	ldr	r2, .L229+44
	str	r3, [r2]
	.loc 2 1385 7
	ldr	r3, [sp, #4]
	cmp	r3, #0
	bne	.L228
	.loc 2 1385 14 discriminator 1
	ldr	r0, .L229+48
	bl	puts
.L228:
	.loc 2 1389 1
	nop
	add	sp, sp, #12
.LCFI162:
	@ sp needed
	ldr	pc, [sp], #4
.L230:
	.align	2
.L229:
	.word	mag_whoamI
	.word	mag_device_found
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.word	mag_config
	.word	.LC11
.LFE286:
	.size	lis2mdl_init, .-lis2mdl_init
	.section	.text.lis2mdl_get_mag,"ax",%progbits
	.align	1
	.global	lis2mdl_get_mag
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_get_mag, %function
lis2mdl_get_mag:
.LFB287:
	.loc 2 1392 36
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI163:
	sub	sp, sp, #20
.LCFI164:
	str	r0, [sp, #4]
	.loc 2 1393 11
	movs	r3, #0
	str	r3, [sp, #12]
	.loc 2 1395 6
	ldr	r3, .L237
	ldrb	r3, [r3]	@ zero_extendqisi2
	eor	r3, r3, #1
	uxtb	r3, r3
	.loc 2 1395 5
	cmp	r3, #0
	beq	.L232
	.loc 2 1396 9
	movs	r3, #1
	str	r3, [sp, #12]
	b	.L233
.L232:
.LBB2:
	.loc 2 1401 11
	add	r3, sp, #11
	mov	r0, r3
	bl	lis2mdl_mag_data_ready_get
	str	r0, [sp, #12]
	.loc 2 1403 8
	ldrb	r3, [sp, #11]	@ zero_extendqisi2
	.loc 2 1403 7
	cmp	r3, #0
	beq	.L234
	.loc 2 1403 19 discriminator 1
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L234
	.loc 2 1408 13
	ldr	r0, .L237+4
	bl	lis2mdl_magnetic_raw_get_my
	str	r0, [sp, #12]
	.loc 2 1411 9
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L234
	.loc 2 1412 26
	ldr	r3, .L237+4
	ldrsh	r3, [r3]
	mov	r0, r3
	bl	lis2mdl_from_lsb_to_mgauss
	vmov.f32	s15, s0
	.loc 2 1412 24
	ldr	r3, .L237+8
	vstr.32	s15, [r3]
	.loc 2 1413 26
	ldr	r3, .L237+4
	ldrsh	r3, [r3, #2]
	mov	r0, r3
	bl	lis2mdl_from_lsb_to_mgauss
	vmov.f32	s15, s0
	.loc 2 1413 24
	ldr	r3, .L237+8
	vstr.32	s15, [r3, #4]
	.loc 2 1414 26
	ldr	r3, .L237+4
	ldrsh	r3, [r3, #4]
	mov	r0, r3
	bl	lis2mdl_from_lsb_to_mgauss
	vmov.f32	s15, s0
	.loc 2 1414 24
	ldr	r3, .L237+8
	vstr.32	s15, [r3, #8]
.L234:
	.loc 2 1420 7
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L233
	.loc 2 1420 13 discriminator 1
	ldr	r3, [sp, #4]
	cmp	r3, #0
	beq	.L233
	.loc 2 1421 27
	ldr	r3, .L237+8
	ldr	r2, [r3]	@ float
	.loc 2 1421 14
	ldr	r3, [sp, #4]
	str	r2, [r3]	@ float
	.loc 2 1422 10
	ldr	r3, [sp, #4]
	adds	r3, r3, #4
	.loc 2 1422 27
	ldr	r2, .L237+8
	ldr	r2, [r2, #4]	@ float
	.loc 2 1422 14
	str	r2, [r3]	@ float
	.loc 2 1423 10
	ldr	r3, [sp, #4]
	adds	r3, r3, #8
	.loc 2 1423 27
	ldr	r2, .L237+8
	ldr	r2, [r2, #8]	@ float
	.loc 2 1423 14
	str	r2, [r3]	@ float
.L233:
.LBE2:
	.loc 2 1428 10
	ldr	r3, [sp, #12]
	.loc 2 1429 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI165:
	@ sp needed
	ldr	pc, [sp], #4
.L238:
	.align	2
.L237:
	.word	mag_device_found
	.word	data_raw_magnetic
	.word	magnetic_mG
.LFE287:
	.size	lis2mdl_get_mag, .-lis2mdl_get_mag
	.global	__aeabi_f2d
	.section .rodata
	.align	2
.LC12:
	.ascii	"raw_m:\011%3.2f\011%3.2f\011%3.2f\000"
	.section	.text.lis2mdl_get_mag_calibrated,"ax",%progbits
	.align	1
	.global	lis2mdl_get_mag_calibrated
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_get_mag_calibrated, %function
lis2mdl_get_mag_calibrated:
.LFB288:
	.loc 2 1432 47
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
.LCFI166:
	sub	sp, sp, #36
.LCFI167:
	str	r0, [sp, #20]
	.loc 2 1433 17
	movs	r0, #0
	bl	lis2mdl_get_mag
	str	r0, [sp, #28]
	.loc 2 1436 52
	ldr	r3, .L242
	ldr	r3, [r3]	@ float
	.loc 2 1436 3
	mov	r0, r3	@ float
	bl	__aeabi_f2d
	mov	r6, r0
	mov	r7, r1
	.loc 2 1436 68
	ldr	r3, .L242
	ldr	r3, [r3, #4]	@ float
	.loc 2 1436 3
	mov	r0, r3	@ float
	bl	__aeabi_f2d
	mov	r4, r0
	mov	r5, r1
	.loc 2 1436 84
	ldr	r3, .L242
	ldr	r3, [r3, #8]	@ float
	.loc 2 1436 3
	mov	r0, r3	@ float
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	strd	r2, [sp, #8]
	strd	r4, [sp]
	mov	r2, r6
	mov	r3, r7
	ldr	r0, .L242+4
	bl	printf
	.loc 2 1439 5
	ldr	r3, [sp, #28]
	cmp	r3, #0
	bne	.L240
	.loc 2 1441 27
	ldr	r3, .L242
	vldr.32	s14, [r3]
	.loc 2 1441 43
	ldr	r3, .L242+8
	ldr	r3, [r3]
	.loc 2 1441 54
	vldr.32	s15, [r3]
	.loc 2 1441 31
	vsub.f32	s14, s14, s15
	.loc 2 1441 71
	ldr	r3, .L242+8
	ldr	r3, [r3]
	.loc 2 1441 82
	vldr.32	s15, [r3, #12]
	.loc 2 1441 59
	vmul.f32	s14, s14, s15
	.loc 2 1442 27
	ldr	r3, .L242
	vldr.32	s13, [r3, #4]
	.loc 2 1442 43
	ldr	r3, .L242+8
	ldr	r3, [r3]
	.loc 2 1442 54
	vldr.32	s15, [r3, #4]
	.loc 2 1442 31
	vsub.f32	s13, s13, s15
	.loc 2 1442 71
	ldr	r3, .L242+8
	ldr	r3, [r3]
	.loc 2 1442 82
	vldr.32	s15, [r3, #24]
	.loc 2 1442 59
	vmul.f32	s15, s13, s15
	.loc 2 1441 86
	vadd.f32	s14, s14, s15
	.loc 2 1443 27
	ldr	r3, .L242
	vldr.32	s13, [r3, #8]
	.loc 2 1443 43
	ldr	r3, .L242+8
	ldr	r3, [r3]
	.loc 2 1443 54
	vldr.32	s15, [r3, #8]
	.loc 2 1443 31
	vsub.f32	s13, s13, s15
	.loc 2 1443 71
	ldr	r3, .L242+8
	ldr	r3, [r3]
	.loc 2 1443 82
	vldr.32	s15, [r3, #36]
	.loc 2 1443 59
	vmul.f32	s15, s13, s15
	.loc 2 1442 86
	vadd.f32	s15, s14, s15
	.loc 2 1441 12
	ldr	r3, [sp, #20]
	vstr.32	s15, [r3]
	.loc 2 1445 27
	ldr	r3, .L242
	vldr.32	s14, [r3]
	.loc 2 1445 43
	ldr	r3, .L242+8
	ldr	r3, [r3]
	.loc 2 1445 54
	vldr.32	s15, [r3]
	.loc 2 1445 31
	vsub.f32	s14, s14, s15
	.loc 2 1445 71
	ldr	r3, .L242+8
	ldr	r3, [r3]
	.loc 2 1445 82
	vldr.32	s15, [r3, #16]
	.loc 2 1445 59
	vmul.f32	s14, s14, s15
	.loc 2 1446 27
	ldr	r3, .L242
	vldr.32	s13, [r3, #4]
	.loc 2 1446 43
	ldr	r3, .L242+8
	ldr	r3, [r3]
	.loc 2 1446 54
	vldr.32	s15, [r3, #4]
	.loc 2 1446 31
	vsub.f32	s13, s13, s15
	.loc 2 1446 71
	ldr	r3, .L242+8
	ldr	r3, [r3]
	.loc 2 1446 82
	vldr.32	s15, [r3, #28]
	.loc 2 1446 59
	vmul.f32	s15, s13, s15
	.loc 2 1445 86
	vadd.f32	s14, s14, s15
	.loc 2 1447 27
	ldr	r3, .L242
	vldr.32	s13, [r3, #8]
	.loc 2 1447 43
	ldr	r3, .L242+8
	ldr	r3, [r3]
	.loc 2 1447 54
	vldr.32	s15, [r3, #8]
	.loc 2 1447 31
	vsub.f32	s13, s13, s15
	.loc 2 1447 71
	ldr	r3, .L242+8
	ldr	r3, [r3]
	.loc 2 1447 82
	vldr.32	s15, [r3, #40]
	.loc 2 1447 59
	vmul.f32	s15, s13, s15
	.loc 2 1445 8
	ldr	r3, [sp, #20]
	adds	r3, r3, #4
	.loc 2 1446 86
	vadd.f32	s15, s14, s15
	.loc 2 1445 12
	vstr.32	s15, [r3]
	.loc 2 1449 27
	ldr	r3, .L242
	vldr.32	s14, [r3]
	.loc 2 1449 43
	ldr	r3, .L242+8
	ldr	r3, [r3]
	.loc 2 1449 54
	vldr.32	s15, [r3]
	.loc 2 1449 31
	vsub.f32	s14, s14, s15
	.loc 2 1449 71
	ldr	r3, .L242+8
	ldr	r3, [r3]
	.loc 2 1449 82
	vldr.32	s15, [r3, #20]
	.loc 2 1449 59
	vmul.f32	s14, s14, s15
	.loc 2 1450 27
	ldr	r3, .L242
	vldr.32	s13, [r3, #4]
	.loc 2 1450 43
	ldr	r3, .L242+8
	ldr	r3, [r3]
	.loc 2 1450 54
	vldr.32	s15, [r3, #4]
	.loc 2 1450 31
	vsub.f32	s13, s13, s15
	.loc 2 1450 71
	ldr	r3, .L242+8
	ldr	r3, [r3]
	.loc 2 1450 82
	vldr.32	s15, [r3, #32]
	.loc 2 1450 59
	vmul.f32	s15, s13, s15
	.loc 2 1449 86
	vadd.f32	s14, s14, s15
	.loc 2 1451 27
	ldr	r3, .L242
	vldr.32	s13, [r3, #8]
	.loc 2 1451 43
	ldr	r3, .L242+8
	ldr	r3, [r3]
	.loc 2 1451 54
	vldr.32	s15, [r3, #8]
	.loc 2 1451 31
	vsub.f32	s13, s13, s15
	.loc 2 1451 71
	ldr	r3, .L242+8
	ldr	r3, [r3]
	.loc 2 1451 82
	vldr.32	s15, [r3, #44]
	.loc 2 1451 59
	vmul.f32	s15, s13, s15
	.loc 2 1449 8
	ldr	r3, [sp, #20]
	adds	r3, r3, #8
	.loc 2 1450 86
	vadd.f32	s15, s14, s15
	.loc 2 1449 12
	vstr.32	s15, [r3]
.L240:
	.loc 2 1455 10
	ldr	r3, [sp, #28]
	.loc 2 1456 1
	mov	r0, r3
	add	sp, sp, #36
.LCFI168:
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L243:
	.align	2
.L242:
	.word	magnetic_mG
	.word	.LC12
	.word	mag_config
.LFE288:
	.size	lis2mdl_get_mag_calibrated, .-lis2mdl_get_mag_calibrated
	.section .rodata
	.align	2
.LC13:
	.ascii	"Error during data reading\000"
	.align	2
.LC14:
	.ascii	"mag:\011%4.2f\011%4.2f\011%4.2f\015\012\000"
	.section	.text.lis2mdl_print_mag,"ax",%progbits
	.align	1
	.global	lis2mdl_print_mag
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_print_mag, %function
lis2mdl_print_mag:
.LFB289:
	.loc 2 1459 29
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
.LCFI169:
	sub	sp, sp, #36
.LCFI170:
	.loc 2 1462 6
	add	r3, sp, #20
	mov	r0, r3
	bl	lis2mdl_get_mag_calibrated
	mov	r3, r0
	.loc 2 1462 5
	cmp	r3, #0
	beq	.L245
	.loc 2 1462 39 discriminator 1
	ldr	r0, .L248
	bl	printf
	.loc 2 1471 1 discriminator 1
	b	.L247
.L245:
	.loc 2 1466 26
	ldr	r3, [sp, #20]	@ float
	.loc 2 1465 5
	mov	r0, r3	@ float
	bl	__aeabi_f2d
	mov	r6, r0
	mov	r7, r1
	.loc 2 1467 26
	ldr	r3, [sp, #24]	@ float
	.loc 2 1465 5
	mov	r0, r3	@ float
	bl	__aeabi_f2d
	mov	r4, r0
	mov	r5, r1
	.loc 2 1468 26
	ldr	r3, [sp, #28]	@ float
	.loc 2 1465 5
	mov	r0, r3	@ float
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	strd	r2, [sp, #8]
	strd	r4, [sp]
	mov	r2, r6
	mov	r3, r7
	ldr	r0, .L248+4
	bl	printf
.L247:
	.loc 2 1471 1
	nop
	add	sp, sp, #36
.LCFI171:
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L249:
	.align	2
.L248:
	.word	.LC13
	.word	.LC14
.LFE289:
	.size	lis2mdl_print_mag, .-lis2mdl_print_mag
	.section	.text.lis2mdl_get_temp,"ax",%progbits
	.align	1
	.global	lis2mdl_get_temp
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_get_temp, %function
lis2mdl_get_temp:
.LFB290:
	.loc 2 1474 37
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI172:
	sub	sp, sp, #20
.LCFI173:
	str	r0, [sp, #4]
	.loc 2 1475 11
	movs	r3, #0
	str	r3, [sp, #12]
	.loc 2 1477 6
	ldr	r3, .L255
	ldrb	r3, [r3]	@ zero_extendqisi2
	eor	r3, r3, #1
	uxtb	r3, r3
	.loc 2 1477 5
	cmp	r3, #0
	beq	.L251
	.loc 2 1478 9
	movs	r3, #1
	str	r3, [sp, #12]
	b	.L252
.L251:
	.loc 2 1482 11
	ldr	r0, .L255+4
	bl	lis2mdl_temperature_raw_get_my
	str	r0, [sp, #12]
	.loc 2 1483 7
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L253
	.loc 2 1485 34
	ldr	r3, .L255+4
	ldrsh	r3, [r3]
	mov	r0, r3
	bl	lis2mdl_from_lsb_to_celsius
	vmov.f32	s15, s0
	.loc 2 1485 32
	ldr	r3, .L255+8
	vstr.32	s15, [r3]
.L253:
	.loc 2 1487 7
	ldr	r3, [sp, #12]
	cmp	r3, #0
	bne	.L252
	.loc 2 1487 13 discriminator 1
	ldr	r3, [sp, #4]
	cmp	r3, #0
	beq	.L252
	.loc 2 1487 34 discriminator 2
	ldr	r3, .L255+8
	ldr	r2, [r3]	@ float
	ldr	r3, [sp, #4]
	str	r2, [r3]	@ float
.L252:
	.loc 2 1490 10
	ldr	r3, [sp, #12]
	.loc 2 1491 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI174:
	@ sp needed
	ldr	pc, [sp], #4
.L256:
	.align	2
.L255:
	.word	mag_device_found
	.word	lis2mdl_data_raw_temperature
	.word	lis2mdl_temperature_degC
.LFE290:
	.size	lis2mdl_get_temp, .-lis2mdl_get_temp
	.section .rodata
	.align	2
.LC15:
	.ascii	"tmp mag:\011%6.2f\015\012\000"
	.section	.text.lis2mdl_print_temp,"ax",%progbits
	.align	1
	.global	lis2mdl_print_temp
	.syntax unified
	.thumb
	.thumb_func
	.type	lis2mdl_print_temp, %function
lis2mdl_print_temp:
.LFB291:
	.loc 2 1494 30
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI175:
	sub	sp, sp, #12
.LCFI176:
	.loc 2 1495 17
	movs	r0, #0
	bl	lis2mdl_get_temp
	str	r0, [sp, #4]
	.loc 2 1497 5
	ldr	r3, [sp, #4]
	cmp	r3, #0
	beq	.L258
	.loc 2 1497 11 discriminator 1
	ldr	r0, .L261
	bl	printf
	.loc 2 1502 1 discriminator 1
	b	.L260
.L258:
	.loc 2 1500 5
	ldr	r3, .L261+4
	ldr	r3, [r3]	@ float
	mov	r0, r3	@ float
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L261+8
	bl	printf
.L260:
	.loc 2 1502 1
	nop
	add	sp, sp, #12
.LCFI177:
	@ sp needed
	ldr	pc, [sp], #4
.L262:
	.align	2
.L261:
	.word	.LC13
	.word	lis2mdl_temperature_degC
	.word	.LC15
.LFE291:
	.size	lis2mdl_print_temp, .-lis2mdl_print_temp
	.section	.debug_frame,"",%progbits
.Lframe0:
	.4byte	.LECIE0-.LSCIE0
.LSCIE0:
	.4byte	0xffffffff
	.byte	0x3
	.ascii	"\000"
	.uleb128 0x1
	.sleb128 -4
	.uleb128 0xe
	.byte	0xc
	.uleb128 0xd
	.uleb128 0
	.align	2
.LECIE0:
.LSFDE0:
	.4byte	.LEFDE0-.LASFDE0
.LASFDE0:
	.4byte	.Lframe0
	.4byte	.LFB124
	.4byte	.LFE124-.LFB124
	.align	2
.LEFDE0:
.LSFDE2:
	.4byte	.LEFDE2-.LASFDE2
.LASFDE2:
	.4byte	.Lframe0
	.4byte	.LFB125
	.4byte	.LFE125-.LFB125
	.align	2
.LEFDE2:
.LSFDE4:
	.4byte	.LEFDE4-.LASFDE4
.LASFDE4:
	.4byte	.Lframe0
	.4byte	.LFB126
	.4byte	.LFE126-.LFB126
	.align	2
.LEFDE4:
.LSFDE6:
	.4byte	.LEFDE6-.LASFDE6
.LASFDE6:
	.4byte	.Lframe0
	.4byte	.LFB127
	.4byte	.LFE127-.LFB127
	.align	2
.LEFDE6:
.LSFDE8:
	.4byte	.LEFDE8-.LASFDE8
.LASFDE8:
	.4byte	.Lframe0
	.4byte	.LFB128
	.4byte	.LFE128-.LFB128
	.align	2
.LEFDE8:
.LSFDE10:
	.4byte	.LEFDE10-.LASFDE10
.LASFDE10:
	.4byte	.Lframe0
	.4byte	.LFB129
	.4byte	.LFE129-.LFB129
	.align	2
.LEFDE10:
.LSFDE12:
	.4byte	.LEFDE12-.LASFDE12
.LASFDE12:
	.4byte	.Lframe0
	.4byte	.LFB130
	.4byte	.LFE130-.LFB130
	.align	2
.LEFDE12:
.LSFDE14:
	.4byte	.LEFDE14-.LASFDE14
.LASFDE14:
	.4byte	.Lframe0
	.4byte	.LFB131
	.4byte	.LFE131-.LFB131
	.align	2
.LEFDE14:
.LSFDE16:
	.4byte	.LEFDE16-.LASFDE16
.LASFDE16:
	.4byte	.Lframe0
	.4byte	.LFB132
	.4byte	.LFE132-.LFB132
	.align	2
.LEFDE16:
.LSFDE18:
	.4byte	.LEFDE18-.LASFDE18
.LASFDE18:
	.4byte	.Lframe0
	.4byte	.LFB133
	.4byte	.LFE133-.LFB133
	.align	2
.LEFDE18:
.LSFDE20:
	.4byte	.LEFDE20-.LASFDE20
.LASFDE20:
	.4byte	.Lframe0
	.4byte	.LFB134
	.4byte	.LFE134-.LFB134
	.align	2
.LEFDE20:
.LSFDE22:
	.4byte	.LEFDE22-.LASFDE22
.LASFDE22:
	.4byte	.Lframe0
	.4byte	.LFB135
	.4byte	.LFE135-.LFB135
	.align	2
.LEFDE22:
.LSFDE24:
	.4byte	.LEFDE24-.LASFDE24
.LASFDE24:
	.4byte	.Lframe0
	.4byte	.LFB136
	.4byte	.LFE136-.LFB136
	.align	2
.LEFDE24:
.LSFDE26:
	.4byte	.LEFDE26-.LASFDE26
.LASFDE26:
	.4byte	.Lframe0
	.4byte	.LFB137
	.4byte	.LFE137-.LFB137
	.align	2
.LEFDE26:
.LSFDE28:
	.4byte	.LEFDE28-.LASFDE28
.LASFDE28:
	.4byte	.Lframe0
	.4byte	.LFB138
	.4byte	.LFE138-.LFB138
	.align	2
.LEFDE28:
.LSFDE30:
	.4byte	.LEFDE30-.LASFDE30
.LASFDE30:
	.4byte	.Lframe0
	.4byte	.LFB139
	.4byte	.LFE139-.LFB139
	.align	2
.LEFDE30:
.LSFDE32:
	.4byte	.LEFDE32-.LASFDE32
.LASFDE32:
	.4byte	.Lframe0
	.4byte	.LFB140
	.4byte	.LFE140-.LFB140
	.align	2
.LEFDE32:
.LSFDE34:
	.4byte	.LEFDE34-.LASFDE34
.LASFDE34:
	.4byte	.Lframe0
	.4byte	.LFB141
	.4byte	.LFE141-.LFB141
	.align	2
.LEFDE34:
.LSFDE36:
	.4byte	.LEFDE36-.LASFDE36
.LASFDE36:
	.4byte	.Lframe0
	.4byte	.LFB142
	.4byte	.LFE142-.LFB142
	.align	2
.LEFDE36:
.LSFDE38:
	.4byte	.LEFDE38-.LASFDE38
.LASFDE38:
	.4byte	.Lframe0
	.4byte	.LFB143
	.4byte	.LFE143-.LFB143
	.align	2
.LEFDE38:
.LSFDE40:
	.4byte	.LEFDE40-.LASFDE40
.LASFDE40:
	.4byte	.Lframe0
	.4byte	.LFB144
	.4byte	.LFE144-.LFB144
	.align	2
.LEFDE40:
.LSFDE42:
	.4byte	.LEFDE42-.LASFDE42
.LASFDE42:
	.4byte	.Lframe0
	.4byte	.LFB145
	.4byte	.LFE145-.LFB145
	.align	2
.LEFDE42:
.LSFDE44:
	.4byte	.LEFDE44-.LASFDE44
.LASFDE44:
	.4byte	.Lframe0
	.4byte	.LFB146
	.4byte	.LFE146-.LFB146
	.align	2
.LEFDE44:
.LSFDE46:
	.4byte	.LEFDE46-.LASFDE46
.LASFDE46:
	.4byte	.Lframe0
	.4byte	.LFB147
	.4byte	.LFE147-.LFB147
	.align	2
.LEFDE46:
.LSFDE48:
	.4byte	.LEFDE48-.LASFDE48
.LASFDE48:
	.4byte	.Lframe0
	.4byte	.LFB148
	.4byte	.LFE148-.LFB148
	.align	2
.LEFDE48:
.LSFDE50:
	.4byte	.LEFDE50-.LASFDE50
.LASFDE50:
	.4byte	.Lframe0
	.4byte	.LFB149
	.4byte	.LFE149-.LFB149
	.align	2
.LEFDE50:
.LSFDE52:
	.4byte	.LEFDE52-.LASFDE52
.LASFDE52:
	.4byte	.Lframe0
	.4byte	.LFB150
	.4byte	.LFE150-.LFB150
	.align	2
.LEFDE52:
.LSFDE54:
	.4byte	.LEFDE54-.LASFDE54
.LASFDE54:
	.4byte	.Lframe0
	.4byte	.LFB151
	.4byte	.LFE151-.LFB151
	.align	2
.LEFDE54:
.LSFDE56:
	.4byte	.LEFDE56-.LASFDE56
.LASFDE56:
	.4byte	.Lframe0
	.4byte	.LFB152
	.4byte	.LFE152-.LFB152
	.align	2
.LEFDE56:
.LSFDE58:
	.4byte	.LEFDE58-.LASFDE58
.LASFDE58:
	.4byte	.Lframe0
	.4byte	.LFB153
	.4byte	.LFE153-.LFB153
	.align	2
.LEFDE58:
.LSFDE60:
	.4byte	.LEFDE60-.LASFDE60
.LASFDE60:
	.4byte	.Lframe0
	.4byte	.LFB154
	.4byte	.LFE154-.LFB154
	.align	2
.LEFDE60:
.LSFDE62:
	.4byte	.LEFDE62-.LASFDE62
.LASFDE62:
	.4byte	.Lframe0
	.4byte	.LFB155
	.4byte	.LFE155-.LFB155
	.align	2
.LEFDE62:
.LSFDE64:
	.4byte	.LEFDE64-.LASFDE64
.LASFDE64:
	.4byte	.Lframe0
	.4byte	.LFB156
	.4byte	.LFE156-.LFB156
	.align	2
.LEFDE64:
.LSFDE66:
	.4byte	.LEFDE66-.LASFDE66
.LASFDE66:
	.4byte	.Lframe0
	.4byte	.LFB157
	.4byte	.LFE157-.LFB157
	.align	2
.LEFDE66:
.LSFDE68:
	.4byte	.LEFDE68-.LASFDE68
.LASFDE68:
	.4byte	.Lframe0
	.4byte	.LFB158
	.4byte	.LFE158-.LFB158
	.align	2
.LEFDE68:
.LSFDE70:
	.4byte	.LEFDE70-.LASFDE70
.LASFDE70:
	.4byte	.Lframe0
	.4byte	.LFB159
	.4byte	.LFE159-.LFB159
	.align	2
.LEFDE70:
.LSFDE72:
	.4byte	.LEFDE72-.LASFDE72
.LASFDE72:
	.4byte	.Lframe0
	.4byte	.LFB160
	.4byte	.LFE160-.LFB160
	.align	2
.LEFDE72:
.LSFDE74:
	.4byte	.LEFDE74-.LASFDE74
.LASFDE74:
	.4byte	.Lframe0
	.4byte	.LFB161
	.4byte	.LFE161-.LFB161
	.align	2
.LEFDE74:
.LSFDE76:
	.4byte	.LEFDE76-.LASFDE76
.LASFDE76:
	.4byte	.Lframe0
	.4byte	.LFB162
	.4byte	.LFE162-.LFB162
	.align	2
.LEFDE76:
.LSFDE78:
	.4byte	.LEFDE78-.LASFDE78
.LASFDE78:
	.4byte	.Lframe0
	.4byte	.LFB163
	.4byte	.LFE163-.LFB163
	.align	2
.LEFDE78:
.LSFDE80:
	.4byte	.LEFDE80-.LASFDE80
.LASFDE80:
	.4byte	.Lframe0
	.4byte	.LFB164
	.4byte	.LFE164-.LFB164
	.align	2
.LEFDE80:
.LSFDE82:
	.4byte	.LEFDE82-.LASFDE82
.LASFDE82:
	.4byte	.Lframe0
	.4byte	.LFB165
	.4byte	.LFE165-.LFB165
	.align	2
.LEFDE82:
.LSFDE84:
	.4byte	.LEFDE84-.LASFDE84
.LASFDE84:
	.4byte	.Lframe0
	.4byte	.LFB232
	.4byte	.LFE232-.LFB232
	.byte	0x4
	.4byte	.LCFI0-.LFB232
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI1-.LCFI0
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI2-.LCFI1
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE84:
.LSFDE86:
	.4byte	.LEFDE86-.LASFDE86
.LASFDE86:
	.4byte	.Lframe0
	.4byte	.LFB233
	.4byte	.LFE233-.LFB233
	.byte	0x4
	.4byte	.LCFI3-.LFB233
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI4-.LCFI3
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI5-.LCFI4
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE86:
.LSFDE88:
	.4byte	.LEFDE88-.LASFDE88
.LASFDE88:
	.4byte	.Lframe0
	.4byte	.LFB234
	.4byte	.LFE234-.LFB234
	.byte	0x4
	.4byte	.LCFI6-.LFB234
	.byte	0xe
	.uleb128 0x8
	.byte	0x4
	.4byte	.LCFI7-.LCFI6
	.byte	0xe
	.uleb128 0
	.align	2
.LEFDE88:
.LSFDE90:
	.4byte	.LEFDE90-.LASFDE90
.LASFDE90:
	.4byte	.Lframe0
	.4byte	.LFB235
	.4byte	.LFE235-.LFB235
	.byte	0x4
	.4byte	.LCFI8-.LFB235
	.byte	0xe
	.uleb128 0x8
	.byte	0x4
	.4byte	.LCFI9-.LCFI8
	.byte	0xe
	.uleb128 0
	.align	2
.LEFDE90:
.LSFDE92:
	.4byte	.LEFDE92-.LASFDE92
.LASFDE92:
	.4byte	.Lframe0
	.4byte	.LFB236
	.4byte	.LFE236-.LFB236
	.byte	0x4
	.4byte	.LCFI10-.LFB236
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI11-.LCFI10
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI12-.LCFI11
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE92:
.LSFDE94:
	.4byte	.LEFDE94-.LASFDE94
.LASFDE94:
	.4byte	.Lframe0
	.4byte	.LFB237
	.4byte	.LFE237-.LFB237
	.byte	0x4
	.4byte	.LCFI13-.LFB237
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI14-.LCFI13
	.byte	0xe
	.uleb128 0x20
	.byte	0x4
	.4byte	.LCFI15-.LCFI14
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE94:
.LSFDE96:
	.4byte	.LEFDE96-.LASFDE96
.LASFDE96:
	.4byte	.Lframe0
	.4byte	.LFB238
	.4byte	.LFE238-.LFB238
	.byte	0x4
	.4byte	.LCFI16-.LFB238
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI17-.LCFI16
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI18-.LCFI17
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE96:
.LSFDE98:
	.4byte	.LEFDE98-.LASFDE98
.LASFDE98:
	.4byte	.Lframe0
	.4byte	.LFB239
	.4byte	.LFE239-.LFB239
	.byte	0x4
	.4byte	.LCFI19-.LFB239
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI20-.LCFI19
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI21-.LCFI20
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE98:
.LSFDE100:
	.4byte	.LEFDE100-.LASFDE100
.LASFDE100:
	.4byte	.Lframe0
	.4byte	.LFB240
	.4byte	.LFE240-.LFB240
	.byte	0x4
	.4byte	.LCFI22-.LFB240
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI23-.LCFI22
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI24-.LCFI23
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE100:
.LSFDE102:
	.4byte	.LEFDE102-.LASFDE102
.LASFDE102:
	.4byte	.Lframe0
	.4byte	.LFB241
	.4byte	.LFE241-.LFB241
	.byte	0x4
	.4byte	.LCFI25-.LFB241
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI26-.LCFI25
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI27-.LCFI26
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE102:
.LSFDE104:
	.4byte	.LEFDE104-.LASFDE104
.LASFDE104:
	.4byte	.Lframe0
	.4byte	.LFB242
	.4byte	.LFE242-.LFB242
	.byte	0x4
	.4byte	.LCFI28-.LFB242
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI29-.LCFI28
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI30-.LCFI29
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE104:
.LSFDE106:
	.4byte	.LEFDE106-.LASFDE106
.LASFDE106:
	.4byte	.Lframe0
	.4byte	.LFB243
	.4byte	.LFE243-.LFB243
	.byte	0x4
	.4byte	.LCFI31-.LFB243
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI32-.LCFI31
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI33-.LCFI32
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE106:
.LSFDE108:
	.4byte	.LEFDE108-.LASFDE108
.LASFDE108:
	.4byte	.Lframe0
	.4byte	.LFB244
	.4byte	.LFE244-.LFB244
	.byte	0x4
	.4byte	.LCFI34-.LFB244
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI35-.LCFI34
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI36-.LCFI35
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE108:
.LSFDE110:
	.4byte	.LEFDE110-.LASFDE110
.LASFDE110:
	.4byte	.Lframe0
	.4byte	.LFB245
	.4byte	.LFE245-.LFB245
	.byte	0x4
	.4byte	.LCFI37-.LFB245
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI38-.LCFI37
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI39-.LCFI38
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE110:
.LSFDE112:
	.4byte	.LEFDE112-.LASFDE112
.LASFDE112:
	.4byte	.Lframe0
	.4byte	.LFB246
	.4byte	.LFE246-.LFB246
	.byte	0x4
	.4byte	.LCFI40-.LFB246
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI41-.LCFI40
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI42-.LCFI41
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE112:
.LSFDE114:
	.4byte	.LEFDE114-.LASFDE114
.LASFDE114:
	.4byte	.Lframe0
	.4byte	.LFB247
	.4byte	.LFE247-.LFB247
	.byte	0x4
	.4byte	.LCFI43-.LFB247
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI44-.LCFI43
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI45-.LCFI44
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE114:
.LSFDE116:
	.4byte	.LEFDE116-.LASFDE116
.LASFDE116:
	.4byte	.Lframe0
	.4byte	.LFB248
	.4byte	.LFE248-.LFB248
	.byte	0x4
	.4byte	.LCFI46-.LFB248
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI47-.LCFI46
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI48-.LCFI47
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE116:
.LSFDE118:
	.4byte	.LEFDE118-.LASFDE118
.LASFDE118:
	.4byte	.Lframe0
	.4byte	.LFB249
	.4byte	.LFE249-.LFB249
	.byte	0x4
	.4byte	.LCFI49-.LFB249
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI50-.LCFI49
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI51-.LCFI50
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE118:
.LSFDE120:
	.4byte	.LEFDE120-.LASFDE120
.LASFDE120:
	.4byte	.Lframe0
	.4byte	.LFB250
	.4byte	.LFE250-.LFB250
	.byte	0x4
	.4byte	.LCFI52-.LFB250
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI53-.LCFI52
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI54-.LCFI53
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE120:
.LSFDE122:
	.4byte	.LEFDE122-.LASFDE122
.LASFDE122:
	.4byte	.Lframe0
	.4byte	.LFB251
	.4byte	.LFE251-.LFB251
	.byte	0x4
	.4byte	.LCFI55-.LFB251
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI56-.LCFI55
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI57-.LCFI56
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE122:
.LSFDE124:
	.4byte	.LEFDE124-.LASFDE124
.LASFDE124:
	.4byte	.Lframe0
	.4byte	.LFB252
	.4byte	.LFE252-.LFB252
	.byte	0x4
	.4byte	.LCFI58-.LFB252
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI59-.LCFI58
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI60-.LCFI59
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE124:
.LSFDE126:
	.4byte	.LEFDE126-.LASFDE126
.LASFDE126:
	.4byte	.Lframe0
	.4byte	.LFB253
	.4byte	.LFE253-.LFB253
	.byte	0x4
	.4byte	.LCFI61-.LFB253
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI62-.LCFI61
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI63-.LCFI62
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE126:
.LSFDE128:
	.4byte	.LEFDE128-.LASFDE128
.LASFDE128:
	.4byte	.Lframe0
	.4byte	.LFB254
	.4byte	.LFE254-.LFB254
	.byte	0x4
	.4byte	.LCFI64-.LFB254
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI65-.LCFI64
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI66-.LCFI65
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE128:
.LSFDE130:
	.4byte	.LEFDE130-.LASFDE130
.LASFDE130:
	.4byte	.Lframe0
	.4byte	.LFB255
	.4byte	.LFE255-.LFB255
	.byte	0x4
	.4byte	.LCFI67-.LFB255
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI68-.LCFI67
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI69-.LCFI68
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE130:
.LSFDE132:
	.4byte	.LEFDE132-.LASFDE132
.LASFDE132:
	.4byte	.Lframe0
	.4byte	.LFB256
	.4byte	.LFE256-.LFB256
	.byte	0x4
	.4byte	.LCFI70-.LFB256
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI71-.LCFI70
	.byte	0xe
	.uleb128 0x20
	.byte	0x4
	.4byte	.LCFI72-.LCFI71
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE132:
.LSFDE134:
	.4byte	.LEFDE134-.LASFDE134
.LASFDE134:
	.4byte	.Lframe0
	.4byte	.LFB257
	.4byte	.LFE257-.LFB257
	.byte	0x4
	.4byte	.LCFI73-.LFB257
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI74-.LCFI73
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI75-.LCFI74
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE134:
.LSFDE136:
	.4byte	.LEFDE136-.LASFDE136
.LASFDE136:
	.4byte	.Lframe0
	.4byte	.LFB258
	.4byte	.LFE258-.LFB258
	.byte	0x4
	.4byte	.LCFI76-.LFB258
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI77-.LCFI76
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI78-.LCFI77
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE136:
.LSFDE138:
	.4byte	.LEFDE138-.LASFDE138
.LASFDE138:
	.4byte	.Lframe0
	.4byte	.LFB259
	.4byte	.LFE259-.LFB259
	.byte	0x4
	.4byte	.LCFI79-.LFB259
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI80-.LCFI79
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI81-.LCFI80
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE138:
.LSFDE140:
	.4byte	.LEFDE140-.LASFDE140
.LASFDE140:
	.4byte	.Lframe0
	.4byte	.LFB260
	.4byte	.LFE260-.LFB260
	.byte	0x4
	.4byte	.LCFI82-.LFB260
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI83-.LCFI82
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI84-.LCFI83
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE140:
.LSFDE142:
	.4byte	.LEFDE142-.LASFDE142
.LASFDE142:
	.4byte	.Lframe0
	.4byte	.LFB261
	.4byte	.LFE261-.LFB261
	.byte	0x4
	.4byte	.LCFI85-.LFB261
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI86-.LCFI85
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI87-.LCFI86
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE142:
.LSFDE144:
	.4byte	.LEFDE144-.LASFDE144
.LASFDE144:
	.4byte	.Lframe0
	.4byte	.LFB262
	.4byte	.LFE262-.LFB262
	.byte	0x4
	.4byte	.LCFI88-.LFB262
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI89-.LCFI88
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI90-.LCFI89
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE144:
.LSFDE146:
	.4byte	.LEFDE146-.LASFDE146
.LASFDE146:
	.4byte	.Lframe0
	.4byte	.LFB263
	.4byte	.LFE263-.LFB263
	.byte	0x4
	.4byte	.LCFI91-.LFB263
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI92-.LCFI91
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI93-.LCFI92
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE146:
.LSFDE148:
	.4byte	.LEFDE148-.LASFDE148
.LASFDE148:
	.4byte	.Lframe0
	.4byte	.LFB264
	.4byte	.LFE264-.LFB264
	.byte	0x4
	.4byte	.LCFI94-.LFB264
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI95-.LCFI94
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI96-.LCFI95
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE148:
.LSFDE150:
	.4byte	.LEFDE150-.LASFDE150
.LASFDE150:
	.4byte	.Lframe0
	.4byte	.LFB265
	.4byte	.LFE265-.LFB265
	.byte	0x4
	.4byte	.LCFI97-.LFB265
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI98-.LCFI97
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI99-.LCFI98
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE150:
.LSFDE152:
	.4byte	.LEFDE152-.LASFDE152
.LASFDE152:
	.4byte	.Lframe0
	.4byte	.LFB266
	.4byte	.LFE266-.LFB266
	.byte	0x4
	.4byte	.LCFI100-.LFB266
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI101-.LCFI100
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI102-.LCFI101
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE152:
.LSFDE154:
	.4byte	.LEFDE154-.LASFDE154
.LASFDE154:
	.4byte	.Lframe0
	.4byte	.LFB267
	.4byte	.LFE267-.LFB267
	.byte	0x4
	.4byte	.LCFI103-.LFB267
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI104-.LCFI103
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI105-.LCFI104
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE154:
.LSFDE156:
	.4byte	.LEFDE156-.LASFDE156
.LASFDE156:
	.4byte	.Lframe0
	.4byte	.LFB268
	.4byte	.LFE268-.LFB268
	.byte	0x4
	.4byte	.LCFI106-.LFB268
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI107-.LCFI106
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI108-.LCFI107
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE156:
.LSFDE158:
	.4byte	.LEFDE158-.LASFDE158
.LASFDE158:
	.4byte	.Lframe0
	.4byte	.LFB269
	.4byte	.LFE269-.LFB269
	.byte	0x4
	.4byte	.LCFI109-.LFB269
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI110-.LCFI109
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI111-.LCFI110
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE158:
.LSFDE160:
	.4byte	.LEFDE160-.LASFDE160
.LASFDE160:
	.4byte	.Lframe0
	.4byte	.LFB270
	.4byte	.LFE270-.LFB270
	.byte	0x4
	.4byte	.LCFI112-.LFB270
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI113-.LCFI112
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI114-.LCFI113
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE160:
.LSFDE162:
	.4byte	.LEFDE162-.LASFDE162
.LASFDE162:
	.4byte	.Lframe0
	.4byte	.LFB271
	.4byte	.LFE271-.LFB271
	.byte	0x4
	.4byte	.LCFI115-.LFB271
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI116-.LCFI115
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI117-.LCFI116
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE162:
.LSFDE164:
	.4byte	.LEFDE164-.LASFDE164
.LASFDE164:
	.4byte	.Lframe0
	.4byte	.LFB272
	.4byte	.LFE272-.LFB272
	.byte	0x4
	.4byte	.LCFI118-.LFB272
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI119-.LCFI118
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI120-.LCFI119
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE164:
.LSFDE166:
	.4byte	.LEFDE166-.LASFDE166
.LASFDE166:
	.4byte	.Lframe0
	.4byte	.LFB273
	.4byte	.LFE273-.LFB273
	.byte	0x4
	.4byte	.LCFI121-.LFB273
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI122-.LCFI121
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI123-.LCFI122
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE166:
.LSFDE168:
	.4byte	.LEFDE168-.LASFDE168
.LASFDE168:
	.4byte	.Lframe0
	.4byte	.LFB274
	.4byte	.LFE274-.LFB274
	.byte	0x4
	.4byte	.LCFI124-.LFB274
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI125-.LCFI124
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI126-.LCFI125
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE168:
.LSFDE170:
	.4byte	.LEFDE170-.LASFDE170
.LASFDE170:
	.4byte	.Lframe0
	.4byte	.LFB275
	.4byte	.LFE275-.LFB275
	.byte	0x4
	.4byte	.LCFI127-.LFB275
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI128-.LCFI127
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI129-.LCFI128
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE170:
.LSFDE172:
	.4byte	.LEFDE172-.LASFDE172
.LASFDE172:
	.4byte	.Lframe0
	.4byte	.LFB276
	.4byte	.LFE276-.LFB276
	.byte	0x4
	.4byte	.LCFI130-.LFB276
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI131-.LCFI130
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI132-.LCFI131
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE172:
.LSFDE174:
	.4byte	.LEFDE174-.LASFDE174
.LASFDE174:
	.4byte	.Lframe0
	.4byte	.LFB277
	.4byte	.LFE277-.LFB277
	.byte	0x4
	.4byte	.LCFI133-.LFB277
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI134-.LCFI133
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI135-.LCFI134
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE174:
.LSFDE176:
	.4byte	.LEFDE176-.LASFDE176
.LASFDE176:
	.4byte	.Lframe0
	.4byte	.LFB278
	.4byte	.LFE278-.LFB278
	.byte	0x4
	.4byte	.LCFI136-.LFB278
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI137-.LCFI136
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI138-.LCFI137
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE176:
.LSFDE178:
	.4byte	.LEFDE178-.LASFDE178
.LASFDE178:
	.4byte	.Lframe0
	.4byte	.LFB279
	.4byte	.LFE279-.LFB279
	.byte	0x4
	.4byte	.LCFI139-.LFB279
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI140-.LCFI139
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI141-.LCFI140
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE178:
.LSFDE180:
	.4byte	.LEFDE180-.LASFDE180
.LASFDE180:
	.4byte	.Lframe0
	.4byte	.LFB280
	.4byte	.LFE280-.LFB280
	.byte	0x4
	.4byte	.LCFI142-.LFB280
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI143-.LCFI142
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI144-.LCFI143
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE180:
.LSFDE182:
	.4byte	.LEFDE182-.LASFDE182
.LASFDE182:
	.4byte	.Lframe0
	.4byte	.LFB281
	.4byte	.LFE281-.LFB281
	.byte	0x4
	.4byte	.LCFI145-.LFB281
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI146-.LCFI145
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI147-.LCFI146
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE182:
.LSFDE184:
	.4byte	.LEFDE184-.LASFDE184
.LASFDE184:
	.4byte	.Lframe0
	.4byte	.LFB282
	.4byte	.LFE282-.LFB282
	.byte	0x4
	.4byte	.LCFI148-.LFB282
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI149-.LCFI148
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI150-.LCFI149
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE184:
.LSFDE186:
	.4byte	.LEFDE186-.LASFDE186
.LASFDE186:
	.4byte	.Lframe0
	.4byte	.LFB283
	.4byte	.LFE283-.LFB283
	.byte	0x4
	.4byte	.LCFI151-.LFB283
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI152-.LCFI151
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI153-.LCFI152
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE186:
.LSFDE188:
	.4byte	.LEFDE188-.LASFDE188
.LASFDE188:
	.4byte	.Lframe0
	.4byte	.LFB284
	.4byte	.LFE284-.LFB284
	.byte	0x4
	.4byte	.LCFI154-.LFB284
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI155-.LCFI154
	.byte	0xe
	.uleb128 0x20
	.byte	0x4
	.4byte	.LCFI156-.LCFI155
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE188:
.LSFDE190:
	.4byte	.LEFDE190-.LASFDE190
.LASFDE190:
	.4byte	.Lframe0
	.4byte	.LFB285
	.4byte	.LFE285-.LFB285
	.byte	0x4
	.4byte	.LCFI157-.LFB285
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI158-.LCFI157
	.byte	0xe
	.uleb128 0x20
	.byte	0x4
	.4byte	.LCFI159-.LCFI158
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE190:
.LSFDE192:
	.4byte	.LEFDE192-.LASFDE192
.LASFDE192:
	.4byte	.Lframe0
	.4byte	.LFB286
	.4byte	.LFE286-.LFB286
	.byte	0x4
	.4byte	.LCFI160-.LFB286
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI161-.LCFI160
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI162-.LCFI161
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE192:
.LSFDE194:
	.4byte	.LEFDE194-.LASFDE194
.LASFDE194:
	.4byte	.Lframe0
	.4byte	.LFB287
	.4byte	.LFE287-.LFB287
	.byte	0x4
	.4byte	.LCFI163-.LFB287
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI164-.LCFI163
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI165-.LCFI164
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE194:
.LSFDE196:
	.4byte	.LEFDE196-.LASFDE196
.LASFDE196:
	.4byte	.Lframe0
	.4byte	.LFB288
	.4byte	.LFE288-.LFB288
	.byte	0x4
	.4byte	.LCFI166-.LFB288
	.byte	0xe
	.uleb128 0x14
	.byte	0x84
	.uleb128 0x5
	.byte	0x85
	.uleb128 0x4
	.byte	0x86
	.uleb128 0x3
	.byte	0x87
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI167-.LCFI166
	.byte	0xe
	.uleb128 0x38
	.byte	0x4
	.4byte	.LCFI168-.LCFI167
	.byte	0xe
	.uleb128 0x14
	.align	2
.LEFDE196:
.LSFDE198:
	.4byte	.LEFDE198-.LASFDE198
.LASFDE198:
	.4byte	.Lframe0
	.4byte	.LFB289
	.4byte	.LFE289-.LFB289
	.byte	0x4
	.4byte	.LCFI169-.LFB289
	.byte	0xe
	.uleb128 0x14
	.byte	0x84
	.uleb128 0x5
	.byte	0x85
	.uleb128 0x4
	.byte	0x86
	.uleb128 0x3
	.byte	0x87
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI170-.LCFI169
	.byte	0xe
	.uleb128 0x38
	.byte	0x4
	.4byte	.LCFI171-.LCFI170
	.byte	0xe
	.uleb128 0x14
	.align	2
.LEFDE198:
.LSFDE200:
	.4byte	.LEFDE200-.LASFDE200
.LASFDE200:
	.4byte	.Lframe0
	.4byte	.LFB290
	.4byte	.LFE290-.LFB290
	.byte	0x4
	.4byte	.LCFI172-.LFB290
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI173-.LCFI172
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI174-.LCFI173
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE200:
.LSFDE202:
	.4byte	.LEFDE202-.LASFDE202
.LASFDE202:
	.4byte	.Lframe0
	.4byte	.LFB291
	.4byte	.LFE291-.LFB291
	.byte	0x4
	.4byte	.LCFI175-.LFB291
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI176-.LCFI175
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI177-.LCFI176
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE202:
	.text
.Letext0:
	.file 3 "E:/Program Files/SEGGER/SEGGER Embedded Studio for ARM 5.70a/include/stdint.h"
	.file 4 "E:/Program Files/SEGGER/SEGGER Embedded Studio for ARM 5.70a/include/math.h"
	.file 5 "E:\\matte\\Documents\\uni\\master EIT\\1st year\\2nd semester\\UV\\UWBdrone_estimation\\UWBmodule\\segger projects\\rtdoa_acc_mag\\project\\tag\\SES\\LIS2MDL\\lis2mdl_reg.h"
	.file 6 "../../../deca_driver/deca_device_api.h"
	.file 7 "E:/matte/Documents/uni/master EIT/1st year/2nd semester/UV/UWBdrone_estimation/UWBmodule/segger projects/rtdoa_acc_mag/project/tag/SES/FDS/fds_manager.h"
	.file 8 "../../common/config.h"
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0x241f
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF332
	.byte	0xc
	.4byte	.LASF333
	.4byte	.LASF334
	.4byte	.Ldebug_ranges0+0
	.4byte	0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.4byte	.LASF0
	.byte	0x3
	.byte	0x29
	.byte	0x1c
	.4byte	0x31
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.4byte	.LASF2
	.uleb128 0x2
	.4byte	.LASF1
	.byte	0x3
	.byte	0x2a
	.byte	0x1c
	.4byte	0x49
	.uleb128 0x4
	.4byte	0x38
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.4byte	.LASF3
	.uleb128 0x2
	.4byte	.LASF4
	.byte	0x3
	.byte	0x2f
	.byte	0x1c
	.4byte	0x5c
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.4byte	.LASF5
	.uleb128 0x2
	.4byte	.LASF6
	.byte	0x3
	.byte	0x30
	.byte	0x1c
	.4byte	0x6f
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.4byte	.LASF7
	.uleb128 0x2
	.4byte	.LASF8
	.byte	0x3
	.byte	0x36
	.byte	0x1c
	.4byte	0x82
	.uleb128 0x5
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x2
	.4byte	.LASF9
	.byte	0x3
	.byte	0x37
	.byte	0x1c
	.4byte	0x9a
	.uleb128 0x6
	.4byte	0x89
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.4byte	.LASF10
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.4byte	.LASF11
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.4byte	.LASF12
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.4byte	.LASF13
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.4byte	.LASF14
	.uleb128 0x3
	.byte	0x8
	.byte	0x4
	.4byte	.LASF15
	.uleb128 0x7
	.4byte	.LASF16
	.byte	0x4
	.2byte	0x10f
	.byte	0xf
	.4byte	0xd1
	.uleb128 0x3
	.byte	0x4
	.byte	0x4
	.4byte	.LASF17
	.uleb128 0x3
	.byte	0x8
	.byte	0x4
	.4byte	.LASF18
	.uleb128 0x8
	.byte	0x1
	.byte	0x5
	.byte	0x50
	.byte	0x9
	.4byte	0x147
	.uleb128 0x9
	.ascii	"md\000"
	.byte	0x5
	.byte	0x51
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x2
	.byte	0x6
	.byte	0
	.uleb128 0x9
	.ascii	"odr\000"
	.byte	0x5
	.byte	0x52
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x2
	.byte	0x4
	.byte	0
	.uleb128 0x9
	.ascii	"lp\000"
	.byte	0x5
	.byte	0x53
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x3
	.byte	0
	.uleb128 0xa
	.4byte	.LASF19
	.byte	0x5
	.byte	0x54
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x2
	.byte	0
	.uleb128 0xa
	.4byte	.LASF20
	.byte	0x5
	.byte	0x55
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x1
	.byte	0
	.uleb128 0xa
	.4byte	.LASF21
	.byte	0x5
	.byte	0x56
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x2
	.4byte	.LASF22
	.byte	0x5
	.byte	0x57
	.byte	0x3
	.4byte	0xdf
	.uleb128 0x8
	.byte	0x1
	.byte	0x5
	.byte	0x59
	.byte	0x9
	.4byte	0x1ad
	.uleb128 0x9
	.ascii	"lpf\000"
	.byte	0x5
	.byte	0x5a
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x7
	.byte	0
	.uleb128 0xa
	.4byte	.LASF23
	.byte	0x5
	.byte	0x5b
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x2
	.byte	0x5
	.byte	0
	.uleb128 0xa
	.4byte	.LASF24
	.byte	0x5
	.byte	0x5c
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x4
	.byte	0
	.uleb128 0xa
	.4byte	.LASF25
	.byte	0x5
	.byte	0x5d
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x3
	.byte	0
	.uleb128 0xa
	.4byte	.LASF26
	.byte	0x5
	.byte	0x5e
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x3
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x2
	.4byte	.LASF27
	.byte	0x5
	.byte	0x5f
	.byte	0x3
	.4byte	0x153
	.uleb128 0x8
	.byte	0x1
	.byte	0x5
	.byte	0x61
	.byte	0x9
	.4byte	0x243
	.uleb128 0xa
	.4byte	.LASF28
	.byte	0x5
	.byte	0x62
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x7
	.byte	0
	.uleb128 0xa
	.4byte	.LASF29
	.byte	0x5
	.byte	0x63
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x6
	.byte	0
	.uleb128 0xa
	.4byte	.LASF30
	.byte	0x5
	.byte	0x64
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x5
	.byte	0
	.uleb128 0x9
	.ascii	"ble\000"
	.byte	0x5
	.byte	0x65
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x4
	.byte	0
	.uleb128 0x9
	.ascii	"bdu\000"
	.byte	0x5
	.byte	0x66
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x3
	.byte	0
	.uleb128 0xa
	.4byte	.LASF31
	.byte	0x5
	.byte	0x67
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x2
	.byte	0
	.uleb128 0xa
	.4byte	.LASF32
	.byte	0x5
	.byte	0x68
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x1
	.byte	0
	.uleb128 0xa
	.4byte	.LASF33
	.byte	0x5
	.byte	0x69
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x2
	.4byte	.LASF34
	.byte	0x5
	.byte	0x6a
	.byte	0x3
	.4byte	0x1b9
	.uleb128 0x8
	.byte	0x1
	.byte	0x5
	.byte	0x6d
	.byte	0x9
	.4byte	0x2c9
	.uleb128 0x9
	.ascii	"ien\000"
	.byte	0x5
	.byte	0x6e
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x7
	.byte	0
	.uleb128 0x9
	.ascii	"iel\000"
	.byte	0x5
	.byte	0x6f
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x6
	.byte	0
	.uleb128 0x9
	.ascii	"iea\000"
	.byte	0x5
	.byte	0x70
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x5
	.byte	0
	.uleb128 0xa
	.4byte	.LASF26
	.byte	0x5
	.byte	0x71
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x2
	.byte	0x3
	.byte	0
	.uleb128 0xa
	.4byte	.LASF35
	.byte	0x5
	.byte	0x72
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x2
	.byte	0
	.uleb128 0xa
	.4byte	.LASF36
	.byte	0x5
	.byte	0x73
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x1
	.byte	0
	.uleb128 0xa
	.4byte	.LASF37
	.byte	0x5
	.byte	0x74
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x2
	.4byte	.LASF38
	.byte	0x5
	.byte	0x75
	.byte	0x3
	.4byte	0x24f
	.uleb128 0x8
	.byte	0x1
	.byte	0x5
	.byte	0x77
	.byte	0x9
	.4byte	0x35f
	.uleb128 0xa
	.4byte	.LASF39
	.byte	0x5
	.byte	0x78
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x7
	.byte	0
	.uleb128 0xa
	.4byte	.LASF40
	.byte	0x5
	.byte	0x79
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x6
	.byte	0
	.uleb128 0xa
	.4byte	.LASF41
	.byte	0x5
	.byte	0x7a
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x5
	.byte	0
	.uleb128 0xa
	.4byte	.LASF42
	.byte	0x5
	.byte	0x7b
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x4
	.byte	0
	.uleb128 0xa
	.4byte	.LASF43
	.byte	0x5
	.byte	0x7c
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x3
	.byte	0
	.uleb128 0xa
	.4byte	.LASF44
	.byte	0x5
	.byte	0x7d
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x2
	.byte	0
	.uleb128 0xa
	.4byte	.LASF45
	.byte	0x5
	.byte	0x7e
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x1
	.byte	0
	.uleb128 0xa
	.4byte	.LASF46
	.byte	0x5
	.byte	0x7f
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x2
	.4byte	.LASF47
	.byte	0x5
	.byte	0x80
	.byte	0x3
	.4byte	0x2d5
	.uleb128 0x8
	.byte	0x1
	.byte	0x5
	.byte	0x82
	.byte	0x9
	.4byte	0x3f5
	.uleb128 0x9
	.ascii	"xda\000"
	.byte	0x5
	.byte	0x83
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x7
	.byte	0
	.uleb128 0x9
	.ascii	"yda\000"
	.byte	0x5
	.byte	0x84
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x6
	.byte	0
	.uleb128 0x9
	.ascii	"zda\000"
	.byte	0x5
	.byte	0x85
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x5
	.byte	0
	.uleb128 0xa
	.4byte	.LASF48
	.byte	0x5
	.byte	0x86
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x4
	.byte	0
	.uleb128 0xa
	.4byte	.LASF49
	.byte	0x5
	.byte	0x87
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x3
	.byte	0
	.uleb128 0x9
	.ascii	"yor\000"
	.byte	0x5
	.byte	0x88
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x2
	.byte	0
	.uleb128 0x9
	.ascii	"zor\000"
	.byte	0x5
	.byte	0x89
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0x1
	.byte	0
	.uleb128 0xa
	.4byte	.LASF50
	.byte	0x5
	.byte	0x8a
	.byte	0xb
	.4byte	0x38
	.byte	0x1
	.byte	0x1
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x2
	.4byte	.LASF51
	.byte	0x5
	.byte	0x8b
	.byte	0x3
	.4byte	0x36b
	.uleb128 0xb
	.byte	0x7
	.byte	0x1
	.4byte	0x49
	.byte	0x5
	.byte	0x97
	.byte	0xd
	.4byte	0x422
	.uleb128 0xc
	.4byte	.LASF52
	.byte	0
	.uleb128 0xc
	.4byte	.LASF53
	.byte	0x1
	.uleb128 0xc
	.4byte	.LASF54
	.byte	0x2
	.byte	0
	.uleb128 0x2
	.4byte	.LASF55
	.byte	0x5
	.byte	0x9b
	.byte	0x3
	.4byte	0x401
	.uleb128 0xb
	.byte	0x7
	.byte	0x1
	.4byte	0x49
	.byte	0x5
	.byte	0x9d
	.byte	0xd
	.4byte	0x455
	.uleb128 0xc
	.4byte	.LASF56
	.byte	0
	.uleb128 0xc
	.4byte	.LASF57
	.byte	0x1
	.uleb128 0xc
	.4byte	.LASF58
	.byte	0x2
	.uleb128 0xc
	.4byte	.LASF59
	.byte	0x3
	.byte	0
	.uleb128 0x2
	.4byte	.LASF60
	.byte	0x5
	.byte	0xa2
	.byte	0x3
	.4byte	0x42e
	.uleb128 0xb
	.byte	0x7
	.byte	0x1
	.4byte	0x49
	.byte	0x5
	.byte	0xa4
	.byte	0xd
	.4byte	0x47c
	.uleb128 0xc
	.4byte	.LASF61
	.byte	0
	.uleb128 0xc
	.4byte	.LASF62
	.byte	0x1
	.byte	0
	.uleb128 0x2
	.4byte	.LASF63
	.byte	0x5
	.byte	0xa7
	.byte	0x3
	.4byte	0x461
	.uleb128 0xb
	.byte	0x7
	.byte	0x1
	.4byte	0x49
	.byte	0x5
	.byte	0xa9
	.byte	0xd
	.4byte	0x4a3
	.uleb128 0xc
	.4byte	.LASF64
	.byte	0
	.uleb128 0xc
	.4byte	.LASF65
	.byte	0x1
	.byte	0
	.uleb128 0x2
	.4byte	.LASF66
	.byte	0x5
	.byte	0xac
	.byte	0x3
	.4byte	0x488
	.uleb128 0xb
	.byte	0x7
	.byte	0x1
	.4byte	0x49
	.byte	0x5
	.byte	0xae
	.byte	0xd
	.4byte	0x4d0
	.uleb128 0xc
	.4byte	.LASF67
	.byte	0
	.uleb128 0xc
	.4byte	.LASF68
	.byte	0x1
	.uleb128 0xc
	.4byte	.LASF69
	.byte	0x2
	.byte	0
	.uleb128 0x2
	.4byte	.LASF70
	.byte	0x5
	.byte	0xb2
	.byte	0x3
	.4byte	0x4af
	.uleb128 0xb
	.byte	0x7
	.byte	0x1
	.4byte	0x49
	.byte	0x5
	.byte	0xb4
	.byte	0xd
	.4byte	0x4f7
	.uleb128 0xc
	.4byte	.LASF71
	.byte	0
	.uleb128 0xc
	.4byte	.LASF72
	.byte	0x1
	.byte	0
	.uleb128 0x2
	.4byte	.LASF73
	.byte	0x5
	.byte	0xb9
	.byte	0x3
	.4byte	0x4dc
	.uleb128 0xb
	.byte	0x7
	.byte	0x1
	.4byte	0x49
	.byte	0x5
	.byte	0xbb
	.byte	0xd
	.4byte	0x51e
	.uleb128 0xc
	.4byte	.LASF74
	.byte	0
	.uleb128 0xc
	.4byte	.LASF75
	.byte	0x1
	.byte	0
	.uleb128 0x2
	.4byte	.LASF76
	.byte	0x5
	.byte	0xc0
	.byte	0x3
	.4byte	0x503
	.uleb128 0xb
	.byte	0x7
	.byte	0x1
	.4byte	0x49
	.byte	0x5
	.byte	0xc2
	.byte	0xd
	.4byte	0x545
	.uleb128 0xc
	.4byte	.LASF77
	.byte	0x1
	.uleb128 0xc
	.4byte	.LASF78
	.byte	0
	.byte	0
	.uleb128 0x2
	.4byte	.LASF79
	.byte	0x5
	.byte	0xc7
	.byte	0x3
	.4byte	0x52a
	.uleb128 0xb
	.byte	0x7
	.byte	0x1
	.4byte	0x49
	.byte	0x5
	.byte	0xc9
	.byte	0xd
	.4byte	0x56c
	.uleb128 0xc
	.4byte	.LASF80
	.byte	0
	.uleb128 0xc
	.4byte	.LASF81
	.byte	0x1
	.byte	0
	.uleb128 0x2
	.4byte	.LASF82
	.byte	0x5
	.byte	0xce
	.byte	0x3
	.4byte	0x551
	.uleb128 0xd
	.4byte	.LASF335
	.byte	0x7
	.byte	0x1
	.4byte	0x49
	.byte	0x1
	.byte	0x68
	.byte	0x6
	.4byte	0x68d
	.uleb128 0xc
	.4byte	.LASF83
	.byte	0x20
	.uleb128 0xc
	.4byte	.LASF84
	.byte	0x21
	.uleb128 0xc
	.4byte	.LASF85
	.byte	0x22
	.uleb128 0xc
	.4byte	.LASF86
	.byte	0x23
	.uleb128 0xc
	.4byte	.LASF87
	.byte	0x24
	.uleb128 0xc
	.4byte	.LASF88
	.byte	0x25
	.uleb128 0xc
	.4byte	.LASF89
	.byte	0x26
	.uleb128 0xc
	.4byte	.LASF90
	.byte	0x27
	.uleb128 0xc
	.4byte	.LASF91
	.byte	0x28
	.uleb128 0xc
	.4byte	.LASF92
	.byte	0x29
	.uleb128 0xc
	.4byte	.LASF93
	.byte	0x2a
	.uleb128 0xc
	.4byte	.LASF94
	.byte	0x2b
	.uleb128 0xc
	.4byte	.LASF95
	.byte	0x2c
	.uleb128 0xc
	.4byte	.LASF96
	.byte	0x2d
	.uleb128 0xc
	.4byte	.LASF97
	.byte	0x2e
	.uleb128 0xc
	.4byte	.LASF98
	.byte	0x2f
	.uleb128 0xc
	.4byte	.LASF99
	.byte	0x30
	.uleb128 0xc
	.4byte	.LASF100
	.byte	0x31
	.uleb128 0xc
	.4byte	.LASF101
	.byte	0x32
	.uleb128 0xc
	.4byte	.LASF102
	.byte	0x33
	.uleb128 0xc
	.4byte	.LASF103
	.byte	0x34
	.uleb128 0xc
	.4byte	.LASF104
	.byte	0x35
	.uleb128 0xc
	.4byte	.LASF105
	.byte	0x36
	.uleb128 0xc
	.4byte	.LASF106
	.byte	0x37
	.uleb128 0xc
	.4byte	.LASF107
	.byte	0x38
	.uleb128 0xc
	.4byte	.LASF108
	.byte	0x39
	.uleb128 0xc
	.4byte	.LASF109
	.byte	0x3a
	.uleb128 0xc
	.4byte	.LASF110
	.byte	0x3b
	.uleb128 0xc
	.4byte	.LASF111
	.byte	0x3c
	.uleb128 0xc
	.4byte	.LASF112
	.byte	0x3d
	.uleb128 0xc
	.4byte	.LASF113
	.byte	0x3e
	.uleb128 0xc
	.4byte	.LASF114
	.byte	0x3f
	.uleb128 0xc
	.4byte	.LASF115
	.byte	0x40
	.uleb128 0xc
	.4byte	.LASF116
	.byte	0x41
	.uleb128 0xc
	.4byte	.LASF117
	.byte	0x42
	.uleb128 0xc
	.4byte	.LASF118
	.byte	0x43
	.uleb128 0xc
	.4byte	.LASF119
	.byte	0x44
	.uleb128 0xc
	.4byte	.LASF120
	.byte	0x45
	.uleb128 0xc
	.4byte	.LASF121
	.byte	0x46
	.uleb128 0xc
	.4byte	.LASF122
	.byte	0x47
	.uleb128 0xc
	.4byte	.LASF123
	.byte	0x48
	.uleb128 0xc
	.4byte	.LASF124
	.byte	0x49
	.uleb128 0xc
	.4byte	.LASF125
	.byte	0x4a
	.byte	0
	.uleb128 0x7
	.4byte	.LASF126
	.byte	0x1
	.2byte	0x128
	.byte	0x1a
	.4byte	0x44
	.uleb128 0xe
	.byte	0xc
	.byte	0x1
	.2byte	0x12b
	.byte	0x9
	.4byte	0x6dd
	.uleb128 0xf
	.4byte	.LASF127
	.byte	0x1
	.2byte	0x12d
	.byte	0x11
	.4byte	0x38
	.byte	0
	.uleb128 0xf
	.4byte	.LASF128
	.byte	0x1
	.2byte	0x12e
	.byte	0x11
	.4byte	0x38
	.byte	0x1
	.uleb128 0xf
	.4byte	.LASF129
	.byte	0x1
	.2byte	0x12f
	.byte	0x11
	.4byte	0x89
	.byte	0x4
	.uleb128 0xf
	.4byte	.LASF130
	.byte	0x1
	.2byte	0x130
	.byte	0x11
	.4byte	0x89
	.byte	0x8
	.byte	0
	.uleb128 0x7
	.4byte	.LASF131
	.byte	0x1
	.2byte	0x131
	.byte	0x3
	.4byte	0x69a
	.uleb128 0xe
	.byte	0xc
	.byte	0x1
	.2byte	0x134
	.byte	0x9
	.4byte	0x72d
	.uleb128 0xf
	.4byte	.LASF127
	.byte	0x1
	.2byte	0x136
	.byte	0x11
	.4byte	0x38
	.byte	0
	.uleb128 0xf
	.4byte	.LASF128
	.byte	0x1
	.2byte	0x137
	.byte	0x11
	.4byte	0x38
	.byte	0x1
	.uleb128 0xf
	.4byte	.LASF132
	.byte	0x1
	.2byte	0x138
	.byte	0x11
	.4byte	0x89
	.byte	0x4
	.uleb128 0xf
	.4byte	.LASF129
	.byte	0x1
	.2byte	0x139
	.byte	0x11
	.4byte	0x89
	.byte	0x8
	.byte	0
	.uleb128 0x7
	.4byte	.LASF133
	.byte	0x1
	.2byte	0x13a
	.byte	0x3
	.4byte	0x6ea
	.uleb128 0x10
	.byte	0xc
	.byte	0x1
	.2byte	0x140
	.byte	0x3
	.4byte	0x75f
	.uleb128 0x11
	.4byte	.LASF134
	.byte	0x1
	.2byte	0x142
	.byte	0x23
	.4byte	0x6dd
	.uleb128 0x11
	.4byte	.LASF135
	.byte	0x1
	.2byte	0x143
	.byte	0x23
	.4byte	0x72d
	.byte	0
	.uleb128 0xe
	.byte	0x10
	.byte	0x1
	.2byte	0x13d
	.byte	0x9
	.4byte	0x786
	.uleb128 0xf
	.4byte	.LASF136
	.byte	0x1
	.2byte	0x13f
	.byte	0x23
	.4byte	0x38
	.byte	0
	.uleb128 0xf
	.4byte	.LASF137
	.byte	0x1
	.2byte	0x144
	.byte	0x5
	.4byte	0x73a
	.byte	0x4
	.byte	0
	.uleb128 0x7
	.4byte	.LASF138
	.byte	0x1
	.2byte	0x145
	.byte	0x3
	.4byte	0x75f
	.uleb128 0x6
	.4byte	0x786
	.uleb128 0xe
	.byte	0x4
	.byte	0x1
	.2byte	0x14d
	.byte	0x5
	.4byte	0x7b1
	.uleb128 0xf
	.4byte	.LASF139
	.byte	0x1
	.2byte	0x14f
	.byte	0x1d
	.4byte	0x7b1
	.byte	0
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x786
	.uleb128 0xe
	.byte	0x4
	.byte	0x1
	.2byte	0x151
	.byte	0x5
	.4byte	0x7d0
	.uleb128 0xf
	.4byte	.LASF129
	.byte	0x1
	.2byte	0x153
	.byte	0x1d
	.4byte	0x89
	.byte	0
	.byte	0
	.uleb128 0x10
	.byte	0x4
	.byte	0x1
	.2byte	0x14b
	.byte	0x3
	.4byte	0x7f5
	.uleb128 0x11
	.4byte	.LASF140
	.byte	0x1
	.2byte	0x150
	.byte	0x7
	.4byte	0x798
	.uleb128 0x11
	.4byte	.LASF141
	.byte	0x1
	.2byte	0x154
	.byte	0x7
	.4byte	0x7b7
	.byte	0
	.uleb128 0xe
	.byte	0x8
	.byte	0x1
	.2byte	0x148
	.byte	0x9
	.4byte	0x81c
	.uleb128 0xf
	.4byte	.LASF142
	.byte	0x1
	.2byte	0x14a
	.byte	0x19
	.4byte	0x38
	.byte	0
	.uleb128 0xf
	.4byte	.LASF137
	.byte	0x1
	.2byte	0x155
	.byte	0x5
	.4byte	0x7d0
	.byte	0x4
	.byte	0
	.uleb128 0x7
	.4byte	.LASF143
	.byte	0x1
	.2byte	0x156
	.byte	0x3
	.4byte	0x7f5
	.uleb128 0x7
	.4byte	.LASF144
	.byte	0x1
	.2byte	0x164
	.byte	0x36
	.4byte	0x836
	.uleb128 0x12
	.byte	0x4
	.4byte	0x83c
	.uleb128 0x13
	.4byte	0x84b
	.4byte	0x84b
	.uleb128 0x14
	.4byte	0x38
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x81c
	.uleb128 0x7
	.4byte	.LASF145
	.byte	0x1
	.2byte	0x167
	.byte	0x11
	.4byte	0x85e
	.uleb128 0x15
	.4byte	0x38
	.4byte	0x86e
	.uleb128 0x16
	.4byte	0x9a
	.byte	0xf
	.byte	0
	.uleb128 0x7
	.4byte	.LASF146
	.byte	0x1
	.2byte	0x168
	.byte	0x11
	.4byte	0x85e
	.uleb128 0x7
	.4byte	.LASF147
	.byte	0x1
	.2byte	0x169
	.byte	0x11
	.4byte	0x85e
	.uleb128 0xe
	.byte	0x30
	.byte	0x1
	.2byte	0x16c
	.byte	0x9
	.4byte	0x8bd
	.uleb128 0x17
	.ascii	"key\000"
	.byte	0x1
	.2byte	0x16e
	.byte	0x18
	.4byte	0x851
	.byte	0
	.uleb128 0xf
	.4byte	.LASF148
	.byte	0x1
	.2byte	0x16f
	.byte	0x18
	.4byte	0x86e
	.byte	0x10
	.uleb128 0xf
	.4byte	.LASF149
	.byte	0x1
	.2byte	0x170
	.byte	0x18
	.4byte	0x87b
	.byte	0x20
	.byte	0
	.uleb128 0x7
	.4byte	.LASF150
	.byte	0x1
	.2byte	0x171
	.byte	0x3
	.4byte	0x888
	.uleb128 0xe
	.byte	0xc
	.byte	0x1
	.2byte	0x175
	.byte	0x9
	.4byte	0x8ff
	.uleb128 0xf
	.4byte	.LASF151
	.byte	0x1
	.2byte	0x177
	.byte	0x1f
	.4byte	0x8ff
	.byte	0
	.uleb128 0xf
	.4byte	.LASF152
	.byte	0x1
	.2byte	0x178
	.byte	0x1f
	.4byte	0x905
	.byte	0x4
	.uleb128 0xf
	.4byte	.LASF153
	.byte	0x1
	.2byte	0x179
	.byte	0x1f
	.4byte	0x90b
	.byte	0x8
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x85e
	.uleb128 0x12
	.byte	0x4
	.4byte	0x85e
	.uleb128 0x12
	.byte	0x4
	.4byte	0x87b
	.uleb128 0x7
	.4byte	.LASF154
	.byte	0x1
	.2byte	0x17a
	.byte	0x3
	.4byte	0x8ca
	.uleb128 0x3
	.byte	0x1
	.byte	0x2
	.4byte	.LASF155
	.uleb128 0x12
	.byte	0x4
	.4byte	0x95
	.uleb128 0x18
	.uleb128 0x4
	.4byte	0x92b
	.uleb128 0x12
	.byte	0x4
	.4byte	0x38
	.uleb128 0x2
	.4byte	.LASF156
	.byte	0x6
	.byte	0x18
	.byte	0x17
	.4byte	0x49
	.uleb128 0x2
	.4byte	.LASF157
	.byte	0x6
	.byte	0x1f
	.byte	0x18
	.4byte	0x6f
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.4byte	.LASF158
	.uleb128 0x8
	.byte	0xc
	.byte	0x6
	.byte	0xc1
	.byte	0x9
	.4byte	0x9e2
	.uleb128 0x19
	.4byte	.LASF159
	.byte	0x6
	.byte	0xc3
	.byte	0xb
	.4byte	0x937
	.byte	0
	.uleb128 0x1a
	.ascii	"prf\000"
	.byte	0x6
	.byte	0xc4
	.byte	0xb
	.4byte	0x937
	.byte	0x1
	.uleb128 0x19
	.4byte	.LASF160
	.byte	0x6
	.byte	0xc5
	.byte	0xb
	.4byte	0x937
	.byte	0x2
	.uleb128 0x19
	.4byte	.LASF161
	.byte	0x6
	.byte	0xc6
	.byte	0xb
	.4byte	0x937
	.byte	0x3
	.uleb128 0x19
	.4byte	.LASF162
	.byte	0x6
	.byte	0xc7
	.byte	0xb
	.4byte	0x937
	.byte	0x4
	.uleb128 0x19
	.4byte	.LASF163
	.byte	0x6
	.byte	0xc8
	.byte	0xb
	.4byte	0x937
	.byte	0x5
	.uleb128 0x19
	.4byte	.LASF164
	.byte	0x6
	.byte	0xc9
	.byte	0xb
	.4byte	0x937
	.byte	0x6
	.uleb128 0x19
	.4byte	.LASF165
	.byte	0x6
	.byte	0xca
	.byte	0xb
	.4byte	0x937
	.byte	0x7
	.uleb128 0x19
	.4byte	.LASF166
	.byte	0x6
	.byte	0xcb
	.byte	0xb
	.4byte	0x937
	.byte	0x8
	.uleb128 0x19
	.4byte	.LASF167
	.byte	0x6
	.byte	0xcc
	.byte	0xc
	.4byte	0x943
	.byte	0xa
	.byte	0
	.uleb128 0x2
	.4byte	.LASF168
	.byte	0x6
	.byte	0xcd
	.byte	0x3
	.4byte	0x956
	.uleb128 0x1b
	.4byte	.LASF172
	.byte	0x8
	.byte	0x10
	.byte	0x15
	.4byte	0x9e2
	.uleb128 0x5
	.byte	0x3
	.4byte	config
	.uleb128 0x15
	.4byte	0xd1
	.4byte	0xa10
	.uleb128 0x16
	.4byte	0x9a
	.byte	0x2
	.byte	0
	.uleb128 0x8
	.byte	0x3c
	.byte	0x7
	.byte	0x34
	.byte	0x9
	.4byte	0xa41
	.uleb128 0x19
	.4byte	.LASF169
	.byte	0x7
	.byte	0x35
	.byte	0xf
	.4byte	0xa00
	.byte	0
	.uleb128 0x19
	.4byte	.LASF170
	.byte	0x7
	.byte	0x36
	.byte	0xf
	.4byte	0xa41
	.byte	0xc
	.uleb128 0x1a
	.ascii	"unc\000"
	.byte	0x7
	.byte	0x37
	.byte	0xf
	.4byte	0xa00
	.byte	0x30
	.byte	0
	.uleb128 0x15
	.4byte	0xd1
	.4byte	0xa51
	.uleb128 0x16
	.4byte	0x9a
	.byte	0x8
	.byte	0
	.uleb128 0x2
	.4byte	.LASF171
	.byte	0x7
	.byte	0x38
	.byte	0x3
	.4byte	0xa10
	.uleb128 0x6
	.4byte	0xa51
	.uleb128 0x15
	.4byte	0x50
	.4byte	0xa72
	.uleb128 0x16
	.4byte	0x9a
	.byte	0x2
	.byte	0
	.uleb128 0x1c
	.4byte	.LASF173
	.byte	0x2
	.2byte	0x4e6
	.byte	0x10
	.4byte	0xa62
	.uleb128 0x5
	.byte	0x3
	.4byte	data_raw_magnetic
	.uleb128 0x1c
	.4byte	.LASF174
	.byte	0x2
	.2byte	0x4e7
	.byte	0x10
	.4byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	lis2mdl_data_raw_temperature
	.uleb128 0x1c
	.4byte	.LASF175
	.byte	0x2
	.2byte	0x4e8
	.byte	0xe
	.4byte	0xa00
	.uleb128 0x5
	.byte	0x3
	.4byte	magnetic_mG
	.uleb128 0x1c
	.4byte	.LASF176
	.byte	0x2
	.2byte	0x4e9
	.byte	0xe
	.4byte	0xd1
	.uleb128 0x5
	.byte	0x3
	.4byte	lis2mdl_temperature_degC
	.uleb128 0x1c
	.4byte	.LASF177
	.byte	0x2
	.2byte	0x4ea
	.byte	0x10
	.4byte	0x38
	.uleb128 0x5
	.byte	0x3
	.4byte	mag_whoamI
	.uleb128 0x1c
	.4byte	.LASF178
	.byte	0x2
	.2byte	0x4eb
	.byte	0xd
	.4byte	0x91e
	.uleb128 0x5
	.byte	0x3
	.4byte	mag_device_found
	.uleb128 0x1c
	.4byte	.LASF179
	.byte	0x2
	.2byte	0x4ed
	.byte	0x1e
	.4byte	0xaf7
	.uleb128 0x5
	.byte	0x3
	.4byte	mag_config
	.uleb128 0x12
	.byte	0x4
	.4byte	0xa5d
	.uleb128 0x1d
	.4byte	.LASF180
	.byte	0x2
	.2byte	0x5d6
	.byte	0x6
	.4byte	.LFB291
	.4byte	.LFE291-.LFB291
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xb25
	.uleb128 0x1e
	.ascii	"err\000"
	.byte	0x2
	.2byte	0x5d7
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF182
	.byte	0x2
	.2byte	0x5c2
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB290
	.4byte	.LFE290-.LFB290
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xb61
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x5c2
	.byte	0x21
	.4byte	0xb61
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"err\000"
	.byte	0x2
	.2byte	0x5c3
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0xd1
	.uleb128 0x1d
	.4byte	.LASF181
	.byte	0x2
	.2byte	0x5b3
	.byte	0x6
	.4byte	.LFB289
	.4byte	.LFE289-.LFB289
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xb8f
	.uleb128 0x1e
	.ascii	"tmp\000"
	.byte	0x2
	.2byte	0x5b4
	.byte	0x9
	.4byte	0xa00
	.uleb128 0x2
	.byte	0x91
	.sleb128 -36
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF183
	.byte	0x2
	.2byte	0x598
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB288
	.4byte	.LFE288-.LFB288
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xbcb
	.uleb128 0x20
	.ascii	"buf\000"
	.byte	0x2
	.2byte	0x598
	.byte	0x2b
	.4byte	0xb61
	.uleb128 0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x1e
	.ascii	"err\000"
	.byte	0x2
	.2byte	0x599
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF184
	.byte	0x2
	.2byte	0x570
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB287
	.4byte	.LFE287-.LFB287
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xc21
	.uleb128 0x20
	.ascii	"buf\000"
	.byte	0x2
	.2byte	0x570
	.byte	0x20
	.4byte	0xb61
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"err\000"
	.byte	0x2
	.2byte	0x571
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x21
	.4byte	.LBB2
	.4byte	.LBE2-.LBB2
	.uleb128 0x1c
	.4byte	.LASF185
	.byte	0x2
	.2byte	0x578
	.byte	0xd
	.4byte	0x38
	.uleb128 0x2
	.byte	0x91
	.sleb128 -13
	.byte	0
	.byte	0
	.uleb128 0x1d
	.4byte	.LASF186
	.byte	0x2
	.2byte	0x535
	.byte	0x6
	.4byte	.LFB286
	.4byte	.LFE286-.LFB286
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xc49
	.uleb128 0x1e
	.ascii	"err\000"
	.byte	0x2
	.2byte	0x536
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF187
	.byte	0x2
	.2byte	0x522
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB285
	.4byte	.LFE285-.LFB285
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xcb5
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x522
	.byte	0x31
	.4byte	0xcb5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x1e
	.ascii	"err\000"
	.byte	0x2
	.2byte	0x523
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x523
	.byte	0x10
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x1c
	.4byte	.LASF188
	.byte	0x2
	.2byte	0x524
	.byte	0xb
	.4byte	0x38
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1c
	.4byte	.LASF189
	.byte	0x2
	.2byte	0x524
	.byte	0x15
	.4byte	0x38
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x50
	.uleb128 0x1f
	.4byte	.LASF190
	.byte	0x2
	.2byte	0x502
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB284
	.4byte	.LFE284-.LFB284
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xd27
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x502
	.byte	0x2e
	.4byte	0xcb5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x1e
	.ascii	"err\000"
	.byte	0x2
	.2byte	0x504
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x504
	.byte	0x10
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x1c
	.4byte	.LASF188
	.byte	0x2
	.2byte	0x505
	.byte	0xb
	.4byte	0x38
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1c
	.4byte	.LASF189
	.byte	0x2
	.2byte	0x505
	.byte	0x15
	.4byte	0x38
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.byte	0
	.uleb128 0x1d
	.4byte	.LASF191
	.byte	0x2
	.2byte	0x4f1
	.byte	0x6
	.4byte	.LFB283
	.4byte	.LFE283-.LFB283
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xd6f
	.uleb128 0x22
	.4byte	.LASF192
	.byte	0x2
	.2byte	0x4f1
	.byte	0x20
	.4byte	0x38
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1c
	.4byte	.LASF193
	.byte	0x2
	.2byte	0x4f2
	.byte	0xb
	.4byte	0x38
	.uleb128 0x2
	.byte	0x91
	.sleb128 -13
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x4f3
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF194
	.byte	0x2
	.2byte	0x4be
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB282
	.4byte	.LFE282-.LFB282
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xdbb
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x4be
	.byte	0x36
	.4byte	0xdbb
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x4c0
	.byte	0x17
	.4byte	0x243
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x4c1
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x56c
	.uleb128 0x1f
	.4byte	.LASF195
	.byte	0x2
	.2byte	0x4a7
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB281
	.4byte	.LFE281-.LFB281
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xe0d
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x4a7
	.byte	0x35
	.4byte	0x56c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x4a9
	.byte	0x17
	.4byte	0x243
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x4aa
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF196
	.byte	0x2
	.2byte	0x487
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB280
	.4byte	.LFE280-.LFB280
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xe59
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x487
	.byte	0x2d
	.4byte	0xe59
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x489
	.byte	0x17
	.4byte	0x243
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x48a
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x545
	.uleb128 0x1f
	.4byte	.LASF197
	.byte	0x2
	.2byte	0x471
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB279
	.4byte	.LFE279-.LFB279
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xeab
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x471
	.byte	0x2c
	.4byte	0x545
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x472
	.byte	0x17
	.4byte	0x243
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x473
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF198
	.byte	0x2
	.2byte	0x451
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB278
	.4byte	.LFE278-.LFB278
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xef7
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x451
	.byte	0x30
	.4byte	0xef7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1c
	.4byte	.LASF199
	.byte	0x2
	.2byte	0x453
	.byte	0xb
	.4byte	0xefd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x454
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x63
	.uleb128 0x15
	.4byte	0x38
	.4byte	0xf0d
	.uleb128 0x16
	.4byte	0x9a
	.byte	0x1
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF200
	.byte	0x2
	.2byte	0x43c
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB277
	.4byte	.LFE277-.LFB277
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xf59
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x43c
	.byte	0x2f
	.4byte	0x63
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x1c
	.4byte	.LASF199
	.byte	0x2
	.2byte	0x43e
	.byte	0xb
	.4byte	0xefd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x43f
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF201
	.byte	0x2
	.2byte	0x42a
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB276
	.4byte	.LFE276-.LFB276
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xf95
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x42a
	.byte	0x3e
	.4byte	0xf95
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x42c
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x35f
	.uleb128 0x1f
	.4byte	.LASF202
	.byte	0x2
	.2byte	0x41a
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB275
	.4byte	.LFE275-.LFB275
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xfd7
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x41a
	.byte	0x3a
	.4byte	0xfd7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x41c
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x2c9
	.uleb128 0x1f
	.4byte	.LASF203
	.byte	0x2
	.2byte	0x40a
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB274
	.4byte	.LFE274-.LFB274
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1019
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x40a
	.byte	0x3a
	.4byte	0xfd7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x40c
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF204
	.byte	0x2
	.2byte	0x3f8
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB273
	.4byte	.LFE273-.LFB273
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1065
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x3f8
	.byte	0x29
	.4byte	0x931
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x3fa
	.byte	0x17
	.4byte	0x243
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x3fb
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF205
	.byte	0x2
	.2byte	0x3e2
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB272
	.4byte	.LFE272-.LFB272
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x10b1
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x3e2
	.byte	0x28
	.4byte	0x38
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x3e3
	.byte	0x17
	.4byte	0x243
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x3e4
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF206
	.byte	0x2
	.2byte	0x3d0
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB271
	.4byte	.LFE271-.LFB271
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x10fd
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x3d0
	.byte	0x2a
	.4byte	0x931
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x3d2
	.byte	0x17
	.4byte	0x243
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x3d3
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF207
	.byte	0x2
	.2byte	0x3b8
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB270
	.4byte	.LFE270-.LFB270
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1149
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x3b8
	.byte	0x29
	.4byte	0x38
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x3ba
	.byte	0x17
	.4byte	0x243
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x3bb
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF208
	.byte	0x2
	.2byte	0x398
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB269
	.4byte	.LFE269-.LFB269
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1195
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x398
	.byte	0x3f
	.4byte	0x1195
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x39a
	.byte	0x17
	.4byte	0x1ad
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x39b
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x51e
	.uleb128 0x1f
	.4byte	.LASF209
	.byte	0x2
	.2byte	0x381
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB268
	.4byte	.LFE268-.LFB268
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x11e7
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x381
	.byte	0x3e
	.4byte	0x51e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x382
	.byte	0x17
	.4byte	0x1ad
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x383
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF210
	.byte	0x2
	.2byte	0x364
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB267
	.4byte	.LFE267-.LFB267
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1223
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x364
	.byte	0x32
	.4byte	0x1223
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x366
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x3f5
	.uleb128 0x1f
	.4byte	.LASF211
	.byte	0x2
	.2byte	0x344
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB266
	.4byte	.LFE266-.LFB266
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1275
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x344
	.byte	0x30
	.4byte	0x1275
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x346
	.byte	0x17
	.4byte	0x243
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x347
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x4f7
	.uleb128 0x1f
	.4byte	.LASF212
	.byte	0x2
	.2byte	0x32d
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB265
	.4byte	.LFE265-.LFB265
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x12c7
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x32d
	.byte	0x2f
	.4byte	0x4f7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x32f
	.byte	0x17
	.4byte	0x243
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x330
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF213
	.byte	0x2
	.2byte	0x31b
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB264
	.4byte	.LFE264-.LFB264
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1313
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x31b
	.byte	0x28
	.4byte	0x931
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x31d
	.byte	0x17
	.4byte	0x243
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x31e
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF214
	.byte	0x2
	.2byte	0x304
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB263
	.4byte	.LFE263-.LFB263
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x135f
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x304
	.byte	0x27
	.4byte	0x38
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x306
	.byte	0x17
	.4byte	0x243
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x307
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF215
	.byte	0x2
	.2byte	0x2f2
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB262
	.4byte	.LFE262-.LFB262
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x13ab
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x2f2
	.byte	0x23
	.4byte	0x931
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x2f4
	.byte	0x17
	.4byte	0x147
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x2f5
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF216
	.byte	0x2
	.2byte	0x2db
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB261
	.4byte	.LFE261-.LFB261
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x13f7
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x2db
	.byte	0x22
	.4byte	0x38
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x2dd
	.byte	0x17
	.4byte	0x147
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x2de
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF217
	.byte	0x2
	.2byte	0x2c9
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB260
	.4byte	.LFE260-.LFB260
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1443
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x2c9
	.byte	0x24
	.4byte	0x931
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x2cb
	.byte	0x17
	.4byte	0x147
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x2cc
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF218
	.byte	0x2
	.2byte	0x2b2
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB259
	.4byte	.LFE259-.LFB259
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x148f
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x2b2
	.byte	0x23
	.4byte	0x38
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x2b4
	.byte	0x17
	.4byte	0x147
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x2b5
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF219
	.byte	0x2
	.2byte	0x2a2
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB258
	.4byte	.LFE258-.LFB258
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x14cb
	.uleb128 0x22
	.4byte	.LASF199
	.byte	0x2
	.2byte	0x2a2
	.byte	0x28
	.4byte	0x931
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x2a4
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF220
	.byte	0x2
	.2byte	0x283
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB257
	.4byte	.LFE257-.LFB257
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1517
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x283
	.byte	0x2e
	.4byte	0xcb5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1c
	.4byte	.LASF199
	.byte	0x2
	.2byte	0x285
	.byte	0xb
	.4byte	0xefd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x286
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF221
	.byte	0x2
	.2byte	0x26c
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB256
	.4byte	.LFE256-.LFB256
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1563
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x26c
	.byte	0x2b
	.4byte	0xcb5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x1c
	.4byte	.LASF199
	.byte	0x2
	.2byte	0x26e
	.byte	0xb
	.4byte	0x1563
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x26f
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x15
	.4byte	0x38
	.4byte	0x1573
	.uleb128 0x16
	.4byte	0x9a
	.byte	0x5
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF222
	.byte	0x2
	.2byte	0x25a
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB255
	.4byte	.LFE255-.LFB255
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x15bf
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x25a
	.byte	0x2b
	.4byte	0x931
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x25c
	.byte	0x18
	.4byte	0x3f5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x25d
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF223
	.byte	0x2
	.2byte	0x248
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB254
	.4byte	.LFE254-.LFB254
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x160b
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x248
	.byte	0x2d
	.4byte	0x931
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x24a
	.byte	0x18
	.4byte	0x3f5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x24b
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF224
	.byte	0x2
	.2byte	0x236
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB253
	.4byte	.LFE253-.LFB253
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1657
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x236
	.byte	0x2f
	.4byte	0x1657
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x238
	.byte	0x17
	.4byte	0x243
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x239
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x25
	.uleb128 0x1f
	.4byte	.LASF225
	.byte	0x2
	.2byte	0x21f
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB252
	.4byte	.LFE252-.LFB252
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x16a9
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x21f
	.byte	0x2f
	.4byte	0x38
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x221
	.byte	0x17
	.4byte	0x243
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x222
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF226
	.byte	0x2
	.2byte	0x20c
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB251
	.4byte	.LFE251-.LFB251
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x16f5
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x20c
	.byte	0x34
	.4byte	0x931
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x20e
	.byte	0x17
	.4byte	0x1ad
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x20f
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF227
	.byte	0x2
	.2byte	0x1f1
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB250
	.4byte	.LFE250-.LFB250
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1741
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x1f1
	.byte	0x33
	.4byte	0x38
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x1f3
	.byte	0x17
	.4byte	0x1ad
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x1f4
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF228
	.byte	0x2
	.2byte	0x1c9
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB249
	.4byte	.LFE249-.LFB249
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x178d
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x1c9
	.byte	0x35
	.4byte	0x178d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x1cb
	.byte	0x17
	.4byte	0x1ad
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x1cc
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x4d0
	.uleb128 0x1f
	.4byte	.LASF229
	.byte	0x2
	.2byte	0x1b2
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB248
	.4byte	.LFE248-.LFB248
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x17df
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x1b2
	.byte	0x34
	.4byte	0x4d0
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x1b4
	.byte	0x17
	.4byte	0x1ad
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x1b5
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF230
	.byte	0x2
	.2byte	0x192
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB247
	.4byte	.LFE247-.LFB247
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x182b
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x192
	.byte	0x37
	.4byte	0x182b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x194
	.byte	0x17
	.4byte	0x1ad
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x195
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x4a3
	.uleb128 0x1f
	.4byte	.LASF231
	.byte	0x2
	.2byte	0x17a
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB246
	.4byte	.LFE246-.LFB246
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x187d
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x17a
	.byte	0x36
	.4byte	0x4a3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x17c
	.byte	0x17
	.4byte	0x1ad
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x17d
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF232
	.byte	0x2
	.2byte	0x167
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB245
	.4byte	.LFE245-.LFB245
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x18c9
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x167
	.byte	0x2f
	.4byte	0x931
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x169
	.byte	0x17
	.4byte	0x147
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x16a
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF233
	.byte	0x2
	.2byte	0x150
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB244
	.4byte	.LFE244-.LFB244
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1915
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x150
	.byte	0x2e
	.4byte	0x38
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x152
	.byte	0x17
	.4byte	0x147
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x153
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF234
	.byte	0x2
	.2byte	0x130
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB243
	.4byte	.LFE243-.LFB243
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1961
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x130
	.byte	0x2e
	.4byte	0x1961
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x132
	.byte	0x17
	.4byte	0x147
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x133
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x47c
	.uleb128 0x1f
	.4byte	.LASF235
	.byte	0x2
	.2byte	0x119
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB242
	.4byte	.LFE242-.LFB242
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x19b3
	.uleb128 0x20
	.ascii	"val\000"
	.byte	0x2
	.2byte	0x119
	.byte	0x2d
	.4byte	0x47c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1e
	.ascii	"reg\000"
	.byte	0x2
	.2byte	0x11b
	.byte	0x17
	.4byte	0x147
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1e
	.ascii	"ret\000"
	.byte	0x2
	.2byte	0x11c
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x23
	.4byte	.LASF236
	.byte	0x2
	.byte	0xf2
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB241
	.4byte	.LFE241-.LFB241
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x19fb
	.uleb128 0x24
	.ascii	"val\000"
	.byte	0x2
	.byte	0xf2
	.byte	0x2e
	.4byte	0x19fb
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x25
	.ascii	"reg\000"
	.byte	0x2
	.byte	0xf3
	.byte	0x17
	.4byte	0x147
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x25
	.ascii	"ret\000"
	.byte	0x2
	.byte	0xf4
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x455
	.uleb128 0x23
	.4byte	.LASF237
	.byte	0x2
	.byte	0xdc
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB240
	.4byte	.LFE240-.LFB240
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1a49
	.uleb128 0x24
	.ascii	"val\000"
	.byte	0x2
	.byte	0xdc
	.byte	0x2d
	.4byte	0x455
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x25
	.ascii	"reg\000"
	.byte	0x2
	.byte	0xdd
	.byte	0x17
	.4byte	0x147
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x25
	.ascii	"ret\000"
	.byte	0x2
	.byte	0xde
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x23
	.4byte	.LASF238
	.byte	0x2
	.byte	0xb7
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB239
	.4byte	.LFE239-.LFB239
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1a91
	.uleb128 0x24
	.ascii	"val\000"
	.byte	0x2
	.byte	0xb7
	.byte	0x32
	.4byte	0x1a91
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x25
	.ascii	"reg\000"
	.byte	0x2
	.byte	0xb9
	.byte	0x17
	.4byte	0x147
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x25
	.ascii	"ret\000"
	.byte	0x2
	.byte	0xba
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x422
	.uleb128 0x23
	.4byte	.LASF239
	.byte	0x2
	.byte	0xa1
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB238
	.4byte	.LFE238-.LFB238
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1adf
	.uleb128 0x24
	.ascii	"val\000"
	.byte	0x2
	.byte	0xa1
	.byte	0x31
	.4byte	0x422
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x25
	.ascii	"reg\000"
	.byte	0x2
	.byte	0xa2
	.byte	0x17
	.4byte	0x147
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x25
	.ascii	"ret\000"
	.byte	0x2
	.byte	0xa3
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x23
	.4byte	.LASF240
	.byte	0x2
	.byte	0x89
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB237
	.4byte	.LFE237-.LFB237
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1b27
	.uleb128 0x24
	.ascii	"val\000"
	.byte	0x2
	.byte	0x89
	.byte	0x2e
	.4byte	0xcb5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x1b
	.4byte	.LASF199
	.byte	0x2
	.byte	0x8b
	.byte	0xb
	.4byte	0x1563
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x25
	.ascii	"ret\000"
	.byte	0x2
	.byte	0x8c
	.byte	0xb
	.4byte	0x76
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x23
	.4byte	.LASF241
	.byte	0x2
	.byte	0x71
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB236
	.4byte	.LFE236-.LFB236
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1b60
	.uleb128 0x24
	.ascii	"val\000"
	.byte	0x2
	.byte	0x71
	.byte	0x2e
	.4byte	0xcb5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1b
	.4byte	.LASF199
	.byte	0x2
	.byte	0x72
	.byte	0xb
	.4byte	0x1563
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.byte	0
	.uleb128 0x26
	.4byte	.LASF242
	.byte	0x2
	.byte	0x54
	.byte	0x9
	.4byte	0xc4
	.4byte	.LFB235
	.4byte	.LFE235-.LFB235
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1b8a
	.uleb128 0x24
	.ascii	"lsb\000"
	.byte	0x2
	.byte	0x54
	.byte	0x2d
	.4byte	0x50
	.uleb128 0x2
	.byte	0x91
	.sleb128 -2
	.byte	0
	.uleb128 0x26
	.4byte	.LASF243
	.byte	0x2
	.byte	0x4f
	.byte	0x9
	.4byte	0xc4
	.4byte	.LFB234
	.4byte	.LFE234-.LFB234
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1bb4
	.uleb128 0x24
	.ascii	"lsb\000"
	.byte	0x2
	.byte	0x4f
	.byte	0x2c
	.4byte	0x50
	.uleb128 0x2
	.byte	0x91
	.sleb128 -2
	.byte	0
	.uleb128 0x23
	.4byte	.LASF244
	.byte	0x2
	.byte	0x3d
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB233
	.4byte	.LFE233-.LFB233
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1bfc
	.uleb128 0x24
	.ascii	"reg\000"
	.byte	0x2
	.byte	0x3d
	.byte	0x23
	.4byte	0x38
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.uleb128 0x27
	.4byte	.LASF193
	.byte	0x2
	.byte	0x3d
	.byte	0x31
	.4byte	0x931
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x24
	.ascii	"len\000"
	.byte	0x2
	.byte	0x3d
	.byte	0x3f
	.4byte	0x38
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.byte	0
	.uleb128 0x23
	.4byte	.LASF245
	.byte	0x2
	.byte	0x2f
	.byte	0x9
	.4byte	0x76
	.4byte	.LFB232
	.4byte	.LFE232-.LFB232
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1c44
	.uleb128 0x24
	.ascii	"reg\000"
	.byte	0x2
	.byte	0x2f
	.byte	0x22
	.4byte	0x38
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.uleb128 0x27
	.4byte	.LASF193
	.byte	0x2
	.byte	0x2f
	.byte	0x30
	.4byte	0x931
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x24
	.ascii	"len\000"
	.byte	0x2
	.byte	0x2f
	.byte	0x3e
	.4byte	0x38
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.byte	0
	.uleb128 0x28
	.4byte	.LASF247
	.byte	0x1
	.2byte	0x39d
	.byte	0x2
	.4byte	0x89
	.4byte	.LFB165
	.4byte	.LFE165-.LFB165
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1c6f
	.uleb128 0x22
	.4byte	.LASF246
	.byte	0x1
	.2byte	0x39d
	.byte	0x2
	.4byte	0x1c6f
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x793
	.uleb128 0x29
	.4byte	.LASF290
	.byte	0x1
	.2byte	0x37d
	.byte	0x2
	.4byte	0x89
	.4byte	.LFB164
	.4byte	.LFE164-.LFB164
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x28
	.4byte	.LASF248
	.byte	0x1
	.2byte	0x370
	.byte	0x2
	.4byte	0x89
	.4byte	.LFB163
	.4byte	.LFE163-.LFB163
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1cb7
	.uleb128 0x22
	.4byte	.LASF249
	.byte	0x1
	.2byte	0x370
	.byte	0x2
	.4byte	0x829
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x28
	.4byte	.LASF250
	.byte	0x1
	.2byte	0x35a
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB162
	.4byte	.LFE162-.LFB162
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1d0f
	.uleb128 0x22
	.4byte	.LASF251
	.byte	0x1
	.2byte	0x35a
	.byte	0x1
	.4byte	0x89
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x22
	.4byte	.LASF252
	.byte	0x1
	.2byte	0x35a
	.byte	0x1
	.4byte	0x89
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x22
	.4byte	.LASF253
	.byte	0x1
	.2byte	0x35a
	.byte	0x1
	.4byte	0x89
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x22
	.4byte	.LASF254
	.byte	0x1
	.2byte	0x35a
	.byte	0x1
	.4byte	0x89
	.uleb128 0x1
	.byte	0x53
	.byte	0
	.uleb128 0x28
	.4byte	.LASF255
	.byte	0x1
	.2byte	0x344
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB161
	.4byte	.LFE161-.LFB161
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1d3a
	.uleb128 0x22
	.4byte	.LASF256
	.byte	0x1
	.2byte	0x344
	.byte	0x1
	.4byte	0x89
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x28
	.4byte	.LASF257
	.byte	0x1
	.2byte	0x326
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB160
	.4byte	.LFE160-.LFB160
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1d83
	.uleb128 0x22
	.4byte	.LASF258
	.byte	0x1
	.2byte	0x326
	.byte	0x1
	.4byte	0x1d83
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x22
	.4byte	.LASF259
	.byte	0x1
	.2byte	0x326
	.byte	0x1
	.4byte	0x925
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x22
	.4byte	.LASF260
	.byte	0x1
	.2byte	0x326
	.byte	0x1
	.4byte	0x89
	.uleb128 0x1
	.byte	0x52
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x89
	.uleb128 0x28
	.4byte	.LASF261
	.byte	0x1
	.2byte	0x303
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB159
	.4byte	.LFE159-.LFB159
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1db4
	.uleb128 0x22
	.4byte	.LASF262
	.byte	0x1
	.2byte	0x303
	.byte	0x1
	.4byte	0x1db4
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x76
	.uleb128 0x28
	.4byte	.LASF263
	.byte	0x1
	.2byte	0x2f8
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB158
	.4byte	.LFE158-.LFB158
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1de5
	.uleb128 0x22
	.4byte	.LASF264
	.byte	0x1
	.2byte	0x2f8
	.byte	0x1
	.4byte	0x1d83
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x28
	.4byte	.LASF265
	.byte	0x1
	.2byte	0x2ed
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB157
	.4byte	.LFE157-.LFB157
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1e1f
	.uleb128 0x22
	.4byte	.LASF266
	.byte	0x1
	.2byte	0x2ed
	.byte	0x1
	.4byte	0x38
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x22
	.4byte	.LASF267
	.byte	0x1
	.2byte	0x2ed
	.byte	0x1
	.4byte	0x1e1f
	.uleb128 0x1
	.byte	0x51
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x911
	.uleb128 0x28
	.4byte	.LASF268
	.byte	0x1
	.2byte	0x2dc
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB156
	.4byte	.LFE156-.LFB156
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1e50
	.uleb128 0x22
	.4byte	.LASF269
	.byte	0x1
	.2byte	0x2dc
	.byte	0x1
	.4byte	0x1e50
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x8bd
	.uleb128 0x28
	.4byte	.LASF270
	.byte	0x1
	.2byte	0x2cc
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB155
	.4byte	.LFE155-.LFB155
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1e90
	.uleb128 0x22
	.4byte	.LASF271
	.byte	0x1
	.2byte	0x2cc
	.byte	0x1
	.4byte	0x38
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x22
	.4byte	.LASF272
	.byte	0x1
	.2byte	0x2cc
	.byte	0x1
	.4byte	0x38
	.uleb128 0x1
	.byte	0x51
	.byte	0
	.uleb128 0x28
	.4byte	.LASF273
	.byte	0x1
	.2byte	0x2ad
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB154
	.4byte	.LFE154-.LFB154
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1eca
	.uleb128 0x22
	.4byte	.LASF274
	.byte	0x1
	.2byte	0x2ad
	.byte	0x1
	.4byte	0x38
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x22
	.4byte	.LASF275
	.byte	0x1
	.2byte	0x2ad
	.byte	0x1
	.4byte	0x1d83
	.uleb128 0x1
	.byte	0x51
	.byte	0
	.uleb128 0x28
	.4byte	.LASF276
	.byte	0x1
	.2byte	0x2a3
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB153
	.4byte	.LFE153-.LFB153
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1f04
	.uleb128 0x22
	.4byte	.LASF274
	.byte	0x1
	.2byte	0x2a3
	.byte	0x1
	.4byte	0x38
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x22
	.4byte	.LASF277
	.byte	0x1
	.2byte	0x2a3
	.byte	0x1
	.4byte	0x89
	.uleb128 0x1
	.byte	0x51
	.byte	0
	.uleb128 0x28
	.4byte	.LASF278
	.byte	0x1
	.2byte	0x299
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB152
	.4byte	.LFE152-.LFB152
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1f2f
	.uleb128 0x22
	.4byte	.LASF274
	.byte	0x1
	.2byte	0x299
	.byte	0x1
	.4byte	0x38
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x28
	.4byte	.LASF279
	.byte	0x1
	.2byte	0x290
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB151
	.4byte	.LFE151-.LFB151
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1f5a
	.uleb128 0x22
	.4byte	.LASF274
	.byte	0x1
	.2byte	0x290
	.byte	0x1
	.4byte	0x38
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x28
	.4byte	.LASF280
	.byte	0x1
	.2byte	0x287
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB150
	.4byte	.LFE150-.LFB150
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1fa3
	.uleb128 0x22
	.4byte	.LASF281
	.byte	0x1
	.2byte	0x287
	.byte	0x1
	.4byte	0x38
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x22
	.4byte	.LASF282
	.byte	0x1
	.2byte	0x287
	.byte	0x1
	.4byte	0x1fa3
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x22
	.4byte	.LASF283
	.byte	0x1
	.2byte	0x287
	.byte	0x1
	.4byte	0x1fa3
	.uleb128 0x1
	.byte	0x52
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x92c
	.uleb128 0x28
	.4byte	.LASF284
	.byte	0x1
	.2byte	0x27c
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB149
	.4byte	.LFE149-.LFB149
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1fd4
	.uleb128 0x22
	.4byte	.LASF285
	.byte	0x1
	.2byte	0x27c
	.byte	0x1
	.4byte	0x89
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x28
	.4byte	.LASF286
	.byte	0x1
	.2byte	0x274
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB148
	.4byte	.LFE148-.LFB148
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1fff
	.uleb128 0x22
	.4byte	.LASF287
	.byte	0x1
	.2byte	0x274
	.byte	0x1
	.4byte	0x89
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x28
	.4byte	.LASF288
	.byte	0x1
	.2byte	0x26c
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB147
	.4byte	.LFE147-.LFB147
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x202a
	.uleb128 0x22
	.4byte	.LASF289
	.byte	0x1
	.2byte	0x26c
	.byte	0x1
	.4byte	0x1d83
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x29
	.4byte	.LASF291
	.byte	0x1
	.2byte	0x264
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB146
	.4byte	.LFE146-.LFB146
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x28
	.4byte	.LASF292
	.byte	0x1
	.2byte	0x248
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB145
	.4byte	.LFE145-.LFB145
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x206c
	.uleb128 0x22
	.4byte	.LASF293
	.byte	0x1
	.2byte	0x248
	.byte	0x1
	.4byte	0x1d83
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x29
	.4byte	.LASF294
	.byte	0x1
	.2byte	0x23d
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB144
	.4byte	.LFE144-.LFB144
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x29
	.4byte	.LASF295
	.byte	0x1
	.2byte	0x232
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB143
	.4byte	.LFE143-.LFB143
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x28
	.4byte	.LASF296
	.byte	0x1
	.2byte	0x226
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB142
	.4byte	.LFE142-.LFB142
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x20c5
	.uleb128 0x22
	.4byte	.LASF297
	.byte	0x1
	.2byte	0x226
	.byte	0x1
	.4byte	0x38
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x28
	.4byte	.LASF298
	.byte	0x1
	.2byte	0x21b
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB141
	.4byte	.LFE141-.LFB141
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x20ff
	.uleb128 0x22
	.4byte	.LASF299
	.byte	0x1
	.2byte	0x21b
	.byte	0x1
	.4byte	0x89
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x22
	.4byte	.LASF300
	.byte	0x1
	.2byte	0x21b
	.byte	0x1
	.4byte	0x1d83
	.uleb128 0x1
	.byte	0x51
	.byte	0
	.uleb128 0x28
	.4byte	.LASF301
	.byte	0x1
	.2byte	0x212
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB140
	.4byte	.LFE140-.LFB140
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x2139
	.uleb128 0x22
	.4byte	.LASF299
	.byte	0x1
	.2byte	0x212
	.byte	0x1
	.4byte	0x89
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x22
	.4byte	.LASF302
	.byte	0x1
	.2byte	0x212
	.byte	0x1
	.4byte	0x89
	.uleb128 0x1
	.byte	0x51
	.byte	0
	.uleb128 0x28
	.4byte	.LASF303
	.byte	0x1
	.2byte	0x209
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB139
	.4byte	.LFE139-.LFB139
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x2173
	.uleb128 0x22
	.4byte	.LASF299
	.byte	0x1
	.2byte	0x209
	.byte	0x1
	.4byte	0x89
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x22
	.4byte	.LASF302
	.byte	0x1
	.2byte	0x209
	.byte	0x1
	.4byte	0x89
	.uleb128 0x1
	.byte	0x51
	.byte	0
	.uleb128 0x28
	.4byte	.LASF304
	.byte	0x1
	.2byte	0x200
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB138
	.4byte	.LFE138-.LFB138
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x21ad
	.uleb128 0x22
	.4byte	.LASF305
	.byte	0x1
	.2byte	0x200
	.byte	0x1
	.4byte	0x38
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x22
	.4byte	.LASF306
	.byte	0x1
	.2byte	0x200
	.byte	0x1
	.4byte	0x1d83
	.uleb128 0x1
	.byte	0x51
	.byte	0
	.uleb128 0x28
	.4byte	.LASF307
	.byte	0x1
	.2byte	0x1f7
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB137
	.4byte	.LFE137-.LFB137
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x21e7
	.uleb128 0x22
	.4byte	.LASF305
	.byte	0x1
	.2byte	0x1f7
	.byte	0x1
	.4byte	0x38
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x22
	.4byte	.LASF308
	.byte	0x1
	.2byte	0x1f7
	.byte	0x1
	.4byte	0x89
	.uleb128 0x1
	.byte	0x51
	.byte	0
	.uleb128 0x28
	.4byte	.LASF309
	.byte	0x1
	.2byte	0x1ee
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB136
	.4byte	.LFE136-.LFB136
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x2221
	.uleb128 0x22
	.4byte	.LASF305
	.byte	0x1
	.2byte	0x1ee
	.byte	0x1
	.4byte	0x38
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x22
	.4byte	.LASF310
	.byte	0x1
	.2byte	0x1ee
	.byte	0x1
	.4byte	0x89
	.uleb128 0x1
	.byte	0x51
	.byte	0
	.uleb128 0x28
	.4byte	.LASF311
	.byte	0x1
	.2byte	0x1e5
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB135
	.4byte	.LFE135-.LFB135
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x224c
	.uleb128 0x22
	.4byte	.LASF312
	.byte	0x1
	.2byte	0x1e5
	.byte	0x1
	.4byte	0x38
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x28
	.4byte	.LASF313
	.byte	0x1
	.2byte	0x1dc
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB134
	.4byte	.LFE134-.LFB134
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x2277
	.uleb128 0x22
	.4byte	.LASF314
	.byte	0x1
	.2byte	0x1dc
	.byte	0x1
	.4byte	0x38
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x29
	.4byte	.LASF315
	.byte	0x1
	.2byte	0x1d1
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB133
	.4byte	.LFE133-.LFB133
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x28
	.4byte	.LASF316
	.byte	0x1
	.2byte	0x1cb
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB132
	.4byte	.LFE132-.LFB132
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x22b9
	.uleb128 0x22
	.4byte	.LASF317
	.byte	0x1
	.2byte	0x1cb
	.byte	0x1
	.4byte	0x38
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x28
	.4byte	.LASF318
	.byte	0x1
	.2byte	0x1c2
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB131
	.4byte	.LFE131-.LFB131
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x22e4
	.uleb128 0x22
	.4byte	.LASF319
	.byte	0x1
	.2byte	0x1c2
	.byte	0x1
	.4byte	0x89
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x28
	.4byte	.LASF320
	.byte	0x1
	.2byte	0x1ba
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB130
	.4byte	.LFE130-.LFB130
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x230f
	.uleb128 0x22
	.4byte	.LASF321
	.byte	0x1
	.2byte	0x1ba
	.byte	0x1
	.4byte	0x1d83
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x28
	.4byte	.LASF322
	.byte	0x1
	.2byte	0x1b2
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB129
	.4byte	.LFE129-.LFB129
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x2349
	.uleb128 0x22
	.4byte	.LASF323
	.byte	0x1
	.2byte	0x1b2
	.byte	0x1
	.4byte	0x931
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x22
	.4byte	.LASF324
	.byte	0x1
	.2byte	0x1b2
	.byte	0x1
	.4byte	0x38
	.uleb128 0x1
	.byte	0x51
	.byte	0
	.uleb128 0x28
	.4byte	.LASF325
	.byte	0x1
	.2byte	0x1a8
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB128
	.4byte	.LFE128-.LFB128
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x2374
	.uleb128 0x22
	.4byte	.LASF326
	.byte	0x1
	.2byte	0x1a8
	.byte	0x1
	.4byte	0x931
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x28
	.4byte	.LASF327
	.byte	0x1
	.2byte	0x1a0
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB127
	.4byte	.LFE127-.LFB127
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x239f
	.uleb128 0x22
	.4byte	.LASF328
	.byte	0x1
	.2byte	0x1a0
	.byte	0x1
	.4byte	0x931
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x28
	.4byte	.LASF329
	.byte	0x1
	.2byte	0x198
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB126
	.4byte	.LFE126-.LFB126
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x23ca
	.uleb128 0x22
	.4byte	.LASF330
	.byte	0x1
	.2byte	0x198
	.byte	0x1
	.4byte	0x23ca
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x12
	.byte	0x4
	.4byte	0x68d
	.uleb128 0x28
	.4byte	.LASF331
	.byte	0x1
	.2byte	0x190
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB125
	.4byte	.LFE125-.LFB125
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x23fb
	.uleb128 0x22
	.4byte	.LASF330
	.byte	0x1
	.2byte	0x190
	.byte	0x1
	.4byte	0x23ca
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x2a
	.4byte	.LASF336
	.byte	0x1
	.2byte	0x187
	.byte	0x1
	.4byte	0x89
	.4byte	.LFB124
	.4byte	.LFE124-.LFB124
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x22
	.4byte	.LASF330
	.byte	0x1
	.2byte	0x187
	.byte	0x1
	.4byte	0x23ca
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",%progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x2134
	.uleb128 0x19
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xd
	.uleb128 0xb
	.uleb128 0xc
	.uleb128 0xb
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xd
	.uleb128 0xb
	.uleb128 0xc
	.uleb128 0xb
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x17
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x26
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x29
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x2a
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_pubnames,"",%progbits
	.4byte	0x12cf
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x2423
	.4byte	0x40f
	.ascii	"LIS2MDL_CONTINUOUS_MODE\000"
	.4byte	0x415
	.ascii	"LIS2MDL_SINGLE_TRIGGER\000"
	.4byte	0x41b
	.ascii	"LIS2MDL_POWER_DOWN\000"
	.4byte	0x43c
	.ascii	"LIS2MDL_ODR_10Hz\000"
	.4byte	0x442
	.ascii	"LIS2MDL_ODR_20Hz\000"
	.4byte	0x448
	.ascii	"LIS2MDL_ODR_50Hz\000"
	.4byte	0x44e
	.ascii	"LIS2MDL_ODR_100Hz\000"
	.4byte	0x46f
	.ascii	"LIS2MDL_HIGH_RESOLUTION\000"
	.4byte	0x475
	.ascii	"LIS2MDL_LOW_POWER\000"
	.4byte	0x496
	.ascii	"LIS2MDL_ODR_DIV_2\000"
	.4byte	0x49c
	.ascii	"LIS2MDL_ODR_DIV_4\000"
	.4byte	0x4bd
	.ascii	"LIS2MDL_SET_SENS_ODR_DIV_63\000"
	.4byte	0x4c3
	.ascii	"LIS2MDL_SENS_OFF_CANC_EVERY_ODR\000"
	.4byte	0x4c9
	.ascii	"LIS2MDL_SET_SENS_ONLY_AT_POWER_ON\000"
	.4byte	0x4ea
	.ascii	"LIS2MDL_LSB_AT_LOW_ADD\000"
	.4byte	0x4f0
	.ascii	"LIS2MDL_MSB_AT_LOW_ADD\000"
	.4byte	0x511
	.ascii	"LIS2MDL_CHECK_BEFORE\000"
	.4byte	0x517
	.ascii	"LIS2MDL_CHECK_AFTER\000"
	.4byte	0x538
	.ascii	"LIS2MDL_SPI_4_WIRE\000"
	.4byte	0x53e
	.ascii	"LIS2MDL_SPI_3_WIRE\000"
	.4byte	0x55f
	.ascii	"LIS2MDL_I2C_ENABLE\000"
	.4byte	0x565
	.ascii	"LIS2MDL_I2C_DISABLE\000"
	.4byte	0x58a
	.ascii	"SD_PPI_CHANNEL_ENABLE_GET\000"
	.4byte	0x590
	.ascii	"SD_PPI_CHANNEL_ENABLE_SET\000"
	.4byte	0x596
	.ascii	"SD_PPI_CHANNEL_ENABLE_CLR\000"
	.4byte	0x59c
	.ascii	"SD_PPI_CHANNEL_ASSIGN\000"
	.4byte	0x5a2
	.ascii	"SD_PPI_GROUP_TASK_ENABLE\000"
	.4byte	0x5a8
	.ascii	"SD_PPI_GROUP_TASK_DISABLE\000"
	.4byte	0x5ae
	.ascii	"SD_PPI_GROUP_ASSIGN\000"
	.4byte	0x5b4
	.ascii	"SD_PPI_GROUP_GET\000"
	.4byte	0x5ba
	.ascii	"SD_FLASH_PAGE_ERASE\000"
	.4byte	0x5c0
	.ascii	"SD_FLASH_WRITE\000"
	.4byte	0x5c6
	.ascii	"SD_FLASH_PROTECT\000"
	.4byte	0x5cc
	.ascii	"SD_MUTEX_NEW\000"
	.4byte	0x5d2
	.ascii	"SD_MUTEX_ACQUIRE\000"
	.4byte	0x5d8
	.ascii	"SD_MUTEX_RELEASE\000"
	.4byte	0x5de
	.ascii	"SD_RAND_APPLICATION_POOL_CAPACITY_GET\000"
	.4byte	0x5e4
	.ascii	"SD_RAND_APPLICATION_BYTES_AVAILABLE_GET\000"
	.4byte	0x5ea
	.ascii	"SD_RAND_APPLICATION_VECTOR_GET\000"
	.4byte	0x5f0
	.ascii	"SD_POWER_MODE_SET\000"
	.4byte	0x5f6
	.ascii	"SD_POWER_SYSTEM_OFF\000"
	.4byte	0x5fc
	.ascii	"SD_POWER_RESET_REASON_GET\000"
	.4byte	0x602
	.ascii	"SD_POWER_RESET_REASON_CLR\000"
	.4byte	0x608
	.ascii	"SD_POWER_POF_ENABLE\000"
	.4byte	0x60e
	.ascii	"SD_POWER_POF_THRESHOLD_SET\000"
	.4byte	0x614
	.ascii	"SD_POWER_RAM_POWER_SET\000"
	.4byte	0x61a
	.ascii	"SD_POWER_RAM_POWER_CLR\000"
	.4byte	0x620
	.ascii	"SD_POWER_RAM_POWER_GET\000"
	.4byte	0x626
	.ascii	"SD_POWER_GPREGRET_SET\000"
	.4byte	0x62c
	.ascii	"SD_POWER_GPREGRET_CLR\000"
	.4byte	0x632
	.ascii	"SD_POWER_GPREGRET_GET\000"
	.4byte	0x638
	.ascii	"SD_POWER_DCDC_MODE_SET\000"
	.4byte	0x63e
	.ascii	"SD_APP_EVT_WAIT\000"
	.4byte	0x644
	.ascii	"SD_CLOCK_HFCLK_REQUEST\000"
	.4byte	0x64a
	.ascii	"SD_CLOCK_HFCLK_RELEASE\000"
	.4byte	0x650
	.ascii	"SD_CLOCK_HFCLK_IS_RUNNING\000"
	.4byte	0x656
	.ascii	"SD_RADIO_NOTIFICATION_CFG_SET\000"
	.4byte	0x65c
	.ascii	"SD_ECB_BLOCK_ENCRYPT\000"
	.4byte	0x662
	.ascii	"SD_ECB_BLOCKS_ENCRYPT\000"
	.4byte	0x668
	.ascii	"SD_RADIO_SESSION_OPEN\000"
	.4byte	0x66e
	.ascii	"SD_RADIO_SESSION_CLOSE\000"
	.4byte	0x674
	.ascii	"SD_RADIO_REQUEST\000"
	.4byte	0x67a
	.ascii	"SD_EVT_GET\000"
	.4byte	0x680
	.ascii	"SD_TEMP_GET\000"
	.4byte	0x686
	.ascii	"SVC_SOC_LAST\000"
	.4byte	0x9ee
	.ascii	"config\000"
	.4byte	0xa72
	.ascii	"data_raw_magnetic\000"
	.4byte	0xa85
	.ascii	"lis2mdl_data_raw_temperature\000"
	.4byte	0xa98
	.ascii	"magnetic_mG\000"
	.4byte	0xaab
	.ascii	"lis2mdl_temperature_degC\000"
	.4byte	0xabe
	.ascii	"mag_whoamI\000"
	.4byte	0xad1
	.ascii	"mag_device_found\000"
	.4byte	0xae4
	.ascii	"mag_config\000"
	.4byte	0xa72
	.ascii	"data_raw_magnetic\000"
	.4byte	0xa85
	.ascii	"lis2mdl_data_raw_temperature\000"
	.4byte	0xa98
	.ascii	"magnetic_mG\000"
	.4byte	0xaab
	.ascii	"lis2mdl_temperature_degC\000"
	.4byte	0xabe
	.ascii	"mag_whoamI\000"
	.4byte	0xad1
	.ascii	"mag_device_found\000"
	.4byte	0xae4
	.ascii	"mag_config\000"
	.4byte	0xafd
	.ascii	"lis2mdl_print_temp\000"
	.4byte	0xb25
	.ascii	"lis2mdl_get_temp\000"
	.4byte	0xb67
	.ascii	"lis2mdl_print_mag\000"
	.4byte	0xb8f
	.ascii	"lis2mdl_get_mag_calibrated\000"
	.4byte	0xbcb
	.ascii	"lis2mdl_get_mag\000"
	.4byte	0xc21
	.ascii	"lis2mdl_init\000"
	.4byte	0xc49
	.ascii	"lis2mdl_temperature_raw_get_my\000"
	.4byte	0xcbb
	.ascii	"lis2mdl_magnetic_raw_get_my\000"
	.4byte	0xd27
	.ascii	"lis2mdl_print_reg\000"
	.4byte	0xd6f
	.ascii	"lis2mdl_i2c_interface_get\000"
	.4byte	0xdc1
	.ascii	"lis2mdl_i2c_interface_set\000"
	.4byte	0xe0d
	.ascii	"lis2mdl_spi_mode_get\000"
	.4byte	0xe5f
	.ascii	"lis2mdl_spi_mode_set\000"
	.4byte	0xeab
	.ascii	"lis2mdl_int_gen_treshold_get\000"
	.4byte	0xf0d
	.ascii	"lis2mdl_int_gen_treshold_set\000"
	.4byte	0xf59
	.ascii	"lis2mdl_int_gen_source_get\000"
	.4byte	0xf9b
	.ascii	"lis2mdl_int_gen_conf_get\000"
	.4byte	0xfdd
	.ascii	"lis2mdl_int_gen_conf_set\000"
	.4byte	0x1019
	.ascii	"lis2mdl_int_on_pin_get\000"
	.4byte	0x1065
	.ascii	"lis2mdl_int_on_pin_set\000"
	.4byte	0x10b1
	.ascii	"lis2mdl_drdy_on_pin_get\000"
	.4byte	0x10fd
	.ascii	"lis2mdl_drdy_on_pin_set\000"
	.4byte	0x1149
	.ascii	"lis2mdl_offset_int_conf_get\000"
	.4byte	0x119b
	.ascii	"lis2mdl_offset_int_conf_set\000"
	.4byte	0x11e7
	.ascii	"lis2mdl_status_get\000"
	.4byte	0x1229
	.ascii	"lis2mdl_data_format_get\000"
	.4byte	0x127b
	.ascii	"lis2mdl_data_format_set\000"
	.4byte	0x12c7
	.ascii	"lis2mdl_self_test_get\000"
	.4byte	0x1313
	.ascii	"lis2mdl_self_test_set\000"
	.4byte	0x135f
	.ascii	"lis2mdl_boot_get\000"
	.4byte	0x13ab
	.ascii	"lis2mdl_boot_set\000"
	.4byte	0x13f7
	.ascii	"lis2mdl_reset_get\000"
	.4byte	0x1443
	.ascii	"lis2mdl_reset_set\000"
	.4byte	0x148f
	.ascii	"lis2mdl_device_id_get\000"
	.4byte	0x14cb
	.ascii	"lis2mdl_temperature_raw_get\000"
	.4byte	0x1517
	.ascii	"lis2mdl_magnetic_raw_get\000"
	.4byte	0x1573
	.ascii	"lis2mdl_mag_data_ovr_get\000"
	.4byte	0x15bf
	.ascii	"lis2mdl_mag_data_ready_get\000"
	.4byte	0x160b
	.ascii	"lis2mdl_block_data_update_get\000"
	.4byte	0x165d
	.ascii	"lis2mdl_block_data_update_set\000"
	.4byte	0x16a9
	.ascii	"lis2mdl_set_rst_sensor_single_get\000"
	.4byte	0x16f5
	.ascii	"lis2mdl_set_rst_sensor_single_set\000"
	.4byte	0x1741
	.ascii	"lis2mdl_set_rst_mode_get\000"
	.4byte	0x1793
	.ascii	"lis2mdl_set_rst_mode_set\000"
	.4byte	0x17df
	.ascii	"lis2mdl_low_pass_bandwidth_get\000"
	.4byte	0x1831
	.ascii	"lis2mdl_low_pass_bandwidth_set\000"
	.4byte	0x187d
	.ascii	"lis2mdl_offset_temp_comp_get\000"
	.4byte	0x18c9
	.ascii	"lis2mdl_offset_temp_comp_set\000"
	.4byte	0x1915
	.ascii	"lis2mdl_power_mode_get\000"
	.4byte	0x1967
	.ascii	"lis2mdl_power_mode_set\000"
	.4byte	0x19b3
	.ascii	"lis2mdl_data_rate_get\000"
	.4byte	0x1a01
	.ascii	"lis2mdl_data_rate_set\000"
	.4byte	0x1a49
	.ascii	"lis2mdl_operating_mode_get\000"
	.4byte	0x1a97
	.ascii	"lis2mdl_operating_mode_set\000"
	.4byte	0x1adf
	.ascii	"lis2mdl_mag_user_offset_get\000"
	.4byte	0x1b27
	.ascii	"lis2mdl_mag_user_offset_set\000"
	.4byte	0x1b60
	.ascii	"lis2mdl_from_lsb_to_celsius\000"
	.4byte	0x1b8a
	.ascii	"lis2mdl_from_lsb_to_mgauss\000"
	.4byte	0x1bb4
	.ascii	"lis2mdl_write_reg\000"
	.4byte	0x1bfc
	.ascii	"lis2mdl_read_reg\000"
	.4byte	0x1c44
	.ascii	"sd_radio_request\000"
	.4byte	0x1c75
	.ascii	"sd_radio_session_close\000"
	.4byte	0x1c8c
	.ascii	"sd_radio_session_open\000"
	.4byte	0x1cb7
	.ascii	"sd_flash_protect\000"
	.4byte	0x1d0f
	.ascii	"sd_flash_page_erase\000"
	.4byte	0x1d3a
	.ascii	"sd_flash_write\000"
	.4byte	0x1d89
	.ascii	"sd_temp_get\000"
	.4byte	0x1dba
	.ascii	"sd_evt_get\000"
	.4byte	0x1de5
	.ascii	"sd_ecb_blocks_encrypt\000"
	.4byte	0x1e25
	.ascii	"sd_ecb_block_encrypt\000"
	.4byte	0x1e56
	.ascii	"sd_radio_notification_cfg_set\000"
	.4byte	0x1e90
	.ascii	"sd_ppi_group_get\000"
	.4byte	0x1eca
	.ascii	"sd_ppi_group_assign\000"
	.4byte	0x1f04
	.ascii	"sd_ppi_group_task_disable\000"
	.4byte	0x1f2f
	.ascii	"sd_ppi_group_task_enable\000"
	.4byte	0x1f5a
	.ascii	"sd_ppi_channel_assign\000"
	.4byte	0x1fa9
	.ascii	"sd_ppi_channel_enable_clr\000"
	.4byte	0x1fd4
	.ascii	"sd_ppi_channel_enable_set\000"
	.4byte	0x1fff
	.ascii	"sd_ppi_channel_enable_get\000"
	.4byte	0x202a
	.ascii	"sd_app_evt_wait\000"
	.4byte	0x2041
	.ascii	"sd_clock_hfclk_is_running\000"
	.4byte	0x206c
	.ascii	"sd_clock_hfclk_release\000"
	.4byte	0x2083
	.ascii	"sd_clock_hfclk_request\000"
	.4byte	0x209a
	.ascii	"sd_power_dcdc_mode_set\000"
	.4byte	0x20c5
	.ascii	"sd_power_gpregret_get\000"
	.4byte	0x20ff
	.ascii	"sd_power_gpregret_clr\000"
	.4byte	0x2139
	.ascii	"sd_power_gpregret_set\000"
	.4byte	0x2173
	.ascii	"sd_power_ram_power_get\000"
	.4byte	0x21ad
	.ascii	"sd_power_ram_power_clr\000"
	.4byte	0x21e7
	.ascii	"sd_power_ram_power_set\000"
	.4byte	0x2221
	.ascii	"sd_power_pof_threshold_set\000"
	.4byte	0x224c
	.ascii	"sd_power_pof_enable\000"
	.4byte	0x2277
	.ascii	"sd_power_system_off\000"
	.4byte	0x228e
	.ascii	"sd_power_mode_set\000"
	.4byte	0x22b9
	.ascii	"sd_power_reset_reason_clr\000"
	.4byte	0x22e4
	.ascii	"sd_power_reset_reason_get\000"
	.4byte	0x230f
	.ascii	"sd_rand_application_vector_get\000"
	.4byte	0x2349
	.ascii	"sd_rand_application_bytes_available_get\000"
	.4byte	0x2374
	.ascii	"sd_rand_application_pool_capacity_get\000"
	.4byte	0x239f
	.ascii	"sd_mutex_release\000"
	.4byte	0x23d0
	.ascii	"sd_mutex_acquire\000"
	.4byte	0x23fb
	.ascii	"sd_mutex_new\000"
	.4byte	0
	.section	.debug_pubtypes,"",%progbits
	.4byte	0x40c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x2423
	.4byte	0x31
	.ascii	"signed char\000"
	.4byte	0x25
	.ascii	"int8_t\000"
	.4byte	0x49
	.ascii	"unsigned char\000"
	.4byte	0x38
	.ascii	"uint8_t\000"
	.4byte	0x5c
	.ascii	"short int\000"
	.4byte	0x50
	.ascii	"int16_t\000"
	.4byte	0x6f
	.ascii	"short unsigned int\000"
	.4byte	0x63
	.ascii	"uint16_t\000"
	.4byte	0x82
	.ascii	"int\000"
	.4byte	0x76
	.ascii	"int32_t\000"
	.4byte	0x9a
	.ascii	"unsigned int\000"
	.4byte	0x89
	.ascii	"uint32_t\000"
	.4byte	0xa1
	.ascii	"long long int\000"
	.4byte	0xa8
	.ascii	"long long unsigned int\000"
	.4byte	0xaf
	.ascii	"long int\000"
	.4byte	0xb6
	.ascii	"char\000"
	.4byte	0xbd
	.ascii	"long double\000"
	.4byte	0xd1
	.ascii	"float\000"
	.4byte	0xc4
	.ascii	"float_t\000"
	.4byte	0xd8
	.ascii	"double\000"
	.4byte	0x147
	.ascii	"lis2mdl_cfg_reg_a_t\000"
	.4byte	0x1ad
	.ascii	"lis2mdl_cfg_reg_b_t\000"
	.4byte	0x243
	.ascii	"lis2mdl_cfg_reg_c_t\000"
	.4byte	0x2c9
	.ascii	"lis2mdl_int_crtl_reg_t\000"
	.4byte	0x35f
	.ascii	"lis2mdl_int_source_reg_t\000"
	.4byte	0x3f5
	.ascii	"lis2mdl_status_reg_t\000"
	.4byte	0x422
	.ascii	"lis2mdl_md_t\000"
	.4byte	0x455
	.ascii	"lis2mdl_odr_t\000"
	.4byte	0x47c
	.ascii	"lis2mdl_lp_t\000"
	.4byte	0x4a3
	.ascii	"lis2mdl_lpf_t\000"
	.4byte	0x4d0
	.ascii	"lis2mdl_set_rst_t\000"
	.4byte	0x4f7
	.ascii	"lis2mdl_ble_t\000"
	.4byte	0x51e
	.ascii	"lis2mdl_int_on_dataoff_t\000"
	.4byte	0x545
	.ascii	"lis2mdl_sim_t\000"
	.4byte	0x56c
	.ascii	"lis2mdl_i2c_dis_t\000"
	.4byte	0x578
	.ascii	"NRF_SOC_SVCS\000"
	.4byte	0x68d
	.ascii	"nrf_mutex_t\000"
	.4byte	0x6dd
	.ascii	"nrf_radio_request_earliest_t\000"
	.4byte	0x72d
	.ascii	"nrf_radio_request_normal_t\000"
	.4byte	0x786
	.ascii	"nrf_radio_request_t\000"
	.4byte	0x81c
	.ascii	"nrf_radio_signal_callback_return_param_t\000"
	.4byte	0x829
	.ascii	"nrf_radio_signal_callback_t\000"
	.4byte	0x851
	.ascii	"soc_ecb_key_t\000"
	.4byte	0x86e
	.ascii	"soc_ecb_cleartext_t\000"
	.4byte	0x87b
	.ascii	"soc_ecb_ciphertext_t\000"
	.4byte	0x8bd
	.ascii	"nrf_ecb_hal_data_t\000"
	.4byte	0x911
	.ascii	"nrf_ecb_hal_data_block_t\000"
	.4byte	0x91e
	.ascii	"_Bool\000"
	.4byte	0x937
	.ascii	"uint8\000"
	.4byte	0x943
	.ascii	"uint16\000"
	.4byte	0x94f
	.ascii	"long unsigned int\000"
	.4byte	0x9e2
	.ascii	"dwt_config_t\000"
	.4byte	0xa51
	.ascii	"man_fds_mag_t\000"
	.4byte	0
	.section	.debug_aranges,"",%progbits
	.4byte	0x344
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.LFB124
	.4byte	.LFE124-.LFB124
	.4byte	.LFB125
	.4byte	.LFE125-.LFB125
	.4byte	.LFB126
	.4byte	.LFE126-.LFB126
	.4byte	.LFB127
	.4byte	.LFE127-.LFB127
	.4byte	.LFB128
	.4byte	.LFE128-.LFB128
	.4byte	.LFB129
	.4byte	.LFE129-.LFB129
	.4byte	.LFB130
	.4byte	.LFE130-.LFB130
	.4byte	.LFB131
	.4byte	.LFE131-.LFB131
	.4byte	.LFB132
	.4byte	.LFE132-.LFB132
	.4byte	.LFB133
	.4byte	.LFE133-.LFB133
	.4byte	.LFB134
	.4byte	.LFE134-.LFB134
	.4byte	.LFB135
	.4byte	.LFE135-.LFB135
	.4byte	.LFB136
	.4byte	.LFE136-.LFB136
	.4byte	.LFB137
	.4byte	.LFE137-.LFB137
	.4byte	.LFB138
	.4byte	.LFE138-.LFB138
	.4byte	.LFB139
	.4byte	.LFE139-.LFB139
	.4byte	.LFB140
	.4byte	.LFE140-.LFB140
	.4byte	.LFB141
	.4byte	.LFE141-.LFB141
	.4byte	.LFB142
	.4byte	.LFE142-.LFB142
	.4byte	.LFB143
	.4byte	.LFE143-.LFB143
	.4byte	.LFB144
	.4byte	.LFE144-.LFB144
	.4byte	.LFB145
	.4byte	.LFE145-.LFB145
	.4byte	.LFB146
	.4byte	.LFE146-.LFB146
	.4byte	.LFB147
	.4byte	.LFE147-.LFB147
	.4byte	.LFB148
	.4byte	.LFE148-.LFB148
	.4byte	.LFB149
	.4byte	.LFE149-.LFB149
	.4byte	.LFB150
	.4byte	.LFE150-.LFB150
	.4byte	.LFB151
	.4byte	.LFE151-.LFB151
	.4byte	.LFB152
	.4byte	.LFE152-.LFB152
	.4byte	.LFB153
	.4byte	.LFE153-.LFB153
	.4byte	.LFB154
	.4byte	.LFE154-.LFB154
	.4byte	.LFB155
	.4byte	.LFE155-.LFB155
	.4byte	.LFB156
	.4byte	.LFE156-.LFB156
	.4byte	.LFB157
	.4byte	.LFE157-.LFB157
	.4byte	.LFB158
	.4byte	.LFE158-.LFB158
	.4byte	.LFB159
	.4byte	.LFE159-.LFB159
	.4byte	.LFB160
	.4byte	.LFE160-.LFB160
	.4byte	.LFB161
	.4byte	.LFE161-.LFB161
	.4byte	.LFB162
	.4byte	.LFE162-.LFB162
	.4byte	.LFB163
	.4byte	.LFE163-.LFB163
	.4byte	.LFB164
	.4byte	.LFE164-.LFB164
	.4byte	.LFB165
	.4byte	.LFE165-.LFB165
	.4byte	.LFB232
	.4byte	.LFE232-.LFB232
	.4byte	.LFB233
	.4byte	.LFE233-.LFB233
	.4byte	.LFB234
	.4byte	.LFE234-.LFB234
	.4byte	.LFB235
	.4byte	.LFE235-.LFB235
	.4byte	.LFB236
	.4byte	.LFE236-.LFB236
	.4byte	.LFB237
	.4byte	.LFE237-.LFB237
	.4byte	.LFB238
	.4byte	.LFE238-.LFB238
	.4byte	.LFB239
	.4byte	.LFE239-.LFB239
	.4byte	.LFB240
	.4byte	.LFE240-.LFB240
	.4byte	.LFB241
	.4byte	.LFE241-.LFB241
	.4byte	.LFB242
	.4byte	.LFE242-.LFB242
	.4byte	.LFB243
	.4byte	.LFE243-.LFB243
	.4byte	.LFB244
	.4byte	.LFE244-.LFB244
	.4byte	.LFB245
	.4byte	.LFE245-.LFB245
	.4byte	.LFB246
	.4byte	.LFE246-.LFB246
	.4byte	.LFB247
	.4byte	.LFE247-.LFB247
	.4byte	.LFB248
	.4byte	.LFE248-.LFB248
	.4byte	.LFB249
	.4byte	.LFE249-.LFB249
	.4byte	.LFB250
	.4byte	.LFE250-.LFB250
	.4byte	.LFB251
	.4byte	.LFE251-.LFB251
	.4byte	.LFB252
	.4byte	.LFE252-.LFB252
	.4byte	.LFB253
	.4byte	.LFE253-.LFB253
	.4byte	.LFB254
	.4byte	.LFE254-.LFB254
	.4byte	.LFB255
	.4byte	.LFE255-.LFB255
	.4byte	.LFB256
	.4byte	.LFE256-.LFB256
	.4byte	.LFB257
	.4byte	.LFE257-.LFB257
	.4byte	.LFB258
	.4byte	.LFE258-.LFB258
	.4byte	.LFB259
	.4byte	.LFE259-.LFB259
	.4byte	.LFB260
	.4byte	.LFE260-.LFB260
	.4byte	.LFB261
	.4byte	.LFE261-.LFB261
	.4byte	.LFB262
	.4byte	.LFE262-.LFB262
	.4byte	.LFB263
	.4byte	.LFE263-.LFB263
	.4byte	.LFB264
	.4byte	.LFE264-.LFB264
	.4byte	.LFB265
	.4byte	.LFE265-.LFB265
	.4byte	.LFB266
	.4byte	.LFE266-.LFB266
	.4byte	.LFB267
	.4byte	.LFE267-.LFB267
	.4byte	.LFB268
	.4byte	.LFE268-.LFB268
	.4byte	.LFB269
	.4byte	.LFE269-.LFB269
	.4byte	.LFB270
	.4byte	.LFE270-.LFB270
	.4byte	.LFB271
	.4byte	.LFE271-.LFB271
	.4byte	.LFB272
	.4byte	.LFE272-.LFB272
	.4byte	.LFB273
	.4byte	.LFE273-.LFB273
	.4byte	.LFB274
	.4byte	.LFE274-.LFB274
	.4byte	.LFB275
	.4byte	.LFE275-.LFB275
	.4byte	.LFB276
	.4byte	.LFE276-.LFB276
	.4byte	.LFB277
	.4byte	.LFE277-.LFB277
	.4byte	.LFB278
	.4byte	.LFE278-.LFB278
	.4byte	.LFB279
	.4byte	.LFE279-.LFB279
	.4byte	.LFB280
	.4byte	.LFE280-.LFB280
	.4byte	.LFB281
	.4byte	.LFE281-.LFB281
	.4byte	.LFB282
	.4byte	.LFE282-.LFB282
	.4byte	.LFB283
	.4byte	.LFE283-.LFB283
	.4byte	.LFB284
	.4byte	.LFE284-.LFB284
	.4byte	.LFB285
	.4byte	.LFE285-.LFB285
	.4byte	.LFB286
	.4byte	.LFE286-.LFB286
	.4byte	.LFB287
	.4byte	.LFE287-.LFB287
	.4byte	.LFB288
	.4byte	.LFE288-.LFB288
	.4byte	.LFB289
	.4byte	.LFE289-.LFB289
	.4byte	.LFB290
	.4byte	.LFE290-.LFB290
	.4byte	.LFB291
	.4byte	.LFE291-.LFB291
	.4byte	0
	.4byte	0
	.section	.debug_ranges,"",%progbits
.Ldebug_ranges0:
	.4byte	.LFB124
	.4byte	.LFE124
	.4byte	.LFB125
	.4byte	.LFE125
	.4byte	.LFB126
	.4byte	.LFE126
	.4byte	.LFB127
	.4byte	.LFE127
	.4byte	.LFB128
	.4byte	.LFE128
	.4byte	.LFB129
	.4byte	.LFE129
	.4byte	.LFB130
	.4byte	.LFE130
	.4byte	.LFB131
	.4byte	.LFE131
	.4byte	.LFB132
	.4byte	.LFE132
	.4byte	.LFB133
	.4byte	.LFE133
	.4byte	.LFB134
	.4byte	.LFE134
	.4byte	.LFB135
	.4byte	.LFE135
	.4byte	.LFB136
	.4byte	.LFE136
	.4byte	.LFB137
	.4byte	.LFE137
	.4byte	.LFB138
	.4byte	.LFE138
	.4byte	.LFB139
	.4byte	.LFE139
	.4byte	.LFB140
	.4byte	.LFE140
	.4byte	.LFB141
	.4byte	.LFE141
	.4byte	.LFB142
	.4byte	.LFE142
	.4byte	.LFB143
	.4byte	.LFE143
	.4byte	.LFB144
	.4byte	.LFE144
	.4byte	.LFB145
	.4byte	.LFE145
	.4byte	.LFB146
	.4byte	.LFE146
	.4byte	.LFB147
	.4byte	.LFE147
	.4byte	.LFB148
	.4byte	.LFE148
	.4byte	.LFB149
	.4byte	.LFE149
	.4byte	.LFB150
	.4byte	.LFE150
	.4byte	.LFB151
	.4byte	.LFE151
	.4byte	.LFB152
	.4byte	.LFE152
	.4byte	.LFB153
	.4byte	.LFE153
	.4byte	.LFB154
	.4byte	.LFE154
	.4byte	.LFB155
	.4byte	.LFE155
	.4byte	.LFB156
	.4byte	.LFE156
	.4byte	.LFB157
	.4byte	.LFE157
	.4byte	.LFB158
	.4byte	.LFE158
	.4byte	.LFB159
	.4byte	.LFE159
	.4byte	.LFB160
	.4byte	.LFE160
	.4byte	.LFB161
	.4byte	.LFE161
	.4byte	.LFB162
	.4byte	.LFE162
	.4byte	.LFB163
	.4byte	.LFE163
	.4byte	.LFB164
	.4byte	.LFE164
	.4byte	.LFB165
	.4byte	.LFE165
	.4byte	.LFB232
	.4byte	.LFE232
	.4byte	.LFB233
	.4byte	.LFE233
	.4byte	.LFB234
	.4byte	.LFE234
	.4byte	.LFB235
	.4byte	.LFE235
	.4byte	.LFB236
	.4byte	.LFE236
	.4byte	.LFB237
	.4byte	.LFE237
	.4byte	.LFB238
	.4byte	.LFE238
	.4byte	.LFB239
	.4byte	.LFE239
	.4byte	.LFB240
	.4byte	.LFE240
	.4byte	.LFB241
	.4byte	.LFE241
	.4byte	.LFB242
	.4byte	.LFE242
	.4byte	.LFB243
	.4byte	.LFE243
	.4byte	.LFB244
	.4byte	.LFE244
	.4byte	.LFB245
	.4byte	.LFE245
	.4byte	.LFB246
	.4byte	.LFE246
	.4byte	.LFB247
	.4byte	.LFE247
	.4byte	.LFB248
	.4byte	.LFE248
	.4byte	.LFB249
	.4byte	.LFE249
	.4byte	.LFB250
	.4byte	.LFE250
	.4byte	.LFB251
	.4byte	.LFE251
	.4byte	.LFB252
	.4byte	.LFE252
	.4byte	.LFB253
	.4byte	.LFE253
	.4byte	.LFB254
	.4byte	.LFE254
	.4byte	.LFB255
	.4byte	.LFE255
	.4byte	.LFB256
	.4byte	.LFE256
	.4byte	.LFB257
	.4byte	.LFE257
	.4byte	.LFB258
	.4byte	.LFE258
	.4byte	.LFB259
	.4byte	.LFE259
	.4byte	.LFB260
	.4byte	.LFE260
	.4byte	.LFB261
	.4byte	.LFE261
	.4byte	.LFB262
	.4byte	.LFE262
	.4byte	.LFB263
	.4byte	.LFE263
	.4byte	.LFB264
	.4byte	.LFE264
	.4byte	.LFB265
	.4byte	.LFE265
	.4byte	.LFB266
	.4byte	.LFE266
	.4byte	.LFB267
	.4byte	.LFE267
	.4byte	.LFB268
	.4byte	.LFE268
	.4byte	.LFB269
	.4byte	.LFE269
	.4byte	.LFB270
	.4byte	.LFE270
	.4byte	.LFB271
	.4byte	.LFE271
	.4byte	.LFB272
	.4byte	.LFE272
	.4byte	.LFB273
	.4byte	.LFE273
	.4byte	.LFB274
	.4byte	.LFE274
	.4byte	.LFB275
	.4byte	.LFE275
	.4byte	.LFB276
	.4byte	.LFE276
	.4byte	.LFB277
	.4byte	.LFE277
	.4byte	.LFB278
	.4byte	.LFE278
	.4byte	.LFB279
	.4byte	.LFE279
	.4byte	.LFB280
	.4byte	.LFE280
	.4byte	.LFB281
	.4byte	.LFE281
	.4byte	.LFB282
	.4byte	.LFE282
	.4byte	.LFB283
	.4byte	.LFE283
	.4byte	.LFB284
	.4byte	.LFE284
	.4byte	.LFB285
	.4byte	.LFE285
	.4byte	.LFB286
	.4byte	.LFE286
	.4byte	.LFB287
	.4byte	.LFE287
	.4byte	.LFB288
	.4byte	.LFE288
	.4byte	.LFB289
	.4byte	.LFE289
	.4byte	.LFB290
	.4byte	.LFE290
	.4byte	.LFB291
	.4byte	.LFE291
	.4byte	0
	.4byte	0
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF163:
	.ascii	"rxCode\000"
.LASF251:
	.ascii	"block_cfg0\000"
.LASF140:
	.ascii	"request\000"
.LASF253:
	.ascii	"block_cfg2\000"
.LASF254:
	.ascii	"block_cfg3\000"
.LASF151:
	.ascii	"p_key\000"
.LASF127:
	.ascii	"hfclk\000"
.LASF292:
	.ascii	"sd_clock_hfclk_is_running\000"
.LASF272:
	.ascii	"distance\000"
.LASF61:
	.ascii	"LIS2MDL_HIGH_RESOLUTION\000"
.LASF318:
	.ascii	"sd_power_reset_reason_clr\000"
.LASF97:
	.ascii	"SD_RAND_APPLICATION_POOL_CAPACITY_GET\000"
.LASF226:
	.ascii	"lis2mdl_set_rst_sensor_single_get\000"
.LASF237:
	.ascii	"lis2mdl_data_rate_set\000"
.LASF106:
	.ascii	"SD_POWER_RAM_POWER_SET\000"
.LASF303:
	.ascii	"sd_power_gpregret_set\000"
.LASF310:
	.ascii	"ram_powerset\000"
.LASF212:
	.ascii	"lis2mdl_data_format_set\000"
.LASF119:
	.ascii	"SD_ECB_BLOCKS_ENCRYPT\000"
.LASF280:
	.ascii	"sd_ppi_channel_assign\000"
.LASF258:
	.ascii	"p_dst\000"
.LASF287:
	.ascii	"channel_enable_set_msk\000"
.LASF40:
	.ascii	"mroi\000"
.LASF67:
	.ascii	"LIS2MDL_SET_SENS_ODR_DIV_63\000"
.LASF300:
	.ascii	"p_gpregret\000"
.LASF36:
	.ascii	"yien\000"
.LASF168:
	.ascii	"dwt_config_t\000"
.LASF21:
	.ascii	"comp_temp_en\000"
.LASF194:
	.ascii	"lis2mdl_i2c_interface_get\000"
.LASF58:
	.ascii	"LIS2MDL_ODR_50Hz\000"
.LASF37:
	.ascii	"xien\000"
.LASF10:
	.ascii	"unsigned int\000"
.LASF146:
	.ascii	"soc_ecb_cleartext_t\000"
.LASF111:
	.ascii	"SD_POWER_GPREGRET_GET\000"
.LASF141:
	.ascii	"extend\000"
.LASF103:
	.ascii	"SD_POWER_RESET_REASON_CLR\000"
.LASF325:
	.ascii	"sd_rand_application_bytes_available_get\000"
.LASF228:
	.ascii	"lis2mdl_set_rst_mode_get\000"
.LASF209:
	.ascii	"lis2mdl_offset_int_conf_set\000"
.LASF171:
	.ascii	"man_fds_mag_t\000"
.LASF316:
	.ascii	"sd_power_mode_set\000"
.LASF84:
	.ascii	"SD_PPI_CHANNEL_ENABLE_SET\000"
.LASF142:
	.ascii	"callback_action\000"
.LASF178:
	.ascii	"mag_device_found\000"
.LASF169:
	.ascii	"hard_iron\000"
.LASF149:
	.ascii	"ciphertext\000"
.LASF306:
	.ascii	"p_ram_power\000"
.LASF43:
	.ascii	"n_th_s_x\000"
.LASF42:
	.ascii	"n_th_s_y\000"
.LASF41:
	.ascii	"n_th_s_z\000"
.LASF190:
	.ascii	"lis2mdl_magnetic_raw_get_my\000"
.LASF255:
	.ascii	"sd_flash_page_erase\000"
.LASF50:
	.ascii	"zyxor\000"
.LASF75:
	.ascii	"LIS2MDL_CHECK_AFTER\000"
.LASF281:
	.ascii	"channel_num\000"
.LASF308:
	.ascii	"ram_powerclr\000"
.LASF26:
	.ascii	"not_used_01\000"
.LASF33:
	.ascii	"not_used_02\000"
.LASF320:
	.ascii	"sd_power_reset_reason_get\000"
.LASF88:
	.ascii	"SD_PPI_GROUP_TASK_DISABLE\000"
.LASF143:
	.ascii	"nrf_radio_signal_callback_return_param_t\000"
.LASF220:
	.ascii	"lis2mdl_temperature_raw_get\000"
.LASF130:
	.ascii	"timeout_us\000"
.LASF189:
	.ascii	"high_data\000"
.LASF154:
	.ascii	"nrf_ecb_hal_data_block_t\000"
.LASF206:
	.ascii	"lis2mdl_drdy_on_pin_get\000"
.LASF63:
	.ascii	"lis2mdl_lp_t\000"
.LASF246:
	.ascii	"p_request\000"
.LASF311:
	.ascii	"sd_power_pof_threshold_set\000"
.LASF116:
	.ascii	"SD_CLOCK_HFCLK_IS_RUNNING\000"
.LASF9:
	.ascii	"uint32_t\000"
.LASF0:
	.ascii	"int8_t\000"
.LASF191:
	.ascii	"lis2mdl_print_reg\000"
.LASF222:
	.ascii	"lis2mdl_mag_data_ovr_get\000"
.LASF104:
	.ascii	"SD_POWER_POF_ENABLE\000"
.LASF102:
	.ascii	"SD_POWER_RESET_REASON_GET\000"
.LASF203:
	.ascii	"lis2mdl_int_gen_conf_set\000"
.LASF85:
	.ascii	"SD_PPI_CHANNEL_ENABLE_CLR\000"
.LASF192:
	.ascii	"reg_add\000"
.LASF17:
	.ascii	"float\000"
.LASF249:
	.ascii	"p_radio_signal_callback\000"
.LASF144:
	.ascii	"nrf_radio_signal_callback_t\000"
.LASF47:
	.ascii	"lis2mdl_int_source_reg_t\000"
.LASF200:
	.ascii	"lis2mdl_int_gen_treshold_set\000"
.LASF35:
	.ascii	"zien\000"
.LASF185:
	.ascii	"data_ready\000"
.LASF166:
	.ascii	"phrMode\000"
.LASF4:
	.ascii	"int16_t\000"
.LASF124:
	.ascii	"SD_TEMP_GET\000"
.LASF29:
	.ascii	"self_test\000"
.LASF12:
	.ascii	"long long unsigned int\000"
.LASF262:
	.ascii	"p_temp\000"
.LASF20:
	.ascii	"reboot\000"
.LASF219:
	.ascii	"lis2mdl_device_id_get\000"
.LASF309:
	.ascii	"sd_power_ram_power_set\000"
.LASF45:
	.ascii	"p_th_s_y\000"
.LASF298:
	.ascii	"sd_power_gpregret_get\000"
.LASF211:
	.ascii	"lis2mdl_data_format_get\000"
.LASF182:
	.ascii	"lis2mdl_get_temp\000"
.LASF162:
	.ascii	"txCode\000"
.LASF122:
	.ascii	"SD_RADIO_REQUEST\000"
.LASF24:
	.ascii	"int_on_dataoff\000"
.LASF31:
	.ascii	"i2c_dis\000"
.LASF236:
	.ascii	"lis2mdl_data_rate_get\000"
.LASF34:
	.ascii	"lis2mdl_cfg_reg_c_t\000"
.LASF199:
	.ascii	"buff\000"
.LASF183:
	.ascii	"lis2mdl_get_mag_calibrated\000"
.LASF186:
	.ascii	"lis2mdl_init\000"
.LASF250:
	.ascii	"sd_flash_protect\000"
.LASF91:
	.ascii	"SD_FLASH_PAGE_ERASE\000"
.LASF19:
	.ascii	"soft_rst\000"
.LASF302:
	.ascii	"gpregret_msk\000"
.LASF38:
	.ascii	"lis2mdl_int_crtl_reg_t\000"
.LASF89:
	.ascii	"SD_PPI_GROUP_ASSIGN\000"
.LASF188:
	.ascii	"low_data\000"
.LASF208:
	.ascii	"lis2mdl_offset_int_conf_get\000"
.LASF155:
	.ascii	"_Bool\000"
.LASF57:
	.ascii	"LIS2MDL_ODR_20Hz\000"
.LASF83:
	.ascii	"SD_PPI_CHANNEL_ENABLE_GET\000"
.LASF136:
	.ascii	"request_type\000"
.LASF98:
	.ascii	"SD_RAND_APPLICATION_BYTES_AVAILABLE_GET\000"
.LASF39:
	.ascii	"_int\000"
.LASF81:
	.ascii	"LIS2MDL_I2C_DISABLE\000"
.LASF261:
	.ascii	"sd_temp_get\000"
.LASF267:
	.ascii	"p_data_blocks\000"
.LASF307:
	.ascii	"sd_power_ram_power_clr\000"
.LASF49:
	.ascii	"_xor\000"
.LASF25:
	.ascii	"off_canc_one_shot\000"
.LASF313:
	.ascii	"sd_power_pof_enable\000"
.LASF177:
	.ascii	"mag_whoamI\000"
.LASF197:
	.ascii	"lis2mdl_spi_mode_set\000"
.LASF94:
	.ascii	"SD_MUTEX_NEW\000"
.LASF53:
	.ascii	"LIS2MDL_SINGLE_TRIGGER\000"
.LASF77:
	.ascii	"LIS2MDL_SPI_4_WIRE\000"
.LASF48:
	.ascii	"zyxda\000"
.LASF333:
	.ascii	"E:\\matte\\Documents\\uni\\master EIT\\1st year\\2n"
	.ascii	"d semester\\UV\\UWBdrone_estimation\\UWBmodule\\seg"
	.ascii	"ger projects\\rtdoa_acc_mag\\project\\tag\\SES\\LIS"
	.ascii	"2MDL\\lis2mdl_reg.c\000"
.LASF16:
	.ascii	"float_t\000"
.LASF73:
	.ascii	"lis2mdl_ble_t\000"
.LASF129:
	.ascii	"length_us\000"
.LASF161:
	.ascii	"rxPAC\000"
.LASF282:
	.ascii	"evt_endpoint\000"
.LASF159:
	.ascii	"chan\000"
.LASF60:
	.ascii	"lis2mdl_odr_t\000"
.LASF14:
	.ascii	"char\000"
.LASF125:
	.ascii	"SVC_SOC_LAST\000"
.LASF234:
	.ascii	"lis2mdl_power_mode_get\000"
.LASF276:
	.ascii	"sd_ppi_group_assign\000"
.LASF180:
	.ascii	"lis2mdl_print_temp\000"
.LASF147:
	.ascii	"soc_ecb_ciphertext_t\000"
.LASF263:
	.ascii	"sd_evt_get\000"
.LASF68:
	.ascii	"LIS2MDL_SENS_OFF_CANC_EVERY_ODR\000"
.LASF335:
	.ascii	"NRF_SOC_SVCS\000"
.LASF157:
	.ascii	"uint16\000"
.LASF193:
	.ascii	"data\000"
.LASF176:
	.ascii	"lis2mdl_temperature_degC\000"
.LASF115:
	.ascii	"SD_CLOCK_HFCLK_RELEASE\000"
.LASF95:
	.ascii	"SD_MUTEX_ACQUIRE\000"
.LASF202:
	.ascii	"lis2mdl_int_gen_conf_get\000"
.LASF1:
	.ascii	"uint8_t\000"
.LASF175:
	.ascii	"magnetic_mG\000"
.LASF245:
	.ascii	"lis2mdl_read_reg\000"
.LASF179:
	.ascii	"mag_config\000"
.LASF123:
	.ascii	"SD_EVT_GET\000"
.LASF198:
	.ascii	"lis2mdl_int_gen_treshold_get\000"
.LASF296:
	.ascii	"sd_power_dcdc_mode_set\000"
.LASF112:
	.ascii	"SD_POWER_DCDC_MODE_SET\000"
.LASF241:
	.ascii	"lis2mdl_mag_user_offset_set\000"
.LASF328:
	.ascii	"p_pool_capacity\000"
.LASF217:
	.ascii	"lis2mdl_reset_get\000"
.LASF118:
	.ascii	"SD_ECB_BLOCK_ENCRYPT\000"
.LASF304:
	.ascii	"sd_power_ram_power_get\000"
.LASF11:
	.ascii	"long long int\000"
.LASF174:
	.ascii	"lis2mdl_data_raw_temperature\000"
.LASF74:
	.ascii	"LIS2MDL_CHECK_BEFORE\000"
.LASF117:
	.ascii	"SD_RADIO_NOTIFICATION_CFG_SET\000"
.LASF22:
	.ascii	"lis2mdl_cfg_reg_a_t\000"
.LASF214:
	.ascii	"lis2mdl_self_test_set\000"
.LASF96:
	.ascii	"SD_MUTEX_RELEASE\000"
.LASF52:
	.ascii	"LIS2MDL_CONTINUOUS_MODE\000"
.LASF314:
	.ascii	"pof_enable\000"
.LASF235:
	.ascii	"lis2mdl_power_mode_set\000"
.LASF218:
	.ascii	"lis2mdl_reset_set\000"
.LASF114:
	.ascii	"SD_CLOCK_HFCLK_REQUEST\000"
.LASF164:
	.ascii	"nsSFD\000"
.LASF279:
	.ascii	"sd_ppi_group_task_enable\000"
.LASF216:
	.ascii	"lis2mdl_boot_set\000"
.LASF334:
	.ascii	"E:\\matte\\Documents\\uni\\master EIT\\1st year\\2n"
	.ascii	"d semester\\UV\\UWBdrone_estimation\\UWBmodule\\seg"
	.ascii	"ger projects\\rtdoa_acc_mag\\project\\tag\\SES\000"
.LASF59:
	.ascii	"LIS2MDL_ODR_100Hz\000"
.LASF248:
	.ascii	"sd_radio_session_open\000"
.LASF133:
	.ascii	"nrf_radio_request_normal_t\000"
.LASF260:
	.ascii	"size\000"
.LASF170:
	.ascii	"soft_iron\000"
.LASF105:
	.ascii	"SD_POWER_POF_THRESHOLD_SET\000"
.LASF301:
	.ascii	"sd_power_gpregret_clr\000"
.LASF138:
	.ascii	"nrf_radio_request_t\000"
.LASF315:
	.ascii	"sd_power_system_off\000"
.LASF181:
	.ascii	"lis2mdl_print_mag\000"
.LASF113:
	.ascii	"SD_APP_EVT_WAIT\000"
.LASF82:
	.ascii	"lis2mdl_i2c_dis_t\000"
.LASF233:
	.ascii	"lis2mdl_offset_temp_comp_set\000"
.LASF285:
	.ascii	"channel_enable_clr_msk\000"
.LASF30:
	.ascii	"_4wspi\000"
.LASF277:
	.ascii	"channel_msk\000"
.LASF243:
	.ascii	"lis2mdl_from_lsb_to_mgauss\000"
.LASF70:
	.ascii	"lis2mdl_set_rst_t\000"
.LASF291:
	.ascii	"sd_app_evt_wait\000"
.LASF270:
	.ascii	"sd_radio_notification_cfg_set\000"
.LASF294:
	.ascii	"sd_clock_hfclk_release\000"
.LASF66:
	.ascii	"lis2mdl_lpf_t\000"
.LASF336:
	.ascii	"sd_mutex_new\000"
.LASF15:
	.ascii	"long double\000"
.LASF268:
	.ascii	"sd_ecb_block_encrypt\000"
.LASF6:
	.ascii	"uint16_t\000"
.LASF317:
	.ascii	"power_mode\000"
.LASF80:
	.ascii	"LIS2MDL_I2C_ENABLE\000"
.LASF264:
	.ascii	"p_evt_id\000"
.LASF28:
	.ascii	"drdy_on_pin\000"
.LASF153:
	.ascii	"p_ciphertext\000"
.LASF3:
	.ascii	"unsigned char\000"
.LASF86:
	.ascii	"SD_PPI_CHANNEL_ASSIGN\000"
.LASF172:
	.ascii	"config\000"
.LASF137:
	.ascii	"params\000"
.LASF266:
	.ascii	"block_count\000"
.LASF256:
	.ascii	"page_number\000"
.LASF332:
	.ascii	"GNU C99 10.3.1 20210824 (release) -fmessage-length="
	.ascii	"0 -std=gnu99 -mcpu=cortex-m4 -mlittle-endian -mfloa"
	.ascii	"t-abi=hard -mfpu=fpv4-sp-d16 -mthumb -mtp=soft -mfp"
	.ascii	"16-format=ieee -munaligned-access -gdwarf-4 -g2 -gp"
	.ascii	"ubnames -fomit-frame-pointer -fno-dwarf2-cfi-asm -f"
	.ascii	"function-sections -fdata-sections -fshort-enums -fn"
	.ascii	"o-common\000"
.LASF5:
	.ascii	"short int\000"
.LASF231:
	.ascii	"lis2mdl_low_pass_bandwidth_set\000"
.LASF322:
	.ascii	"sd_rand_application_vector_get\000"
.LASF244:
	.ascii	"lis2mdl_write_reg\000"
.LASF13:
	.ascii	"long int\000"
.LASF305:
	.ascii	"index\000"
.LASF330:
	.ascii	"p_mutex\000"
.LASF87:
	.ascii	"SD_PPI_GROUP_TASK_ENABLE\000"
.LASF324:
	.ascii	"length\000"
.LASF247:
	.ascii	"sd_radio_request\000"
.LASF132:
	.ascii	"distance_us\000"
.LASF128:
	.ascii	"priority\000"
.LASF295:
	.ascii	"sd_clock_hfclk_request\000"
.LASF319:
	.ascii	"reset_reason_clr_msk\000"
.LASF69:
	.ascii	"LIS2MDL_SET_SENS_ONLY_AT_POWER_ON\000"
.LASF196:
	.ascii	"lis2mdl_spi_mode_get\000"
.LASF139:
	.ascii	"p_next\000"
.LASF326:
	.ascii	"p_bytes_available\000"
.LASF240:
	.ascii	"lis2mdl_mag_user_offset_get\000"
.LASF167:
	.ascii	"sfdTO\000"
.LASF239:
	.ascii	"lis2mdl_operating_mode_set\000"
.LASF299:
	.ascii	"gpregret_id\000"
.LASF327:
	.ascii	"sd_rand_application_pool_capacity_get\000"
.LASF62:
	.ascii	"LIS2MDL_LOW_POWER\000"
.LASF101:
	.ascii	"SD_POWER_SYSTEM_OFF\000"
.LASF121:
	.ascii	"SD_RADIO_SESSION_CLOSE\000"
.LASF184:
	.ascii	"lis2mdl_get_mag\000"
.LASF120:
	.ascii	"SD_RADIO_SESSION_OPEN\000"
.LASF213:
	.ascii	"lis2mdl_self_test_get\000"
.LASF223:
	.ascii	"lis2mdl_mag_data_ready_get\000"
.LASF265:
	.ascii	"sd_ecb_blocks_encrypt\000"
.LASF150:
	.ascii	"nrf_ecb_hal_data_t\000"
.LASF51:
	.ascii	"lis2mdl_status_reg_t\000"
.LASF205:
	.ascii	"lis2mdl_int_on_pin_set\000"
.LASF165:
	.ascii	"dataRate\000"
.LASF56:
	.ascii	"LIS2MDL_ODR_10Hz\000"
.LASF107:
	.ascii	"SD_POWER_RAM_POWER_CLR\000"
.LASF257:
	.ascii	"sd_flash_write\000"
.LASF221:
	.ascii	"lis2mdl_magnetic_raw_get\000"
.LASF227:
	.ascii	"lis2mdl_set_rst_sensor_single_set\000"
.LASF160:
	.ascii	"txPreambLength\000"
.LASF158:
	.ascii	"long unsigned int\000"
.LASF215:
	.ascii	"lis2mdl_boot_get\000"
.LASF100:
	.ascii	"SD_POWER_MODE_SET\000"
.LASF297:
	.ascii	"dcdc_mode\000"
.LASF8:
	.ascii	"int32_t\000"
.LASF284:
	.ascii	"sd_ppi_channel_enable_clr\000"
.LASF225:
	.ascii	"lis2mdl_block_data_update_set\000"
.LASF286:
	.ascii	"sd_ppi_channel_enable_set\000"
.LASF232:
	.ascii	"lis2mdl_offset_temp_comp_get\000"
.LASF135:
	.ascii	"normal\000"
.LASF289:
	.ascii	"p_channel_enable\000"
.LASF76:
	.ascii	"lis2mdl_int_on_dataoff_t\000"
.LASF271:
	.ascii	"type\000"
.LASF195:
	.ascii	"lis2mdl_i2c_interface_set\000"
.LASF275:
	.ascii	"p_channel_msk\000"
.LASF201:
	.ascii	"lis2mdl_int_gen_source_get\000"
.LASF109:
	.ascii	"SD_POWER_GPREGRET_SET\000"
.LASF273:
	.ascii	"sd_ppi_group_get\000"
.LASF78:
	.ascii	"LIS2MDL_SPI_3_WIRE\000"
.LASF229:
	.ascii	"lis2mdl_set_rst_mode_set\000"
.LASF145:
	.ascii	"soc_ecb_key_t\000"
.LASF32:
	.ascii	"int_on_pin\000"
.LASF274:
	.ascii	"group_num\000"
.LASF173:
	.ascii	"data_raw_magnetic\000"
.LASF278:
	.ascii	"sd_ppi_group_task_disable\000"
.LASF64:
	.ascii	"LIS2MDL_ODR_DIV_2\000"
.LASF46:
	.ascii	"p_th_s_x\000"
.LASF93:
	.ascii	"SD_FLASH_PROTECT\000"
.LASF44:
	.ascii	"p_th_s_z\000"
.LASF90:
	.ascii	"SD_PPI_GROUP_GET\000"
.LASF187:
	.ascii	"lis2mdl_temperature_raw_get_my\000"
.LASF65:
	.ascii	"LIS2MDL_ODR_DIV_4\000"
.LASF210:
	.ascii	"lis2mdl_status_get\000"
.LASF152:
	.ascii	"p_cleartext\000"
.LASF312:
	.ascii	"threshold\000"
.LASF331:
	.ascii	"sd_mutex_acquire\000"
.LASF108:
	.ascii	"SD_POWER_RAM_POWER_GET\000"
.LASF71:
	.ascii	"LIS2MDL_LSB_AT_LOW_ADD\000"
.LASF293:
	.ascii	"p_is_running\000"
.LASF27:
	.ascii	"lis2mdl_cfg_reg_b_t\000"
.LASF99:
	.ascii	"SD_RAND_APPLICATION_VECTOR_GET\000"
.LASF2:
	.ascii	"signed char\000"
.LASF242:
	.ascii	"lis2mdl_from_lsb_to_celsius\000"
.LASF230:
	.ascii	"lis2mdl_low_pass_bandwidth_get\000"
.LASF79:
	.ascii	"lis2mdl_sim_t\000"
.LASF259:
	.ascii	"p_src\000"
.LASF7:
	.ascii	"short unsigned int\000"
.LASF321:
	.ascii	"p_reset_reason\000"
.LASF134:
	.ascii	"earliest\000"
.LASF207:
	.ascii	"lis2mdl_drdy_on_pin_set\000"
.LASF288:
	.ascii	"sd_ppi_channel_enable_get\000"
.LASF156:
	.ascii	"uint8\000"
.LASF18:
	.ascii	"double\000"
.LASF148:
	.ascii	"cleartext\000"
.LASF110:
	.ascii	"SD_POWER_GPREGRET_CLR\000"
.LASF283:
	.ascii	"task_endpoint\000"
.LASF329:
	.ascii	"sd_mutex_release\000"
.LASF54:
	.ascii	"LIS2MDL_POWER_DOWN\000"
.LASF92:
	.ascii	"SD_FLASH_WRITE\000"
.LASF323:
	.ascii	"p_buff\000"
.LASF72:
	.ascii	"LIS2MDL_MSB_AT_LOW_ADD\000"
.LASF238:
	.ascii	"lis2mdl_operating_mode_get\000"
.LASF224:
	.ascii	"lis2mdl_block_data_update_get\000"
.LASF131:
	.ascii	"nrf_radio_request_earliest_t\000"
.LASF269:
	.ascii	"p_ecb_data\000"
.LASF126:
	.ascii	"nrf_mutex_t\000"
.LASF252:
	.ascii	"block_cfg1\000"
.LASF23:
	.ascii	"set_rst\000"
.LASF290:
	.ascii	"sd_radio_session_close\000"
.LASF55:
	.ascii	"lis2mdl_md_t\000"
.LASF204:
	.ascii	"lis2mdl_int_on_pin_get\000"
	.ident	"GCC: (based on arm-10.3-2021.10 GCC) 10.3.1 20210824 (release)"
