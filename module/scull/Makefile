ifeq ($(KERNELRELEASE),)

KERNELDIR ?= /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

modules:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules

clean:
	rm -rf *.o *~ core .depend .*.cmd *.ko *.mod.c .tmp_versions *.mod \
	modules.order *.symvers

.PHONY: modules clean

else
	EXTRA_CFLAGS += -I$(src)/../../include

	obj-m      := scull.o
	scull-objs := main.o pipe.o access.o
endif

