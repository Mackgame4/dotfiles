#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Ask user if he wants to install the "WhiteSur" GTK and icon themes
echo "Do you want to install the WhiteSur GTK and icon themes? (Y/n)"
read -r response
if [[ -z "$response" || $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    INSTALL_CUSTOMTHEME=true
else
    INSTALL_CUSTOMTHEME=false
fi

if [ "$INSTALL_CUSTOMTHEME" = true ]; then
    echo "Installing the WhiteSur GTK and icon themes..."
    # Update and install basic packages
    sudo apt upgrade -y
    sudo apt update -y
    sudo apt install git curl dconf dconf-editor gnome-tweaks -y # gnome-shell-extension-manager (is optional, but doesnt work with "gnome-shell-extension-installer")

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
    sudo ./tweaks.sh -g # Customizes GDM theme
    sudo ./tweaks.sh -g -b default # Customizes GDM background
    cd ..
    git clone https://github.com/vinceliuice/WhiteSur-icon-theme
    cd WhiteSur-icon-theme/
    ./install.sh -a # Install icon theme

    # Import dconf settings
    dconf load / < dconf-settings.ini

    # Restart GNOME Shell
    killall -SIGQUIT gnome-shell
fi

# Ask user if he wants to install extra apps
echo "Do you want to install extra apps? (Y/n)"
read -r response
if [[ -z "$response" || $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    INSTALL_EXTRAAPPS=true
else
    INSTALL_EXTRAAPPS=false
fi

if [ "$INSTALL_EXTRAAPPS" = true ]; then
    echo "Installing extra apps..."
    # Update and install basic packages
    sudo apt upgrade -y
    #sudo apt update -y
    #sudo apt install snapd -y
    #sudo apt install vlc gimp inkscape krita blender audacity obs-studio kdenlive krita kdenlive -y
    #sudo snap install spotify
    #sudo snap install discord
    #sudo snap install code
    # or, using a more modern way to install apps:

    # Install Flatpak
    sudo add-apt-repository ppa:flatpak/stable
    sudo apt update -y
    sudo apt install flatpak -y
    sudo apt install gnome-software-plugin-flatpak -y
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    # Install apps
    flatpak_apps=(
        "org.videolan.VLC"
        "org.gimp.GIMP"
        "com.visualstudio.code"
        "com.discordapp.Discord"
        "com.spotify.Client"
        # Add more apps to this list as needed
    )
    flatpak install flathub ${flatpak_apps[@]} -y

    # Install sub-apps
    sudo apt install gparted neofetch -y
fi