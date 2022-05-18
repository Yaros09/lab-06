cmake_minimum_required(VERSION 3.4)


project(equation)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUERED ON)

add_executable(equation equation.cpp)

target_include_directories(equation PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/../formatter_ex_lib)
target_include_directories(equation PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/../solver_lib)

target_link_libraries(equation formatter_ex)
target_link_libraries(equation solver)

option(Generator "generator" DEFAULT)


if(${Generator} MATCHES ARC)
	install(FILES equation.cpp DESTINATION src)
	install(TARGETS formatter_ex solver LIBRARY DESTINATION lib)
endif()
if(${Generator} MATCHES RPM)
	set(CPACK_GENERATOR "RPM")
	install(TARGETS equation DESTINATION bin)
endif()
if(${Generator} MATCHES DEB)
	set(CPACK_GENERATOR "DEB")
	install(TARGETS equation DESTINATION bin)
endif()
if(${Generator} MATCHES MSI)
	set(CPACK_GENERATOR "WIX")
	install(TARGETS equation DESTINATION bin)
endif()
if(${Generator} MATCHES DMG)
	set(MACOSX_BUNDLE TRUE)
	set(CPACK_GENERATOR "DragNDrop")
	install(TARGETS equation DESTINATION bin)
endif()

include(InstallRequiredSystemLibraries)
set(CPACK_PACKEGE_NAME "Solve")
set(CPACK_PACKAGE_VENDOR "Solve equation")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "yaroslavdomov@gmail.com")
set(CPACK_PACKAGE_VERSION_MAJOR 1)
set(CPACK_PACKAGE_VERSION_MINOR 0)
set(CPACK_PACKAGE_VERSION_PATCH 0)
include(CPack)
