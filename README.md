# Arch Linux dotfiles<br />
Run as root after fresh install of Arch Linux.<br />
`git clone https://github.com/Consolider/dotfiles.git`<br />
`cd dotfiles`<br />
`chmod +x 0.install.sh`<br />
`./0.install.sh`<br />
<br />
Computer will install and reboot.<br />
After reboot login as user and run `1.post-install.sh` located in dotfiles folder:<br />
`cd dotfiles`<br />
`sudo chmod +x 1.post-install.sh`<br />
`./1.post-install.sh`<br />
<br />
Option:<br />
Run `2.options.sh` to change keyboard keymap and Polybar weather location.<br />
`cd dotfiles`<br />
`sudo chmod +x 2.options.sh`<br />
`./2.options.sh`<br />
