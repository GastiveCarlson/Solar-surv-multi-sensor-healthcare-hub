# ☀️ Solar-Surv-Tech Multi-Sensor Hub

**One hub, many lifesaving eyes.**

A solar-powered, modular health surveillance device for rural clinics that monitors multiple health threats through pluggable sensors and provides offline alerts via LoRa/GSM.

![Status](https://img.shields.io/badge/status-prototype-yellow)
![License](https://img.shields.io/badge/license-MIT-blue)
![Platform](https://img.shields.io/badge/platform-Arduino-orange)

## 🎯 Problem Statement

Rural health facilities in Africa face critical challenges:
- Limited connectivity prevents real-time health monitoring
- Unreliable power infrastructure causes equipment failures
- Single-purpose devices are costly and inflexible
- Delayed emergency response due to lack of alert systems
- Vaccine cold-chain failures go undetected

## 💡 Solution

Solar-Surv is a modular, off-grid surveillance hub that:
- Monitors **multiple sensor inputs** (patient vitals, vaccine storage, environment)
- Performs **local threshold checking** without internet dependency
- Triggers **immediate offline alerts** (LED/buzzer + wireless messaging)
- Operates on **solar power** with battery backup
- Scales across clinics with **unique device IDs**

## 🔧 Key Features

### Multi-Sensor Architecture
- **Patient Vitals**: Heart rate, SpO₂, blood pressure monitoring
- **Cold Chain**: Vaccine refrigerator temperature (2-8°C range)
- **Environment**: Room humidity and temperature
- **Emergency**: Manual distress button

### Intelligent Alert System
- **Local Alerts**: LED indicators + audible buzzer
- **Remote Alerts**: LoRa/GSM messaging with sensor ID
- **Threshold Logic**: Configurable rules per sensor
- **Dashboard Display**: Web-based receiver interface

### Off-Grid Operation
- Solar panel charging system
- Rechargeable battery with multi-day autonomy
- Low-power sleep modes
- Rugged, weather-resistant design

## 🏗️ System Architecture

```
┌─────────────┐      ┌──────────────────┐      ┌─────────────┐      ┌──────────────┐
│   Sensors   │─────▶│  Microcontroller │─────▶│ LoRa/GSM    │─────▶│  Dashboard   │
│  (P01, F02, │      │  Threshold Logic │      │  Module     │      │  (Receiver)  │
│   H03)      │      └──────────────────┘      └─────────────┘      └──────────────┘
└─────────────┘               │                                              │
                               │                                              │
                        ┌──────▼──────┐                                      │
                        │ Solar Panel │                              ┌───────▼────────┐
                        │  + Battery  │                              │ Alerts Display │
                        └─────────────┘                              │  - Patient P01 │
                                                                      │  - Fridge F02  │
                                                                      │  - Room H03    │
                                                                      └────────────────┘
```

## 📊 Technical Specifications

### Hardware Components
- **Microcontroller**: ESP32 / Arduino Mega
- **Sensors**:
  - MAX30102 (Pulse + SpO₂)
  - DS18B20 (Temperature)
  - DHT22 (Humidity)
- **Communication**: LoRa SX1278 / SIM800L GSM
- **Power**: 10W Solar Panel + 12V LiPo Battery
- **Alerts**: LED strips + Piezo buzzer

### Software Stack
- Arduino C++ for firmware
- Web dashboard (HTML/CSS/JavaScript)
- LoRa/GSM protocol handling
- Low-power optimization

## 🚀 Demo Workflow

1. **Normal Operation**: All sensors within safe thresholds → Green status
2. **Breach Detection**: Sensor exceeds threshold → Local alert triggered
3. **Alert Transmission**: Message sent via LoRa/SMS with sensor ID
4. **Dashboard Update**: Receiver displays alert with source identification
5. **Response**: Healthcare workers respond based on alert type

### Example Alerts
```
🚨 CRITICAL: Patient pulse low (35 BPM) - ID: P01
⚠️ WARNING: Vaccine fridge overheating (9.1°C) - ID: F02
⚠️ WARNING: High humidity detected (88%) - ID: H03
```

## 💻 Installation & Setup

### Prerequisites
```bash
- Arduino IDE 2.0+
- LoRa library
- Sensor libraries (MAX30102, DHT, DS18B20)
- Web browser for dashboard
```

### Hardware Setup
1. Connect sensors to microcontroller pins (see wiring diagram)
2. Install LoRa module and antenna
3. Connect solar panel to charge controller
4. Mount battery pack

### Software Setup
```bash
# Clone repository
git clone https://github.com/yourusername/solar-surv.git
cd solar-surv

# Upload firmware
arduino-cli compile --fqbn esp32:esp32:esp32 firmware/
arduino-cli upload -p /dev/ttyUSB0 --fqbn esp32:esp32:esp32 firmware/

# Launch dashboard
cd dashboard
python3 -m http.server 8000
# Open http://localhost:8000 in browser
```

## 📈 Real-World Impact

### Immediate Benefits
✅ Faster emergency response (patient distress, equipment failure)  
✅ Works fully offline in low-connectivity areas  
✅ Reliable solar power reduces downtime  
✅ Multi-threat monitoring from single device  

### Scalability
🔧 Modular sensor swapping for different use cases  
🔧 Unique IDs support hundreds of devices per region  
🔧 Low-cost design enables mass deployment  
🔧 Adaptable to maternal health, outbreak detection, water quality  

### Long-Term Vision
🌍 Strengthen disease surveillance networks across rural Africa  
🌍 Close alert gaps in remote health systems  
🌍 Build resilient, connected healthcare infrastructure  

## 🛣️ Roadmap

- [x] Prototype development
- [x] Dashboard interface
- [ ] Field testing in pilot clinic
- [ ] TinyML anomaly detection integration
- [ ] Mobile app for dashboard
- [ ] Multi-language support
- [ ] Integration with national health systems

## 📸 Screenshots

### Dashboard - Normal State
![Dashboard Normal](docs/images/dashboard-normal.png)

### Dashboard - Alert State
![Dashboard Alert](docs/images/dashboard-alert.png)

### Hardware Prototype
![Hardware](docs/images/hardware-prototype.png)

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md) first.

1. Fork the repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

## 👥 Team

- **Your Name** - Lead Developer - [@yourusername](https://github.com/yourusername)

## 🙏 Acknowledgments

- Hackathon organizers and mentors
- Rural health workers who inspired this solution
- Open-source community for libraries and tools

## 📞 Contact

- Project Link: [https://github.com/yourusername/solar-surv-tech](https://github.com/yourusername/solar-surv-tech)
- Email: your.email@example.com
- Twitter: [@yourhandle](https://twitter.com/yourhandle)

---

**Built with ❤️ for rural healthcare in Africa**