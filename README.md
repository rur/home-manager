# Home Manager Config

Home enviornment setup, powered by [Nix](https://nixos.org/nix/) and [home-manager](https://github.com/rycee/home-manager).

## How to use

1. Install Nix:
   ```bash
   $ sh <(curl -L https://nixos.org/nix/install)
   ```
1. Enable [Nix Flakes](https://www.tweag.io/blog/2020-05-25-flakes):
   ```bash
   $ mkdir -p ~/.config/nix

   $ cat <<EOF >> ~/.config/nix/nix.conf
   experimental-features = nix-command flakes
   EOF

   $ sudo launchctl kickstart -k system/org.nixos.nix-daemon
   ```
1. Install Make in your nix profile:
   ```bash
   $ nix-env -iA nixpkgs.gnumake
   ```
1. Clone this repo:
   ```bash
   $ git clone https://github.com/rur/home-manager.git && cd home-manager
   ```
1. Run the flake and activate your env (`chromebook` used for example, choose appropriate env):
   ```bash
   $ make chromebook
   ```
1. Then you can update it with (`chromebook` used for example, choose appropriate env):
   ```bash
   $ make chromebook-update
   ```

## How to uninstall

Home manager has the ability to (mostly) cleanly remove itself from your system.
There are two caviats that I have noticed:

1. Files backed-up during the initial setup will not be re-instated. You will have to do that manually
1. The current session is dirty, restart your login session

```bash
   $ make uninstall
```

