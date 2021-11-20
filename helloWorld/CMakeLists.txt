# Provided c++20/cmake available
#
# RHEL8 --> toolser-10 installed and enabled
# scl enable gcc-toolset-10 bash
#
# Windows without VS --> latest mingw from https://winlibs.com/
# UCRT Win64 for at least gcc 11.2.0 in your path
#
# Windows with VS --> latest VS2020
# open your Develper Powershell VS2020 terminal
#
# Archlinux --> my usual dev distro
# do nothing
#
# LINUX example:
# cmake .. -D CMAKE_BUILD_TYPE=Release
# make .
# make install 
#
# Windows example:
# cmake .. -G "MinGW Makefiles"
# cmake --build . --config Release
# cmake --install .
#
# cmake .. -G "Visual Studio 17 2022" -DCMAKE_BUILD_TYPE=Release
# cmake --build .
# cmake --install .
#
cmake_minimum_required(VERSION 3.18)
project(HelloWorld)

# going for the latest standard by default. Ajust it to your needs
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# you might want to cp -r the root include on your local source folder instead
include_directories(${PROJECT_SOURCE_DIR}/../include)
file(GLOB MY_SOURCES *.cpp)

if(WIN32)
	# using gendef.exe tool to generate .def out of .dll
	link_directories(${PROJECT_SOURCE_DIR}/../lib)
	set(CMAKE_LINK_DEF_FILE_FLAG "/DEF:libHelloWorld.def")
endif()

add_library(${PROJECT_NAME} SHARED ${MY_SOURCES})
add_compile_definitions($<$<CONFIG:RELEASE>:NDEBUG>)
add_compile_options(-Wall -Werror $<$<CONFIG:RELEASE>:-O3> $<$<CONFIG:DEBUG>-O0>)

# using kdb+ 4.0 for this examples

if(WIN32)
    target_compile_options(${PROJECT_NAME} PRIVATE -DKXVER=4)
    if ("${CMAKE_GENERATOR}" STREQUAL "Visual Studio 17 2022")
	    target_link_libraries(${PROJECT_NAME} PUBLIC "est")
    elseif ("${CMAKE_GENERATOR}" STREQUAL "MinGW Makefiles")
	    target_link_libraries(${PROJECT_NAME} PUBLIC "-l:est_static.lib -lmsvcr100 -lkernel32 -lws2_32  -liphlpapi -static-libgcc -static-libstdc++")
    else()
	message(FATAL_ERROR "Unsupported Windows Generator")
    endif()
    message(STATUS "Windows build with CXX=${CMAKE_CXX_COMPILER}")
endif(WIN32)

if(UNIX AND NOT APPLE)
    target_compile_options(${PROJECT_NAME} PRIVATE -fPIC -DKXVER=4)
    target_link_libraries(${PROJECT_NAME} PUBLIC "-static-libgcc -static-libstdc++")
    message(STATUS "Linux build with CXX=${CMAKE_CXX_COMPILER}")
endif(UNIX AND NOT APPLE)

# depends on your local kdb configuration

if ("${CMAKE_GENERATOR}" STREQUAL "Visual Studio 17 2022")
	message(STATUS "Proceed to manually install the library once built in your Debug or Release folder")
elseif (DEFINED ENV{QHOME} AND DEFINED ENV{QARCH})
	file(TO_CMAKE_PATH "$ENV{QHOME}/$ENV{QARCH}" LIB_DESTINATION)
    message(STATUS "Install into ${LIB_DESTINATION}")
	install(TARGETS ${PROJECT_NAME} LIBRARY DESTINATION ${LIB_DESTINATION} RUNTIME DESTINATION ${LIB_DESTINATION} ARCHIVE DESTINATION ${LIB_DESTINATION})
elseif (DEFINED LIB_DESTINATION)
    message(STATUS "Install into ${LIB_DESTINATION}")
	install(TARGETS ${PROJECT_NAME} LIBRARY DESTINATION ${LIB_DESTINATION} RUNTIME DESTINATION ${LIB_DESTINATION} ARCHIVE DESTINATION ${LIB_DESTINATION})
else()
	message(STATUS "Proceed to manually install the library once built")
endif()
