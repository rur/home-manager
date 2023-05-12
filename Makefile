.PHONY: chromebook chromebook-update flakeupdate uninstall

help:
	>&2 echo 'You must specify an environment' && exit 1

chromebook:
	nix run . -- switch --flake '.#ruaidhridevery@chromebook' -b backup

chromebook-update: | flakeupdate chromebook

chromebook-remove:
	nix run . -- uninstall --flake '.#ruaidhridevery@chromebook'
	echo 'Home manager uninstalled, I recommend restarting your session'

flakeupdate:
	nix flake update 

