#!/bin/bash

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
RED='\033[0;31m'
DIM='\033[2m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Check if iPhone is connected via USB
iphone_info=$(system_profiler SPUSBDataType 2>/dev/null | grep -B 15 -A 15 "iPhone\|iPad")

if [[ ! -z "$iphone_info" ]]; then
    # Extract iPhone information
    device_name=$(echo "$iphone_info" | grep -E "iPhone|iPad" | head -1 | sed 's/^[[:space:]]*//' | cut -d: -f1)
    serial=$(echo "$iphone_info" | grep "Serial Number:" | awk -F': ' '{print $2}' | head -1)
    version=$(echo "$iphone_info" | grep "Version:" | awk -F': ' '{print $2}' | head -1)
    speed=$(echo "$iphone_info" | grep "Speed:" | awk -F': ' '{print $2}' | head -1)
    
    # Get battery info
    battery_info=$(ioreg -l | grep -i "batterypercent" | head -1 | awk '{print $NF}')
    
    clear
    
    # Display header and iPhone art
    echo -e "${GREEN}                    ┌─────────────────┐${NC}          ${CYAN}╔═══════════════════════════════════════╗${NC}"
    echo -e "${GREEN}                    │  ${WHITE}━━━━━━━━━━━━━${GREEN}  │${NC}          ${CYAN}║${NC} ${YELLOW}Device:${NC} ${WHITE}${device_name:-iPhone}${NC}"
    echo -e "${GREEN}                    │ ┌─────────────┐ │${NC}          ${CYAN}║${NC} ${YELLOW}Serial:${NC} ${WHITE}${serial:-N/A}${NC}"
    echo -e "${GREEN}                    │ │${WHITE}             ${GREEN}│ │${NC}          ${CYAN}║${NC} ${YELLOW}iOS Version:${NC} ${WHITE}${version:-Unknown}${NC}"
    echo -e "${GREEN}                    │ │${WHITE}    ${RED}●   ●${WHITE}    ${GREEN}│ │${NC}          ${CYAN}║${NC} ${YELLOW}USB Speed:${NC} ${WHITE}${speed:-USB 2.0}${NC}"
    echo -e "${GREEN}                    │ │${WHITE}             ${GREEN}│ │${NC}          ${CYAN}║${NC} ${YELLOW}Battery:${NC} ${WHITE}${battery_info:-Unknown}%${NC}"
    echo -e "${GREEN}                    │ │${WHITE}  ┌───────┐  ${GREEN}│ │${NC}          ${CYAN}║${NC} ${YELLOW}Status:${NC} ${GREEN}● Connected${NC}"
    echo -e "${GREEN}                    │ │${WHITE}  │       │  ${GREEN}│ │${NC}          ${CYAN}╚═══════════════════════════════════════╝${NC}"
    echo -e "${GREEN}                    │ │${WHITE}  └───────┘  ${GREEN}│ │${NC}"
    echo -e "${GREEN}                    │ │${WHITE}             ${GREEN}│ │${NC}"
    echo -e "${GREEN}                    │ │${WHITE}      ${RED}◉${WHITE}      ${GREEN}│ │${NC}"
    echo -e "${GREEN}                    │ │${WHITE}             ${GREEN}│ │${NC}"
    echo -e "${GREEN}                    │ └─────────────┘ │${NC}"
    echo -e "${GREEN}                    │                 │${NC}"
    echo -e "${GREEN}                    │      ${WHITE}(   )${GREEN}      │${NC}"
    echo -e "${GREEN}                    └─────────────────┘${NC}"

fi

# Run neofetch with green Apple logo
neofetch --ascii_colors 2 2 2 2 2 2 --color_blocks off
