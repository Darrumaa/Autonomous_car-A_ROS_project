cmake_minimum_required(VERSION 2.8.3)
project(ackermann_encoder_odometry)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  nav_msgs
  tf
  serial
  message_generation
)

add_message_files(
  FILES
  EncoderTicks.msg
)

generate_messages(
  DEPENDENCIES
  std_msgs
)

catkin_package(
  CATKIN_DEPENDS roscpp nav_msgs tf serial message_runtime
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)

add_executable(encoder_odometry_node src/encoder_odometry_node.cpp)

target_link_libraries(encoder_odometry_node
  ${catkin_LIBRARIES}
)

install(TARGETS encoder_odometry_node
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

install(DIRECTORY launch/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/launch
)



