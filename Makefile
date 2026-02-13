vim:
	install-scripts/vim-plugins.sh

debian-packages:
	install-scripts/debian-packages.sh

links:
	install-scripts/symbolic-links.sh


all: debian-packages vim links

av-apply:
	sudo av apply --inventory ./aviary-inventory
