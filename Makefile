obj-m += module/misc-modules/
obj-m += module/scull/

module/misc-modules-y := hello.o faulty.o

all:
    make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
    make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
