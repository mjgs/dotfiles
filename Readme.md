This is a collection of zsh, jshint, and vim configuration files that I use in my development environment.
Includes an install script to setup fresh OSX environments.

# Adding dotfiles:

1) Add items you don't want tracked in .gitignore

2) Add .symlink in filename to files to be symlinked
e.g. zshrc.symlink

# Install

To install a fresh OSX environment run

sh -c "$(curl -fsSL https://raw.githubusercontent.com/mjgs/dotfiles/master/install.sh)"

NOTE: Typically run from user's home directory. 
Defaults to creating Configs and Codes directories in current directory.

Override by setting environment variables before running the install command:
export CONFIGS_DIR=/path/to/dir 
export CODES_DIR=/path/to/dir