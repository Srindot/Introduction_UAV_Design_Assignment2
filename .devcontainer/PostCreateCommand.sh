#!/bin/bash

# Step 1: Install xterm if it's not already installed
echo "Installing xterm..."
sudo apt-get update && sudo apt-get install -y xterm

# Step 2: Launch QGroundControl in a new xterm window
echo "Launching QGroundControl in xterm..."
xterm -hold -e "/usr/local/bin/QGroundControl" &

# Step 3: Launch Micro XRCE DDS Agent in a new xterm window
echo "Launching Micro XRCE DDS Agent in xterm..."
xterm -hold -e "MicroXRCEAgent udp4 -p 8888" &

# Step 4: Launch PX4 SITL gz_x500 in a new xterm window
echo "Launching PX4 SITL gz_x500 in xterm..."
xterm -hold -e "bash -c 'cd ~/PX4-Autopilot && make px4_sitl gz_x500'" &

# Step 5: Build and launch the sensor_combined_listener in a new xterm window
echo "Building and launching sensor_combined_listener in xterm..."
xterm -hold -e "bash -c 'mkdir -p ~/ws_sensor_combined/src/ && \
cd ~/ws_sensor_combined/src/ && \
git clone https://github.com/PX4/px4_msgs.git && \
git clone https://github.com/PX4/px4_ros_com.git && \
cd .. && \
source /opt/ros/humble/setup.bash && \
colcon build && \
source install/local_setup.bash && \
ros2 launch px4_ros_com sensor_combined_listener.launch.py'" &

# Step 6: Install and run ROS-GZ harmonic bridge in a new xterm window
echo "Installing and running ROS-GZ harmonic bridge in xterm..."
xterm -hold -e "bash -c 'sudo apt install -y ros-humble-ros-gzharmonic && \
ros2 run ros_gz_bridge parameter_bridge /clock@rosgraph_msgs/msg/Clock[gz.msgs.Clock]'" &

# Step 7: Build and run the offboard control in a new xterm window
echo "Building and running offboard control in xterm..."
xterm -hold -e "bash -c 'mkdir -p ~/ws_offboard_control/src/ && \
cd ~/ws_offboard_control/src/ && \
git clone https://github.com/PX4/px4_msgs.git && \
git clone https://github.com/PX4/px4_ros_com.git && \
cd .. && \
source /opt/ros/humble/setup.bash && \
colcon build && \
source install/local_setup.bash && \
ros2 run px4_ros_com offboard_control'" &

echo "All commands have been launched in separate xterm windows!"
