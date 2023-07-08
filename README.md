# ROS Wrapper for [Time of Flight SDK](https://github.com/analogdevicesinc/ToF) of Analog Devices (for Ubuntu)


# 1. Install ROS

Install the recommended [ROS distribution](http://wiki.ros.org/Distributions) for your operating system**
  - [ROS Install page](http://wiki.ros.org/ROS/Installation)

# 2. ToF dependency
## Download debian package:
### For Crosby:
* Tof lib for ([Ubuntu 18.04](https://swdownloads.analog.com/cse/aditof/tof_deb_pkg/crosby/out_ubuntu18/tof_lib.deb)) [Deprecated]
* Tof lib for ([Ubuntu 20.04](https://swdownloads.analog.com/cse/aditof/tof_deb_pkg/crosby/out_ubuntu20/tof_lib.deb)) [Rel. ver. 4.2.0]
* Tof lib for ([Ubuntu 22.04](https://swdownloads.analog.com/cse/aditof/tof_deb_pkg/crosby/out_ubuntu22/tof_lib.deb)) [Rel. ver. 4.2.0]

### For Adsd3030:
* Tof lib for ([Ubuntu 18.04](https://swdownloads.analog.com/cse/aditof/tof_deb_pkg/adsd3030/out_ubuntu18/tof_lib.deb)) [Deprecated]
* Tof lib for ([Ubuntu 20.04](https://swdownloads.analog.com/cse/aditof/tof_deb_pkg/adsd3030/out_ubuntu20/tof_lib.deb)) [Rel. ver. 4.2.0]
* Tof lib for ([Ubuntu 22.04](https://swdownloads.analog.com/cse/aditof/tof_deb_pkg/adsd3030/out_ubuntu22/tof_lib.deb)) [Rel. ver. 4.2.0]

Install command: ```sudo dpkg -i tof_lib.deb```

## Building from sources 

In order to prepare the system to run the ROS wrapper in the general catkin workspace make sure to install correctly the following library:

- [Build ToF from sourcecode](https://github.com/analogdevicesinc/ToF/blob/master/doc/itof/linux_build_instructions.md) (Until the step: "Download and build the SDK only")

Also make sure to run ```sudo make install``` at the end of the build


# 3. Usage

In directory ```catkin_ws/src/``` clone the repository:

```console
git clone https://github.com/analogdevicesinc/tof-ros
```

After cloning the repository in the ``catkin_ws/ run the following command:
 
```console
catkin_make
source devel/setup.bash
```

# Starting the camera node

## With ```roslaunch```

* EVAL-ADTF3175-NXZ : ```roslaunch aditof_roscpp camera_EVAL-ADTF3175-NXZ.launch```
* EVAL-ADTF3175D-NXZ : ```roslaunch aditof_roscpp camera_EVAL-ADTF3175D-NXZ.launch```

## With ```ros run```

- In the general ROS2 workspace run the following code, setting up the path towards shaed library:
```console
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH;/opt/websockets/lib;/usr/local/lib"
```

```console
roslaunch aditof_roscpp camera_node.launch ip:=<ip addr> config_file:="<path> mode:=<mode number>
```


|                                 |          |   |
|---------------------------------|----------|---|
| With RQT Dynamic reconfigure    | USB      |`roslaunch aditof_roscpp camera_node_gui.launch config_file:="<path>"`   |
|                                 | Ethernet |`roslaunch aditof_roscpp camera_node_gui.launch ip:="10.42.0.1" config_file:="<path>"`   |
| Without RQT Dynamic reconfigure | USB      |`roslaunch aditof_roscpp camera_node.launch config_file:="<path>" mode:="1" use_depthCompute:="false"`   |
|                                 | Ethernet |`roslaunch aditof_roscpp camera_node.launch ip:="10.42.0.1" config_file:="<path>  mode:="1" use_depthCompute:="false"`   |


### Parameters:
 [config_file:"<<b>path></b>"]
* ```config/config_adsd3500_adsd3030_new_modes.json```
* ```config/config_adsd3500_adsd3030_old_modes.json```
* ```config/config_crosby_adsd3500_new_modes.json```
* ```config/config_crosby_nxp.json```
* ```config/config_crosby_old_modes.json```


 [mode]:
|          | New modes                                                                      | Old modes                                               |
|----------|--------------------------------------------------------------------------------|---------------------------------------------------------|
| adsd3500 | mode 0 - sr-native; mode 1 - lr-native; mode 2 - sr-qnative; mode 3 - lr-qnative  | mode 0 - lt_bin; mode 1 - pcmmp; mode 2 - qmp; mode 3 - mp |
| adsd3030 | mode 0 - sr-native; mode 1 - lr-native; mode 2 - sr-qnative; mode 3 - lr-qnative  | mode 0 - vga                                            |



###  Dynamic reconfigure window:

    
 <p align="center"><img src="doc/img/ros_dynamic_reconfigure.png" /></p>
 

### Examples
  - Visualize point cloud in rviz
    ```console
    cd catkin_ws
    source devel/setup.bash
    roslaunch aditof_roscpp rviz_publisher.launch
    ```


### Published Topics
The aditof_camera_node publishes messages defined by the [sensor_msgs](http://wiki.ros.org/sensor_msgs) package on the following topics
- /aditof_roscpp/aditof_camera_info
- /aditof_roscpp/aditof_depth
- /aditof_roscpp/aditof_ir
- /aditof_roscpp/aditof_pcloud

### Update parameters at runtime using
Using the [dynamic_reconfigure](http://wiki.ros.org/dynamic_reconfigure) package, the aditof_ros_package offers the users the possibility to update the camera parameters
