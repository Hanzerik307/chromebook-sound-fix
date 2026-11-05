# chromebook-sound

Fix for Acer 311 Chromebook Linux Sound Not Working

This is used for fixing the sound on a Acer/Gateway 311 Chromebook which has been flashed to CoreBoot running Linux.

The service file goes into `$HOME/.config/systemd/user/`

Enable the user service with: `systemctl --user enable fix-chromebook-sound.service`

The .sh file goes into `$HOME/.local/bin/`

Make executable: `chmod +x ~/.local/bin/fix-chromebook-sound.sh`

Reboot
