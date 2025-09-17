execute_process(COMMAND "/home/self/Saxxophone_500/build_isolated/mpu_6050_driver/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/self/Saxxophone_500/build_isolated/mpu_6050_driver/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
