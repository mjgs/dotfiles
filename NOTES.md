# Notes

## Making it easier to test on an existing system

The install script works for installing, I've installed my latest system using it, but once you have a system up and running it's more tricky to test the script because everything is already installed. Of course you can just run the script again and since it's written to be idempodent it should just skip all the things that are already installed, but there is the possibility that some bug in the script has been introduced and is just not showing up because it's being skipped. So it would be cool to be able to install to a temp location for testing purposes.

Here is the progress on this so far, in order to run the install to a temp location:

- Set environment variables BACKUP_DIR=/tmp/TEST_BACKUP
- Run ./bin/install/backup-laptop.sh
- Set environment variables HOME=/tmp/TEST_HOME CODES_DIR=/tmp/TEST_CODES
- unset NVM_DIR
- Run dotfiles/install.sh

What happens:

- Homebrew will still install to regular location, so these will all be skipped (Homebrew tends to work fine so not an issue)
- Nvm gets installed to /tmp/TEST_HOME
- All the symlinks get created in /tmp/TEST_HOME
- So far so good, but...

-> Currently these test installs fail with an nvm error: nvm is not compatible with the npm config "prefix" option
