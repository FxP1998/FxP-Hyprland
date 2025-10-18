#!/bin/bash

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
ICON_INFO=""
ICON_SUCCESS=""
ICON_WARNING=""
ICON_ERROR=""
ICON_FOLDER=""
ICON_FILE=""
ICON_COPY="󰆐"
ICON_BACKUP=""
ICON_FONT=""
ICON_CHECK="󰄬"
ICON_SHIELD="󰒃"

# Script variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"
CURRENT_USER=$(whoami)
BACKUP_DIR="$HOME/.config/${CURRENT_USER}_old_config_$(date +%Y%m%d_%H%M%S)"

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
    echo -e ""
}

check_sudo_permissions() {
    echo -e "${BLUE}${ICON_SHIELD}  Checking for sudo permissions...${NC}"
    
    # First attempt - check if we can create directories in system locations
    if ! mkdir -p "$HOME/.config/test_sudo" 2>/dev/null; then
        echo -e "${YELLOW}${ICON_WARNING}  Insufficient permissions to create directories.${NC}"
        echo -e "${YELLOW}${ICON_INFO}  This script needs sudo permissions to:${NC}"
        echo -e "${CYAN}    - Create directories in ~/.config/${NC}"
        echo -e "${CYAN}    - Create directories in ~/.fonts/${NC}"
        echo -e "${CYAN}    - Create directories in ~/.icons/${NC}"
        echo -e "${CYAN}    - Copy files to system locations${NC}"
        
        # First ask for sudo
        echo -e ""
        echo -e "${YELLOW}${ICON_WARNING}  Please grant sudo permissions to continue.${NC}"
        read -p "$(echo -e "${YELLOW}${ICON_INFO}  Grant sudo permissions? (Y/n): ${NC}")" -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Nn]$ ]]; then
            # Try to run with sudo
            echo -e "${BLUE}${ICON_SHIELD}  Attempting to run with sudo...${NC}"
            exec sudo "$0" "$@"
        else
            echo -e "${RED}${ICON_ERROR}  Sudo permissions denied. Installation cancelled.${NC}"
            exit 1
        fi
    else
        # Clean up test directory
        rmdir "$HOME/.config/test_sudo" 2>/dev/null
        echo -e "${GREEN}${ICON_CHECK}  Sufficient permissions detected!${NC}"
        return 0
    fi
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
    
    # Only backup if destination exists
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
    
    # Copy .config contents (copy everything INSIDE .config to ~/.config)
    if [ -d "$DOTFILES_DIR/.config" ]; then
        echo -e "${BLUE}${ICON_FOLDER}  Copying .config contents...${NC}"
        for config_item in "$DOTFILES_DIR/.config"/*; do
            if [ -e "$config_item" ]; then
                local item_name=$(basename "$config_item")
                local destination="$HOME/.config/$item_name"
                
                # Only backup if the target exists in ~/.config
                if [ -e "$destination" ]; then
                    create_backup "$destination"
                    echo -e "${YELLOW}${ICON_COPY}  Replacing: $destination${NC}"
                else
                    echo -e "${BLUE}${ICON_COPY}  Copying new: $destination${NC}"
                fi
                
                mkdir -p "$(dirname "$destination")"
                cp -r "$config_item" "$destination"
                
                if [ $? -eq 0 ]; then
                    echo -e "${GREEN}${ICON_SUCCESS}  Success: $destination${NC}"
                else
                    echo -e "${RED}${ICON_ERROR}  Failed: $destination${NC}"
                fi
            fi
        done
    fi
    
    # Copy .fonts contents
    if [ -d "$DOTFILES_DIR/.fonts" ]; then
        echo -e "${BLUE}${ICON_FOLDER}  Copying .fonts contents...${NC}"
        for font_item in "$DOTFILES_DIR/.fonts"/*; do
            if [ -e "$font_item" ]; then
                local item_name=$(basename "$font_item")
                local destination="$HOME/.fonts/$item_name"
                
                if [ -e "$destination" ]; then
                    create_backup "$destination"
                    echo -e "${YELLOW}${ICON_COPY}  Replacing: $destination${NC}"
                else
                    echo -e "${BLUE}${ICON_COPY}  Copying new: $destination${NC}"
                fi
                
                mkdir -p "$(dirname "$destination")"
                cp -r "$font_item" "$destination"
                
                if [ $? -eq 0 ]; then
                    echo -e "${GREEN}${ICON_SUCCESS}  Success: $destination${NC}"
                else
                    echo -e "${RED}${ICON_ERROR}  Failed: $destination${NC}"
                fi
            fi
        done
    fi
    
    # Copy .icons contents
    if [ -d "$DOTFILES_DIR/.icons" ]; then
        echo -e "${BLUE}${ICON_FOLDER}  Copying .icons contents...${NC}"
        for icon_item in "$DOTFILES_DIR/.icons"/*; do
            if [ -e "$icon_item" ]; then
                local item_name=$(basename "$icon_item")
                local destination="$HOME/.icons/$item_name"
                
                if [ -e "$destination" ]; then
                    create_backup "$destination"
                    echo -e "${YELLOW}${ICON_COPY}  Replacing: $destination${NC}"
                else
                    echo -e "${BLUE}${ICON_COPY}  Copying new: $destination${NC}"
                fi
                
                mkdir -p "$(dirname "$destination")"
                cp -r "$icon_item" "$destination"
                
                if [ $? -eq 0 ]; then
                    echo -e "${GREEN}${ICON_SUCCESS}  Success: $destination${NC}"
                else
                    echo -e "${RED}${ICON_ERROR}  Failed: $destination${NC}"
                fi
            fi
        done
    fi
    
    # Copy individual dotfiles from root
    echo -e "${BLUE}${ICON_FILE}  Copying individual dotfiles...${NC}"
    for item in "$DOTFILES_DIR"/.*; do
        # Skip . and .. entries
        if [ "$item" = "$DOTFILES_DIR/." ] || [ "$item" = "$DOTFILES_DIR/.." ]; then
            continue
        fi
        
        local item_name=$(basename "$item")
        
        # Skip directories we already handled
        if [ "$item_name" = ".config" ] || [ "$item_name" = ".fonts" ] || [ "$item_name" = ".icons" ]; then
            continue
        fi
        
        # Only copy files (not directories)
        if [ -f "$item" ]; then
            local destination="$HOME/$item_name"
            
            if [ -e "$destination" ]; then
                create_backup "$destination"
                echo -e "${YELLOW}${ICON_COPY}  Replacing: $destination${NC}"
            else
                echo -e "${BLUE}${ICON_COPY}  Copying new: $destination${NC}"
            fi
            
            cp "$item" "$destination"
            
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}${ICON_SUCCESS}  Success: $destination${NC}"
            else
                echo -e "${RED}${ICON_ERROR}  Failed: $destination${NC}"
            fi
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
    
    # Check sudo permissions first
    check_sudo_permissions "$@"
    
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

# End of the script