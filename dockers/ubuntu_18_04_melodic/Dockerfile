FROM ubuntu:18.04
 
LABEL maintainer="Robert Budai, <robert.budai@analog.com>"
ARG DEBIAN_FRONTEND=noninteractive

# Install updates to base image
RUN \
  apt-get update -y \
  && apt-get install -y git 
RUN \
  apt-get install -y cmake \
  && apt-get install -y build-essential 
RUN \
  apt-get install -y apt-utils

#Install Glog
RUN \
  git clone -b v0.6.0 --depth 1 https://github.com/google/glog \
  && cd glog \
  && mkdir build_0_6_0 && cd build_0_6_0 \
  && cmake -DWITH_GFLAGS=off -DCMAKE_INSTALL_PREFIX=/opt/glog .. \
  && cmake --build . --target install

#Install Libwebsoocket
RUN \
  git clone --branch v3.1-stable --depth 1 https://github.com/warmcat/libwebsockets \
  && cd libwebsockets \
  && mkdir build_3_1 && cd build_3_1 \
  && cmake -DLWS_WITH_SSL=OFF -DLWS_STATIC_PIC=ON -DCMAKE_INSTALL_PREFIX=/opt/websockets .. \
  && cmake --build . --target install

#Install Protobuf
RUN \
  git clone --branch v3.9.0 --depth 1 https://github.com/protocolbuffers/protobuf \
  && cd protobuf \
  && mkdir build_3_9_0 && cd build_3_9_0 \
  && cmake -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_INSTALL_PREFIX=/opt/protobuf ../cmake \
  && cmake --build . --target install

# #Install ToF SDK
# RUN \
#   git clone https://github.com/analogdevicesinc/ToF \
#   && cd ToF \
#   && mkdir build && cd build \
#   && cmake -DUSE_DEPTH_COMPUTE_OPENSOURCE=1 -DWITH_NETWORK=1 -DWITH_EXAMPLES=off -DCMAKE_PREFIX_PATH="/opt/glog;/opt/protobuf;/opt/websockets" .. \
#   && cmake --build . --target install 

#Install ROS2
RUN \
  sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
  && apt install curl -y \
  && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add - \
  && apt update -y \
  && apt install -y ros-melodic-desktop

RUN \
  mkdir catkin_ws && cd catkin_ws && mkdir src