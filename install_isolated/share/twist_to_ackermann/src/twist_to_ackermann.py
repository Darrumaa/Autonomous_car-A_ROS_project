#!/usr/bin/env python

import rospy
from geometry_msgs.msg import Twist
from ackermann_msgs.msg import AckermannDriveStamped
import math

class TwistToAckermann:
 def __init__(self):
  rospy.init_node('twist_to_ackermann')
  
  self.wheelbase = rospy.get_param("~wheelbase", 1.9)
  self.max_steering_angle = rospy.get_param("~max_steering_angle", 0.611)
  self.ackermann_pub = rospy.Publisher("/ackermann_cmd", AckermannDriveStamped, queue_size = 10)
  rospy.Subscriber("/cmd_vel", Twist, self.cmd_vel_callback)

 def cmd_vel_callback(self,msg): 
  ack_msg = AckermannDriveStamped()
  ack_msg.header.stamp = rospy.Time.now()
  ack_msg.drive.speed = msg.linear.x
  
  if abs(msg.angular.z) > 1e-6 and abs(msg.linear.x) > 1e-6:
   turning_radius = msg.linear.x/msg.angular.z
   steering_angle = math.atan(self.wheelbase/turning_radius)
  else:
   steering_angle = 0.0
   steering_angle = max(min(steering_angle, self.max_steering_angle), -self.max_steering_angle)
   ack_msg.drive.steering_angle = steering_angle
   self.ackermann_pub.publish(ack_msg)
 
 def run(self):
  rospy.spin()

if __name__ == '__main__':
 node = TwistToAckermann()
 node.run()
   
    
