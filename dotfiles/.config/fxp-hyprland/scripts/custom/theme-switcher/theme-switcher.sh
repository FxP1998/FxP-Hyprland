#!/usr/bin/env bash

# Configuration
THEMES_DIR="$HOME/.config/fxp-hyprland/themes/useable"
CONFIG_DIR="$HOME/.config"
CURRENT_THEME_FILE="$CONFIG_DIR/current_theme"

# Get available themes
get_themes() {
    find "$THEMES_DIR" -maxdepth 1 -type d -name "*-*" | sort | while read theme; do
        basename "$theme"
    done
}

# Copy all files from source to destination directory
copy_all_files() {
    local source_dir="$1"
    local dest_dir="$2"
    
    if [ -d "$source_dir" ]; then
        # Create destination directory if it doesn't exist
        mkdir -p "$dest_dir"
        
        # Copy ALL files and subdirectories from source to destination
        echo "Copying files from $source_dir to $dest_dir"
        cp -r "$source_dir"/* "$dest_dir/" 2>/dev/null
        
        if [ $? -eq 0 ]; then
            echo "  → $(basename "$dest_dir") config applied"
            return 0
        else
            echo "  → No files found in $(basename "$source_dir")"
            return 1
        fi
    else
        echo "  → Directory not found: $(basename "$source_dir")"
        return 1
    fi
}

# Execute wallpaper script
execute_wallpaper_script() {
    local wallpaper_script="$HOME/.config/hypr/scripts/startupwallpaper-reload.sh"
    
    if [ -f "$wallpaper_script" ]; then
        echo "Executing wallpaper script..."
        chmod +x "$wallpaper_script"
        "$wallpaper_script"
        echo "  → Wallpaper script executed successfully"
    else
        echo "  → Wallpaper script not found: $wallpaper_script"
    fi
}

# Reload GTK themes properly
reload_gtk_themes() {
    echo "Reloading GTK themes, icons, and cursors..."
    
    # Method 1: Use gsettings to force theme change
    if command -v gsettings >/dev/null 2>&1; then
        export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
        
        # Read the current theme from settings.ini
        local gtk_theme=$(grep '^gtk-theme-name' ~/.config/gtk-3.0/settings.ini | cut -d'=' -f2)
        local icon_theme=$(grep '^gtk-icon-theme-name' ~/.config/gtk-3.0/settings.ini | cut -d'=' -f2)
        local cursor_theme=$(grep '^gtk-cursor-theme-name' ~/.config/gtk-3.0/settings.ini | cut -d'=' -f2)
        
        # Remove quotes if present
        gtk_theme=$(echo "$gtk_theme" | tr -d '"' | tr -d "'")
        icon_theme=$(echo "$icon_theme" | tr -d '"' | tr -d "'")
        cursor_theme=$(echo "$cursor_theme" | tr -d '"' | tr -d "'")
        
        echo "  → Setting GTK theme: $gtk_theme"
        echo "  → Setting icon theme: $icon_theme"
        echo "  → Setting cursor theme: $cursor_theme"
        
        # Force set the themes using gsettings
        gsettings set org.gnome.desktop.interface gtk-theme "$gtk_theme"
        gsettings set org.gnome.desktop.interface icon-theme "$icon_theme"
        gsettings set org.gnome.desktop.interface cursor-theme "$cursor_theme"
        
        echo "  → GTK themes set via gsettings"
    fi
    
    # Method 2: Restart common GTK applications to apply changes
    echo "  → Restarting GTK applications..."
    
    # List of common GTK apps that need restart
    local gtk_apps=("nautilus" "nemo" "thunar" "caja" "pcmanfm")
    
    for app in "${gtk_apps[@]}"; do
        if pgrep "$app" >/dev/null; then
            echo "  → Restarting $app"
            killall "$app" 2>/dev/null
            sleep 0.5
            # Restart in background
            nohup "$app" >/dev/null 2>&1 &
        fi
    done
    
    # Method 3: Update GTK settings cache
    if command -v update-desktop-database >/dev/null 2>&1; then
        update-desktop-database ~/.local/share/applications
        echo "  → Desktop database updated"
    fi
    
    # Method 4: Reload GTK modules
    if command -v gtk-query-settings >/dev/null 2>&1; then
        gtk-query-settings >/dev/null 2>&1
        echo "  → GTK settings reloaded"
    fi
    
    echo "  → GTK theme changes applied"
    echo "  → Note: Some applications may need manual restart to see changes"
}

# Check if GTK themes are installed
check_gtk_themes() {
    echo "Checking GTK themes..."
    
    local gtk_theme=$(gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null | tr -d "'")
    local icon_theme=$(gsettings get org.gnome.desktop.interface icon-theme 2>/dev/null | tr -d "'")
    local cursor_theme=$(gsettings get org.gnome.desktop.interface cursor-theme 2>/dev/null | tr -d "'")
    
    echo "  → GTK Theme: $gtk_theme"
    echo "  → Icon Theme: $icon_theme" 
    echo "  → Cursor Theme: $cursor_theme"
    
    # Check if themes exist
    if [ ! -d "/usr/share/themes/$gtk_theme" ] && [ ! -d "$HOME/.themes/$gtk_theme" ]; then
        echo "  → WARNING: GTK theme '$gtk_theme' not found!"
    fi
    
    if [ ! -d "/usr/share/icons/$icon_theme" ] && [ ! -d "$HOME/.icons/$icon_theme" ]; then
        echo "  → WARNING: Icon theme '$icon_theme' not found!"
    fi
    
    if [ ! -d "/usr/share/icons/$cursor_theme" ] && [ ! -d "$HOME/.icons/$cursor_theme" ]; then
        echo "  → WARNING: Cursor theme '$cursor_theme' not found!"
    fi
}

# Reload applications
reload_applications() {
    echo "Reloading applications..."
    
    # Reload Waybar
    if pgrep waybar > /dev/null; then
        killall waybar
        waybar &
        echo "  → Waybar reloaded"
    fi
    
    # Reload Kitty (send signal to reload config)
    if pgrep kitty > /dev/null; then
        killall -USR1 kitty
        echo "  → Kitty reloaded"
    fi
    
    # Reload Dunst
    if pgrep dunst > /dev/null; then
        killall dunst
        dunst &
        echo "  → Dunst reloaded"
    fi

    # Reload SwayOSD-Server
    pkill -USR1 swayosd-server && swayosd-server &
    echo "  → swayosd-server reloaded"
    
    # Execute wallpaper script
    execute_wallpaper_script
    
    # RELOAD GTK THEMES - ADD THIS LINE
    reload_gtk_themes
    
    # Reload Hyprland
    hyprctl reload
    echo "  → Hyprland reloaded"
    
    # Wofi doesn't need reloading as it's launched on demand
    echo "  → Wofi will use new theme on next launch"
}

# Apply theme
apply_theme() {
    local theme_name="$1"
    local theme_path="$THEMES_DIR/$theme_name"
    
    echo "Applying theme: $theme_name"
    
    # Copy ALL theme configurations
    if [ -d "$theme_path/configs" ]; then
        # Copy everything from theme's waybar to ~/.config/waybar/
        copy_all_files "$theme_path/configs/waybar" "$CONFIG_DIR/waybar"
        
        # Copy everything from theme's kitty to ~/.config/kitty/
        copy_all_files "$theme_path/configs/kitty" "$CONFIG_DIR/kitty"
        
        # Copy everything from theme's hyprland to ~/.config/hypr/
        copy_all_files "$theme_path/configs/hyprland" "$CONFIG_DIR/hypr"
        
        # Copy everything from theme's wofi to ~/.config/wofi/
        copy_all_files "$theme_path/configs/wofi" "$CONFIG_DIR/wofi"
        
        # Copy everything from theme's nvim to ~/.config/nvim/
        copy_all_files "$theme_path/configs/nvim" "$CONFIG_DIR/nvim"
        
        # Copy everything from theme's dunst to ~/.config/dunst/
        copy_all_files "$theme_path/configs/dunst" "$CONFIG_DIR/dunst"
 
        # Copy everything from theme's scripts to ~/.config/hypr/scripts
        copy_all_files "$theme_path/scripts" "$CONFIG_DIR/hypr/scripts"

        # Copy everything from theme's swayosd to ~/.config/swayosd/
        copy_all_files "$theme_path/configs/swayosd" "$CONFIG_DIR/swayosd"
       
        # Copy everything from theme's starship to ~/.config/
        copy_all_files "$theme_path/configs/starship" "$CONFIG_DIR"
        
        # COPY GTK CONFIGURATIONS - ADD THESE LINES
        copy_all_files "$theme_path/configs/gtk-3.0" "$CONFIG_DIR/gtk-3.0"
        copy_all_files "$theme_path/configs/gtk-4.0" "$CONFIG_DIR/gtk-4.0"
               
        # Special case: Vim colors to ~/.vim/colors/
        if [ -d "$theme_path/configs/vim" ]; then
            copy_all_files "$theme_path/configs/vim" "$HOME/.vim"
        fi
    fi
    
    # Execute wallpaper script AFTER all files are copied
    execute_wallpaper_script
    
    # In apply_theme function, before reload_applications:
    check_gtk_themes

    # Save current theme
    echo "$theme_name" > "$CURRENT_THEME_FILE"
    echo "Theme '$theme_name' applied successfully!"
    
    # Reload applications AFTER copying files and changing wallpaper
    reload_applications
}

# Show current theme
show_current_theme() {
    if [ -f "$CURRENT_THEME_FILE" ]; then
        echo "Current theme: $(cat "$CURRENT_THEME_FILE")"
    else
        echo "No theme currently set"
    fi
}

# Show theme selection using wofi
show_theme_selection() {
    get_themes | wofi --dmenu --prompt "Select theme:" --width 300 --height 200
}

# Main execution
main() {
    case "$1" in
        "--list")
            get_themes
            ;;
        "--current")
            show_current_theme
            ;;
        "--reload")
            reload_applications
            ;;
        *)
            selected_theme=$(show_theme_selection)
            
            if [ -n "$selected_theme" ]; then
                apply_theme "$selected_theme"
            else
                echo "No theme selected"
            fi
            ;;
    esac
}

# Run main function
main "$@"
