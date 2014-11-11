UNAME := $(shell uname)

# MAC OS Build
ifeq ($(UNAME), Darwin)
	BITTINESS = -m64
	CXX = c++ ${BITTINESS}
endif

# Linux Build
ifeq ($(UNAME), Linux)
	CXX = c++
endif

All:
	make action_message_rb

action_message_rb:
	protoc --beefcake_out ./lib -I . ActionMessage.proto

clean:
	rm ./lib/*
