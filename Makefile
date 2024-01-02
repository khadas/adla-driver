ifeq ($(Building_Yocto), 1)
KERNEL_SRC := $(KDIR)
unexport Building_Yocto
else
# specified buildroot kernel src
KERNEL_SRC :=
endif

LOCAL_PATH=$(CURDIR)



HAS_PM_DOMAIN ?= 1
DEBUG ?= 0

ifeq ($(DEBUG),1)
EXTRA_CFLAGS1 += -DCONFIG_ADLAK_DEBUG=1
endif


ifeq ($(HAS_PM_DOMAIN),0)
EXTRA_CFLAGS1 += -DCONFIG_HAS_PM_DOMAIN=0
endif


EXTRA_INCLUDE := -I $(LOCAL_PATH)/adla/kmd/drv/port/platform/linux
EXTRA_INCLUDE += -I $(LOCAL_PATH)/adla/kmd/drv/port/platform
EXTRA_INCLUDE += -I $(LOCAL_PATH)/adla/kmd/drv/port/os/linux/mm
EXTRA_INCLUDE += -I $(LOCAL_PATH)/adla/kmd/drv/port/os/linux
EXTRA_INCLUDE += -I $(LOCAL_PATH)/adla/kmd/drv/port/os
EXTRA_INCLUDE += -I $(LOCAL_PATH)/adla/kmd/drv/port
EXTRA_INCLUDE += -I $(LOCAL_PATH)/adla/kmd/drv/uapi/linux
EXTRA_INCLUDE += -I $(LOCAL_PATH)/adla/kmd/drv/uapi
EXTRA_INCLUDE += -I $(LOCAL_PATH)/adla/kmd/drv/common/mm
EXTRA_INCLUDE += -I $(LOCAL_PATH)/adla/kmd/drv/common
EXTRA_INCLUDE += -I $(LOCAL_PATH)/adla/kmd/drv


modules:
	$(MAKE) -C $(KERNEL_SRC) M=$(LOCAL_PATH)/adla/kmd  modules "EXTRA_LDFLAGS+=$(EXTRA_LDFLAGS1)" "EXTRA_CFLAGS+= -Wno-error $(EXTRA_CFLAGS1)  $(EXTRA_INCLUDE)"


all:modules


clean:
	$(MAKE) -C $(KERNEL_SRC) M=$(LOCAL_PATH)/adla/kmd clean

help:
	$(MAKE) -C $(KERNEL_SRC) M=$(LOCAL_PATH)/adla/kmd help

