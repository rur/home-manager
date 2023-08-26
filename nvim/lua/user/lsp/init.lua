local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  vim.notify("lua/user/lsp/init.lua failed to require 'lspconfig'")
  return
end
local util = require "lspconfig/util"
local handlers = require "user.lsp.handlers"

-- 
-- Language server settings
--

lspconfig.lua_ls.setup({
	on_attach = function(client, bufnr)
   -- apply standard bindings 
   handlers.on_attach(client, bufnr)
  end,
	capabilities = handlers.capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$vimruntime/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

lspconfig.gopls.setup {
  on_attach = handlers.on_attach,
  capabilities = handlers.capabilities,
  cmd = {"gopls", "serve"},
  filetypes = {"go", "gomod"},
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

lspconfig.pylsp.setup({
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
    settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391'},
          maxLineLength = 100
        },
        rope_completion = {
          enabled = true
        }
      }
    }
  },
})

lspconfig.tsserver.setup({})

handlers.setup()
