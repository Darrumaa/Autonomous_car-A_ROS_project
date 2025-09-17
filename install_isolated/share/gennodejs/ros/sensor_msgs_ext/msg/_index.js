
"use strict";

let magnetometer = require('./magnetometer.js');
let accelerometer = require('./accelerometer.js');
let time_reference = require('./time_reference.js');
let proximity = require('./proximity.js');
let gyroscope = require('./gyroscope.js');
let gnss_fix = require('./gnss_fix.js');
let gnss_track = require('./gnss_track.js');
let analog_voltage = require('./analog_voltage.js');
let covariance = require('./covariance.js');
let axis_state = require('./axis_state.js');
let temperature = require('./temperature.js');
let gnss_position = require('./gnss_position.js');

module.exports = {
  magnetometer: magnetometer,
  accelerometer: accelerometer,
  time_reference: time_reference,
  proximity: proximity,
  gyroscope: gyroscope,
  gnss_fix: gnss_fix,
  gnss_track: gnss_track,
  analog_voltage: analog_voltage,
  covariance: covariance,
  axis_state: axis_state,
  temperature: temperature,
  gnss_position: gnss_position,
};
