# ROS Wrapper for [Time of Flight SDK](https://https://github.com/analogdevicesinc/ToF) of Analog Devices (for Ubuntu)


# 1. Install ROS

Install the recommended [ROS distribution](http://wiki.ros.org/Distributions) for your operating system**
  - [ROS Install page](http://wiki.ros.org/ROS/Installation)

# 2. ToF dependency

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

### Starting the camera node 

|                                 |          |   |
|---------------------------------|----------|---|
| With RQT Dynamic reconfigure    | USB      |`roslaunch aditof_roscpp camera_node_gui.launch config_file:="<path>"`   |
|                                 | Ethernet |`roslaunch aditof_roscpp camera_node_gui.launch ip:="10.42.0.1" config_file:="<path>"`   |
| Without RQT Dynamic reconfigure | USB      |`roslaunch aditof_roscpp camera_node.launch config_file:="<path>" mode:="1" use_depthCompute:="false"`   |
|                                 | Ethernet |`roslaunch aditof_roscpp camera_node.launch ip:="10.42.0.1" config_file:="<path>  mode:="1" use_depthCompute:="false"`   |


### Parameters:
 [config_file:"<<b>path></b>"]
* Crosby with Pulsatrix: "```config/config_walden_3500_nxp.json```"
* Crosby: "```config/config_crosby_nxp.json```"
* Walden: "```config/config_walden_nxp.json```"

 [use_depthCompute] 
 - `true` for enabling Depth Compute libraries
 - `false` for disabling Depth Compute libraries 


 [mode]:
* 1 -> SR - QMP mode of the camera (Short Range Quarter Megapixel)
* 2 -> SR - MP mode of the camera (Short Range Megapixel)
* 3 -> LR - QMP mode of the camera (Long Range Quarter Megapixel)
* 4 -> LR - MP mode of the camera (Long Range Megapixel)


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
