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
ICON_INFO=""
ICON_SUCCESS=""
ICON_WARNING=""
ICON_ERROR=""
ICON_FOLDER=""
ICON_FILE=""
ICON_COPY="󱁥"
ICON_BACKUP=""
ICON_FONT=""
ICON_CHECK=""

# Script variables
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOTFILES_DIR="$REPO_DIR/dotfiles"
BACKUP_DIR="$HOME/user_old_config_$(date +%Y%m%d_%H%M%S)"
CURRENT_USER=$(whoami)

# ==========================================
# FUNCTIONS
# ==========================================

print_header() {
    echo -e "${PURPLE}
    ███████╗██╗██████╗ ███████╗██████╗ ██████╗ ██████╗ 
    ██╔════╝██║██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔══██╗
    █████╗  ██║██████╔╝█████╗  ██║  ██║██████╔╝██║  ██║
    ██╔══╝  ██║██╔══██╗██╔══╝  ██║  ██║██╔══██╗██║  ██║
    ██║     ██║██║  ██║███████╗██████╔╝██║  ██║██████╔╝
    ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚═════╝ 
    
                      ██╗  ██╗
                       ╚██╗██╔╝
                        ╚███╔╝ 
                        ██╔██╗ 
                       ██╔╝ ██╗
                       ╚═╝  ╚═╝
    
    ██████╗ ██╗  ██╗███████╗██╗  ██╗███╗   ██╗██╗██╗  ██╗
    ██╔══██╗██║  ██║██╔════╝██║  ██║████╗  ██║██║╚██╗██╔╝
    ██████╔╝███████║█████╗  ███████║██╔██╗ ██║██║ ╚███╔╝ 
    ██╔═══╝ ██╔══██║██╔══╝  ██╔══██║██║╚██╗██║██║ ██╔██╗ 
    ██║     ██║  ██║███████╗██║  ██║██║ ╚████║██║██╔╝ ██╗
    ╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝
    ${NC}"
    echo -e "${CYAN}${ICON_INFO}  FxP Dotfiles Installer${NC}"
    echo -e "${CYAN}${ICON_INFO}  User: $CURRENT_USER${NC}"
    echo -e "${CYAN}${ICON_INFO}  Repository: $REPO_DIR${NC}"
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
    
    # Copy .config directories
    for config_dir in "$DOTFILES_DIR/.config"/*; do
        if [ -d "$config_dir" ]; then
            local dir_name=$(basename "$config_dir")
            copy_with_backup "$config_dir" "$HOME/.config/$dir_name"
        fi
    done
    
    # Copy .config files
    for config_file in "$DOTFILES_DIR/.config"/*; do
        if [ -f "$config_file" ]; then
            local file_name=$(basename "$config_file")
            copy_with_backup "$config_file" "$HOME/.config/$file_name"
        fi
    done
    
    # Copy .fonts
    if [ -d "$DOTFILES_DIR/.fonts" ]; then
        copy_with_backup "$DOTFILES_DIR/.fonts" "$HOME/.fonts"
    fi
    
    # Copy .icons
    if [ -d "$DOTFILES_DIR/.icons" ]; then
        copy_with_backup "$DOTFILES_DIR/.icons" "$HOME/.icons"
    fi
    
    # Copy .bashrc
    if [ -f "$DOTFILES_DIR/.bashrc" ]; then
        copy_with_backup "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
    fi
}

show_summary() {
    echo -e "${PURPLE}
    ┌──────────────────────────────────────────────┐
    │                 INSTALLATION SUMMARY          │
    └──────────────────────────────────────────────┘${NC}"
    
    echo -e "${GREEN}${ICON_SUCCESS}  Dotfiles installed successfully!${NC}"
    echo -e "${BLUE}${ICON_BACKUP}  Backups saved to: $BACKUP_DIR${NC}"
    echo -e "${CYAN}${ICON_INFO}  Installed components:${NC}"
    echo -e "  ${ICON_FOLDER}  Configurations: ~/.config/"
    echo -e "  ${ICON_FONT}  Fonts: ~/.fonts/"
    echo -e "  ${ICON_FOLDER}  Icons: ~/.icons/"
    echo -e "  ${ICON_FILE}  Shell: ~/.bashrc"
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
    
    # Check if we're in the right directory
    if [ ! -d "$DOTFILES_DIR" ]; then
        echo -e "${RED}${ICON_ERROR}  Error: dotfiles directory not found!${NC}"
        echo -e "${RED}  Please run this script from the repository root.${NC}"
        exit 1
    fi
    
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