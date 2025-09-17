;; Auto-generated. Do not edit!


(when (boundp 'ackermann_encoder_odometry::EncoderTicks)
  (if (not (find-package "ACKERMANN_ENCODER_ODOMETRY"))
    (make-package "ACKERMANN_ENCODER_ODOMETRY"))
  (shadow 'EncoderTicks (find-package "ACKERMANN_ENCODER_ODOMETRY")))
(unless (find-package "ACKERMANN_ENCODER_ODOMETRY::ENCODERTICKS")
  (make-package "ACKERMANN_ENCODER_ODOMETRY::ENCODERTICKS"))

(in-package "ROS")
;;//! \htmlinclude EncoderTicks.msg.html


(defclass ackermann_encoder_odometry::EncoderTicks
  :super ros::object
  :slots (_left _right _steering ))

(defmethod ackermann_encoder_odometry::EncoderTicks
  (:init
   (&key
    ((:left __left) 0)
    ((:right __right) 0)
    ((:steering __steering) 0)
    )
   (send-super :init)
   (setq _left (round __left))
   (setq _right (round __right))
   (setq _steering (round __steering))
   self)
  (:left
   (&optional __left)
   (if __left (setq _left __left)) _left)
  (:right
   (&optional __right)
   (if __right (setq _right __right)) _right)
  (:steering
   (&optional __steering)
   (if __steering (setq _steering __steering)) _steering)
  (:serialization-length
   ()
   (+
    ;; int64 _left
    8
    ;; int64 _right
    8
    ;; int64 _steering
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _left
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _left (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _left) (= (length (_left . bv)) 2)) ;; bignum
              (write-long (ash (elt (_left . bv) 0) 0) s)
              (write-long (ash (elt (_left . bv) 1) -1) s))
             ((and (class _left) (= (length (_left . bv)) 1)) ;; big1
              (write-long (elt (_left . bv) 0) s)
              (write-long (if (>= _left 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _left s)(write-long (if (>= _left 0) 0 #xffffffff) s)))
     ;; int64 _right
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _right (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _right) (= (length (_right . bv)) 2)) ;; bignum
              (write-long (ash (elt (_right . bv) 0) 0) s)
              (write-long (ash (elt (_right . bv) 1) -1) s))
             ((and (class _right) (= (length (_right . bv)) 1)) ;; big1
              (write-long (elt (_right . bv) 0) s)
              (write-long (if (>= _right 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _right s)(write-long (if (>= _right 0) 0 #xffffffff) s)))
     ;; int64 _steering
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _steering (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _steering) (= (length (_steering . bv)) 2)) ;; bignum
              (write-long (ash (elt (_steering . bv) 0) 0) s)
              (write-long (ash (elt (_steering . bv) 1) -1) s))
             ((and (class _steering) (= (length (_steering . bv)) 1)) ;; big1
              (write-long (elt (_steering . bv) 0) s)
              (write-long (if (>= _steering 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _steering s)(write-long (if (>= _steering 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _left
#+(or :alpha :irix6 :x86_64)
      (setf _left (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _left (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _right
#+(or :alpha :irix6 :x86_64)
      (setf _right (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _right (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _steering
#+(or :alpha :irix6 :x86_64)
      (setf _steering (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _steering (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;;
   self)
  )

(setf (get ackermann_encoder_odometry::EncoderTicks :md5sum-) "d4c5a794458df2ce8a4f30070d9589ef")
(setf (get ackermann_encoder_odometry::EncoderTicks :datatype-) "ackermann_encoder_odometry/EncoderTicks")
(setf (get ackermann_encoder_odometry::EncoderTicks :definition-)
      "int64 left
int64 right
int64 steering


")



(provide :ackermann_encoder_odometry/EncoderTicks "d4c5a794458df2ce8a4f30070d9589ef")


