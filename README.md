# ROS Wrapper for Time of Flight SDK of Analog Devices&copy; (for Ubuntu)

## ROS Installation

- Install the recommended [ROS distribution](http://wiki.ros.org/Distributions) for your operating system**
  - [ROS Install page](http://wiki.ros.org/ROS/Installation)

- In order to prepare the system to run the ROS wrapper in the general catkin workspace make sure to install correctly the following libraries:

## Library prerequisits

* ToF libraries:
```console
wget https://swdownloads.analog.com/cse/aditof/tof_deb_pkg/tof_roscpp.deb
sudo dpkg -i tof_roscpp.deb
```

- After preparing the neccessary libraries open the general catkin workspace and in the ```src```  and run 
```console
git clone https://github.com/rbudai98/tof_roscpp.git
```
and in the main catkin directory run the: ```catkin_make``` commad.

## Starting with packages:
-config_file:"<<b>path></b>"
* Crosby with Pulsatrix: "```config/config_walden_3500_nxp.json```"
* Crosby: "```config/config_crosby_nxp.json```"
* Walden: "```config/config_walden_nxp.json```"
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

