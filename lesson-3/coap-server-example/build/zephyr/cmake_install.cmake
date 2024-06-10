# Install script for directory: E:/Programas/ncs/v2.3.0/zephyr

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "C:/Program Files/Zephyr-Kernel")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "TRUE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "E:/Programas/ncs/toolchains/v2.3.0/opt/zephyr-sdk/arm-zephyr-eabi/bin/arm-zephyr-eabi-objdump.exe")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/arch/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/lib/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/soc/arm/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/boards/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/drivers/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/nrf/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/hostap/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/mcuboot/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/mbedtls/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/trusted-firmware-m/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/cjson/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/azure-sdk-for-c/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/memfault-firmware-sdk/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/cirrus-logic/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/openthread/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/canopennode/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/chre/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/cmsis/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/fatfs/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/hal_nordic/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/st/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/hal_wurthelektronik/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/libmetal/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/liblc3/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/littlefs/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/loramac-node/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/lvgl/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/lz4/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/mipi-sys-t/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/nanopb/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/nrf_hw_models/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/open-amp/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/picolibc/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/segger/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/tinycbor/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/tinycrypt/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/TraceRecorder/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/uoscore-uedhoc/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/zcbor/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/zscilib/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/nrfxlib/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/modules/connectedhomeip/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/kernel/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/cmake/flash/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/cmake/usage/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/cmake/reports/cmake_install.cmake")
endif()

