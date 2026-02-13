/*
 * Solar-Surv-Tech Multi-Sensor Hub Firmware
 * 
 * Monitors multiple health/environment sensors and sends
 * alerts via LoRa when thresholds are breached.
 * 
 * Hardware: ESP32 or Arduino Mega
 * Sensors: MAX30102 (pulse), DS18B20 (temp), DHT22 (humidity)
 * Communication: LoRa SX1278
 */

#include <Wire.h>
#include <SPI.h>
#include <LoRa.h>
#include <DHT.h>
#include <OneWire.h>
#include <DallasTemperature.h>

// Pin Definitions
#define DHTPIN 4
#define DHTTYPE DHT22
#define TEMP_SENSOR_PIN 5
#define BUZZER_PIN 13
#define LED_RED_PIN 12
#define LED_GREEN_PIN 14
#define EMERGENCY_BUTTON 15

// LoRa Pins (adjust for your module)
#define LORA_SS 18
#define LORA_RST 14
#define LORA_DIO0 26

// Sensor IDs
#define DEVICE_ID "HUB001"
#define PATIENT_ID "P01"
#define FRIDGE_ID "F02"
#define ENVIRONMENT_ID "H03"

// Thresholds
#define PULSE_MIN 40
#define PULSE_MAX 120
#define TEMP_MIN 2.0
#define TEMP_MAX 8.0
#define HUMIDITY_MAX 85.0

// Timing
#define SENSOR_READ_INTERVAL 5000
#define ALERT_COOLDOWN 30000

// Initialize sensors
DHT dht(DHTPIN, DHTTYPE);
OneWire oneWire(TEMP_SENSOR_PIN);
DallasTemperature tempSensor(&oneWire);

// Global variables
unsigned long lastReadTime = 0;
unsigned long lastAlertTime = 0;
bool systemActive = true;

struct SensorData {
  float pulseRate;
  float fridgeTemp;
  float roomHumidity;
  bool emergencyPressed;
};

SensorData currentData;

void setup() {
  Serial.begin(115200);
  
  // Initialize pins
  pinMode(BUZZER_PIN, OUTPUT);
  pinMode(LED_RED_PIN, OUTPUT);
  pinMode(LED_GREEN_PIN, OUTPUT);
  pinMode(EMERGENCY_BUTTON, INPUT_PULLUP);
  
  // Start with green LED
  digitalWrite(LED_GREEN_PIN, HIGH);
  digitalWrite(LED_RED_PIN, LOW);
  
  // Initialize sensors
  dht.begin();
  tempSensor.begin();
  
  // Initialize LoRa
  LoRa.setPins(LORA_SS, LORA_RST, LORA_DIO0);
  if (!LoRa.begin(915E6)) {
    Serial.println("LoRa init failed!");
    flashError();
    while (1);
  }
  
  Serial.println("Solar-Surv-Tech Multi-Sensor Hub Initialized");
  Serial.println("Device ID: " + String(DEVICE_ID));
  
  // Startup beep
  tone(BUZZER_PIN, 1000, 200);
  delay(300);
  tone(BUZZER_PIN, 1500, 200);
}

void loop() {
  unsigned long currentTime = millis();
  
  // Read sensors at intervals
  if (currentTime - lastReadTime >= SENSOR_READ_INTERVAL) {
    lastReadTime = currentTime;
    
    readSensors();
    checkThresholds();
    
    // Print status to serial
    printStatus();
  }
  
  // Check emergency button
  if (digitalRead(EMERGENCY_BUTTON) == LOW) {
    handleEmergency();
    delay(1000); // Debounce
  }
  
  delay(100);
}

void readSensors() {
  // Simulate pulse reading (replace with MAX30102 library)
  currentData.pulseRate = random(35, 100); // For demo
  
  // Read fridge temperature
  tempSensor.requestTemperatures();
  currentData.fridgeTemp = tempSensor.getTempCByIndex(0);
  
  // Read room humidity
  currentData.roomHumidity = dht.readHumidity();
  
  // Validate readings
  if (isnan(currentData.roomHumidity)) {
    currentData.roomHumidity = -1;
  }
  if (currentData.fridgeTemp == DEVICE_DISCONNECTED_C) {
    currentData.fridgeTemp = -1;
  }
}

