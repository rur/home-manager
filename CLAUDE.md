# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Nix Home Manager configuration repository that manages dotfiles and package installations across multiple machines (chromebook and macbookpro). The configuration uses Nix flakes for reproducible builds and includes shell environments, editor configs, and development tools.

## Architecture

The repository follows a modular architecture:

- **Machine-specific configs**: `chromebook.nix` and `macbookpro.nix` are the entry points for each machine
- **Feature modules**: Individual `.nix` files for specific tools (git.nix, vim.nix, tmux.nix, etc.)
- **Nested configurations**: The `nvim/` directory contains a separate flake for Neovim configuration
- **Supporting files**: Shell configuration files in `bash/`, `zsh/`, and `git/` directories

The flake.nix defines two home configurations:
- `ruaidhridevery@chromebook` (x86_64-linux)
- `ruaidhridevery@macbookpro` (x86_64-darwin with unstable packages)

## Common Commands

### Build and Apply Configuration
```bash
# Apply configuration for specific machine
make chromebook        # Apply chromebook config
make macbookpro        # Apply macbookpro config

# Update flake dependencies and apply
make chromebook-update  # Update deps + apply chromebook
make macbookpro-update  # Update deps + apply macbookpro

# Remove home-manager configuration
make chromebook-remove
make macbookpro-remove

# Update flake dependencies only
make flakeupdate
```

### Development Workflow
```bash
# Test configuration changes without applying
nix flake check

# Build specific configuration without applying
nix build '.#homeConfigurations."ruaidhridevery@macbookpro".activationPackage'

# Show what changes would be applied
nix run . -- switch --flake '.#ruaidhridevery@macbookpro' --dry-run
```

## Key Configuration Areas

### Neovim Configuration
The `nvim/` directory contains a separate flake-based Neovim configuration with:
- LSP setup in `nvim/lua/user/lsp/`
- Plugin configurations in `nvim/lua/user/`
- Custom keymaps and options

### Shell Environments
- **Bash**: Configured in `bash.nix` with custom `bashrc`, `profile`, and `logout`
- **Zsh**: macOS-specific shell with custom prompt and profile in `zsh/`
- Both shells set `CODE_SEARCH_LIST` environment variable for development directories

### Package Management
- Core packages defined in `packages.nix`
- Unstable packages (like claude-code) available on macbookpro via `pkgs-unstable`
- Machine-specific package lists in respective config files

## File Modification Patterns

When editing configuration:
1. **Machine configs** (`chromebook.nix`, `macbookpro.nix`): Add new module imports here
2. **Feature modules**: Create/edit individual `.nix` files for specific tools
3. **Dotfiles**: Place shell configs in appropriate subdirectories (`bash/`, `zsh/`, `git/`)
4. **Neovim**: Edit files in `nvim/lua/user/` for editor customization

After making changes, test with the appropriate `make` command before committing.