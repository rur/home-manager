local handlers = require "user.lsp.handlers"

--
-- Language server settings
--

-- Configure lua_ls
vim.lsp.config['lua_ls'] = {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_dir = function(fname)
    return vim.fs.root(fname, {'.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git'})
  end,
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
}

-- Configure gopls
vim.lsp.config['gopls'] = {
  cmd = {"gopls", "serve"},
  filetypes = {"go", "gomod"},
  root_dir = function(fname)
    return vim.fs.root(fname, {"go.work", "go.mod", ".git"})
  end,
  on_attach = handlers.on_attach,
  capabilities = handlers.capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

-- Configure pylsp
vim.lsp.config['pylsp'] = {
  cmd = { 'pylsp' },
  filetypes = { 'python' },
  root_dir = function(fname)
    return vim.fs.root(fname, {'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git'})
  end,
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
}

-- Enable the language servers
vim.lsp.enable('lua_ls')
vim.lsp.enable('gopls')
vim.lsp.enable('pylsp')

handlers.setup()