void checkThresholds() {
  bool alertTriggered = false;
  String alertMessage = "";
  
  // Check pulse
  if (currentData.pulseRate > 0 && 
      (currentData.pulseRate < PULSE_MIN || currentData.pulseRate > PULSE_MAX)) {
    alertMessage = "CRITICAL: Patient pulse abnormal (" + 
                   String(currentData.pulseRate, 0) + " BPM) - ID: " + PATIENT_ID;
    alertTriggered = true;
    triggerAlert(alertMessage, true);
  }
  
  // Check fridge temperature
  if (currentData.fridgeTemp > 0 &&
      (currentData.fridgeTemp < TEMP_MIN || currentData.fridgeTemp > TEMP_MAX)) {
    alertMessage = "WARNING: Vaccine fridge temp breach (" + 
                   String(currentData.fridgeTemp, 1) + "C) - ID: " + FRIDGE_ID;
    alertTriggered = true;
    triggerAlert(alertMessage, false);
  }
  
  // Check humidity
  if (currentData.roomHumidity > 0 && currentData.roomHumidity > HUMIDITY_MAX) {
    alertMessage = "WARNING: High humidity detected (" + 
                   String(currentData.roomHumidity, 0) + "%) - ID: " + ENVIRONMENT_ID;
    alertTriggered = true;
    triggerAlert(alertMessage, false);
  }
  
  // If no alerts, ensure green LED
  if (!alertTriggered) {
    digitalWrite(LED_GREEN_PIN, HIGH);
    digitalWrite(LED_RED_PIN, LOW);
  }
}

void triggerAlert(String message, bool isCritical) {
  unsigned long currentTime = millis();
  
  // Alert cooldown to prevent spam
  if (currentTime - lastAlertTime < ALERT_COOLDOWN) {
    return;
  }
  
  lastAlertTime = currentTime;
  
  Serial.println("\n*** ALERT ***");
  Serial.println(message);
  
  // Visual alert
  digitalWrite(LED_GREEN_PIN, LOW);
  digitalWrite(LED_RED_PIN, HIGH);
  
  // Audible alert
  if (isCritical) {
    // Urgent pattern
    for (int i = 0; i < 5; i++) {
      tone(BUZZER_PIN, 2000, 100);
      delay(150);
    }
  } else {
    // Warning pattern
    tone(BUZZER_PIN, 1500, 300);
    delay(400);
    tone(BUZZER_PIN, 1500, 300);
  }
  
  // Send via LoRa
  sendLoRaMessage(message);
}

void handleEmergency() {
  String message = "EMERGENCY: Manual distress button pressed - Device: " + String(DEVICE_ID);
  
  Serial.println("\n*** EMERGENCY BUTTON PRESSED ***");
  
  // Continuous alarm
  digitalWrite(LED_RED_PIN, HIGH);
  for (int i = 0; i < 10; i++) {
    tone(BUZZER_PIN, 2500, 200);
    delay(300);
  }
  
  sendLoRaMessage(message);
}

void sendLoRaMessage(String message) {
  // Construct packet with device ID and timestamp
  String packet = String(DEVICE_ID) + "|" + 
                  String(millis() / 1000) + "|" + 
                  message;
  
  LoRa.beginPacket();
  LoRa.print(packet);
  LoRa.endPacket();
  
  Serial.println("LoRa message sent: " + packet);
}

void printStatus() {
  Serial.println("\n--- Sensor Status ---");
  Serial.print("Pulse: ");
  Serial.print(currentData.pulseRate, 0);
  Serial.println(" BPM");
  
  Serial.print("Fridge Temp: ");
  Serial.print(currentData.fridgeTemp, 1);
  Serial.println(" C");
  
  Serial.print("Room Humidity: ");
  Serial.print(currentData.roomHumidity, 0);
  Serial.println(" %");
  
  Serial.println("--------------------\n");
}

void flashError() {
  for (int i = 0; i < 10; i++) {
    digitalWrite(LED_RED_PIN, !digitalRead(LED_RED_PIN));
    delay(200);
  }
}