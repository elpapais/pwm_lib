# arduino_due_toolchain.cmake: toolchain file for arduino due 

include (CMakeForceCompiler)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

# checking environment variable ARDUINO_DUE_SOURCE_PATH
if( 
  NOT (DEFINED ENV{ARDUINO_DUE_ROOT_PATH})
  OR 
  ($ENV{ARDUINO_DUE_ROOT_PATH} EQUAL "")
)

  message(FATAL_ERROR "[ERROR] Environment variable ARDUINO_DUE_ROOT_PATH not set!")

else()

  message(STATUS "Environment variable ARDUINO_DUE_ROOT_PATH: $ENV{ARDUINO_DUE_ROOT_PATH}")

endif()

function(find_due_program DUE_PROGRAM_PATH DUE_PROGRAM WHERE)

  find_program(
    ${DUE_PROGRAM_PATH} 
    ${DUE_PROGRAM}
    PATH ${WHERE}
    NO_SYSTEM_ENVIRONMENT_PATH
  )
  if(NOT ${DUE_PROGRAM_PATH})
    message(FATAL_ERROR "[ERROR] \"${DUE_PROGRAM}\" not found!")
  else()
    message(STATUS "\"${DUE_PROGRAM}\" found: ${${DUE_PROGRAM_PATH}}")
  endif()

endfunction(find_due_program)

find_due_program(
  DUE_CC 
  arm-none-eabi-gcc 
  $ENV{ARDUINO_DUE_ROOT_PATH}/tools/arm-none-eabi-gcc/4.8.3-2014q1/bin
)
find_due_program(
  DUE_CXX 
  arm-none-eabi-g++ 
  $ENV{ARDUINO_DUE_ROOT_PATH}/tools/arm-none-eabi-gcc/4.8.3-2014q1/bin
)
find_due_program(
  DUE_OBJCOPY 
  arm-none-eabi-objcopy
  $ENV{ARDUINO_DUE_ROOT_PATH}/tools/arm-none-eabi-gcc/4.8.3-2014q1/bin
)
find_due_program(
  DUE_SIZE_TOOL 
  arm-none-eabi-size
  $ENV{ARDUINO_DUE_ROOT_PATH}/tools/arm-none-eabi-gcc/4.8.3-2014q1/bin
)
find_due_program(
  DUE_OBJDUMP 
  arm-none-eabi-objdump
  $ENV{ARDUINO_DUE_ROOT_PATH}/tools/arm-none-eabi-gcc/4.8.3-2014q1/bin
)
find_due_program(
  DUE_BOSSAC 
  bossac
  $ENV{ARDUINO_DUE_ROOT_PATH}/tools/bossac/1.6.1-arduino
)

CMAKE_FORCE_C_COMPILER(${DUE_CC} arduino_due_arm)
CMAKE_FORCE_CXX_COMPILER(${DUE_CXX} arduino_due_arm)

include_directories(
  $ENV{ARDUINO_DUE_ROOT_PATH}/hardware/sam/1.6.6/system/libsam
  $ENV{ARDUINO_DUE_ROOT_PATH}/hardware/sam/1.6.6/system/CMSIS/CMSIS/Include
  $ENV{ARDUINO_DUE_ROOT_PATH}/hardware/sam/1.6.6/system/CMSIS/Device/ATMEL $ENV{ARDUINO_DUE_ROOT_PATH}/hardware/sam/1.6.6/cores/arduino 
  $ENV{ARDUINO_DUE_ROOT_PATH}/hardware/sam/1.6.6/cores/arduino/USB
  $ENV{ARDUINO_DUE_ROOT_PATH}/hardware/sam/1.6.6/variants/arduino_due_x
)


