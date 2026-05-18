# Git integration plugins
{
  programs.nixvim.plugins = {
    # Git integration
    fugitive.enable = true;

    gitsigns = {
      enable = true;

      settings = {
        signs = {
          add = { text = "+"; };
          change = { text = "~"; };
          delete = { text = "_"; };
          topdelete = { text = "‾"; };
          changedelete = { text = "~"; };
        };

        on_attach = ''
          function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']g', function()
              if vim.wo.diff then return ']g' end
              vim.schedule(function() gs.next_hunk() end)
              return '<Ignore>'
            end, {expr=true, desc = "Next git hunk"})

            map('n', '[g', function()
              if vim.wo.diff then return '[g' end
              vim.schedule(function() gs.prev_hunk() end)
              return '<Ignore>'
            end, {expr=true, desc = "Previous git hunk"})
          end
        '';
      };
    };
  };
}
