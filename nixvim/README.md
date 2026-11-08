# NixVim Configuration

This directory contains a modular NixVim configuration organized into logical components.

## Directory Structure

```
nixvim/
├── core/              # Core Neovim settings
│   ├── options.nix    # Global vim options (tabs, UI, etc.)
│   └── keymaps.nix    # All keybindings
├── plugins/           # Plugin configurations
│   ├── lsp.nix        # LSP servers and configuration
│   ├── completion.nix # nvim-cmp and luasnip
│   ├── treesitter.nix # Syntax highlighting
│   ├── telescope.nix  # Fuzzy finder
│   ├── git.nix        # Git integration (fugitive, gitsigns)
│   ├── editing.nix    # Editing enhancements (comment, autopairs, zen-mode)
│   ├── claude-code.nix        # Claude Code integration
│   ├── language-specific.nix  # Language-specific plugins (Go, Nix)
│   └── utilities.nix          # Utility plugins (tabular, snacks)
└── ui/                # UI components
    ├── colorscheme.nix    # Color scheme (Nord)
    ├── nvim-tree.nix      # File explorer
    ├── bufferline.nix     # Buffer/tab line
    └── statusline.nix     # Status line (lualine)
```

## Design Principles

### Portability First
- **No Icon Fonts Required**: All UI elements use ASCII-compatible characters
- **nvim-tree**: File icons disabled, using simple text glyphs (▹, ▾, etc.)
- **bufferline**: Simple characters (×, ●, ▎) instead of Nerd Font icons
- **statusline**: Pipe separators (|) instead of fancy glyphs

### Modular Organization
- Each module is self-contained and focuses on a specific area
- Easy to find and modify configurations
- Clear separation of concerns

## Key Features

### File Explorer (nvim-tree)
- Located in: `ui/nvim-tree.nix`
- Portable glyphs matching legacy `nvim/lua/user/nvimtree.lua`
- File icons explicitly disabled
- Git status indicators using simple text

### Buffer Line
- Located in: `ui/bufferline.nix`
- Portable characters matching legacy `nvim/lua/user/bufferline.lua`
- Simple indicators: × (close), ● (modified), ▎ (indicator)

### Claude Code Integration
- Located in: `plugins/claude-code.nix`
- Migrated from legacy vim.nix wrapped plugin
- Uses snacks.nvim for terminal integration
- Keymaps under `<leader>a` prefix

### LSP Configuration
- Located in: `plugins/lsp.nix`
- Servers: lua_ls, gopls, pylsp, nixd
- Standard keymaps: gd (definition), K (hover), etc.

## Making Changes

### Adding a New Plugin
1. Determine the appropriate category (plugins/, ui/, core/)
2. Add to existing module or create a new one if it's substantial
3. Update `../nixvim.nix` imports if you create a new module

### Modifying Keymaps
- Edit `core/keymaps.nix` for general keymaps
- Plugin-specific keymaps are in their respective plugin modules

### Changing UI Elements
- All UI configurations are in `ui/` directory
- Remember to use portable glyphs (no icon fonts)

### Language Server Configuration
- Edit `plugins/lsp.nix` to add or configure language servers
- Language-specific plugins (like vim-go) go in `plugins/language-specific.nix`

## Testing Changes

After making changes:
```bash
# Test the configuration
nix flake check

# Apply for chromebook
make chromebook

# Apply for macbookpro
make macbookpro
```

## Portable Glyph Reference

These glyphs are safe to use without icon fonts:
- Arrows: ▹ ▾ ➚
- Symbols: × ● ∅ | ~ + -
- Math: ‾ _
- Text: "u", "s", "m", "del", etc.

Avoid emoji and Nerd Font icons (like  ) as they require special fonts.
