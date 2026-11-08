# Claude Code integration plugin
{ pkgs, ... }:
{
  programs.nixvim = {
    # Add the claudecode.nvim plugin from nixpkgs
    extraPlugins = with pkgs.vimPlugins; [
      claudecode-nvim
    ];

    # Claude Code setup and keymaps
    extraConfigLua = ''
      -- Claude Code setup
      local status_ok, claudecode = pcall(require, "claudecode")
      if status_ok then
        claudecode.setup({
          terminal = {
            provider = "snacks",
            split_side = "right",
            split_width_percentage = 0.35,
            auto_close = false
          }
        })
      else
        vim.notify("Failed to load claudecode plugin", vim.log.levels.WARN)
      end

      -- Claude Code keymaps
      vim.keymap.set("n", "<leader>a", "<Nop>", { noremap = true, silent = true, desc = "AI/Claude Code" })
      vim.keymap.set("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { noremap = true, silent = true, desc = "Toggle Claude" })
      vim.keymap.set("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { noremap = true, silent = true, desc = "Focus Claude" })
      vim.keymap.set("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { noremap = true, silent = true, desc = "Resume Claude" })
      vim.keymap.set("n", "<leader>aC", "<cmd>ClaudeCode --continue<cr>", { noremap = true, silent = true, desc = "Continue Claude" })
      vim.keymap.set("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { noremap = true, silent = true, desc = "Add current buffer" })
      vim.keymap.set("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { noremap = true, silent = true, desc = "Send to Claude" })
      vim.keymap.set("n", "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", { noremap = true, silent = true, desc = "Add file" })
      vim.keymap.set("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { noremap = true, silent = true, desc = "Accept diff" })
      vim.keymap.set("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", { noremap = true, silent = true, desc = "Deny diff" })
    '';
  };
}
