# Completion and snippets configuration
{ pkgs, ... }:
{
  programs.nixvim.plugins = {
    # Completion
    cmp = {
      enable = true;
      autoEnableSources = true;

      settings = {
        snippet.expand = ''
          function(args)
            require('luasnip').lsp_expand(args.body)
          end
        '';

        mapping = {
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif require("luasnip").expand_or_jumpable() then
                require("luasnip").expand_or_jump()
              else
                fallback()
              end
            end, { "i", "s" })
          '';
          "<S-Tab>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif require("luasnip").jumpable(-1) then
                require("luasnip").jump(-1)
              else
                fallback()
              end
            end, { "i", "s" })
          '';
        };

        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
      };
    };

    # Snippets
    luasnip = {
      enable = true;
      fromVscode = [
        { paths = "${pkgs.vimPlugins.friendly-snippets}"; }
      ];
    };
  };

  programs.nixvim.extraConfigLua = ''
    -- Completion toggle function
    function ToggleCompletion()
      local cmp = require('cmp')
      if cmp.get_config().enabled then
        cmp.setup({ enabled = false })
        vim.notify("Completion disabled", vim.log.levels.INFO)
      else
        cmp.setup({ enabled = true })
        vim.notify("Completion enabled", vim.log.levels.INFO)
      end
    end

    vim.keymap.set("n", "<leader>tc", ":lua ToggleCompletion()<cr>", { noremap = true, silent = true, desc = "Toggle completion" })
  '';
}
