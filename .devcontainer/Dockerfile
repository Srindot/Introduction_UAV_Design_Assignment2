# Pull the rosgzpx4 image
FROM rosgzpx4:latest

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Switch to bash shell
SHELL ["/bin/bash", "-c"]

# Update packages and install required dependencies
RUN sudo apt-get update && sudo apt-get install -y \
    ros-humble-ros-gzharmonic \
    python3-colcon-common-extensions && \
    sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

# Create and build the ws_sensor_combined workspace
RUN mkdir -p ~/ws_sensor_combined/src && \
    cd ~/ws_sensor_combined/src && \
    git clone https://github.com/PX4/px4_msgs.git && \
    git clone https://github.com/PX4/px4_ros_com.git && \
    cd .. && \
    . /opt/ros/humble/setup.bash && \
    colcon build && \
    . install/local_setup.bash

# Create and build the ws_offboard_control workspace
RUN mkdir -p ~/ws_offboard_control/src && \
    cd ~/ws_offboard_control/src && \
    git clone https://github.com/PX4/px4_msgs.git && \
    git clone https://github.com/PX4/px4_ros_com.git && \
    cd .. && \
    . /opt/ros/humble/setup.bash && \
    colcon build && \
    . install/local_setup.bash

RUN sudo pip install git+https://github.com/fishros/ros2bag_convert.git


# Set the default command to open a bash shell
CMD ["bash"]
