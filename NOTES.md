# Notes

## Making it easier to test on an existing system

The install script works for installing, I've installed my latest system using it, but once you have a system up and running it's more tricky to test the script because everything is already installed. Of course you can just run the script again and since it's written to be idempodent it should just skip all the things that are already installed, but there is the possibility that some bug in the script has been introduced and is just not showing up because it's being skipped. So it would be cool to be able to install to a temp location for testing purposes.

2019-08-18 I've removed nvm in favour of just installing from source, so will need to test this temp location proceedure again, but current hard drive isn't big enough to run the test

2019-08-22 I got this working by updating all the language installer scripts to install from source, rather than use version managers like nvm. These are the settings for a test run:

```
DEBUG=1 \
HOME=/TESTS/DOTFILES_TESTS/TEST_HOME \
OS_TYPE=osx \
DOTFILES_ROOT_DIR=[REPLACE WITH PATH TO WHERE YOUR CODE REPOS ARE] \
DOTFILES_REPO_URL=git@github.com:mjgs/dotfiles.git \
DOTFILES_REPO_BRANCH=easier-testing \
DOTFILES_LOCAL_REPO_URL=git@ github.com:mjgs/dotfiles_local.git \
DOTFILES_LOCAL_REPO_BRANCH=easier-testing \
DOTFILES_RELATIVE_BASE=[REPLACE WITH RELATIVE PATH SEGMENT FOR SYMLINKS] \
bash -c "$(curl -fsSL https://raw.githubusercontent.com/mjgs/dotfiles/easier-testing/install.sh)"
```

Additionally, setting BACKUP_DIR will cause a full restore to be done that triggers the restore-laptop.sh script. I've been testing without this to ensure I don't fill up my hard drive. So I still need to test it with a full restore, I need a bigger hard drive to do this.

As you can see from the above command, you can create test branches in the dotfiles repos and these will be checked out when they get cloned, then test everything works and merge the branch into master when it's all working.

What happens:

- Homebrew will still install to regular location, so these will all be skipped (Homebrew tends to work fine so not an issue)
- Everything else gets installed to /TESTS/DOTFILES_TESTS/TEST_HOME
- All the symlinks get created in /TESTS/DOTFILES_TESTS/TEST_HOME
