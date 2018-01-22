# Dummy CMakeLists.txt for building 0MQ
cmake_minimum_required(VERSION 2.8)

project(zeromq)

set(TEMP_INSTALL_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../temp-install)

add_custom_target(zeromq ALL
  COMMAND mkdir -p ../temp-install
  COMMAND ./configure --prefix=${TEMP_INSTALL_DIR}
  COMMAND make
  COMMAND make install
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)
