
(cl:in-package :asdf)

(defsystem "ackermann_encoder_odometry-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "EncoderTicks" :depends-on ("_package_EncoderTicks"))
    (:file "_package_EncoderTicks" :depends-on ("_package"))
  ))