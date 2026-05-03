# LSP configuration and language servers
{
  programs.nixvim.plugins.lsp = {
    enable = true;

    servers = {
      # Lua
      lua_ls = {
        enable = true;
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT";
            };
            diagnostics = {
              globals = [ "vim" ];
            };
            workspace = {
              library = [
                "\${3rd}/luv/library"
                "~/.config/nvim"
              ];
              checkThirdParty = false;
            };
            telemetry = {
              enable = false;
            };
          };
        };
      };

      # Go
      gopls = {
        enable = true;
        extraOptions = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true;
              };
              staticcheck = true;
            };
          };
        };
      };

      # Python
      pylsp = {
        enable = true;
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = {
                ignore = [ "W391" ];
                maxLineLength = 100;
              };
              rope_completion = {
                enabled = true;
              };
            };
          };
        };
      };

      # Nix
      nixd = {
        enable = true;
      };
    };

    keymaps = {
      diagnostic = {
        "[d" = "goto_prev";
        "]d" = "goto_next";
      };
      lspBuf = {
        "gd" = "definition";
        "gD" = "declaration";
        "gr" = "references";
        "gI" = "implementation";
        "K" = "hover";
        "<leader>ca" = "code_action";
        "<leader>rn" = "rename";
        "<leader>f" = "format";
      };
    };
  };
}
