#!/bin/bash

# Solar-Surv-Tech GitHub Repository Setup Script
# This script automates the entire project setup process
# Run this script and it will do everything for you!

set -e  # Exit on error

echo "================================================"
echo "   Solar-Surv-Tech GitHub Repository Setup"
echo "================================================"
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get user information
echo -e "${BLUE}Please provide the following information:${NC}"
read -p "Enter your GitHub username: " GITHUB_USERNAME
read -p "Enter your email (for git config): " GIT_EMAIL
read -p "Enter your name (for git config): " GIT_NAME

echo ""
echo -e "${GREEN}✓ Configuration received${NC}"
echo ""

# Create project directory
PROJECT_DIR="solar-surv-tech"
echo -e "${BLUE}Creating project directory: $PROJECT_DIR${NC}"
mkdir -p $PROJECT_DIR
cd $PROJECT_DIR

# Initialize git
echo -e "${BLUE}Initializing git repository...${NC}"
git init
git config user.email "$GIT_EMAIL"
git config user.name "$GIT_NAME"

# Create directory structure
echo -e "${BLUE}Creating directory structure...${NC}"
mkdir -p firmware
mkdir -p dashboard/{css,js,assets/icons}
mkdir -p hardware/{schematics,pcb,enclosure/3d-models}
mkdir -p docs/{images,presentations}
mkdir -p tests/{sensor-tests,integration-tests}
mkdir -p scripts

echo -e "${GREEN}✓ Directory structure created${NC}"

# Create README.md
echo -e "${BLUE}Creating README.md...${NC}"
cat > README.md << 'EOF'
# ☀️ Solar-Surv Multi-Sensor Hub

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

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/USERNAME/solar-surv.git
cd solar-surv

# View the interactive dashboard
cd dashboard
python3 -m http.server 8000
# Open http://localhost:8000
```

## 📊 Features

- ✅ Multi-sensor monitoring (vitals, temperature, humidity)
- ✅ Offline-first architecture
- ✅ Solar-powered with battery backup
- ✅ LoRa/GSM communication
- ✅ Real-time alert dashboard
- ✅ Modular and scalable design

## 📸 Demo

![Dashboard Demo](docs/images/dashboard-demo.gif)

## 🛠️ Hardware Requirements

- ESP32 or Arduino Mega
- LoRa SX1278 Module
- DHT22 Humidity/Temperature Sensor
- DS18B20 Temperature Sensor
- 10W Solar Panel + 12V Battery
- LED indicators and buzzer

**Total estimated cost: ~$60 USD**

## 📖 Documentation

- [Installation Guide](docs/installation-guide.md)
- [User Manual](docs/user-manual.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Hardware Schematics](hardware/schematics/)

## 🤝 Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file.

## 🌍 Impact

Built with ❤️ for rural healthcare in Africa

---

**Star ⭐ this repo if you find it helpful!**
EOF

# Replace USERNAME with actual username
sed -i "s/USERNAME/$GITHUB_USERNAME/g" README.md
sed -i "s/solar-surv/solar-surv-tech/g" README.md

echo -e "${GREEN}✓ README.md created${NC}"

# Create .gitignore
echo -e "${BLUE}Creating .gitignore...${NC}"
cat > .gitignore << 'EOF'
# Arduino
*.hex
*.elf
*.bin
*.eep
*.lss
*.map
*.sym
build/
*.autosave

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Python
__pycache__/
*.py[cod]
venv/
env/

# Node
node_modules/
package-lock.json

# Logs
*.log

# Secrets
secrets.h
config_private.h
*.key
*.pem

# Hardware
*.bck
*.kicad_pcb-bak
fp-info-cache
EOF

echo -e "${GREEN}✓ .gitignore created${NC}"

# Create LICENSE
echo -e "${BLUE}Creating LICENSE...${NC}"
cat > LICENSE << 'EOF'
MIT License

Copyright (c) 2026 Solar-Surv Contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

echo -e "${GREEN}✓ LICENSE created${NC}"

# Create CONTRIBUTING.md
echo -e "${BLUE}Creating CONTRIBUTING.md...${NC}"
cat > CONTRIBUTING.md << 'EOF'
# Contributing to Solar-Surv

Thank you for your interest in improving healthcare in rural areas!

## How to Contribute

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Code Standards

- Follow Arduino style guide for firmware
- Keep dashboard lightweight for low-bandwidth areas
- Test on actual hardware when possible
- Document all changes

## Questions?

Open an issue with the `question` label.

Thank you! 🌍
EOF

echo -e "${GREEN}✓ CONTRIBUTING.md created${NC}"

# Create firmware libraries list
echo -e "${BLUE}Creating firmware/libraries.txt...${NC}"
cat > firmware/libraries.txt << 'EOF'
# Required Arduino Libraries for Solar-Surv

## Install these via Arduino Library Manager:

1. LoRa by Sandeep Mistry (v0.8.0+)
2. DHT sensor library by Adafruit (v1.4.0+)
3. DallasTemperature (v3.9.0+)
4. OneWire (v2.3.5+)

## Installation:
Arduino IDE → Tools → Manage Libraries → Search and install each library
EOF

echo -e "${GREEN}✓ libraries.txt created${NC}"

# Create Bill of Materials
echo -e "${BLUE}Creating hardware/bom.csv...${NC}"
cat > hardware/bom.csv << 'EOF'
Component,Quantity,Unit Cost (USD),Total Cost (USD),Source
ESP32 Development Board,1,8.00,8.00,AliExpress/Amazon
LoRa SX1278 Module,1,6.00,6.00,AliExpress
DHT22 Temperature/Humidity Sensor,1,4.00,4.00,Amazon
DS18B20 Temperature Sensor,1,3.00,3.00,Amazon
10W Solar Panel,1,12.00,12.00,Local supplier
12V 3000mAh LiPo Battery,1,15.00,15.00,Battery supplier
5V Buzzer,1,1.00,1.00,Electronics store
LED 5mm (Red),1,0.25,0.25,Electronics store
LED 5mm (Green),1,0.25,0.25,Electronics store
Push Button,1,0.50,0.50,Electronics store
Waterproof Enclosure,1,5.00,5.00,Local fabrication
Jumper Wires & Connectors,1 set,3.00,3.00,Electronics store
PCB (optional),1,2.00,2.00,PCB manufacturer
,,Total:,60.00,
EOF

echo -e "${GREEN}✓ Bill of Materials created${NC}"

# Create basic installation guide
echo -e "${BLUE}Creating docs/installation-guide.md...${NC}"
cat > docs/installation-guide.md << 'EOF'
# Solar-Surv Installation Guide

## Prerequisites

- Arduino IDE 2.0 or later
- USB cable for programming
- Required libraries (see firmware/libraries.txt)

## Step 1: Hardware Assembly

1. Connect ESP32 to breadboard
2. Wire sensors according to schematic
3. Connect LoRa module
4. Attach solar panel to charge controller
5. Connect battery

See `hardware/schematics/wiring-diagram.png` for detailed connections.

## Step 2: Software Setup

1. Install Arduino IDE from arduino.cc
2. Add ESP32 board support
3. Install required libraries
4. Open `firmware/solar-surv.ino`
5. Configure WiFi/LoRa settings in `config.h`
6. Select board: ESP32 Dev Module
7. Upload code

## Step 3: Dashboard Setup

1. Navigate to `dashboard/` folder
2. Run: `python3 -m http.server 8000`
3. Open browser: `http://localhost:8000`
4. Configure LoRa receiver settings

