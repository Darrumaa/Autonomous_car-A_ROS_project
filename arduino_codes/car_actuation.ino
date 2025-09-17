#include <ros.h>
#include <ackermann_msgs/AckermannDriveStamped.h>

// ====== ROS Node Handle ======
ros::NodeHandle nh;

// ====== Motor driver pins (IBT-2 BTS7960) ======
// Drive motor
const int MOTOR_RPWM = 5;
const int MOTOR_LPWM = 6;

// Steering motor
const int STEER_RPWM = 7;
const int STEER_LPWM = 8;

// ====== Scaling factors (tune these) ======
// Rough mapping from SI units → PWM
const float SPEED_TO_PWM = 200.0;   // m/s → pwm (increase if too weak)
const float STEER_TO_PWM = 150.0;   // rad → pwm

// ====== Deadband threshold ======
const int MIN_PWM = 60; // IBT-2 needs ~60+ to overcome motor deadband

// ====== Helper: set motor power for IBT-2 ======
void setMotor(int rpwm_pin, int lpwm_pin, float value) {
  value = constrain(value, -255, 255);

  if (value > 0) {
    if (value < MIN_PWM) value = MIN_PWM;  // overcome deadband
    analogWrite(rpwm_pin, (int)value);
    analogWrite(lpwm_pin, 0);
  } else if (value < 0) {
    if (value > -MIN_PWM) value = -MIN_PWM;
    analogWrite(rpwm_pin, 0);
    analogWrite(lpwm_pin, (int)(-value));
  } else {
    analogWrite(rpwm_pin, 0);
    analogWrite(lpwm_pin, 0);
  }
}

// ====== Subscriber: Ackermann command ======
void ackermannCb(const ackermann_msgs::AckermannDriveStamped& msg) {
  float pwm_speed = msg.drive.speed * SPEED_TO_PWM;
  float pwm_steer = msg.drive.steering_angle * STEER_TO_PWM;

  setMotor(MOTOR_RPWM, MOTOR_LPWM, pwm_speed);
  setMotor(STEER_RPWM, STEER_LPWM, pwm_steer);

  nh.loginfo("Received AckermannDriveStamped cmd");
}

ros::Subscriber<ackermann_msgs::AckermannDriveStamped> sub_cmd("ackermann_cmd", ackermannCb);

void setup() {
  pinMode(MOTOR_RPWM, OUTPUT);
  pinMode(MOTOR_LPWM, OUTPUT);
  pinMode(STEER_RPWM, OUTPUT);
  pinMode(STEER_LPWM, OUTPUT);

  nh.getHardware()->setBaud(115200);
  nh.initNode();
  nh.subscribe(sub_cmd);
}

void loop() {
  nh.spinOnce();
  delay(10);
}
