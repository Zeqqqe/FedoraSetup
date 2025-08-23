#!/bin/bash

# This line makes the script exit immediately if any command fails.
set -e

# --- 1. User Feedback ---
echo "Starting automated setup..."
echo "You may be asked for your password for software installation."

# --- 2. Install Programs ---
echo "Installing programs..."
sudo dnf install -y git pavucontrol python3-pip gparted

# Install Vesktop
echo "Downloading and installing Vesktop..."
# Use curl to get the .rpm file and save it in the /tmp directory
# Replace the URL with the latest version from the Vesktop GitHub releases page
curl -L "https://github.com/Vesktop/Vesktop/releases/download/v0.4.4/vesktop-0.4.4.x86_64.rpm" -o /tmp/vesktop.rpm

# Install the downloaded .rpm file
sudo dnf install -y /tmp/vesktop.rpm

# You can add other programs here, for example:
# sudo dnf install -y vlc screenkey

# --- 3. Set Up Virtual Audio Cable ---
echo "Setting up virtual audio cable..."
# Create the virtual output device (the "cable")
pactl load-module module-null-sink sink_name=virtual_cable sink_properties=device.description="Virtual_Cable"

# Create the loopback so you can hear the audio too
pactl load-module module-loopback source=virtual_cable.monitor sink=@DEFAULT_SINK@

echo "Audio cable created and active."

# --- 4. Get File from GitHub ---
echo "Downloading script from GitHub..."
# Navigate to the Documents folder to keep things tidy
cd ~/Documents

# **CHOOSE ONE METHOD BELOW**

# Method A: If you want to download an entire repository
# Replace the URL with the URL of the repository you want.
# git clone https://github.com/user/repository.git

# Method B: If you only want to download a single file
# Go to the file on GitHub, click the "Raw" button, and copy that URL.
# Replace the URL and the desired filename below.
curl -L "https://raw.githubusercontent.com/Zeqqqe/Python-Text-To-Speech/main/Text%20To%20Speech%20CLI.py" -o "Python TTS.py"

echo "File successfully downloaded to the Documents folder."

# --- 5. Final Message ---
echo ""
echo "---------------------------------------"
echo "  zeqqe's Preset finished correctly    "
echo "---------------------------------------"
