#!/usr/bin/env python2

import rospy
import math
from geometry_msgs.msg import Twist
from ackermann_msgs.msg import AckermannDriveStamped

class CmdVelToAckermann:
    def __init__(self):
        # Parameters
        self.wheelbase = rospy.get_param("~wheelbase", 1.98)          # meters
        self.max_steering_angle = rospy.get_param("~max_steering_angle", 0.6)  # radians (~34 deg)

        # Subscribers & Publishers
        self.cmd_vel_sub = rospy.Subscriber("/cmd_vel", Twist, self.cmd_vel_callback, queue_size=10)
        self.ackermann_pub = rospy.Publisher("/ackermann_cmd", AckermannDriveStamped, queue_size=10)

        rospy.loginfo("cmd_vel_to_ackermann node started.")

    def cmd_vel_callback(self, msg):
        ack_msg = AckermannDriveStamped()
        ack_msg.header.stamp = rospy.Time.now()
        ack_msg.drive.speed = msg.linear.x   # forward velocity

        # Compute steering angle
        if abs(msg.angular.z) > 1e-6 and abs(msg.linear.x) > 1e-6:
            turning_radius = msg.linear.x / msg.angular.z
            steering_angle = math.atan(self.wheelbase / turning_radius)
        else:
            steering_angle = 0.0

        # Clamp to physical limits
        steering_angle = max(min(steering_angle, self.max_steering_angle), -self.max_steering_angle)

        # Fill Ackermann message
        ack_msg.drive.steering_angle = steering_angle

        # Publish
        self.ackermann_pub.publish(ack_msg)


if __name__ == "__main__":
    rospy.init_node("cmd_vel_to_ackermann")
    converter = CmdVelToAckermann()
    rospy.spin()

