# 🐚 Simple Shared Bash Dotfiles

This repository is a lightweight, focused solution for managing shared Bash configurations, aliases, and functions across my **macOS laptop** and **Android (Termux)** environment.

## 🎯 Goal

My previous dotfiles repository ([mjgs/dotfiles.old](https://github.com/mjgs/dotfiles.old)) attempted to manage a complete system installation, which became overly complicated and difficult to maintain.

This new repository has a single, streamlined goal: **to manage and share only the Bash configuration** (`.bashrc`, aliases, and functions).

This allows for a consistent terminal experience on both devices while still supporting device-specific settings and avoiding manual configuration duplication.

-----

## 📂 Structure Overview & File Tree

The configuration is split into three main areas, separating common code from platform-specific customizations.

### Annotated File Tree

```
dotfiles/
├── bash/                       # Directory containing all Bash configurations.
│   ├── bashrc_common           # Core configuration and environment settings common to ALL platforms.
│   ├── aliases_common          # Aliases common to ALL platforms.
│   ├── functions_common        # Functions common to ALL platforms.
│   ├── macos/                  # Configurations specific to macOS.
│   │   ├── bash_profile        # Wrapper to source bashrc (SYMLINKED to ~/.bash_profile).
│   │   ├── bashrc              # macOS-specific bashrc (SYMLINKED to ~/.bashrc on Mac).
│   │   ├── exports             # CRITICAL: Defines all macOS-specific env variables (e.g., CODE_DIR).
│   │   ├── aliases             # macOS-specific aliases.
│   │   └── functions           # macOS-specific functions.
│   └── android/                # Configurations specific to Android (Termux, etc.).
│       ├── bashrc              # Android-specific bashrc (SYMLINKED to ~/.bashrc on Android).
│       ├── exports             # CRITICAL: Defines all Android-specific env variables (e.g., code_dir).
│       ├── aliases             # Android-specific aliases.
│       ├── functions           # Android-specific functions.
│       └── vimrc               # Vim configuration specific to Android (SYMLINKED to ~/.vimrc).
├── termux/                     # Application configuration files for Termux.
│   └── termux.properties       # Termux app settings (SYMLINKED to ~/.termux).
└── README.md                   # This file.
```

### Structure Breakdown

1.  **Platform Exports** (`bash/platform/exports`): Defines all platform-specific environment variables (`$CODE_DIR`, Homebrew setup, NVM, etc.). **This is sourced first** by the respective `bashrc` file.
2.  **Common** (`bash/` files): Code that works identically on both macOS and Android.
      * `bashrc_common`: Shared core settings and the custom `PATH` logic.
      * `aliases_common`: Shared aliases (`ll`, `git` shortcuts, etc.)
      * `functions_common`: Shared custom shell functions.
3.  **Device-Specific** (`bash/macos/` and `bash/android/`): Customizations unique to each OS.
      * `bashrc`: The primary entry point.
      * `aliases`: Device-specific aliases.
      * `functions`: Device-specific functions.

This structure separates environment variables, aliases, and functions for maximum clarity.

-----

## 🚀 Installation and Setup

The setup involves two steps: cloning the repository and setting up symlinks for all configuration files.

### 1. Clone the Repository

Clone this repository to your home directory:

```bash
git clone <your_repo_url> ~/dotfiles
```

### 2. Create the Symlinks

#### 🍎 On macOS:

Create symbolic links for your Bash configuration in your home directory:

```bash
# Move your existing configs
mv ~/.bashrc ~/.bashrc.orig
mv ~/.bash_profile ~/.bash_profile.orig

# Link the platform-specific Bash entry point
ln -s ~/dotfiles/bash/macos/bashrc ~/.bashrc

# Link the tiny wrapper to ensure ~/.bashrc runs in login shells
ln -s ~/dotfiles/bash/macos/bash_profile ~/.bash_profile
```

#### 🤖 On Android (Termux, etc.):

Create symbolic links for your Bash, Vim, and Termux application configurations:

```bash
# Move your existing config
mv ~/.bashrc ~/.bashrc.orig
mv ~/.vimrc ~/.vimrc.orig
mv ~/.termux ~/.termux.orig

# Link the platform-specific Bash entry point
ln -s ~/dotfiles/bash/android/bashrc ~/.bashrc

# Link the platform-specific Vim configuration
ln -s ~/dotfiles/bash/android/vimrc ~/.vimrc

# Link the Termux application configuration files
ln -s ~/dotfiles/termux/ ~/.termux
```

### 3. Usage

After setup, any changes to the `_common` files (aliases, functions, etc.) can be instantly propagated to all devices with a simple `git pull` and then reloading your shell (`source ~/.bashrc`).

If anything goes wrong and things don't work as expected, delete the symlinks you created and move your old configs back:

```bash
# Remove the symlinks
rm ~/.bashrc ~/.bash_profile # etc...

# Move all your original configs back
mv ~/.bashrc.orig ~/.bashrc # etc...
```
