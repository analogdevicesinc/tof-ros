pipeline {
    agent none
      stages {
        stage ('Ubuntu 18.04/ ROS Melodic')
        {
            agent { 
                docker { 
                    image 'ubuntu18.04/ros_melodic'
                    args '-u root:sudo'
                        } 
                }
            steps{
                sh '''
                #!/bin/bash
                rm -rf ToF && git clone https://github.com/analogdevicesinc/ToF && cd ToF && mkdir build && cd build && cmake -DWITH_EXAMPLES=off -DCMAKE_PREFIX_PATH="/opt/glog;/opt/protobuf;/opt/websockets" -DUSE_DEPTH_COMPUTE_STUBS=1 .. &&  make install .
                '''
           
                sh '''
                #!/bin/bash
                rm -rf catkin_ws && mkdir -p catkin_ws/src && cd catkin_ws/src && git clone https://github.com/analogdevicesinc/tof-ros && cd ../ && . /opt/ros/melodic/setup.sh && catkin_make
                '''
            }
        }

        stage ('Ubuntu 20.04/ ROS Noetic')
        {
            agent { 
                docker { 
                    image 'ubuntu20.04/ros_noetic'
                    args '-u root:sudo'
                        } 
                }
            steps{
                sh '''
                #!/bin/bash
                rm -rf ToF && git clone https://github.com/analogdevicesinc/ToF && cd ToF && mkdir build && cd build && cmake -DWITH_EXAMPLES=off -DCMAKE_PREFIX_PATH="/opt/glog;/opt/protobuf;/opt/websockets" -DUSE_DEPTH_COMPUTE_STUBS=1 .. &&  make install .
                '''
           
                sh '''
                #!/bin/bash
                rm -rf catkin_ws && mkdir -p catkin_ws/src && cd catkin_ws/src && git clone https://github.com/analogdevicesinc/tof-ros && cd ../ && . /opt/ros/noetic/setup.sh && catkin_make
                '''
            }
        }

  }
}