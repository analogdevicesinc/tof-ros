# ROS Wrapper for [Time of Flight SDK](https://github.com/analogdevicesinc/ToF) of Analog Devices (for Ubuntu)

| Ubuntu 20.04: Noetic|
|-|
| [![Build Status](https://dev.azure.com/AnalogDevices/ToF/_apis/build/status%2Fanalogdevicesinc.tof-ros?branchName=main&jobName=Job)](https://dev.azure.com/AnalogDevices/ToF/_build/latest?definitionId=45&branchName=main) |

## 1. Install ROS

Install the recommended [ROS distribution](http://wiki.ros.org/Distributions) for your operating system**
  - [ROS Install page](http://wiki.ros.org/ROS/Installation)

## 2. ToF dependency
### Download debian package:
#### For Crosby:
* Tof lib for ([Ubuntu 20.04](https://swdownloads.analog.com/cse/aditof/tof_deb_pkg/crosby/out_ubuntu20/tof_lib.deb)) [Latest SDK master]
* Tof lib for ([Ubuntu 22.04](https://swdownloads.analog.com/cse/aditof/tof_deb_pkg/crosby/out_ubuntu22/tof_lib.deb)) [Latest SDK master]

#### For Adsd3030:
* Tof lib for ([Ubuntu 20.04](https://swdownloads.analog.com/cse/aditof/tof_deb_pkg/adsd3030/out_ubuntu20/tof_lib.deb)) [Latest SDK master]
* Tof lib for ([Ubuntu 22.04](https://swdownloads.analog.com/cse/aditof/tof_deb_pkg/adsd3030/out_ubuntu22/tof_lib.deb)) [Latest SDK master]

Install command: ```sudo dpkg -i tof_lib.deb```

### Building from sources 

In order to prepare the system to run the ROS wrapper in the general catkin workspace make sure to install correctly the following library:

- [Build ToF from sourcecode](https://github.com/analogdevicesinc/ToF/blob/master/doc/itof/linux_build_instructions.md) (Until the step: "Download and build the SDK only")

Also make sure to run ```sudo make install``` at the end of the build


## 3. Usage

In directory ```catkin_ws/src/``` clone the repository:

```console
git clone https://github.com/analogdevicesinc/tof-ros
```

After cloning the repository in the ``catkin_ws/ run the following command:
 
```console
export ROS_HOME=~/.ros/
catkin_make
source devel/setup.bash
```

## Starting the camera node

- In the general ROS2 workspace run the following code, setting up the path towards shaed library:
```console
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH;/opt/websockets/lib;/usr/local/lib"
```
### With ```roslaunch```

* EVAL-ADTF3175-NXZ : 
```console 
roslaunch aditof_roscpp EVAL-ADTF3175D.launch
```

### With ```rosrun```

```console
roscore & rosrun aditof_roscpp aditof_camera_node ip="10.42.0.1" config_file=<path> mode=<mode>
```

#### Parameters:
[config_file:="<<b>path></b>"]
* ```config/config_adsd3500_adsd3100.json``` ("Crosby")
* ```config/config_adsd3500_adsd3030.json``` ("Adsd3030")


[mode:="<<b>mode></b>"] (for both cameras):
 * 0: sr-native (short-range native)
 * 1: lr-native (long-range native)
 * 2: sr-qnative (short-range quarter native)
 * 3: lr-qnative (long-range quarter native)
 * 4: pcm-native 
 * 5: sr-mixed (short-range mixed)
 * 6: lr-mixed (long-range mixed)



####  Dynamic reconfigure window:

    
 <p align="center"><img src="doc/img/ros_dynamic_reconfigure.png" /></p>
 

#### Examples
  - Visualize point cloud in rviz
    ```console
    cd catkin_ws
    source devel/setup.bash
    roslaunch aditof_roscpp rviz_publisher.launch
    ```


#### Published Topics
The aditof_camera_node publishes messages defined by the [sensor_msgs](http://wiki.ros.org/sensor_msgs) package on the following topics
- /aditof_roscpp/aditof_camera_info
- /aditof_roscpp/aditof_depth
- /aditof_roscpp/aditof_ir
- /aditof_roscpp/aditof_pcloud

#### Update parameters at runtime using
Using the [dynamic_reconfigure](http://wiki.ros.org/dynamic_reconfigure) package, the aditof_ros_package offers the users the possibility to update the camera parameters
