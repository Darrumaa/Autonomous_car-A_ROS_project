#!/usr/bin/python2

import time
import smbus
import rospy
import numpy as np
from sensor_msgs.msg import Temperature, Imu
from tf.transformations import quaternion_about_axis
from mpu_6050_driver.registers import PWR_MGMT_1, ACCEL_XOUT_H, ACCEL_YOUT_H, ACCEL_ZOUT_H, TEMP_H, \
    GYRO_XOUT_H, GYRO_YOUT_H, GYRO_ZOUT_H

ADDR = None
bus = None
IMU_FRAME = None
temp_pub = None
imu_pub = None

# Low-pass filter constants
ALPHA = 0.5

# Filter and bias state
filtered_accel = np.zeros(3)
filtered_gyro = np.zeros(3)
accel_bias = np.zeros(3)
gyro_bias = np.zeros(3)
calibrated = False

def read_word(adr):
    high = bus.read_byte_data(ADDR, adr)
    low = bus.read_byte_data(ADDR, adr + 1)
    val = (high << 8) + low
    return val

def read_word_2c(adr):
    val = read_word(adr)
    if val >= 0x8000:
        return -((65535 - val) + 1)
    else:
        return val

def calibrate_bias(samples=100):
    global accel_bias, gyro_bias

    rospy.loginfo("Calibrating IMU... please keep it still")
    accel_samples = []
    gyro_samples = []

    for _ in range(samples):
        raw_accel = np.array([
            read_word_2c(ACCEL_XOUT_H) / 16384.0,
            read_word_2c(ACCEL_YOUT_H) / 16384.0,
            read_word_2c(ACCEL_ZOUT_H) / 16384.0
        ])
        raw_gyro = np.array([
            read_word_2c(GYRO_XOUT_H) / 131.0,
            read_word_2c(GYRO_YOUT_H) / 131.0,
            read_word_2c(GYRO_ZOUT_H) / 131.0
        ])
        accel_samples.append(raw_accel)
        gyro_samples.append(raw_gyro)
        rospy.sleep(0.01)  # 10 ms

    accel_bias = np.mean(accel_samples, axis=0)
    gyro_bias = np.mean(gyro_samples, axis=0)

    rospy.loginfo("Calibration done.")
    rospy.loginfo("Accel bias: %s", accel_bias)
    rospy.loginfo("Gyro bias:  %s", gyro_bias)

def publish_temp(timer_event):
    temp_msg = Temperature()
    temp_msg.header.frame_id = IMU_FRAME
    temp_msg.temperature = read_word_2c(TEMP_H) / 340.0 + 36.53
    temp_msg.header.stamp = rospy.Time.now()
    temp_pub.publish(temp_msg)

def publish_imu(timer_event):
    global filtered_accel, filtered_gyro, calibrated

    if not calibrated:
        return  # Wait until calibration completes

    imu_msg = Imu()
    imu_msg.header.frame_id = IMU_FRAME

    # Raw sensor data
    raw_accel = np.array([
        read_word_2c(ACCEL_XOUT_H) / 16384.0,
        read_word_2c(ACCEL_YOUT_H) / 16384.0,
        read_word_2c(ACCEL_ZOUT_H) / 16384.0
    ])
    raw_gyro = np.array([
        read_word_2c(GYRO_XOUT_H) / 131.0,
        read_word_2c(GYRO_YOUT_H) / 131.0,
        read_word_2c(GYRO_ZOUT_H) / 131.0
    ])

    # Subtract bias
    raw_accel -= accel_bias
    raw_gyro -= gyro_bias

    # Low-pass filtering
    filtered_accel = ALPHA * raw_accel + (1 - ALPHA) * filtered_accel
    filtered_gyro = ALPHA * raw_gyro + (1 - ALPHA) * filtered_gyro

    # Orientation estimation using gravity
    acceln = filtered_accel / np.linalg.norm(filtered_accel)
    ref = np.array([0, 0, 1])
    axis = np.cross(acceln, ref)
    angle = np.arccos(np.clip(np.dot(acceln, ref), -1.0, 1.0))
    if np.linalg.norm(axis) == 0:
        quaternion = [0.0, 0.0, 0.0, 1.0]
    else:
        quaternion = quaternion_about_axis(angle, axis / np.linalg.norm(axis))

    # Populate IMU message
    imu_msg.orientation.x = quaternion[0]
    imu_msg.orientation.y = quaternion[1]
    imu_msg.orientation.z = quaternion[2]
    imu_msg.orientation.w = quaternion[3]
    imu_msg.orientation_covariance = [0.02, 0, 0,
                                      0, 0.02, 0,
                                      0, 0, 0.02]

    imu_msg.angular_velocity.x = filtered_gyro[0]
    imu_msg.angular_velocity.y = filtered_gyro[1]
    imu_msg.angular_velocity.z = filtered_gyro[2]
    imu_msg.angular_velocity_covariance = [0.2, 0, 0,
                                           0, 0.2, 0,
                                           0, 0, 0.2]

    imu_msg.linear_acceleration.x = filtered_accel[0]
    imu_msg.linear_acceleration.y = filtered_accel[1]
    imu_msg.linear_acceleration.z = filtered_accel[2]
    imu_msg.linear_acceleration_covariance = [0.1, 0, 0,
                                              0, 0.1, 0,
                                              0, 0, 0.1]

    imu_msg.header.stamp = rospy.Time.now()
    imu_pub.publish(imu_msg)

if __name__ == '__main__':
    rospy.init_node('imu_node')

    bus = smbus.SMBus(rospy.get_param('~bus', 1))
    ADDR = rospy.get_param('~device_address', 0x68)
    if isinstance(ADDR, str):
        ADDR = int(ADDR, 16)

    IMU_FRAME = rospy.get_param('~imu_frame', 'imu_link')

    bus.write_byte_data(ADDR, PWR_MGMT_1, 0)  # Wake up MPU6050

    temp_pub = rospy.Publisher('temperature', Temperature, queue_size=10)
    imu_pub = rospy.Publisher('imu/data', Imu, queue_size=10)

    # Run calibration before starting timers
    calibrate_bias()
    calibrated = True

    rospy.Timer(rospy.Duration(0.02), publish_imu)  # 50 Hz
    rospy.Timer(rospy.Duration(10), publish_temp)   # Every 10 seconds

    rospy.spin()

