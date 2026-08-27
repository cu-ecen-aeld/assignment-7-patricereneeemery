obj-m :=
obj-m += misc-modules/
obj-m += scull/

misc-modules-y := hello.o faulty.o seq.o jiq.o jit.o silly.o sleepy.o kdataalign.o kdatasize.o complete.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
