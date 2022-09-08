# ROS Wrapper for Time of Flight SDK of Analog Devices&copy; (for Ubuntu)

## Installation

- Install the recommended [ROS distribution](http://wiki.ros.org/Distributions) for your operating system**
  - [ROS Install page](http://wiki.ros.org/ROS/Installation)

- In order to prepare the system to run the ROS wrapper in the general catkin workspace make sure to install correctly the following libraries:

## Library prerequisits

* Glog:
```console
git clone --branch v0.3.5 --depth 1 https://github.com/google/glog
cd glog
mkdir build_0_3_5 && cd build_0_3_5
cmake -DWITH_GFLAGS=off -DCMAKE_INSTALL_PREFIX=/opt/glog ..
sudo cmake --build . --target install
```

* Libwebsockets:
```console
git clone --branch v3.1-stable --depth 1 https://github.com/warmcat/libwebsockets
cd libwebsockets
mkdir build_3_1 && cd build_3_1
cmake -DLWS_WITH_SSL=OFF -DLWS_STATIC_PIC=ON -DCMAKE_INSTALL_PREFIX=/opt/websockets ..
sudo cmake --build . --target install
```

* Protobuf:
```console
git clone --branch v3.9.0 --depth 1 https://github.com/protocolbuffers/protobuf
cd protobuf
mkdir build_3_9_0 && cd build_3_9_0
cmake -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_INSTALL_PREFIX=/opt/protobuf ../cmake
sudo cmake --build . --target install
```
* ToF libraries:
```console
wget https://swdownloads.analog.com/cse/aditof/tof_deb_pkg/tof_roscpp.deb
sudo dpkg -i tof_roscpp.deb
```

- After preparing the neccessary libraries open the general catkin workspace and in the ```src``` directory clone <b>THIS</b> repository and in the main catkin directory run the: ```catkin_make``` commad.

## Starting the packages:
### Starting camera node
* For <b>USB</b> type camera connections with RQT dynamic reconfigure GUI use the following commands:
    ```console
    roslaunch aditof_roscpp camera_node_gui.launch config_file:="<path>"
    ```
    
The path should point towards the appropriate config file for the cameras. 
* For <b>Ethernet\Wi-Fi</b> connections, you should specify the camera's IP address, using the ip parameter, as shown below:

    ```console
    roslaunch aditof_roscpp camera_node_gui.launch ip:="124.0.0.0" config_file:="<path>"
    ```
    
 <p align="center"><img src="doc/img/ros_dynamic_reconfigure.png" /></p>
 
### Without RQT Reconfigure
* For <b>USB</b> type camera connections witouth RQT dynamic reconfigure GUI use the following commands:
    ```console
    roslaunch aditof_roscpp camera_node.launch config_file:="<path>" mode:="1" use_depthCompute:="false"
    ```
The path should point towards the appropriate config file for the cameras, mode should be selected as follows:
  - mode: qmp = 1 
  - mode: mp = 2 </br>
The use of depthCompute libraries can be modified by setting the ```use_depthCompute``` variable to ```true```/```false```
* For <b>Ethernet\Wi-Fi</b> connections, you should specify the camera's IP address, using the ip parameter, as shown below:
    ```console
    roslaunch aditof_roscpp camera_node.launch ip:="124.0.0.0" config_file:="<path>  mode:="1" use_depthCompute:="false"
    ```
The path should point towards the appropriate config file for the cameras, mode should be selected as follows:
  - mode: qmp = 1 
  - mode: mp = 2 </br>
The use of depthCompute libraries can be modified by setting the ```use_depthCompute``` variable to ```true```/```false```


 ### ***Note:***
 *In case you wish to launch nodes using the rosrun command instead of roslaunch:*
```console
rosrun aditof_roscpp aditof_camera_node 127.0.0.1
```

## Published Topics
The aditof_camera_node publishes messages defined by the [sensor_msgs](http://wiki.ros.org/sensor_msgs) package on the following topics
- /aditof_roscpp/aditof_camera_info
- /aditof_roscpp/aditof_depth
- /aditof_roscpp/aditof_ir
- Or:
- /aditof_roscpp/raw

## Update parameters at runtime using
Using the [dynamic_reconfigure](http://wiki.ros.org/dynamic_reconfigure) package, the aditof_ros_package offers the users the possibility to update the camera parameters

