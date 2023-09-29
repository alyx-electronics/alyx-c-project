cmake_minimum_required(VERSION 3.13)

# Make project data accessible to compiler
add_compile_definitions(DEMO_NAME="${DEMO_NAME}")
add_compile_definitions(DEMO_VERSION="${DEMO_VERSION_NUMBER}")
add_compile_definitions(BUILD_NUM=${BUILD_NUMBER})

# add the executable
add_executable(hello_usb
    ${DEMO_SRC_DIRECTORY}/hello_usb.c
    )
add_executable(blink
    ${DEMO_SRC_DIRECTORY}/blink.c
    )

# pull in common dependencies
target_link_libraries(hello_usb pico_stdlib)
target_link_libraries(blink pico_stdlib hardware_gpio)

# enable usb output, disable uart output
pico_enable_stdio_usb(hello_usb 1)
pico_enable_stdio_uart(hello_usb 0)

# create map/bin/hex/uf2 file in addition to ELF.
pico_add_extra_outputs(hello_usb)
pico_add_extra_outputs(blink)
