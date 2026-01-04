#!/bin/bash

# Colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
RED='\033[0;31m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Produce a random binary digit
generate_binary() {
    printf "%d" "$((RANDOM % 2))"
}

# Center a string based on current terminal width
center() {
    local str="$1"
    local term_width
    term_width=$(tput cols 2>/dev/null || echo 80)
    printf "%*s\n" $(((${#str} + term_width) / 2)) "$str"
}

# Check if iPhone is connected via USB
iphone_info=$(system_profiler SPUSBDataType 2>/dev/null | grep -B 15 -A 15 -E "iPhone|iPad")

if [[ -n "$iphone_info" ]]; then
    device_name=$(echo "$iphone_info" | grep -E "iPhone|iPad" | head -1 | sed 's/^[[:space:]]*//' | cut -d: -f1)
    serial=$(echo "$iphone_info" | grep "Serial Number:" | awk -F': ' '{print $2}' | head -1)
    manufacturer=$(echo "$iphone_info" | grep "Manufacturer:" | awk -F': ' '{print $2}' | head -1)
    version=$(echo "$iphone_info" | grep "Version:" | awk -F': ' '{print $2}' | head -1)
    current_available=$(echo "$iphone_info" | grep "Current Available" | awk -F': ' '{print $2}' | head -1)
    current_required=$(echo "$iphone_info" | grep "Current Required" | awk -F': ' '{print $2}' | head -1)
    speed=$(echo "$iphone_info" | grep "Speed:" | awk -F': ' '{print $2}' | head -1)

    battery_info=$(ioreg -l | awk -F'= ' '/"BatteryPercent"/{print $2; exit}')

    clear
    center "${PURPLE}=== IPHONE CONNECTED TO TERMINAL ===${NC}"
    center "${CYAN}[SYSTEM SYNCHRONIZED WITH IPHONE]${NC}"
    echo

    printf "${GREEN}  .-----------------.   ${CYAN}Device: ${WHITE}%s${NC}\n" "${device_name:-iPhone}"
    printf "${GREEN}  |  _______        |   ${CYAN}Serial: ${WHITE}%s${NC}\n" "${serial:-N/A}"
    printf "${GREEN}  | |       |       |   ${CYAN}Manufacturer: ${WHITE}%s${NC}\n" "${manufacturer:-Apple Inc.}"
    printf "${GREEN}  | |  o o  |       |   ${CYAN}iOS Version: ${WHITE}%s${NC}\n" "${version:-Unknown}"
    printf "${GREEN}  | |       |       |   ${CYAN}USB Speed: ${WHITE}%s${NC}\n" "${speed:-USB 2.0}"
    printf "${GREEN}  | |  ---  |       |   ${CYAN}Power Available: ${WHITE}%s${NC}\n" "${current_available:-N/A}"
    printf "${GREEN}  | |       |       |   ${CYAN}Power Required: ${WHITE}%s${NC}\n" "${current_required:-N/A}"
    printf "${GREEN}  | |_______|       |   ${CYAN}Battery: ${WHITE}%s%%%s\n" "${battery_info:-Unknown}" "${NC}"
    printf "${GREEN}  |               * |   ${CYAN}Status: ${GREEN}Connected${NC}\n"
    printf "${GREEN}  |                 |${NC}\n"
    printf "${GREEN}  '-----------------'${NC}\n\n"

    printf "${GREEN}"
    for _ in {1..3}; do
        line=""
        for _ in {1..65}; do
            line+=$(generate_binary)
        done
        printf "%s\n" "$line"
    done
    printf "${NC}\n"

    neofetch --ascii_colors 2 2 2 2 2 2 --color_blocks off
else
    neofetch --ascii_colors 2 2 2 2 2 2 --color_blocks off
fi
