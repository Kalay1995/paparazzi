# Hey Emacs, this is a -*- makefile -*-

# attitude estimation for fixedwings using infrared sensors

#
# default values for tiny and twog are:
# ADC_IR1    = ADC_1
# ADC_IR2    = ADC_2
# ADC_IR_TOP = ADC_0
# ADC_IR_NB_SAMPLES = 16
#
# to change just redefine these before including this file
#

#
# LPC only has one ADC
#
ifeq ($(ARCH), lpc21)
ap.CFLAGS += -DADC_CHANNEL_IR1=$(ADC_IR1) -DUSE_$(ADC_IR1)
ap.CFLAGS += -DADC_CHANNEL_IR2=$(ADC_IR2) -DUSE_$(ADC_IR2)
ap.CFLAGS += -DADC_CHANNEL_IR_TOP=$(ADC_IR_TOP) -DUSE_$(ADC_IR_TOP)
endif

#
# On STM32 let's hardwire infrared sensors to AD1 for now
#
ifeq ($(ARCH), stm32)
ap.CFLAGS += -DUSE_AD1
ap.CFLAGS += -DADC_CHANNEL_IR1=$(ADC_IR1_CHAN) -DUSE_AD1_$(ADC_IR1)
ap.CFLAGS += -DADC_CHANNEL_IR2=$(ADC_IR2_CHAN) -DUSE_AD1_$(ADC_IR2)
ap.CFLAGS += -DADC_CHANNEL_IR_TOP=$(ADC_IR_TOP_CHAN) -DUSE_AD1_$(ADC_IR_TOP)
endif

ap.CFLAGS += -DADC_CHANNEL_IR_NB_SAMPLES=$(ADC_IR_NB_SAMPLES)

$(TARGET).CFLAGS += -DUSE_INFRARED
$(TARGET).srcs += subsystems/sensors/infrared.c
$(TARGET).srcs += subsystems/sensors/infrared_adc.c



$(TARGET).CFLAGS += -DAHRS_TYPE_H=\"subsystems/ahrs/ahrs_infrared.h\"
$(TARGET).CFLAGS += -DUSE_AHRS

$(TARGET).srcs   += $(SRC_SUBSYSTEMS)/ahrs.c
$(TARGET).srcs   += $(SRC_SUBSYSTEMS)/ahrs/ahrs_infrared.c


ifeq ($(TARGET), sim)

sim.srcs += $(SRC_ARCH)/sim_ir.c

endif

