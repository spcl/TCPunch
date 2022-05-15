cmake_minimum_required(VERSION 3.10)

set(CMAKE_THREAD_PREFER_PTHREAD TRUE)
set(THREADS_PREFER_PTHREAD_FLAG TRUE)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)


project(tcpunch VERSION 1.0)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

find_package(Threads REQUIRED)
add_library(tcpunch STATIC tcpunch.cpp)
target_include_directories(tcpunch PUBLIC  
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>  
  $<INSTALL_INTERFACE:include> 
)
target_link_libraries(tcpunch PRIVATE Threads::Threads)


include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

install(FILES tcpunch.h DESTINATION include)
install(TARGETS
  tcpunch
  EXPORT tcpunchTargets
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(EXPORT
  tcpunchTargets
  FILE tcpunchTargets.cmake
  DESTINATION "${CMAKE_INSTALL_DATADIR}/tcpunch/cmake"
  NAMESPACE tcpunch::
)
configure_package_config_file(
  cmake/tcpunchConfig.cmake.in
  "${CMAKE_CURRENT_BINARY_DIR}/tcpunchConfig.cmake"
  INSTALL_DESTINATION "${CMAKE_INSTALL_DATADIR}/tcpunch/cmake"
)

install(
  FILES "${CMAKE_CURRENT_BINARY_DIR}/tcpunchConfig.cmake"
  DESTINATION "${CMAKE_INSTALL_DATADIR}/tcpunch/cmake"
)

