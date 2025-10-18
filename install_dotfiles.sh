#!/usr/bin/env bash

# ==========================================
# FxP DOTFILES INSTALLER SCRIPT
# ==========================================

# Colors for pretty output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Icons (using Nerd Fonts)
ICON_INFO=""
ICON_SUCCESS=""
ICON_WARNING=""
ICON_ERROR=""
ICON_FOLDER=""
ICON_FILE="󰈔"
ICON_COPY=""
ICON_BACKUP="󰁯"
ICON_FONT=""
ICON_CHECK=""

# Script variables - DYNAMIC DETECTION
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"
BACKUP_DIR="$HOME/user_old_config_$(date +%Y%m%d_%H%M%S)"
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
    echo -e "${CYAN}${ICON_INFO}  FxP Dotfiles Installer${NC}"
    echo -e "${CYAN}${ICON_INFO}  User: $CURRENT_USER${NC}"
    echo -e "${CYAN}${ICON_INFO}  Script Location: $SCRIPT_DIR${NC}"
    echo -e "${CYAN}${ICON_INFO}  Dotfiles Source: $DOTFILES_DIR${NC}"
    echo -e ""
}

check_nerd_font() {
    echo -e "${BLUE}${ICON_FONT}  Checking for Nerd Fonts...${NC}"
    
    if fc-list | grep -i "nerd" > /dev/null; then
        echo -e "${GREEN}${ICON_CHECK}  Nerd Fonts detected!${NC}"
        return 0
    else
        echo -e "${YELLOW}${ICON_WARNING}  No Nerd Fonts found!${NC}"
        echo -e "${YELLOW}${ICON_INFO}  Please install a Nerd Font manually:${NC}"
        echo -e "${CYAN}    sudo pacman -S ttf-nerd-fonts-symbols${NC}"
        echo -e "${CYAN}    Or download from: https://www.nerdfonts.com/${NC}"
        echo -e "${YELLOW}${ICON_WARNING}  Continuing without Nerd Fonts...${NC}"
        return 1
    fi
}

create_backup() {
    local target="$1"
    local backup_path="$BACKUP_DIR/${target#$HOME/}"
    
    if [ -e "$target" ]; then
        echo -e "${YELLOW}${ICON_BACKUP}  Backing up: $target${NC}"
        mkdir -p "$(dirname "$backup_path")"
        cp -r "$target" "$backup_path" 2>/dev/null
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}${ICON_SUCCESS}  Backup created: $backup_path${NC}"
        else
            echo -e "${RED}${ICON_ERROR}  Failed to backup: $target${NC}"
        fi
    fi
}

copy_with_backup() {
    local source="$1"
    local destination="$2"
    
    if [ -e "$destination" ]; then
        create_backup "$destination"
        echo -e "${YELLOW}${ICON_COPY}  Replacing: $destination${NC}"
    else
        echo -e "${BLUE}${ICON_COPY}  Copying new: $destination${NC}"
    fi
    
    mkdir -p "$(dirname "$destination")"
    cp -r "$source" "$destination"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}${ICON_SUCCESS}  Success: $destination${NC}"
    else
        echo -e "${RED}${ICON_ERROR}  Failed: $destination${NC}"
    fi
}

install_dotfiles() {
    echo -e "${CYAN}${ICON_FOLDER}  Installing dotfiles...${NC}"
    
    # Create backup directory
    mkdir -p "$BACKUP_DIR"
    echo -e "${BLUE}${ICON_BACKUP}  Backup directory: $BACKUP_DIR${NC}"
    
    # Check if dotfiles directory exists
    if [ ! -d "$DOTFILES_DIR" ]; then
        echo -e "${RED}${ICON_ERROR}  Dotfiles directory not found: $DOTFILES_DIR${NC}"
        echo -e "${RED}  Please make sure the 'dotfiles' folder exists in the same directory as this script.${NC}"
        exit 1
    fi
    
    # Dynamically copy ALL contents from dotfiles to home directory
    echo -e "${BLUE}${ICON_INFO}  Copying contents from: $DOTFILES_DIR${NC}"
    echo -e "${BLUE}${ICON_INFO}  Destination: $HOME${NC}"
    
    # Copy everything from dotfiles directory to home
    for item in "$DOTFILES_DIR"/* "$DOTFILES_DIR"/.*; do
        # Skip . and .. entries
        if [ "$item" = "$DOTFILES_DIR/*" ] || [ "$item" = "$DOTFILES_DIR/.*" ]; then
            continue
        fi
        
        local item_name=$(basename "$item")
        
        # Skip the dotfiles directory itself
        if [ "$item_name" = "." ] || [ "$item_name" = ".." ]; then
            continue
        fi
        
        local destination="$HOME/$item_name"
        
        if [ -e "$item" ]; then
            copy_with_backup "$item" "$destination"
        fi
    done
}

show_summary() {
    echo -e "${PURPLE}
    ┌──────────────────────────────────────────────┐
    │                 INSTALLATION SUMMARY         │
    └──────────────────────────────────────────────┘${NC}"
    
    echo -e "${GREEN}${ICON_SUCCESS}  Dotfiles installed successfully!${NC}"
    echo -e "${BLUE}${ICON_BACKUP}  Backups saved to: $BACKUP_DIR${NC}"
    echo -e "${CYAN}${ICON_INFO}  Source: $DOTFILES_DIR${NC}"
    echo -e "${CYAN}${ICON_INFO}  Destination: $HOME${NC}"
    echo -e ""
    echo -e "${YELLOW}${ICON_WARNING}  Next steps:${NC}"
    echo -e "  ${ICON_INFO}  Restart your terminal or run: source ~/.bashrc"
    echo -e "  ${ICON_INFO}  Check individual app configurations"
    echo -e ""
}

# ==========================================
# MAIN EXECUTION
# ==========================================

main() {
    print_header
    
    # Check for nerd fonts (but don't stop if not found)
    check_nerd_font
    
    echo -e "${YELLOW}${ICON_WARNING}  This will backup existing files to: $BACKUP_DIR${NC}"
    read -p "$(echo -e "${YELLOW}${ICON_INFO}  Continue? (y/N): ${NC}")" -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}${ICON_ERROR}  Installation cancelled.${NC}"
        exit 0
    fi
    
    # Install dotfiles
    install_dotfiles
    
    # Show summary
    show_summary
}

# Run main function
main "$@"