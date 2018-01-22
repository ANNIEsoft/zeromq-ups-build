# ======================================================================
#  Build file for the zeromq ups product
#
#  cd /path/to/build/directory
#  source /path/to/zeromq-ups-build/ups/setup_for_development <-d|-o|-p>
#  buildtool -I "/path/to/install/location" -bti [-jN]
# ======================================================================

# use cmake 2.8 or later
cmake_minimum_required (VERSION 2.8)

project(zeromq-ups)

# cetbuildtools contains our cmake modules
set( CETBUILDTOOLS_VERSION $ENV{CETBUILDTOOLS_VERSION} )
if( NOT CETBUILDTOOLS_VERSION )
  message( FATAL_ERROR "ERROR: setup cetbuildtools to get the cmake modules" )
endif()
set(CMAKE_MODULE_PATH $ENV{CETBUILDTOOLS_DIR}/Modules ${CMAKE_MODULE_PATH})

include(CetCMakeEnv)
cet_cmake_env()

# these are minimum required versions, not the actual product versions
find_ups_product( cetbuildtools v2_03_00 )

cet_check_gcc()

# ups - table and config files
add_subdirectory(ups)

# packaging utility - enable building a package tarball
include(UseCPack)

include(ExternalProject)

set(UPS_PRODUCT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR})

#message("${UPS_PRODUCT_SOURCE_DIR}/zeromq.txt")

# Retrieve the appropriate version of 0MQ from the public git
# repository, then use GNU make to build it
ExternalProject_Add(zeromq
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/zeromq
  STAMP_DIR ${CMAKE_CURRENT_BINARY_DIR}/stamp
  TMP_DIR  ${CMAKE_CURRENT_BINARY_DIR}/tmp
  GIT_REPOSITORY https://github.com/ToolDAQ/zeromq-4.0.7.git
  SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/zeromq-4.0.7
  BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/zeromq-4.0.7
  UPDATE_COMMAND ${CMAKE_COMMAND} -E remove -f
    ${CMAKE_CURRENT_BINARY_DIR}/zeromq-4.0.7/CMakeLists.txt
    COMMAND ${CMAKE_COMMAND} -E copy ${UPS_PRODUCT_SOURCE_DIR}/zeromq.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/zeromq-4.0.7
    COMMAND ${CMAKE_COMMAND} -E rename
    ${CMAKE_CURRENT_BINARY_DIR}/zeromq-4.0.7/zeromq.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/zeromq-4.0.7/CMakeLists.txt
  INSTALL_COMMAND ""
)

ExternalProject_Get_Property(zeromq binary_dir)
ExternalProject_Get_Property(zeromq source_dir)

# Use CMake to install the files since it is aware of the ups product
# layout defined by cetbuildtools
install(DIRECTORY ${binary_dir}/lib DESTINATION ${${product}_lib_dir}/..)
install(DIRECTORY ${source_dir}/include DESTINATION ${${product}_inc_dir}/..)
install(FILES ${source_dir}/README.md ${source_dir}/COPYING
  DESTINATION ${product}/${version})
