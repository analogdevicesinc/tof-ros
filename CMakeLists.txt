cmake_minimum_required(VERSION 2.8.3)
project(aditof_roscpp)

option(WITH_ROS_EXAMPLES "Build ROS examples" OFF)

list(APPEND CMAKE_PREFIX_PATH ${ADITOF_CMAKE_INSTALL_PREFIX}
     ${ADITOF_CMAKE_PREFIX_PATH})
list(APPEND CMAKE_PREFIX_PATH "/usr/local;/opt/glog;/opt/protobuf;/opt/websockets" ${ADITOF_CMAKE_PREFIX_PATH})


# Find catkin macros and libraries
find_package(catkin REQUIRED COMPONENTS roscpp sensor_msgs dynamic_reconfigure roslib)
find_package(aditof ${VERSION} REQUIRED)
find_library(TOFI_COMPUTE
  NAMES tofi_compute
  PATHS /usr/lib)
  
set(ADITOF_MIN_VERSION "4.2.0")

if(aditof_VERSION VERSION_LESS ${ADITOF_MIN_VERSION})
    message(FATAL_ERROR "You can not compile with aditof version less than ${ADITOF_MIN_VERSION}" )
else()
    message(STATUS "Compiling with aditof_VERSION ${aditof_VERSION}")
endif()  

generate_dynamic_reconfigure_options(
  cfg/Aditof_roscpp.cfg
)

catkin_package(
  INCLUDE_DIRS include
  CATKIN_DEPENDS roscpp sensor_msgs dynamic_reconfigure roslib
  DEPENDS aditof)

include_directories(include/${PROJECT_NAME} ${catkin_INCLUDE_DIRS}
                    ${aditof_INCLUDE_DIRS})

file(GLOB SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp)
list(REMOVE_ITEM SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/src/camera_node.cpp)

add_executable(aditof_camera_node
               ${CMAKE_CURRENT_SOURCE_DIR}/src/camera_node.cpp ${SOURCES})
target_sources(aditof_camera_node
               INTERFACE ${CMAKE_SOURCE_DIR}/include/${PROJECT_NAME})
target_link_libraries(aditof_camera_node aditof::aditof)
target_link_libraries(aditof_camera_node ${catkin_LIBRARIES})

add_library(tofi_compute SHARED IMPORTED)

add_dependencies(aditof_camera_node ${PROJECT_NAME}_gencfg)

if(WITH_ROS_EXAMPLES)
  find_package(catkin REQUIRED COMPONENTS rviz)

  add_executable(
    aditof_rviz_pcl ${CMAKE_CURRENT_SOURCE_DIR}/src/examples/rviz_pointcloud.cpp
                    ${SOURCES})
  target_sources(aditof_rviz_pcl
                 INTERFACE ${CMAKE_SOURCE_DIR}/include/${PROJECT_NAME})
  
  
  target_link_libraries(aditof_rviz_pcl aditof::aditof)
  target_link_libraries(aditof_rviz_pcl ${catkin_LIBRARIES})
  
endif()
## Copying config files and depth compute libraries from sdk/config, sdk/lib folders to build/examples/first-frame and build/first-frame/Debug or Release folders
# FILE(GLOB CONFIG_FILES ${CMAKE_CURRENT_SOURCE_DIR}/config/*)
# install(FILES ${CONFIG_FILES} DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/../../../config/)
# install(FILES ${CONFIG_FILES} DESTINATION lib/${PROJECT_NAME}/config/)

file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/config DESTINATION /home/$ENV{USER}/.ros/)
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/config DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/../../)
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/config DESTINATION $ENV{ROS_HOME}/)
