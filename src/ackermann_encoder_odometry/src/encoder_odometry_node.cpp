#include <ros/ros.h>
#include <nav_msgs/Odometry.h>
#include <tf/transform_broadcaster.h>
#include <geometry_msgs/TransformStamped.h>
#include <math.h>
#include <string>
#include <serial/serial.h>

// ===================== Constants =====================
const double TICKS_PER_REV = 2400.0;
const double STEER_TICKS_PER_REV = 400.0;
const double WHEEL_DIAMETER = 0.3302; // meters
const double WHEEL_BASE = 1.9812;     // meters
const double DIST_PER_TICK = (M_PI * WHEEL_DIAMETER) / TICKS_PER_REV;
const double STEER_RATIO = 0.075;
const double STEER_DEADBAND = 0.01;   // radians
const double STEER_SENSITIVITY = 0.046;

serial::Serial ser;

// ===================== Encoder Tracking =====================
int64_t last_left_ticks = 0;
int64_t last_right_ticks = 0;
int64_t last_steer_ticks = 0;
bool first_read = true;

// ===================== Robot Pose =====================
double x = 0.0, y = 0.0, theta = 0.0;
ros::Time last_time;

// ===================== Helper Function =====================
void parseLine(const std::string& line, int64_t& left, int64_t& right, int64_t& steer) {
    sscanf(line.c_str(), "Left: %ld | Right: %ld | Steering: %ld", &left, &right, &steer);
}

// ===================== Main =====================
int main(int argc, char** argv) {
    ros::init(argc, argv, "encoder_odometry_node");
    ros::NodeHandle nh;

    ros::Publisher odom_pub = nh.advertise<nav_msgs::Odometry>("odom", 50);
    tf::TransformBroadcaster odom_broadcaster;

    // -------------------- Open Serial --------------------
    try {
        ser.setPort("/dev/ttyACM0");
        ser.setBaudrate(115200);
        serial::Timeout to = serial::Timeout::simpleTimeout(1000);
        ser.setTimeout(to);
        ser.open();
        ROS_INFO("Serial port opened successfully.");
    } catch (serial::IOException& e) {
        ROS_ERROR_STREAM("Unable to open port: " << e.what());
        return -1;
    }

    if (!ser.isOpen()) {
        ROS_ERROR("Serial port not open.");
        return -1;
    }

    ros::Rate rate(20); // 50 Hz loop
    last_time = ros::Time::now();

    // ===================== Main Loop =====================
    while (ros::ok()) {
        if (ser.available()) {
            std::string line = ser.readline(1024, "\n");
            //ROS_INFO_STREAM("Serial line received: " << line);

            int64_t left_ticks, right_ticks, steer_ticks;
            parseLine(line, left_ticks, right_ticks, steer_ticks);

            // -------------------- Initialize first read --------------------
            if (first_read) {
                last_left_ticks = left_ticks;
                last_right_ticks = right_ticks;
                last_steer_ticks = steer_ticks;
                last_time = ros::Time::now();
                first_read = false;
                ROS_INFO("First read completed, initializing tick values.");
                continue;
            }

            // -------------------- Timestamp --------------------
            ros::Time stamp = ros::Time::now();

            double dt = (stamp - last_time).toSec();
            if (dt <= 0.0) {
                ROS_WARN_THROTTLE(1, "Delta time zero or negative, skipping update.");
                continue;
            }

            // -------------------- Compute Tick Differences --------------------
            int64_t delta_left = left_ticks - last_left_ticks;
            int64_t delta_right = right_ticks - last_right_ticks;
            int64_t delta_steer = steer_ticks - last_steer_ticks;

            last_left_ticks = left_ticks;
            last_right_ticks = right_ticks;
            last_steer_ticks = steer_ticks;
            last_time = stamp;

            // -------------------- Convert to Distances --------------------
            double d_left = -delta_left * DIST_PER_TICK;
            double d_right = delta_right * DIST_PER_TICK;
            double d_center = (d_left + d_right) / 2.0;

            // -------------------- Steering Angle --------------------
            double steer_angle = ((steer_ticks / STEER_TICKS_PER_REV) * 2.0 * M_PI * STEER_RATIO) * STEER_SENSITIVITY;
            if (fabs(steer_angle) < STEER_DEADBAND) steer_angle = 0.0;

            // -------------------- Update Robot Pose --------------------
            double delta_theta = (steer_angle == 0.0) ? 0.0 : steer_angle * d_center / WHEEL_BASE;
            double theta_prev = theta;
            theta += delta_theta;

            x += d_center * cos(theta_prev + delta_theta / 2.0);
            y += d_center * sin(theta_prev + delta_theta / 2.0);

            geometry_msgs::Quaternion odom_quat = tf::createQuaternionMsgFromYaw(theta);

            // -------------------- Publish TF --------------------
            geometry_msgs::TransformStamped odom_trans;
            odom_trans.header.stamp = stamp;
            odom_trans.header.frame_id = "odom";
            odom_trans.child_frame_id = "base_link";
            odom_trans.transform.translation.x = x;
            odom_trans.transform.translation.y = y;
            odom_trans.transform.translation.z = 0.0;
            odom_trans.transform.rotation = odom_quat;
            odom_broadcaster.sendTransform(odom_trans);

            // -------------------- Publish Odometry --------------------
            nav_msgs::Odometry odom;
            odom.header.stamp = stamp;
            odom.header.frame_id = "odom";
            odom.child_frame_id = "base_link";
            odom.pose.pose.position.x = x;
            odom.pose.pose.position.y = y;
            odom.pose.pose.position.z = 0.0;
            odom.pose.pose.orientation = odom_quat;
            odom.twist.twist.linear.x = d_center / dt;
            odom.twist.twist.angular.z = delta_theta / dt;

            odom_pub.publish(odom);
        } else {
            ROS_WARN_THROTTLE(5, "No serial data available yet.");
        }

        ros::spinOnce();
        rate.sleep();
    }

    return 0;
}