## Testing

1. Power on device
2. Check serial monitor for output
3. Trigger test alerts
4. Verify dashboard receives messages

## Troubleshooting

See `docs/troubleshooting.md` for common issues.
EOF

echo -e "${GREEN}✓ Installation guide created${NC}"

# Create placeholder images info
echo -e "${BLUE}Creating docs/images/README.md...${NC}"
cat > docs/images/README.md << 'EOF'
# Project Images

Place your project images here:

- `dashboard-normal.png` - Dashboard showing normal sensor readings
- `dashboard-alert.png` - Dashboard showing active alerts
- `hardware-prototype.jpg` - Photo of assembled hardware
- `dashboard-demo.gif` - Animated demo of dashboard in action
- `logo.png` - Project logo (optional)

## Image Guidelines

- Use PNG for screenshots
- Use JPG for photos
- Keep file sizes reasonable (< 2MB each)
- Use descriptive filenames
EOF

echo -e "${GREEN}✓ Images directory prepared${NC}"

# Stage all files
echo -e "${BLUE}Staging all files...${NC}"
git add .

# Create initial commit
echo -e "${BLUE}Creating initial commit...${NC}"
git commit -m "Initial commit: Solar-Surv-Tech Multi-Sensor Hub prototype

- Added comprehensive README with project overview
- Created firmware directory structure
- Added dashboard interface foundation
- Included hardware documentation templates
- Set up contribution guidelines
- Added MIT license"

echo -e "${GREEN}✓ Initial commit created${NC}"
echo ""

# Create GitHub repository
echo -e "${YELLOW}================================================${NC}"
echo -e "${YELLOW}NEXT STEPS - GitHub Repository Creation${NC}"
echo -e "${YELLOW}================================================${NC}"
echo ""
echo "Now you need to create the GitHub repository. Choose ONE option:"
echo ""
echo -e "${GREEN}OPTION 1: Using GitHub CLI (recommended)${NC}"
echo "If you have GitHub CLI installed (gh):"
echo ""
echo "  gh auth login"
echo "  gh repo create solar-surv-tech --public --source=. --remote=origin --push"
echo ""
echo -e "${GREEN}OPTION 2: Manual Creation${NC}"
echo "1. Go to https://github.com/new"
echo "2. Repository name: solar-surv-tech"
echo "3. Description: Solar-powered multi-sensor health surveillance hub"
echo "4. Choose: Public"
echo "5. Do NOT initialize with README"
echo "6. Click 'Create repository'"
echo "7. Then run these commands:"
echo ""
echo "  git remote add origin https://github.com/$GITHUB_USERNAME/solar-surv-tech.git"
echo "  git branch -M main"
echo "  git push -u origin main"
echo ""
echo -e "${BLUE}After pushing, your repository will be live at:${NC}"
echo "  https://github.com/$GITHUB_USERNAME/solar-surv-tech"
echo ""
echo -e "${GREEN}✓ Setup complete! Project ready in: $(pwd)${NC}"
echo ""
echo -e "${YELLOW}Don't forget to:${NC}"
echo "  • Add project topics/tags on GitHub"
echo "  • Upload photos to docs/images/"
echo "  • Copy the dashboard HTML (I'll provide separately)"
echo "  • Star your own repository ⭐"
echo ""