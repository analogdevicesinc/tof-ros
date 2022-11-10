cmake_minimum_required(VERSION 2.8.3)
project(aditof_roscpp)

option(WITH_ROS_EXAMPLES "Build ROS examples" OFF)


list(APPEND CMAKE_PREFIX_PATH "/usr/local/lib;/opt/glog;/opt/protobuf;/opt/websockets")
list(APPEND AMENT_PREFIX_PATH "/usr/local;/opt/glog;/opt/protobuf;/opt/websockets")
set(CMAKE_INSTALL_RPATH "/usr/local/lib;/opt/websockets/lib")


# Find catkin macros and libraries
find_package(catkin REQUIRED COMPONENTS roscpp sensor_msgs dynamic_reconfigure roslib)
find_package(aditof REQUIRED )
find_package(Libwebsockets REQUIRED)
find_package(glog REQUIRED)
find_package(Protobuf REQUIRED)

generate_dynamic_reconfigure_options(
  cfg/Aditof_roscpp.cfg
)

catkin_package(
  INCLUDE_DIRS include
  CATKIN_DEPENDS roscpp sensor_msgs dynamic_reconfigure roslib
  DEPENDS aditof
)


find_library(TOFI_COMPUTE
  NAMES tofi_compute
  PATHS /usr/local/lib
    /usr/lib/)

include_directories(include/${PROJECT_NAME} ${catkin_INCLUDE_DIRS}
                    ${aditof_INCLUDE_DIRS})

file(GLOB SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp)
list(REMOVE_ITEM SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/src/camera_node.cpp)

add_executable(aditof_camera_node
               ${CMAKE_CURRENT_SOURCE_DIR}/src/camera_node.cpp ${SOURCES})
target_sources(aditof_camera_node
               INTERFACE ${CMAKE_SOURCE_DIR}/include/${PROJECT_NAME})
target_link_libraries(aditof_camera_node ${catkin_LIBRARIES})
add_dependencies(aditof_camera_node ${PROJECT_NAME}_gencfg)


target_include_directories(aditof_camera_node PUBLIC "${ADITOF_INCLUDE_DIRS}")
target_include_directories(aditof_camera_node PUBLIC "${LIBWEBSOCKETS_INCLUDE_DIRS}")
target_link_libraries(aditof_camera_node "${ADITOF_LIBRARIES}")
target_link_libraries(aditof_camera_node aditof)
target_link_libraries(aditof_camera_node tofi_compute)
target_link_libraries(aditof_camera_node glog::glog)
target_link_libraries(aditof_camera_node websockets_shared)

# Copying config files and depth compute libraries from sdk/config, sdk/lib folders to build/examples/first-frame and build/first-frame/Debug or Release folders    
add_custom_command( TARGET aditof_camera_node POST_BUILD
COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/config /home/$ENV{USER}/.ros/config
    COMMENT "Copying cfgs and libs to build config "
)

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

