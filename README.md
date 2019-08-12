# Dotfiles

## Description

This is a collection of bash, jshint, and vim configuration files that I use in my 
development environment. Dotfiles are a convenient way to setup your development environment enabling easy backup and restore of application configurations.

Includes an install script to setup fresh environment. Currenly supports osx but other unixy operating systems could quite easily be added.

The install script is written to be idempodent, which means that you should be able to run it easily again if something goes wrong during the install, and it should normally just skip the parts that are already complete.

If you want to know how dotfiles function, search online there are lots of tutorials that have been written.

## Warning

Use at your own risk - these scripts run commands that could break your operating system.

I publish this repo publically mainly so that other developers that are setting up their dotfiles have some examples to base their setup on. 

Having said that, I use it myself to build my own system, so it should be functional, that's the intention, but you should definitely know what you are doing if you do run this and I would advise reading and understanding the code before running it.

## Adding dotfiles

1) Add items you don't want tracked in .gitignore

2) Add .symlink in filename to files to be symlinked
e.g. bash.symlink

## Install fresh environment

sh -c "$(curl -fsSL https://raw.githubusercontent.com/mjgs/dotfiles/master/install.sh)"

You'll need to set a few environment variables in your shell before you run the script:

```
  HOME                   - user home directory
  OS_TYPE                - osx (*)
  CODES_DIR              - path to codes directory (d)
  DOTFILES_REPO          - ssh connection string for dotfiles repository (d)
  DOTFILES_LOCAL_REPO    - ssh connection string for dotfiles_local repository (d)
  DOTFILES_RELATIVE_BASE - path segment used as base for relative symlink creation (d)

  (d) - indicates that a default is set, see code for details
  
  (*) - add other os types scripts to bin/install/<os_type>
```

## Development

I am currently making modifications that will make it easier to test on an existing operating system by setting the HOME variable to a temporary location.

Set environment variable DEBUG=1 to see debug logging as the scripts runs.

## TODO

- Make it easier to test on an existing system - [progres so far](https://github.com/mjgs/dotfiles/blob/master/NOTES.md#making-it-easier-to-test-on-an-existing-system)
## Thanks to…

* Nick Nisi [dotfiles repository](https://github.com/nicknisi/dotfiles)
* Mathias Bynens [dotfiles repository](https://github.com/mathiasbynens/dotfiles)
* @ptb and [his _OS X Lion Setup_ repository](https://github.com/ptb/Mac-OS-X-Lion-Setup)
* [Kevin Suttle](http://kevinsuttle.com/) and his [OSXDefaults project](https://github.com/kevinSuttle/OSXDefaults), which aims to provide better documentation for [`~/.osx`](https://mths.be/osx)
