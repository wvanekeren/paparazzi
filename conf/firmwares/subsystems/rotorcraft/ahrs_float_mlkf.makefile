# Hey Emacs, this is a -*- makefile -*-
#
#

USE_MAGNETOMETER ?= 1
AHRS_ALIGNER_LED ?= none

AHRS_CFLAGS  = -DUSE_AHRS -DAHRS_FLOAT
AHRS_CFLAGS += -DUSE_AHRS_ALIGNER

ifeq (,$(findstring $(USE_MAGNETOMETER),0 FALSE))
  AHRS_CFLAGS += -DUSE_MAGNETOMETER
else
$(error ahrs_float_mlkf needs a magnetometer)
endif

ifneq ($(AHRS_ALIGNER_LED),none)
  AHRS_CFLAGS += -DAHRS_ALIGNER_LED=$(AHRS_ALIGNER_LED)
endif

AHRS_CFLAGS += -DAHRS_TYPE_H=\"subsystems/ahrs/ahrs_float_mlkf.h\"
AHRS_SRCS   += subsystems/ahrs.c
AHRS_SRCS   += subsystems/ahrs/ahrs_float_mlkf.c
AHRS_SRCS   += subsystems/ahrs/ahrs_aligner.c

ap.CFLAGS += $(AHRS_CFLAGS)
ap.srcs += $(AHRS_SRCS)

nps.CFLAGS += $(AHRS_CFLAGS)
nps.srcs += $(AHRS_SRCS)
