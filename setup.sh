#!/bin/bash

# This line makes the script exit immediately if any command fails.
set -e

# --- 1. User Feedback ---
echo "Starting automated setup..."
echo "You may be asked for your password for software installation."

# --- 2. Install Programs ---
echo "Installing programs..."
sudo dnf install -y git pavucontrol python3-pip gparted vim

# --- 2.1. Install Python Packages ---
echo "Installing Python packages..."
pip3 install keyboard pyttsx3

# Install Vesktop
echo "Downloading and installing Vesktop..."
# Use curl to get the .rpm file and save it in the /tmp directory
# Replace the URL with the latest version from the Vesktop GitHub releases page
curl -L "https://github.com/Vencord/Vesktop/releases/download/v1.5.8/vesktop-1.5.8.x86_64.rpm" -o /tmp/vesktop.rpm

# Install the downloaded .rpm file
sudo dnf install -y /tmp/vesktop.rpm

# --- 3. Configure Desktop Environment ---
echo "Applying desktop tweaks..."

# Set the theme to dark mode
echo "Enabling dark mode..."
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Set font scaling to 125% (this makes most UI elements larger)
echo "Setting UI scaling to 125%..."
gsettings set org.gnome.desktop.interface text-scaling-factor 1.25

# --- 4. Mute All Physical Microphones ---
echo "Muting all physical input devices..."
for source in $(pactl list sources short | grep -v 'monitor' | cut -f1); do
    pactl set-source-mute $source 1
done
echo "Microphones muted."

# --- 5. Set Up Virtual Audio Cable ---
echo "Setting up virtual audio cable..."
# Create the virtual output device (the "cable")
pactl load-module module-null-sink sink_name=virtual_cable sink_properties=device.description="Virtual_Cable"

# Create the loopback so you can hear the audio too
pactl load-module module-loopback source=virtual_cable.monitor sink=@DEFAULT_SINK@

echo "Audio cable created and active."

# --- 6. Get File from GitHub ---
echo "Downloading script from GitHub..."
# Navigate to the Documents folder to keep things tidy
cd ~/Documents

# Download the Python TTS script
curl -L "https://raw.githubusercontent.com/Zeqqqe/Python-Text-To-Speech/main/Text%20To%20Speech%20CLI.py" -o "Python TTS.py"

echo "File successfully downloaded to the Documents folder."

# --- 7. Final Message ---
echo ""
echo "---------------------------------------"
echo "  zeqqe's Preset Finished Correctly    "
echo "---------------------------------------"
