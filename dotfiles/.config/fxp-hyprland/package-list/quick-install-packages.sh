#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACMAN_LIST="$SCRIPT_DIR/pacman.txt"
YAY_LIST="$SCRIPT_DIR/yay.txt"

# Function to check file existence
check_file() {
    if [[ ! -f "$1" ]]; then
        echo "❌ File not found: $1"
        return 1
    fi
    echo "✅ Found: $1"
    return 0
}

# Function to count packages
count_packages() {
    if [[ -f "$1" ]]; then
        count=$(wc -l < "$1")
        echo "📊 Packages in $(basename "$1"): $count"
    fi
}

# Function to check if yay is installed
check_yay_installed() {
    if command -v yay &> /dev/null; then
        echo "✅ yay is already installed"
        return 0
    else
        echo "❌ yay is not installed"
        return 1
    fi
}

# Function to install yay-bin
install_yay_bin() {
    echo "🟡 Installing yay-bin..."
    
    # Check if git is installed (needed for AUR installation)
    if ! command -v git &> /dev/null; then
        echo "📦 Installing git first..."
        sudo pacman -S --needed --noconfirm git
    fi
    
    # Check if base-devel is installed
    if ! pacman -Q base-devel &> /dev/null; then
        echo "🔧 Installing base-devel..."
        sudo pacman -S --needed --noconfirm base-devel
    fi
    
    # Install yay-bin from AUR
    echo "📥 Downloading and installing yay-bin..."
    temp_dir=$(mktemp -d)
    cd "$temp_dir"
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si --noconfirm
    
    # Cleanup
    cd ..
    rm -rf "$temp_dir"
    
    # Verify installation
    if command -v yay &> /dev/null; then
        echo "✅ yay-bin installed successfully!"
        return 0
    else
        echo "❌ Failed to install yay-bin"
        return 1
    fi
}

echo "📦 Starting package installation..."
echo "======================================"
echo "Script directory: $SCRIPT_DIR"
echo ""

# Check files
check_file "$PACMAN_LIST" || exit 1
check_file "$YAY_LIST" || exit 1

# Show package counts
count_packages "$PACMAN_LIST"
count_packages "$YAY_LIST"

echo ""

# Check and install yay if needed
if ! check_yay_installed; then
    echo "yay is required for AUR package installation."
    read -p "Do you want to install yay-bin now? (Y/n): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        install_yay_bin || exit 1
    else
        echo "❌ Cannot continue without yay. Installation cancelled."
        exit 1
    fi
fi

echo ""
read -p "Continue with package installation? (y/N): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Installation cancelled."
    exit 1
fi

# Install pacman packages
echo ""
echo "🔵 Installing Pacman packages..."
while IFS= read -r pkg; do
    if [[ -n "$pkg" && "$pkg" != "yay-bin" ]]; then  # Skip yay-bin if in pacman list
        echo "Installing: $pkg"
        sudo pacman -S --needed --noconfirm "$pkg" 2>/dev/null || echo "⚠️  Failed to install: $pkg"
    fi
done < "$PACMAN_LIST"

# Install AUR packages
echo ""
echo "🟡 Installing AUR packages..."
while IFS= read -r pkg; do
    if [[ -n "$pkg" && "$pkg" != "yay-bin" ]]; then  # Skip yay-bin if in AUR list
        echo "Installing: $pkg"
        yay -S --needed --noconfirm "$pkg" 2>/dev/null || echo "⚠️  Failed to install: $pkg"
    fi
done < "$YAY_LIST"

echo "✅ Package installation completed!"