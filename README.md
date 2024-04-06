# dotfiles
🔧 My public dotfiles for Linux, Windows, macOS and personal apps.

## File Tree
```
├── $ 📂 .
│   ├── ctree.bat
│   ├── ctree.sh
│   ├── dotfiles-linux
│   ├── dotfiles-vscode
│   └── README.md
│   ├── $ 📂 dotfiles-linux
│   │   ├── dconf-settings.ini
│   │   ├── install.sh
│   │   └── Wallpapers
│   │   ├── $ 📂 Wallpapers
│   │   │   ├── Monterey-dark.jpg
│   │   │   ├── Monterey.jpg
│   │   │   ├── Monterey-light.jpg
│   │   │   ├── Monterey-morning.jpg
│   │   │   ├── Monterey-nord.png
│   │   │   ├── WhiteSur-dark.jpg
│   │   │   ├── WhiteSur.jpg
│   │   │   ├── WhiteSur-light.jpg
│   │   │   └── WhiteSur-morning.jpg
│   ├── $ 📂 dotfiles-vscode
│   │   ├── default-profile
│   │   └── linux-profile
│   │   ├── $ 📂 default-profile
│   │   │   ├── Default.code-profile
│   │   │   └── settings.json
│   │   ├── $ 📂 linux-profile
│   │   │   ├── Linux.code-profile
│   │   │   └── settings.json
```

## Installation
First, clone the repository to your home directory and then run the installation script **OR** add the settings/aliases to your existing files/dotfiles.

#### Linux

```bash
cd dotfiles-linux
chmod +x install.sh
./install.sh
```

<!--
### Windows

```powershell
git clone
cd dotfiles
./install.ps1
```

### macOS

```bash
git clone
cd dotfiles
./install.sh
```
-->

#### Git (Global) Configuration
```bash
git config --global core.autocrlf false
git config --global gpg.format ssh
git config --global commit.gpgsign true
git config --global tag.gpgsign true
git config --global user.signingkey C:\\Users\\fabio/.ssh/id_rsa (default for Windows using "ssh-keygen")
```