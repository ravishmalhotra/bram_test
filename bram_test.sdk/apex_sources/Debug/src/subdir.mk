################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/debug.c \
../src/freq_counter.c \
../src/main.c \
../src/oscillator.c \
../src/parser.c \
../src/platform.c \
../src/site.c \
../src/uart.c 

OBJS += \
./src/debug.o \
./src/freq_counter.o \
./src/main.o \
./src/oscillator.o \
./src/parser.o \
./src/platform.o \
./src/site.o \
./src/uart.o 

C_DEPS += \
./src/debug.d \
./src/freq_counter.d \
./src/main.d \
./src/oscillator.d \
./src/parser.d \
./src/platform.d \
./src/site.d \
./src/uart.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM gcc compiler'
	arm-xilinx-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -I../../apex_sources_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


