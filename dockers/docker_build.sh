#Building docker files from source
echo "Building dockers"

#Ubuntu 18
# sudo docker build --tag ubuntu18.04/ros_melodic ./ubuntu_18_04_melodic/

#Ubuntu 20
sudo docker build --tag ubuntu20.04/ros_noetic ./ubuntu_20_04_noetic/
