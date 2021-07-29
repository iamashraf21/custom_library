#include <AUnit.h>

test(correct) {
  int x = 1;
  assertEqual(x, 1);
}

test(incorrect) {
  int x = 2;
  assertNotEqual(x, 9);
}

test(Custom) {
  int x = 4;
  assertEqual(x, 5);
}

//----------------------------------------------------------------------------
// setup() and loop()
//----------------------------------------------------------------------------

void setup() {
  delay(1000); // wait for stability on some boards to prevent garbage Serial
  Serial.begin(115200); // ESP8266 default of 74880 not supported on Linux
  while(!Serial); // for the Arduino Leonardo/Micro only
}

void loop() {
  //aunit::TestRunner::run();
  aunit::PrintXml::runXml();
  delay(500);
}
