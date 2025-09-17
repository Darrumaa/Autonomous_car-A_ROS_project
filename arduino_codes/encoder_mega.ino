#include <Encoder.h>

// Define encoder objects
Encoder leftEncoder(3, 5);       
Encoder rightEncoder(2, 4);    
Encoder steeringEncoder(18, 19); 

// Store last positions
long lastLeft = 0;
long lastRight = 0;
long lastSteering = 0;

void setup() {
  Serial.begin(115200);
  Serial.flush();
  delay(100);
  Serial.println("Triple Encoder Reader");
}

void loop() {
  long newLeft = leftEncoder.read();
  long newRight = rightEncoder.read();
  long newSteering = steeringEncoder.read();

  char buffer[100];
  snprintf(buffer, sizeof(buffer), "Left: %ld | Right: %ld | Steering: %ld", newLeft, newRight  , newSteering);
  Serial.println(buffer);

  lastLeft = newLeft;
  lastRight = newRight;
  lastSteering = newSteering;

  delay(50);
}
