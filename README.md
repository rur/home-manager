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
   ```
   On macOS, also restart the Nix daemon:
   ```bash
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

## Machines

### Macbook Pro
The macbookpro configuration (`macbookpro.nix`) is designed for macOS systems and includes:

- **User**: ruaidhridevery with home directory at `/Users/ruaidhridevery`
- **Platform**: x86_64-darwin
- **Shell**: Zsh
- **Unstable packages**: claude-code (with symlink at `~/.local/bin/claude-code` for claudecode.nvim compatibility)
- **Code search paths**: `CODE_PATH` set to `~/code` and `~/learning`
- **Nix garbage collection**: Automated cleanup via launchd job — runs `nix-collect-garbage -d` every Sunday at 03:00

Apply with: `make macbookpro`

### Chromebook
The chromebook configuration (`chromebook.nix`) is designed for Linux systems and includes:

- **User**: ruaidhridevery with home directory at `/home/ruaidhridevery`
- **Platform**: x86_64-linux
- **Shell**: Bash
- **Unstable packages**: claude-code
- **Code search paths**: `CODE_PATH` set to `~/code`
- **Nix garbage collection**: Not configured — run `nix-collect-garbage -d` manually as needed

Apply with: `make chromebook`

### Agent Host
The agent-operator configuration (`agent-operator.nix`) is designed for a headless Linux agent environment and includes:

- **User**: operator with home directory at `/home/operator`
- **Platform**: x86_64-linux
- **Shell**: Bash
- **Unstable packages**: claude-code
- **Code search paths**: `CODE_PATH` set to `~/code`
- **Nix garbage collection**: Not configured — run `nix-collect-garbage -d` manually as needed

Apply with:
```bash
nix run . -- switch --flake '.#operator@agent-host' -b backup
```
