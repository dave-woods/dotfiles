# dotfiles

The directory `.dwpc_installs` contains listings for installations on dwpc:
* the file `aptitude_listing` is the output of the command `aptitude search '~i!~M` and should contain expressly  installed packages, as well as a brief description of what they are
* the file `apt_listing` is the output of the command `apt list --installed` which includes installed dependencies
* the file `local_share_fonts_listing` is the output of the command `ls -al .local/share/fonts` and should give the fonts that have been explicitly installed
