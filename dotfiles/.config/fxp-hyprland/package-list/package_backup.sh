#!/usr/bin/env bash

# ==========================================
# PACKAGE BACKUP SCRIPT - SIMPLIFIED
# ==========================================

# Colors for pretty output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Icons (Nerd Fonts)
ICON_INFO=""
ICON_SUCCESS=""
ICON_WARNING=""
ICON_ERROR=""
ICON_PACKAGE=""
ICON_FILE="󰈔"

# Variables - output in current directory
BACKUP_FILE="$(pwd)/package_list.txt"
CURRENT_USER=$(whoami)

print_header() {
    echo -e "${PURPLE}
    ███████╗██╗██████╗ ███████╗██████╗ ██╗██████╗ ██████╗ 
    ██╔════╝██║██╔══██╗██╔════╝██╔══██╗██║██╔══██╗██╔══██╗
    █████╗  ██║██████╔╝█████╗  ██████╔╝██║██████╔╝██║  ██║
    ██╔══╝  ██║██╔══██╗██╔══╝  ██╔══██╗██║██╔══██╗██║  ██║
    ██║     ██║██║  ██║███████╗██████╔╝██║██║  ██║██████╔╝
    ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝╚═╝  ╚═╝╚═════╝ 
    
                      ██╗  ██╗
                       ╚██╗██╔╝
                        ╚███╔╝ 
                        ██╔██╗ 
                       ██╔╝ ██╗
                       ╚═╝  ╚═╝
    
    ██████╗ ██╗  ██╗ ██████╗ ███████╗███╗   ██╗██╗██╗  ██╗
    ██╔══██╗██║  ██║██╔═══██╗██╔════╝████╗  ██║██║╚██╗██╔╝
    ██████╔╝███████║██║   ██║█████╗  ██╔██╗ ██║██║ ╚███╔╝ 
    ██╔═══╝ ██╔══██║██║   ██║██╔══╝  ██║╚██╗██║██║ ██╔██╗ 
    ██║     ██║  ██║╚██████╔╝███████╗██║ ╚████║██║██╔╝ ██╗
    ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝
    ${NC}"
    echo -e "${CYAN}${ICON_INFO}  FxP Package Backup Script - Simplified${NC}"
    echo -e "${CYAN}${ICON_INFO}  User: $CURRENT_USER${NC}"
    echo -e "${CYAN}${ICON_INFO}  Backup File: $(basename "$BACKUP_FILE")${NC}"
    echo -e "${CYAN}${ICON_INFO}  Location: $(pwd)${NC}"
    echo -e ""
}

backup_packages() {
    echo -e "${BLUE}${ICON_PACKAGE}  Backing up packages (clean list)...${NC}"
    
    # Create clean backup file (overwrite if exists)
    echo -e "# Package List - Generated $(date)" > "$BACKUP_FILE"
    echo -e "# User: $CURRENT_USER" >> "$BACKUP_FILE"
    echo -e "# Clean package names only - ready for installation" >> "$BACKUP_FILE"
    echo -e "" >> "$BACKUP_FILE"
    
    if command -v pacman >/dev/null 2>&1; then
        # Get explicitly installed packages (both native and AUR)
        echo -e "${BLUE}${ICON_INFO}  Collecting explicitly installed packages...${NC}"
        
        # Native packages (explicitly installed)
        pacman -Qqe | grep -v "$(pacman -Qqm)" | sort -u >> "$BACKUP_FILE"
        
        # AUR packages
        pacman -Qqm | sort -u >> "$BACKUP_FILE"
        
        echo -e "${GREEN}${ICON_SUCCESS}  Packages backed up successfully!${NC}"
    else
        echo -e "${RED}${ICON_ERROR}  pacman not found!${NC}"
        return 1
    fi
}

show_summary() {
    local total_packages=$(pacman -Qq | wc -l)
    local native_packages=$(pacman -Qqe | grep -v "$(pacman -Qqm)" | wc -l)
    local aur_packages=$(pacman -Qqm | wc -l)
    local backup_count=$(grep -v '^#' "$BACKUP_FILE" | grep -v '^$' | wc -l)
    
    echo -e "${PURPLE}"
    echo -e "┌──────────────────────────────────────────────┐"
    echo -e "│               BACKUP SUMMARY                 │"
    echo -e "└──────────────────────────────────────────────┘${NC}"
    echo -e "${GREEN}${ICON_SUCCESS}  Backup completed successfully!${NC}"
    echo -e "${CYAN}${ICON_FILE}  Backup file: $(basename "$BACKUP_FILE")${NC}"
    echo -e "${CYAN}${ICON_INFO}  Location: $(pwd)${NC}"
    echo -e "${BLUE}${ICON_INFO}  Package Statistics:${NC}"
    echo -e "  ${ICON_PACKAGE}  Total packages in system: $total_packages"
    echo -e "  ${ICON_PACKAGE}  Native packages: $native_packages"
    echo -e "  ${ICON_PACKAGE}  AUR packages: $aur_packages"
    echo -e "  ${ICON_PACKAGE}  Packages in backup: $backup_count"
    echo -e ""
    echo -e "${YELLOW}${ICON_WARNING}  To restore packages:${NC}"
    echo -e "  ${ICON_INFO}  Run: ./quick_install_packages.sh"
    echo -e "  ${ICON_INFO}  This will install latest versions automatically"
    echo -e ""
}

# ==========================================
# MAIN EXECUTION
# ==========================================

main() {
    print_header
    
    # Create backup file
    echo -e "${BLUE}${ICON_FILE}  Creating clean package list: $(basename "$BACKUP_FILE")${NC}"
    echo -e "${BLUE}${ICON_INFO}  In directory: $(pwd)${NC}"
    echo -e "${YELLOW}${ICON_WARNING}  Note: Only package names (no versions) will be saved${NC}"
    echo -e ""
    
    # Backup packages
    backup_packages
    
    # Show summary
    show_summary
}

# Run main function
main "$@"