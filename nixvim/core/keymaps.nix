# Core keymaps and key bindings
{
  programs.nixvim.keymaps = [
    # Leader key setup
    { mode = ""; key = "<Space>"; action = "<Nop>"; options = { noremap = true; silent = true; }; }

    # Window navigation
    { mode = "n"; key = "<C-h>"; action = "<C-w>h"; options = { noremap = true; silent = true; desc = "Move to left window"; }; }
    { mode = "n"; key = "<C-j>"; action = "<C-w>j"; options = { noremap = true; silent = true; desc = "Move to below window"; }; }
    { mode = "n"; key = "<C-k>"; action = "<C-w>k"; options = { noremap = true; silent = true; desc = "Move to above window"; }; }
    { mode = "n"; key = "<C-l>"; action = "<C-w>l"; options = { noremap = true; silent = true; desc = "Move to right window"; }; }

    # Buffer management
    { mode = "n"; key = "<leader>w"; action = ":bp|bd #<CR>"; options = { noremap = true; silent = true; desc = "Delete current buffer"; }; }
    { mode = "n"; key = "<S-h>"; action = ":bprevious<CR>"; options = { noremap = true; silent = true; desc = "Previous buffer"; }; }
    { mode = "n"; key = "<S-l>"; action = ":bnext<CR>"; options = { noremap = true; silent = true; desc = "Next buffer"; }; }

    # File tree
    { mode = "n"; key = "<leader>e"; action = ":NvimTreeToggle<CR>"; options = { noremap = true; silent = true; desc = "Toggle file tree"; }; }

    # Clear search highlight
    { mode = "n"; key = "<CR>"; action = ":nohlsearch<CR>"; options = { noremap = true; silent = true; desc = "Clear search highlight"; }; }

    # Window resizing
    { mode = "n"; key = "<C-Up>"; action = ":resize +2<CR>"; options = { noremap = true; silent = true; desc = "Increase window height"; }; }
    { mode = "n"; key = "<C-Down>"; action = ":resize -2<CR>"; options = { noremap = true; silent = true; desc = "Decrease window height"; }; }
    { mode = "n"; key = "<C-Left>"; action = ":vertical resize +2<CR>"; options = { noremap = true; silent = true; desc = "Decrease window width"; }; }
    { mode = "n"; key = "<C-Right>"; action = ":vertical resize -2<CR>"; options = { noremap = true; silent = true; desc = "Increase window width"; }; }

    # Visual mode - Stay in indent mode
    { mode = "v"; key = "<"; action = "<gv"; options = { noremap = true; silent = true; desc = "Indent left"; }; }
    { mode = "v"; key = ">"; action = ">gv"; options = { noremap = true; silent = true; desc = "Indent right"; }; }

    # Visual mode - Move text
    { mode = "v"; key = "<A-j>"; action = ":m .+1<CR>=="; options = { noremap = true; silent = true; desc = "Move line down"; }; }
    { mode = "v"; key = "<A-k>"; action = ":m .-2<CR>=="; options = { noremap = true; silent = true; desc = "Move line up"; }; }
    { mode = "v"; key = "p"; action = ''"_dP''; options = { noremap = true; silent = true; desc = "Paste without yank"; }; }

    # Visual Block mode - Move text
    { mode = "x"; key = "J"; action = ":move '>+1<CR>gv-gv"; options = { noremap = true; silent = true; desc = "Move block down"; }; }
    { mode = "x"; key = "K"; action = ":move '<-2<CR>gv-gv"; options = { noremap = true; silent = true; desc = "Move block up"; }; }
    { mode = "x"; key = "<A-j>"; action = ":move '>+1<CR>gv-gv"; options = { noremap = true; silent = true; desc = "Move block down"; }; }
    { mode = "x"; key = "<A-k>"; action = ":move '<-2<CR>gv-gv"; options = { noremap = true; silent = true; desc = "Move block up"; }; }

    # Terminal mode navigation
    { mode = "t"; key = "<C-h>"; action = "<C-\\><C-N><C-w>h"; options = { silent = true; desc = "Terminal left window"; }; }
    { mode = "t"; key = "<C-j>"; action = "<C-\\><C-N><C-w>j"; options = { silent = true; desc = "Terminal below window"; }; }
    { mode = "t"; key = "<C-k>"; action = "<C-\\><C-N><C-w>k"; options = { silent = true; desc = "Terminal above window"; }; }
    { mode = "t"; key = "<C-l>"; action = "<C-\\><C-N><C-w>l"; options = { silent = true; desc = "Terminal right window"; }; }

    # Telescope
    { mode = "n"; key = "<C-p>"; action = "<cmd>Telescope find_files<CR>"; options = { noremap = true; silent = true; desc = "Find files"; }; }
    { mode = "n"; key = "<leader>p"; action = "<cmd>Telescope commands<CR>"; options = { noremap = true; silent = true; desc = "Commands"; }; }
    { mode = "n"; key = "<leader>P"; action = "<cmd>Telescope live_grep<CR>"; options = { noremap = true; silent = true; desc = "Live grep"; }; }

    # Location list
    { mode = "n"; key = "<leader>lc"; action = ":lclose<CR>"; options = { noremap = true; silent = true; desc = "Close location list"; }; }
    { mode = "n"; key = "<leader>ll"; action = ":lopen<CR>"; options = { noremap = true; silent = true; desc = "Open location list"; }; }

    # Quickfix list
    { mode = "n"; key = "<leader>qc"; action = ":cclose<CR>"; options = { noremap = true; silent = true; desc = "Close quickfix"; }; }
    { mode = "n"; key = "<leader>qq"; action = ":copen<CR>"; options = { noremap = true; silent = true; desc = "Open quickfix"; }; }

    # Git (vim-fugitive)
    { mode = "n"; key = "G"; action = ":Git<CR>"; options = { noremap = true; silent = true; desc = "Git status"; }; }
  ];
}
