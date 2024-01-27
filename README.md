# dotfiles
🔧 My public dotfiles for Linux, Windows, macOS and personal apps.

<style>
code-block {
    display: block;
    width: 100%;
    overflow-x: auto;
    white-space: pre;
    counter-reset: line;
    padding: 1em;
    font-family: "Inter", "Fira Code", monospace;
    font-size: 0.9em;
    line-height: 1.5;
    margin: 0.5em 0;
    tab-size: 4;
    hyphens: none;
}
</style>

## File Tree
<code-block>$ [main](#)
.
├── [.gitignore](.gitignore)
├── 📂 [dotfiles-linux](dotfiles-linux)
├── 📂 [dotfiles-vscode](dotfiles-vscode)
│  ├── 📂 [default-profile](dotfiles-vscode/default-profile)
│  │  ├── [Default.code-profile](dotfiles-vscode/default-profile/Default.code-profile)
│  │  └── [settings.json](dotfiles-vscode/default-profile/settings.json)
│  └── 📂 [linux-profile](dotfiles-vscode/linux-profile)
│     ├── [Linux.code-profile](dotfiles-vscode/linux-profile/Linux.code-profile)
│     └── [settings.json](dotfiles-vscode/linux-profile/settings.json)
└── [README.md](README.md)
</code-block>

## Installation
First, clone the repository to your home directory and then run the installation script **OR** add the settings/aliases to your existing files/dotfiles.

#### Linux

```bash
cd dotfiles-linux
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