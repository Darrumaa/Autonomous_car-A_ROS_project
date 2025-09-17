// Auto-generated. Do not edit!

// (in-package ackermann_encoder_odometry.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class EncoderTicks {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.left = null;
      this.right = null;
      this.steering = null;
    }
    else {
      if (initObj.hasOwnProperty('left')) {
        this.left = initObj.left
      }
      else {
        this.left = 0;
      }
      if (initObj.hasOwnProperty('right')) {
        this.right = initObj.right
      }
      else {
        this.right = 0;
      }
      if (initObj.hasOwnProperty('steering')) {
        this.steering = initObj.steering
      }
      else {
        this.steering = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type EncoderTicks
    // Serialize message field [left]
    bufferOffset = _serializer.int64(obj.left, buffer, bufferOffset);
    // Serialize message field [right]
    bufferOffset = _serializer.int64(obj.right, buffer, bufferOffset);
    // Serialize message field [steering]
    bufferOffset = _serializer.int64(obj.steering, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type EncoderTicks
    let len;
    let data = new EncoderTicks(null);
    // Deserialize message field [left]
    data.left = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [right]
    data.right = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [steering]
    data.steering = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'ackermann_encoder_odometry/EncoderTicks';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd4c5a794458df2ce8a4f30070d9589ef';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int64 left
    int64 right
    int64 steering
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new EncoderTicks(null);
    if (msg.left !== undefined) {
      resolved.left = msg.left;
    }
    else {
      resolved.left = 0
    }

    if (msg.right !== undefined) {
      resolved.right = msg.right;
    }
    else {
      resolved.right = 0
    }

    if (msg.steering !== undefined) {
      resolved.steering = msg.steering;
    }
    else {
      resolved.steering = 0
    }

    return resolved;
    }
};

module.exports = EncoderTicks;
