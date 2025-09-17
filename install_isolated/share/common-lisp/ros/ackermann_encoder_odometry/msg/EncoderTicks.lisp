; Auto-generated. Do not edit!


(cl:in-package ackermann_encoder_odometry-msg)


;//! \htmlinclude EncoderTicks.msg.html

(cl:defclass <EncoderTicks> (roslisp-msg-protocol:ros-message)
  ((left
    :reader left
    :initarg :left
    :type cl:integer
    :initform 0)
   (right
    :reader right
    :initarg :right
    :type cl:integer
    :initform 0)
   (steering
    :reader steering
    :initarg :steering
    :type cl:integer
    :initform 0))
)

(cl:defclass EncoderTicks (<EncoderTicks>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EncoderTicks>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EncoderTicks)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ackermann_encoder_odometry-msg:<EncoderTicks> is deprecated: use ackermann_encoder_odometry-msg:EncoderTicks instead.")))

(cl:ensure-generic-function 'left-val :lambda-list '(m))
(cl:defmethod left-val ((m <EncoderTicks>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ackermann_encoder_odometry-msg:left-val is deprecated.  Use ackermann_encoder_odometry-msg:left instead.")
  (left m))

(cl:ensure-generic-function 'right-val :lambda-list '(m))
(cl:defmethod right-val ((m <EncoderTicks>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ackermann_encoder_odometry-msg:right-val is deprecated.  Use ackermann_encoder_odometry-msg:right instead.")
  (right m))

(cl:ensure-generic-function 'steering-val :lambda-list '(m))
(cl:defmethod steering-val ((m <EncoderTicks>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ackermann_encoder_odometry-msg:steering-val is deprecated.  Use ackermann_encoder_odometry-msg:steering instead.")
  (steering m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EncoderTicks>) ostream)
  "Serializes a message object of type '<EncoderTicks>"
  (cl:let* ((signed (cl:slot-value msg 'left)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'right)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'steering)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EncoderTicks>) istream)
  "Deserializes a message object of type '<EncoderTicks>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'left) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'right) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'steering) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EncoderTicks>)))
  "Returns string type for a message object of type '<EncoderTicks>"
  "ackermann_encoder_odometry/EncoderTicks")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EncoderTicks)))
  "Returns string type for a message object of type 'EncoderTicks"
  "ackermann_encoder_odometry/EncoderTicks")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EncoderTicks>)))
  "Returns md5sum for a message object of type '<EncoderTicks>"
  "d4c5a794458df2ce8a4f30070d9589ef")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EncoderTicks)))
  "Returns md5sum for a message object of type 'EncoderTicks"
  "d4c5a794458df2ce8a4f30070d9589ef")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EncoderTicks>)))
  "Returns full string definition for message of type '<EncoderTicks>"
  (cl:format cl:nil "int64 left~%int64 right~%int64 steering~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EncoderTicks)))
  "Returns full string definition for message of type 'EncoderTicks"
  (cl:format cl:nil "int64 left~%int64 right~%int64 steering~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EncoderTicks>))
  (cl:+ 0
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EncoderTicks>))
  "Converts a ROS message object to a list"
  (cl:list 'EncoderTicks
    (cl:cons ':left (left msg))
    (cl:cons ':right (right msg))
    (cl:cons ':steering (steering msg))
))
