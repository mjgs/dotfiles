
#!/bin/sh

echo "Deleting /Applications/Google\ Chrome.app/"
rm -r /Applications/Google\ Chrome.app/

echo "Deleting ~/Library/Application\ Support/Google/Chrome/"
rm -r ~/Library/Application\ Support/Google/Chrome/

echo "Deleting ~/Library/Application\ Support/CrashReporter/Google\ Chrome*"
rm ~/Library/Application\ Support/CrashReporter/Google\ Chrome*

echo "Deleting ~/Library/Preferences/com.google.Chrome*"
rm ~/Library/Preferences/com.google.Chrome*

echo "Deleting ~/Library/Preferences/Google\ Chrome*"
rm ~/Library/Preferences/Google\ Chrome*

echo "Deleting ~/Library/Caches/com.google.Chrome*"
rm -r ~/Library/Caches/com.google.Chrome*

echo "Deleting ~/Library/Saved\ Application\ State/com.google.Chrome.savedState/"
rm -r ~/Library/Saved\ Application\ State/com.google.Chrome.savedState/

echo "Deleting ~/Library/Google/GoogleSoftwareUpdate/Actives/com.google.Chrome"
rm ~/Library/Google/GoogleSoftwareUpdate/Actives/com.google.Chrome

echo "Deleting ~/Library/Google/Google\ Chrome*"
rm ~/Library/Google/Google\ Chrome*

echo "Deleting ~/Library/Speech/Speakable\ Items/Application\ Speakable\ Items/Google\ Chrome/"
rm -r ~/Library/Speech/Speakable\ Items/Application\ Speakable\ Items/Google\ Chrome/