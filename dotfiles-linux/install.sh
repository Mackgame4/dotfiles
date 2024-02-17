#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

$WALLPAPER_NAME="Monterey-nord.png"

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
    mkdir InstalledShellExtensions
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
    cp -r Wallpapers/ ~/CustomGTKThemes/ # Copy this "Wallpapers" to the "CustomGTKTheme/Wallpapers" directory
    sudo ./tweaks.sh -g -b "../Wallpapers/$WALLPAPER_NAME" # Customizes GDM theme
    gsettings set org.gnome.desktop.background picture-uri "file:///home/$USER/CustomGTKThemes/Wallpapers/$WALLPAPER_NAME"
    gsettings set org.gnome.desktop.background picture-uri-dark "file:///home/$USER/CustomGTKThemes/Wallpapers/$WALLPAPER_NAME"
    # lock screen
    gsettings set org.gnome.desktop.screensaver picture-uri "file:///home/$USER/CustomGTKThemes/Wallpapers/$WALLPAPER_NAME"
    cd ..
    git clone https://github.com/vinceliuice/WhiteSur-icon-theme
    cd WhiteSur-icon-theme/
    ./install.sh -a # Install icon theme

    # Import dconf settings
    #dconf load / < dconf-settings.ini

    # Restart GNOME Shell
    #killall -SIGQUIT gnome-shell
}

# Ask user if he wants to install the "WhiteSur" GTK and icon themes
echo "Do you want to install the WhiteSur GTK and icon themes? (Y/n)"
read -r response
if [[ -z "$response" || $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    install_customtheme
fi