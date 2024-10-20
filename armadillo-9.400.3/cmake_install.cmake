# Install script for directory: /PANFS/user/home/mgrecu/data/2BCMBV6/armadillo-9.400.3

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr")
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

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "0")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/PANFS/user/home/mgrecu/data/2BCMBV6/armadillo-9.400.3/tmp/include/" REGEX "/\\.svn$" EXCLUDE REGEX "/[^/]*\\.cmake$" EXCLUDE REGEX "/[^/]*\\~$" EXCLUDE REGEX "/[^/]*orig$" EXCLUDE)
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib64" TYPE SHARED_LIBRARY FILES
    "/PANFS/user/home/mgrecu/data/2BCMBV6/armadillo-9.400.3/CMakeFiles/CMakeRelink.dir/libarmadillo.so.9.400.3"
    "/PANFS/user/home/mgrecu/data/2BCMBV6/armadillo-9.400.3/CMakeFiles/CMakeRelink.dir/libarmadillo.so.9"
    "/PANFS/user/home/mgrecu/data/2BCMBV6/armadillo-9.400.3/CMakeFiles/CMakeRelink.dir/libarmadillo.so"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "dev")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/Armadillo/CMake/ArmadilloLibraryDepends.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/Armadillo/CMake/ArmadilloLibraryDepends.cmake"
         "/PANFS/user/home/mgrecu/data/2BCMBV6/armadillo-9.400.3/CMakeFiles/Export/share/Armadillo/CMake/ArmadilloLibraryDepends.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/Armadillo/CMake/ArmadilloLibraryDepends-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/Armadillo/CMake/ArmadilloLibraryDepends.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/Armadillo/CMake" TYPE FILE FILES "/PANFS/user/home/mgrecu/data/2BCMBV6/armadillo-9.400.3/CMakeFiles/Export/share/Armadillo/CMake/ArmadilloLibraryDepends.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^()$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/Armadillo/CMake" TYPE FILE FILES "/PANFS/user/home/mgrecu/data/2BCMBV6/armadillo-9.400.3/CMakeFiles/Export/share/Armadillo/CMake/ArmadilloLibraryDepends-noconfig.cmake")
  endif()
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "dev")
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/share/Armadillo/CMake/ArmadilloConfig.cmake;/usr/share/Armadillo/CMake/ArmadilloConfigVersion.cmake")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/share/Armadillo/CMake" TYPE FILE FILES
    "/PANFS/user/home/mgrecu/data/2BCMBV6/armadillo-9.400.3/InstallFiles/ArmadilloConfig.cmake"
    "/PANFS/user/home/mgrecu/data/2BCMBV6/armadillo-9.400.3/InstallFiles/ArmadilloConfigVersion.cmake"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib64/pkgconfig" TYPE FILE FILES "/PANFS/user/home/mgrecu/data/2BCMBV6/armadillo-9.400.3/tmp/misc/armadillo.pc")
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

file(WRITE "/PANFS/user/home/mgrecu/data/2BCMBV6/armadillo-9.400.3/${CMAKE_INSTALL_MANIFEST}" "")
foreach(file ${CMAKE_INSTALL_MANIFEST_FILES})
  file(APPEND "/PANFS/user/home/mgrecu/data/2BCMBV6/armadillo-9.400.3/${CMAKE_INSTALL_MANIFEST}" "${file}\n")
endforeach()
