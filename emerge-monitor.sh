#!/bin/bash

# Emerge Monitor - A feature-rich Gentoo emerge monitoring tool
# Author: Generated for Gentoo users
# License: MIT

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# Global variables
SCREENSAVER_MODE=0
SCREENSAVER_ACTIVE=false
AUTO_REFRESH=true
REFRESH_INTERVAL=5
SCRIPT_START_TIME=$(date +%s)
EMERGE_START_TIME=""
SCREENSAVER_PID=""

# Available screensavers
SCREENSAVERS=("none" "pipes.sh" "cmatrix" "hollywood" "asciiquarium")
CURRENT_SCREENSAVER=0

# Function to check dependencies
check_dependencies() {
    local missing_deps=()
    
    # Check for genlop (required)
    if ! command -v genlop &> /dev/null; then
        echo -e "${RED}Error: genlop is not installed. Please install it first.${RESET}"
        echo "Run: sudo emerge app-portage/genlop"
        exit 1
    fi
    
    # Check for optional screensaver dependencies
    if ! command -v pipes.sh &> /dev/null; then
        missing_deps+=("pipes.sh")
    fi
    if ! command -v cmatrix &> /dev/null; then
        missing_deps+=("cmatrix")
    fi
    if ! command -v hollywood &> /dev/null; then
        missing_deps+=("hollywood")
    fi
    if ! command -v asciiquarium &> /dev/null; then
        missing_deps+=("asciiquarium")
    fi
    
    if [ ${#missing_deps[@]} -gt 0 ]; then
        echo -e "${YELLOW}Warning: Some screensavers are not available:${RESET}"
        for dep in "${missing_deps[@]}"; do
            echo "  - $dep"
        done
        echo -e "${CYAN}Install them for full functionality.${RESET}"
        echo ""
        sleep 2
    fi
}

# Function to get emerge start time
get_emerge_start_time() {
    # Try to get the start time of the current emerge process
    # Look for emerge processes (excluding grep itself)
    local emerge_pid=$(pgrep -x emerge | head -1)
    if [ -z "$emerge_pid" ]; then
        # If pgrep -x doesn't work, try with full command line
        emerge_pid=$(pgrep -f "/usr/bin/emerge" | head -1)
    fi
    if [ -n "$emerge_pid" ]; then
        local start_seconds=$(ps -p "$emerge_pid" -o etimes= 2>/dev/null | tr -d ' ')
        if [ -n "$start_seconds" ]; then
            EMERGE_START_TIME=$(($(date +%s) - start_seconds))
        fi
    fi
}

# Function to format time duration
format_duration() {
    local total_seconds=$1
    local hours=$((total_seconds / 3600))
    local minutes=$(((total_seconds % 3600) / 60))
    local seconds=$((total_seconds % 60))
    
    printf "%02d:%02d:%02d" $hours $minutes $seconds
}

# Function to get emerge ETA information
get_emerge_eta() {
    # Check for emerge process more reliably
    local emerge_running=false
    if pgrep -x emerge &> /dev/null || pgrep -f "/usr/bin/emerge" &> /dev/null; then
        emerge_running=true
    fi
    
    if [ "$emerge_running" = false ]; then
        echo -e "${YELLOW}No emerge process currently running.${RESET}"
        return 1
    fi
    
    # Use genlop with sudo to get current emerge information
    sudo genlop -c 2>/dev/null
}

# Function to display header
display_header() {
    local current_time=$(date "+%Y-%m-%d %H:%M:%S")
    local script_runtime=$(($(date +%s) - SCRIPT_START_TIME))
    local emerge_runtime=""
    
    if [ -n "$EMERGE_START_TIME" ]; then
        emerge_runtime=$(($(date +%s) - EMERGE_START_TIME))
    fi
    
    echo -e "${BOLD}${CYAN}╔════════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${BOLD}${CYAN}║${RESET}            ${BOLD}Gentoo Emerge Monitor v1.0${RESET}                     ${BOLD}${CYAN}║${RESET}"
    echo -e "${BOLD}${CYAN}╚════════════════════════════════════════════════════════════════╝${RESET}"
    echo ""
    echo -e "${BOLD}Current Time:${RESET}     $current_time"
    echo -e "${BOLD}Script Runtime:${RESET}   $(format_duration $script_runtime)"
    
    if [ -n "$emerge_runtime" ]; then
        echo -e "${BOLD}Emerge Runtime:${RESET}   $(format_duration $emerge_runtime)"
    fi
    
    echo -e "${BOLD}Refresh Mode:${RESET}     $([ "$AUTO_REFRESH" = true ] && echo "Auto ($REFRESH_INTERVAL sec)" || echo "Manual")"
    echo ""
}

# Function to display controls
display_controls() {
    echo ""
    echo -e "${BOLD}${GREEN}Controls:${RESET}"
    echo -e "  ${BOLD}s${RESET} - Toggle screensaver cycle"
    echo -e "  ${BOLD}r${RESET} - Manual refresh (when auto-refresh is off)"
    echo -e "  ${BOLD}a${RESET} - Toggle auto-refresh"
    echo -e "  ${BOLD}+${RESET} - Increase refresh interval"
    echo -e "  ${BOLD}-${RESET} - Decrease refresh interval"
    echo -e "  ${BOLD}q${RESET} - Quit"
    echo ""
}

# Function to kill screensaver
kill_screensaver() {
    if [ -n "$SCREENSAVER_PID" ]; then
        kill $SCREENSAVER_PID 2>/dev/null
        wait $SCREENSAVER_PID 2>/dev/null
        SCREENSAVER_PID=""
    fi
}

# Function to start screensaver
start_screensaver() {
    local screensaver="${SCREENSAVERS[$CURRENT_SCREENSAVER]}"
    
    kill_screensaver
    clear
    
    case "$screensaver" in
        "none")
            SCREENSAVER_ACTIVE=false
            return
            ;;
        "pipes.sh")
            if command -v pipes.sh &> /dev/null; then
                pipes.sh &
                SCREENSAVER_PID=$!
            else
                echo -e "${RED}pipes.sh not found${RESET}"
                sleep 2
                SCREENSAVER_ACTIVE=false
                return
            fi
            ;;
        "cmatrix")
            if command -v cmatrix &> /dev/null; then
                cmatrix -b &
                SCREENSAVER_PID=$!
            else
                echo -e "${RED}cmatrix not found${RESET}"
                sleep 2
                SCREENSAVER_ACTIVE=false
                return
            fi
            ;;
        "hollywood")
            if command -v hollywood &> /dev/null; then
                hollywood &
                SCREENSAVER_PID=$!
            else
                echo -e "${RED}hollywood not found${RESET}"
                sleep 2
                SCREENSAVER_ACTIVE=false
                return
            fi
            ;;
        "asciiquarium")
            if command -v asciiquarium &> /dev/null; then
                asciiquarium &
                SCREENSAVER_PID=$!
            else
                echo -e "${RED}asciiquarium not found${RESET}"
                sleep 2
                SCREENSAVER_ACTIVE=false
                return
            fi
            ;;
    esac
    
    SCREENSAVER_ACTIVE=true
}

