if (DEFINED ENV{ALYX_HEADER_PATH} AND (NOT ALYX_HEADER_PATH))
    set(ALYX_HEADER_PATH $ENV{ALYX_HEADER_PATH})
    message("Using ALYX_HEADER_PATH from environment ('${ALYX_HEADER_PATH}')")
endif ()

if (DEFINED ENV{ALYX_HEADER_FETCH_FROM_GIT} AND (NOT ALYX_HEADER_FETCH_FROM_GIT))
    set(ALYX_HEADER_FETCH_FROM_GIT $ENV{ALYX_HEADER_FETCH_FROM_GIT})
    message("Using ALYX_HEADER_FETCH_FROM_GIT from environment ('${ALYX_HEADER_FETCH_FROM_GIT}')")
endif ()

if (DEFINED ENV{ALYX_HEADER_FETCH_FROM_GIT_PATH} AND (NOT ALYX_HEADER_FETCH_FROM_GIT_PATH))
    set(ALYX_HEADER_FETCH_FROM_GIT_PATH $ENV{ALYX_HEADER_FETCH_FROM_GIT_PATH})
    message("Using ALYX_HEADER_FETCH_FROM_GIT_PATH from environment ('${ALYX_HEADER_FETCH_FROM_GIT_PATH}')")
endif ()

if (NOT ALYX_HEADER_PATH)
    if (ALYX_HEADER_FETCH_FROM_GIT)
        include(FetchContent)
        set(FETCHCONTENT_BASE_DIR_SAVE ${FETCHCONTENT_BASE_DIR})
        if (ALYX_HEADER_FETCH_FROM_GIT_PATH)
            get_filename_component(FETCHCONTENT_BASE_DIR "${ALYX_HEADER_FETCH_FROM_GIT_PATH}" REALPATH BASE_DIR "${CMAKE_SOURCE_DIR}")
        endif ()
        FetchContent_Declare(
                alyx_header
                GIT_REPOSITORY https://github.com/alyx-electronics/alyx-c-headers.git
                GIT_TAG main
        )
        if (NOT alyx_header)
            message("Downloading Alyx C Headers ...")
            FetchContent_Populate(alyx_header)
            set(ALYX_HEADER_PATH ${alyx_header_SOURCE_DIR})
        endif ()
        set(FETCHCONTENT_BASE_DIR ${FETCHCONTENT_BASE_DIR_SAVE})
    else ()
        if (PICO_SDK_PATH AND EXISTS "${PICO_SDK_PATH}/../alyx-c-header")
            set(ALYX_HEADER_PATH ${PICO_SDK_PATH}/../alyx-c-header)
            message("Defaulting ALYX_HEADER_PATH as sibling of PICO_SDK_PATH: ${ALYX_HEADER_PATH}")
        else()
            message(FATAL_ERROR
                    "Alyx C Header location was not specified. Please set ALYX_HEADER_PATH or set ALYX_HEADER_FETCH_FROM_GIT to on to fetch from git."
                    )
        endif()
    endif ()
endif ()

set(ALYX_HEADER_PATH "${ALYX_HEADER_PATH}" CACHE PATH "Path to the PICO EXTRAS")
set(ALYX_HEADER_FETCH_FROM_GIT "${ALYX_HEADER_FETCH_FROM_GIT}" CACHE BOOL "Set to ON to fetch copy of Alyx C Headers from git if not otherwise locatable")
set(ALYX_HEADER_FETCH_FROM_GIT_PATH "${ALYX_HEADER_FETCH_FROM_GIT_PATH}" CACHE FILEPATH "location to download Alyx C Headers")

get_filename_component(ALYX_HEADER_PATH "${ALYX_HEADER_PATH}" REALPATH BASE_DIR "${CMAKE_BINARY_DIR}")
if (NOT EXISTS ${ALYX_HEADER_PATH})
    message(FATAL_ERROR "Directory '${ALYX_HEADER_PATH}' not found")
endif ()

set(ALYX_HEADER_PATH ${ALYX_HEADER_PATH} CACHE PATH "Path to the Alyx C Headers" FORCE)

add_subdirectory(${ALYX_HEADER_PATH} alyx_header)
