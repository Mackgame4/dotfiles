#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )" # Get the path of the current script

### CUSTOM THEME INSTALLATION ###
WALLPAPER_NAME="Monterey-nord.png"

function install_customtheme() {
    echo "Installing the WhiteSur GTK and icon themes..."
    # Update and install basic packages
    sudo apt upgrade -y
    sudo apt update -y
    sudo apt install git curl dconf-editor gnome-tweaks gnome-shell-extensions -y # gnome-shell-extension-manager (is optional, but doesnt work with "gnome-shell-extension-installer"); and dconf (already installed by default in Ubuntu)

    # Create a directory for custom themes
    mkdir -p ~/CustomGTKThemes
    cd ~/CustomGTKThemes

    # Install "gnome-shell-extension-installer"
    wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
    chmod +x gnome-shell-extension-installer
    sudo mv gnome-shell-extension-installer /usr/bin/

    # Install and enable GNOME Shell Extensions
    mkdir -p InstalledShellExtensions
    cd InstalledShellExtensions
    gnome-shell-extension-installer 19 307 3193 6 8 --yes --no-install
    gnome-extensions install blur-my-shell@aunetx.shell-extension.zip
    gnome-extensions install apps-menu@gnome-shell-extensions.gcampax.github.com.shell-extension.zip
    gnome-extensions install dash-to-dock@micxgx.gmail.com.shell-extension.zip
    gnome-extensions install places-menu@gnome-shell-extensions.gcampax.github.com.shell-extension.zip
    gnome-extensions install user-theme@gnome-shell-extensions.gcampax.github.com.shell-extension.zip
    gnome-extensions enable blur-my-shell@aunetx
    gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
    gnome-extensions enable places-menu@gnome-shell-extensions.gcampax.github.com
    gnome-extensions enable apps-menu@gnome-shell-extensions.gcampax.github.com
    gnome-extensions enable dash-to-dock@micxgx.gmail.com
    cd ..

    # Install "WhiteSur" GTK and icon themes
    git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
    cd WhiteSur-gtk-theme/
    ./install.sh -i simple # or all the themes: ./install.sh -t all
    ./tweaks.sh -f monterey # Customizes firefox theme
    cp -r $SCRIPTPATH/Wallpapers/ ~/CustomGTKThemes/ # Copy this "Wallpapers" to the "CustomGTKTheme/Wallpapers" directory
    sudo ./tweaks.sh -g -b "../Wallpapers/$WALLPAPER_NAME" # Customizes GDM theme
    gsettings set org.gnome.desktop.background picture-uri "file:///home/$USER/CustomGTKThemes/Wallpapers/$WALLPAPER_NAME"
    gsettings set org.gnome.desktop.background picture-uri-dark "file:///home/$USER/CustomGTKThemes/Wallpapers/$WALLPAPER_NAME"
    # lock screen
    gsettings set org.gnome.desktop.screensaver picture-uri "file:///home/$USER/CustomGTKThemes/Wallpapers/$WALLPAPER_NAME"
    cd ..
    git clone https://github.com/vinceliuice/WhiteSur-icon-theme
    cd WhiteSur-icon-theme/
    ./install.sh -a # Install icon theme

    cd $SCRIPTPATH/
    # Import dconf settings
    dconf load / < dconf-settings.ini

    # Restart GNOME Shell
    #killall -SIGQUIT gnome-shell
}

# Ask user if he wants to install the "WhiteSur" GTK and icon themes
echo "Do you want to install the WhiteSur GTK and icon themes? (Y/n)"
read -r response
if [[ -z "$response" || $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    install_customtheme
fi

### CUSTOM APPS INSTALLATION ###

function install_customgetapps() {
    echo "Installing Custom Get Apps..."
    # Create a folder to store the installers
    mkdir -p ~/CustomGetApps
    cd ~/CustomGetApps
    # Install "Github Desktop" app
    wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
    sudo apt update && sudo apt install github-desktop -y
    # Install "Google Chrome" app
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    sudo apt install -f -y
    # Delete the installers
    rm -rf ~/CustomGetApps
    cd $SCRIPTPATH/
}

function install_extraapps() {
    echo "Installing extra apps..."
    AptAppList=("vlc" # VLC Media Player
        "gimp" # GIMP
    )
    sudo apt install -y ${AptAppList[@]}
    sudo apt install snapd -y
    SnapAppList=("code" # VS Code
        "discord" # Discord
        "spotify" # Spotify
    )
    for app in "${SnapAppList[@]}"; do
        sudo snap install $app --classic
    done
    # Install Custom Get Apps
    install_customgetapps
}

# Ask user if he wants to install extra apps
echo "Do you want to install extra apps? (Y/n)"
read -r response
if [[ -z "$response" || $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    install_extraapps
fi

### CUSTOM PROG LANGUAGE INSTALLATION ###
function install_proglangs() {
    echo "Installing programming languages..."
    # Install "Node.js" and "npm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    source ~/.bashrc
    nvm install --lts
    #sudo apt install -y npm
    # Install "Python" and "pip"
    sudo apt install -y python3 python3-pip
    # Install "Java"
    #sudo apt install -y default-jre default-jdk
    # Install "Java 21 SDK" (for Debian-based distros only)
    wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb -O jdk-21_linux-x64_bin.deb
    sudo apt install -y ./jdk-21_linux-x64_bin.deb
    rm jdk-21_linux-x64_bin.deb
    # Install "Go"
    sudo apt install -y golang-go
}

# Ask user if he wants to install programming languages
echo "Do you want to install some programming languages supports? (Y/n)"
read -r response
if [[ -z "$response" || $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    install_proglangs
fi

echo "Installation complete!"