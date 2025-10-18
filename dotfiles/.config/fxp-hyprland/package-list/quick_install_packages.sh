#!/usr/bin/env bash

# ==========================================
# QUICK PACKAGE INSTALLER - FxP CUTE EDITION
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
ICON_INFO=""
ICON_SUCCESS=""
ICON_WARNING=""
ICON_ERROR=""
ICON_PACKAGE=""
ICON_FILE=""

# Script variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGE_LIST="$SCRIPT_DIR/package_list.txt"
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
    echo -e "${CYAN}${ICON_INFO}  FxP Quick Package Installer${NC}"
    echo -e "${CYAN}${ICON_INFO}  User: $CURRENT_USER${NC}"
    echo -e "${CYAN}${ICON_INFO}  Directory: $SCRIPT_DIR${NC}"
    echo -e ""
}

# Function to check file existence
check_file() {
    if [[ ! -f "$1" ]]; then
        echo -e "${RED}${ICON_ERROR}  File not found: $1${NC}"
        return 1
    fi
    echo -e "${GREEN}${ICON_SUCCESS}  Found: $1${NC}"
    return 0
}

# Function to count packages
count_packages() {
    if [[ -f "$1" ]]; then
        count=$(grep -v '^#' "$1" | grep -v '^$' | wc -l)
        echo -e "${CYAN}${ICON_PACKAGE}  Total packages in $(basename "$1"): ${YELLOW}$count${NC}"
    fi
}

# Function to check if yay is installed
check_yay_installed() {
    if command -v yay >/dev/null 2>&1; then
        echo -e "${GREEN}${ICON_SUCCESS}  yay is already installed${NC}"
        return 0
    else
        echo -e "${RED}${ICON_ERROR}  yay is not installed${NC}"
        return 1
    fi
}

# Function to install yay-bin with dependencies
install_yay_bin() {
    echo -e "${YELLOW}${ICON_WARNING}  Installing yay-bin...${NC}"
    
    # Check and install git if needed
    if ! command -v git >/dev/null 2>&1; then
        echo -e "${BLUE}${ICON_INFO}  Installing git first...${NC}"
        sudo pacman -S --needed --noconfirm git || {
            echo -e "${RED}${ICON_ERROR}  Failed to install git!${NC}"
            return 1
        }
    fi
    
    # Check and install base-devel if needed
    if ! pacman -Qg base-devel >/dev/null 2>&1; then
        echo -e "${BLUE}${ICON_INFO}  Installing base-devel...${NC}"
        sudo pacman -S --needed --noconfirm base-devel || {
            echo -e "${RED}${ICON_ERROR}  Failed to install base-devel!${NC}"
            return 1
        }
    fi
    
    # Install yay-bin from AUR
    echo -e "${BLUE}${ICON_INFO}  Downloading and installing yay-bin...${NC}"
    temp_dir=$(mktemp -d)
    cd "$temp_dir" || return 1
    
    if git clone https://aur.archlinux.org/yay-bin.git; then
        cd yay-bin || return 1
        if makepkg -si --noconfirm; then
            echo -e "${GREEN}${ICON_SUCCESS}  yay-bin installed successfully!${NC}"
            cd ../..
            rm -rf "$temp_dir"
            return 0
        else
            echo -e "${RED}${ICON_ERROR}  Failed to build yay-bin!${NC}"
            cd ../..
            rm -rf "$temp_dir"
            return 1
        fi
    else
        echo -e "${RED}${ICON_ERROR}  Failed to clone yay-bin repository!${NC}"
        cd ..
        rm -rf "$temp_dir"
        return 1
    fi
}

