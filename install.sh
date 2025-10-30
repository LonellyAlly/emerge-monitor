#!/bin/bash

# Emerge Monitor - Automated Installation Script
# This script will help you set up Emerge Monitor with all dependencies

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

echo -e "${BOLD}${BLUE}"
echo "╔════════════════════════════════════════════════╗"
echo "║   Emerge Monitor - Installation Script        ║"
echo "╚════════════════════════════════════════════════╝"
echo -e "${RESET}"

# Check if running on Gentoo
if [ ! -f /etc/gentoo-release ]; then
    echo -e "${RED}Error: This script is designed for Gentoo Linux only.${RESET}"
    exit 1
fi

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo -e "${YELLOW}Warning: Don't run this script as root. It will ask for sudo when needed.${RESET}"
    exit 1
fi

echo -e "${GREEN}Step 1: Checking for required dependencies...${RESET}"

# Check for genlop
if command -v genlop &> /dev/null; then
    echo -e "  ✓ genlop is already installed"
else
    echo -e "  ${YELLOW}✗ genlop is not installed${RESET}"
    read -p "  Do you want to install genlop? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo emerge app-portage/genlop
        echo -e "  ${GREEN}✓ genlop installed successfully${RESET}"
    else
        echo -e "  ${RED}Error: genlop is required. Installation aborted.${RESET}"
        exit 1
    fi
fi

echo ""
echo -e "${GREEN}Step 2: Checking for optional screensaver dependencies...${RESET}"

MISSING_SCREENSAVERS=()

# Check each screensaver
if ! command -v pipes.sh &> /dev/null; then
    echo -e "  ${YELLOW}✗ pipes.sh not found${RESET}"
    MISSING_SCREENSAVERS+=("app-misc/pipes")
else
    echo -e "  ✓ pipes.sh is installed"
fi

if ! command -v cmatrix &> /dev/null; then
    echo -e "  ${YELLOW}✗ cmatrix not found${RESET}"
    MISSING_SCREENSAVERS+=("app-misc/cmatrix")
else
    echo -e "  ✓ cmatrix is installed"
fi

if ! command -v hollywood &> /dev/null; then
    echo -e "  ${YELLOW}✗ hollywood not found${RESET}"
    MISSING_SCREENSAVERS+=("app-misc/hollywood")
else
    echo -e "  ✓ hollywood is installed"
fi

if ! command -v asciiquarium &> /dev/null; then
    echo -e "  ${YELLOW}✗ asciiquarium not found${RESET}"
    MISSING_SCREENSAVERS+=("games-misc/asciiquarium")
else
    echo -e "  ✓ asciiquarium is installed"
fi

if [ ${#MISSING_SCREENSAVERS[@]} -gt 0 ]; then
    echo ""
    echo -e "  ${YELLOW}Missing screensavers:${RESET}"
    for pkg in "${MISSING_SCREENSAVERS[@]}"; do
        echo "    - $pkg"
    done
    echo ""
    read -p "  Do you want to install all missing screensavers? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        for pkg in "${MISSING_SCREENSAVERS[@]}"; do
            echo -e "  Installing $pkg..."
            sudo emerge "$pkg"
        done
        echo -e "  ${GREEN}✓ All screensavers installed successfully${RESET}"
    else
        echo -e "  ${YELLOW}Note: You can install them later if you want${RESET}"
    fi
else
    echo -e "  ${GREEN}✓ All screensavers are already installed!${RESET}"
fi

echo ""
echo -e "${GREEN}Step 3: Setting up emerge-monitor script...${RESET}"

# Check if emerge-monitor.sh exists in current directory
if [ ! -f "emerge-monitor.sh" ]; then
    echo -e "  ${RED}Error: emerge-monitor.sh not found in current directory${RESET}"
    echo -e "  Please download it first or run this script from the same directory as emerge-monitor.sh"
    exit 1
fi

# Make executable
chmod +x emerge-monitor.sh
echo -e "  ✓ Script made executable"

# Ask about system-wide installation
echo ""
read -p "  Do you want to install emerge-monitor system-wide? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo cp emerge-monitor.sh /usr/local/bin/emerge-monitor
    echo -e "  ${GREEN}✓ Installed to /usr/local/bin/emerge-monitor${RESET}"
    echo -e "  ${GREEN}You can now run it from anywhere using: emerge-monitor${RESET}"
    INSTALLED_PATH="/usr/local/bin/emerge-monitor"
else
    echo -e "  ${YELLOW}Script remains in current directory${RESET}"
    echo -e "  ${YELLOW}Run it using: ./emerge-monitor.sh${RESET}"
    INSTALLED_PATH="./emerge-monitor.sh"
fi

echo ""
echo -e "${GREEN}Step 4: Configuring sudo for genlop...${RESET}"
echo ""
echo "To avoid entering your password every time, we can configure sudo to allow"
echo "genlop to run without password prompt."
echo ""
read -p "Do you want to configure passwordless sudo for genlop? (y/n) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Create sudoers file for genlop
    SUDO_FILE="/etc/sudoers.d/genlop-nopasswd"
    echo "$USER ALL=(ALL) NOPASSWD: /usr/bin/genlop" | sudo tee "$SUDO_FILE" > /dev/null
    sudo chmod 0440 "$SUDO_FILE"
    echo -e "  ${GREEN}✓ Sudo configured for genlop${RESET}"
    echo -e "  ${GREEN}File created: $SUDO_FILE${RESET}"
else
    echo -e "  ${YELLOW}Skipped sudo configuration${RESET}"
    echo -e "  ${YELLOW}You'll need to enter your password when running emerge-monitor${RESET}"
fi

echo ""
echo -e "${BOLD}${GREEN}"
echo "╔════════════════════════════════════════════════╗"
echo "║       Installation Complete! 🎉                ║"
echo "╚════════════════════════════════════════════════╝"
echo -e "${RESET}"

echo -e "${BOLD}Quick Start:${RESET}"
echo ""
echo "1. Start an emerge in one terminal:"
echo -e "   ${BLUE}sudo emerge --update @world${RESET}"
echo ""
echo "2. Run emerge-monitor in another terminal:"
if [[ $INSTALLED_PATH == "/usr/local/bin/emerge-monitor" ]]; then
    echo -e "   ${BLUE}emerge-monitor${RESET}"
else
    echo -e "   ${BLUE}./emerge-monitor.sh${RESET}"
fi
echo ""
echo -e "${BOLD}Controls:${RESET}"
echo "  s - Toggle screensavers"
echo "  r - Refresh / Exit screensaver"
echo "  a - Toggle auto-refresh"
echo "  +/- - Adjust refresh interval"
echo "  q - Quit"
echo ""
echo "For more information, see README.md or index.html"
echo ""
echo -e "${GREEN}Happy emerging! 🚀${RESET}"
