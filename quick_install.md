# 🚀 Solar-Surv-Tech - Super Easy Setup Guide

## Option 1: Complete Automated Setup (Easiest!)

### Step 1: Download the setup script

Copy this **entire command** and paste it into your terminal:

```bash
curl -o setup-solar-surv-tech.sh https://raw.githubusercontent.com/[AFTER-YOU-UPLOAD]/solar-surv-tech/main/scripts/setup-solar-surv-tech.sh && chmod +x setup-solar-surv-tech.sh && ./setup-solar-surv-tech.sh
```

**OR** manually create the script:

```bash
# Download the setup script I created above
# Save it as "setup-solar-surv-tech.sh" in your desired location
# Then run:

chmod +x setup-solar-surv-tech.sh
./setup-solar-surv-tech.sh
```

### Step 2: Answer the prompts

The script will ask you for:
- Your GitHub username
- Your email
- Your name

### Step 3: Create GitHub repository

After the script finishes, choose one:

**If you have GitHub CLI:**
```bash
cd solar-surv-tech
gh auth login
gh repo create solar-surv-tech --public --source=. --remote=origin --push
```

**If you don't have GitHub CLI:**
1. Go to https://github.com/new
2. Name: `solar-surv-tech`
3. Public repository
4. DON'T initialize with README
5. Click "Create repository"
6. Then in terminal:
```bash
cd solar-surv-tech
git remote add origin https://github.com/YOUR-USERNAME/solar-surv-tech.git
git branch -M main
git push -u origin main
```

---

## Option 2: Manual Step-by-Step

If you prefer to do it manually, here are the exact commands:

```bash
# 1. Create project folder
mkdir solar-surv-tech
cd solar-surv-tech

# 2. Initialize git
git init

# 3. Set up your git identity
git config user.name "Your Name"
git config user.email "your.email@example.com"

# 4. Create directories
mkdir -p firmware dashboard/{css,js,assets} hardware/{schematics,pcb} docs/{images,presentations} tests scripts

# 5. Download the dashboard HTML
# Copy the dashboard HTML I created earlier and save as: dashboard/index.html

# 6. Create README.md
# Copy the README content I provided and save as: README.md

# 7. Create .gitignore
# Copy the .gitignore content and save as: .gitignore

# 8. Create LICENSE
# Copy the LICENSE content and save as: LICENSE

# 9. Commit everything
git add .
git commit -m "Initial commit: Solar-Surv-Tech prototype"

# 10. Create repo on GitHub and push
git remote add origin https://github.com/YOUR-USERNAME/solar-surv-tech.git
git branch -M main
git push -u origin main
```

---

## Option 3: Super Quick (GitHub Desktop)

1. Install GitHub Desktop: https://desktop.github.com/
2. Create folder named `solar-surv-tech`
3. Add all the files I provided
4. Open GitHub Desktop
5. File → Add Local Repository → Select solar-surv-tech folder
6. Commit all files
7. Publish repository to GitHub (button in top right)

---

## What You Need to Add Manually

After setup, you'll need to:

### 1. Copy the Dashboard HTML
Save this as `dashboard/index.html` (I created this in the first artifact above)

### 2. Copy the Arduino Firmware
Save this as `firmware/solar-surv-tech.ino` (I created this earlier)

### 3. Add Photos (Optional but Recommended)
- Take photos of your hardware
- Screenshot the dashboard
- Save in `docs/images/`

### 4. Customize README
- Replace "YOUR-USERNAME" with your actual GitHub username
- Add your contact info
- Add your name to the team section

---

## Troubleshooting

### "Permission denied" when running script
```bash
chmod +x setup-solar-surv.sh
```

### "git: command not found"
Install git first:
- Mac: `brew install git`
- Ubuntu/Debian: `sudo apt-get install git`
- Windows: Download from https://git-scm.com/

### "gh: command not found" 
Install GitHub CLI:
- Mac: `brew install gh`
- Ubuntu/Debian: See https://github.com/cli/cli/blob/trunk/docs/install_linux.md
- Windows: Download from https://cli.github.com/

### Need to authenticate with GitHub
```bash
gh auth login
# Follow the prompts
```

---

## After Your Repo is Live

### Enable GitHub Pages for Dashboard
1. Go to your repo on GitHub
2. Settings → Pages
3. Source: Deploy from branch
4. Branch: main, folder: /dashboard
5. Save
4. Your dashboard will be at: `https://YOUR-USERNAME.github.io/solar-surv-tech/`

### Add Topics
Click "Add topics" on your repo and add:
- `iot`
- `healthcare`
- `arduino`
- `lora`
- `africa`
- `solar-power`
- `sensor-monitoring`

### Share Your Project
- Tweet about it with #IoT #HealthTech
- Post on Reddit: r/arduino, r/raspberry_pi
- Submit to Hackster.io
- Share on LinkedIn

---

## Need Help?

Can't get something to work? Let me know which step is causing issues and I'll help troubleshoot!