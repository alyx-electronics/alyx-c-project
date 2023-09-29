cmake_minimum_required(VERSION 3.13)

# Set project data
set(PROJECT_NAME "Alyx Base Project")
set(BUILD_NUMBER "1")

# Set app name(s) and version(s)
set(DMO_NAME "DEMO")
set(DMO_VERSION_NUMBER "1")

# Specify the app(s) source code
set(DEMO_SRC_DIRECTORY "${CMAKE_SOURCE_DIR}/demo")

# initialize pico-sdk from GIT
# (note this can come from environment, CMake cache etc)
set(PICO_SDK_FETCH_FROM_GIT on)

# pico_sdk_import.cmake is a single file copied from this SDK
# note: this must happen before project()
include(pico_sdk_import.cmake)
include(${PICO_SDK_PATH}/pico_sdk_init.cmake)

# name of the Project
project(${PROJECT_NAME})

# initialize the Raspberry Pi Pico SDK
pico_sdk_init()

# Include the apps' source code
add_subdirectory(${DEMO_SRC_DIRECTORY})
