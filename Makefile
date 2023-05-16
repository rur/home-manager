.PHONY: chromebook chromebook-update chromebook-remove macbookpro macbookpro-update macbookpro-remove flakeupdate

help:
	>&2 echo 'You must specify an environment' && exit 1

chromebook:
	nix run . -- switch --flake '.#ruaidhridevery@chromebook' -b backup

chromebook-update: | flakeupdate chromebook

chromebook-remove:
	nix run . -- uninstall --flake '.#ruaidhridevery@chromebook'
	echo 'Home manager uninstalled, I recommend restarting your session'

macbookpro:
	nix run . -- switch --flake '.#ruaidhridevery@macbookpro' -b backup

macbookpro-update: | flakeupdate macbookpro

macbookpro-remove:
	nix run . -- uninstall --flake '.#ruaidhridevery@macbookpro'
	echo 'Home manager uninstalled, I recommend restarting your session'

flakeupdate:
	nix flake update 

