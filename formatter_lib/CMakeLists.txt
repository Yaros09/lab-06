cmake_minimum_required(VERSION 3.4)

project(CMake)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUERED ON)

add_library(formatter STATIC formatter.h formatter.cpp)