# Function to display main screen
display_main_screen() {
    clear
    display_header
    echo -e "${BOLD}${MAGENTA}════════════════════ Emerge Status ═══════════════════${RESET}"
    echo ""
    get_emerge_eta
    echo ""
    echo -e "${BOLD}${MAGENTA}══════════════════════════════════════════════════════${RESET}"
    display_controls
}

# Function to handle key press
handle_keypress() {
    local key=$1
    
    case "$key" in
        s|S)
            if [ "$SCREENSAVER_ACTIVE" = true ]; then
                # Cycle to next screensaver
                CURRENT_SCREENSAVER=$(((CURRENT_SCREENSAVER + 1) % ${#SCREENSAVERS[@]}))
                start_screensaver
            else
                # Start first screensaver
                CURRENT_SCREENSAVER=0
                start_screensaver
            fi
            ;;
        r|R)
            if [ "$SCREENSAVER_ACTIVE" = true ]; then
                kill_screensaver
                SCREENSAVER_ACTIVE=false
            fi
            display_main_screen
            ;;
        a|A)
            AUTO_REFRESH=$([ "$AUTO_REFRESH" = true ] && echo false || echo true)
            if [ "$SCREENSAVER_ACTIVE" = false ]; then
                display_main_screen
            fi
            ;;
        +|=)
            REFRESH_INTERVAL=$((REFRESH_INTERVAL + 1))
            if [ "$SCREENSAVER_ACTIVE" = false ]; then
                display_main_screen
            fi
            ;;
        -)
            if [ $REFRESH_INTERVAL -gt 1 ]; then
                REFRESH_INTERVAL=$((REFRESH_INTERVAL - 1))
            fi
            if [ "$SCREENSAVER_ACTIVE" = false ]; then
                display_main_screen
            fi
            ;;
        q|Q)
            kill_screensaver
            clear
            echo -e "${GREEN}Thank you for using Emerge Monitor!${RESET}"
            exit 0
            ;;
    esac
}

# Main function
main() {
    # Check if running in a terminal
    if [ ! -t 0 ]; then
        echo "This script must be run in an interactive terminal."
        exit 1
    fi
    
    # Check dependencies
    check_dependencies
    
    # Get emerge start time
    get_emerge_start_time
    
    # Setup terminal
    stty -echo -icanon time 0 min 0
    
    # Trap exit to restore terminal
    trap 'stty echo icanon; kill_screensaver; clear; exit 0' EXIT INT TERM
    
    # Initial display
    display_main_screen
    
    # Main loop
    local counter=0
    while true; do
        # Read key press (non-blocking)
        local key
        read -r -n1 key 2>/dev/null
        
        if [ -n "$key" ]; then
            handle_keypress "$key"
        fi
        
        # Auto refresh logic
        if [ "$AUTO_REFRESH" = true ] && [ "$SCREENSAVER_ACTIVE" = false ]; then
            if [ $counter -ge $REFRESH_INTERVAL ]; then
                display_main_screen
                counter=0
            fi
        fi
        
        # Sleep for 1 second and increment counter
        sleep 1
        counter=$((counter + 1))
    done
}

# Run main function
main
