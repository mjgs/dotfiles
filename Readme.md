This is a collection of zsh, jshint, and vim configuration files that I use in my 
development environment.

Includes an install script to setup fresh OSX environments.

# Adding dotfiles

1) Add items you don't want tracked in .gitignore

2) Add .symlink in filename to files to be symlinked
e.g. zshrc.symlink

# Install fresh OSX dev environment

sh -c "$(curl -fsSL https://raw.githubusercontent.com/mjgs/dotfiles/master/install.sh)"

Typically run from user's home directory, defaults to creating Configs and Codes 
directories in current directory.

Environment variables that you should set before install:

```
  HOME        - user home directory"
  CONFIGS_DIR - path to configs directory (d)"
  CODES_DIR   - path to codes directory (d)"
  REPO        - ssh connection string for dotfiles repository (d)"
  REPO_LOCAL  - ssh connection string for dotfiles_local repository (d)"

 (d) - Have default values (check the code for details)
```

## TODO

- Update the git clone commands to be idempodent

## Thanks to…

* Nick Nisi [dotfiles repository](https://github.com/nicknisi/dotfiles)
* Mathias Bynens [dotfiles repository](https://github.com/mathiasbynens/dotfiles)
* @ptb and [his _OS X Lion Setup_ repository](https://github.com/ptb/Mac-OS-X-Lion-Setup)
* [Kevin Suttle](http://kevinsuttle.com/) and his [OSXDefaults project](https://github.com/kevinSuttle/OSXDefaults), which aims to provide better documentation for [`~/.osx`](https://mths.be/osx)