# Function to install packages
install_packages() {
    local package_count=0
    local success_count=0
    local fail_count=0
    local failed_packages=()
    
    echo -e "${BLUE}${ICON_PACKAGE}  Installing packages from package_list.txt...${NC}"
    
    while IFS= read -r pkg; do
        # Skip comments, empty lines, and yay-bin
        if [[ -z "$pkg" || "$pkg" =~ ^# || "$pkg" == "yay-bin" ]]; then
            continue
        fi
        
        ((package_count++))
        echo -e "${CYAN}${ICON_INFO}  Installing: $pkg${NC}"
        
        # Try installing with pacman first
        if sudo pacman -S --needed --noconfirm "$pkg" 2>/dev/null; then
            echo -e "${GREEN}${ICON_SUCCESS}  ✓ $pkg (pacman)${NC}"
            ((success_count++))
        else
            # If pacman fails, try with yay
            echo -e "${YELLOW}${ICON_WARNING}  Trying AUR for: $pkg${NC}"
            if yay -S --needed --noconfirm "$pkg" 2>/dev/null; then
                echo -e "${GREEN}${ICON_SUCCESS}  ✓ $pkg (AUR)${NC}"
                ((success_count++))
            else
                echo -e "${RED}${ICON_ERROR}  ✗ Failed to install: $pkg${NC}"
                ((fail_count++))
                failed_packages+=("$pkg")
            fi
        fi
    done < "$PACKAGE_LIST"
    
    # Show installation summary
    echo -e "${PURPLE}"
    echo -e "┌──────────────────────────────────────────────┐"
    echo -e "│             INSTALLATION SUMMARY             │"
    echo -e "└──────────────────────────────────────────────┘${NC}"
    echo -e "${GREEN}${ICON_SUCCESS}  Successfully installed: $success_count${NC}"
    echo -e "${RED}${ICON_ERROR}  Failed: $fail_count${NC}"
    echo -e "${CYAN}${ICON_PACKAGE}  Total processed: $package_count${NC}"
    
    if [[ $fail_count -gt 0 ]]; then
        echo -e "${YELLOW}${ICON_WARNING}  Failed packages: ${failed_packages[*]}${NC}"
    fi
}

show_summary() {
    local total_packages=$(grep -v '^#' "$PACKAGE_LIST" | grep -v '^$' | grep -v "yay-bin" | wc -l)
    
    echo -e "${PURPLE}"
    echo -e "┌──────────────────────────────────────────────┐"
    echo -e "│                 FINAL SUMMARY                │"
    echo -e "└──────────────────────────────────────────────┘${NC}"
    echo -e "${GREEN}${ICON_SUCCESS}  Package installation completed!${NC}"
    echo -e "${CYAN}${ICON_FILE}  Package list: $(basename "$PACKAGE_LIST")${NC}"
    echo -e "${BLUE}${ICON_INFO}  Package Statistics:${NC}"
    echo -e "  ${ICON_PACKAGE}  Total packages to install: $total_packages"
    echo -e ""
}

# ==========================================
# MAIN EXECUTION
# ==========================================

main() {
    print_header
    
    echo -e "${BLUE}${ICON_INFO}  Starting package installation...${NC}"
    echo -e "${CYAN}${ICON_INFO}  Script directory: $SCRIPT_DIR${NC}"
    echo -e ""

    # Check if package_list.txt exists
    if ! check_file "$PACKAGE_LIST"; then
        echo -e "${RED}${ICON_ERROR}  Please create package_list.txt in the script directory${NC}"
        exit 1
    fi

    # Show package count
    count_packages "$PACKAGE_LIST"
    echo -e ""

    # Check and install yay if needed
    if ! check_yay_installed; then
        echo -e "${YELLOW}${ICON_WARNING}  yay is required for AUR package installation.${NC}"
        read -p "Do you want to install yay-bin now? (Y/n): " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Nn]$ ]]; then
            install_yay_bin || {
                echo -e "${RED}${ICON_ERROR}  Cannot continue without yay. Installation cancelled.${NC}"
                exit 1
            }
        else
            echo -e "${RED}${ICON_ERROR}  Cannot continue without yay. Installation cancelled.${NC}"
            exit 1
        fi
    fi

    echo -e ""
    read -p "Continue with package installation? (y/N): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}${ICON_ERROR}  Installation cancelled.${NC}"
        exit 1
    fi

    # Install packages
    echo -e ""
    install_packages
    
    # Show final summary
    echo -e ""
    show_summary
}

# Run main function
main "$@"