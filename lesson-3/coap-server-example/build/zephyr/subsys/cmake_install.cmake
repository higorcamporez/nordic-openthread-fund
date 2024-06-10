# Install script for directory: E:/Programas/ncs/v2.3.0/zephyr/subsys

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
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/debug/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/logging/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/cpp/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/fs/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/ipc/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/mgmt/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/net/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/usb/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/random/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/storage/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/settings/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/fb/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/portability/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/pm/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/stats/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/task_wdt/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/testsuite/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/tracing/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/canbus/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/modbus/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/sd/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("E:/Projects/estagio/openthread-fund/lessons/nordic-openthread-fund/aula-3/coap-server-example/build/zephyr/subsys/rtio/cmake_install.cmake")
endif()
