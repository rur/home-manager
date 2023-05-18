# Home Manager Config

Home environment setup, powered by [Nix](https://nixos.org/nix/) and [home-manager](https://github.com/rycee/home-manager).

## Setup

1. Install Nix:
   ```bash
   $ sh <(curl -L https://nixos.org/nix/install) --daemon
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
1. Run the flake and activate your env
   ```bash
   $ make <machine>
   ```
1. Then you can update dependencies:
   ```bash
   $ make <machine>-update
   ```
1. You can also remove the config (revert dotfiles manually):
   ```bash
   $ make <machine>-remove
   ```

