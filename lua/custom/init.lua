-- This is where you custom modules and plugins goes.
-- See the wiki for a guide on how to extend NvChad

local hooks = require "core.hooks"

-- NOTE: To use this, make a copy with `cp example_init.lua init.lua`

--------------------------------------------------------------------

-- To modify packaged plugin configs, use the overrides functionality
-- if the override does not exist in the plugin config, make or request a PR,
-- or you can override the whole plugin config with 'chadrc' -> M.plugins.default_plugin_config_replace{}
-- this will run your config instead of the NvChad config for the given plugin

-- hooks.override("lsp", "publish_diagnostics", function(current)
--   current.virtual_text = false;
--   return current;
-- end)

-- To add new mappings, use the "setup_mappings" hook,
-- you can set one or many mappings
-- example below:

hooks.add("setup_mappings", function(map)
   map("n", "<left>", "0")
   map("n", "<right>", "$")
   map("n", "<up>", "kkkkkkk")
   map("n", "<down>", "jjjjjjj")
   map("v", "<up>", "kkkkkkk")
   map("v", "<down>", "jjjjjjj")
   map("n", "<leader>nh", "<esc>: ")
   map("n", "<leader>nn", "<esc>/")
   map("n", "<leader>w", ":w!<cr>")
   map("n", "<leader><leader>w", ":wq!<cr>")
   map("n", "<leader>q", ":q<cr>")
   map("n", "<leader><leader>q", ":qa!<cr>")
   -- map('n', '<leader><leader>e', ':q!<cr>')

   map("n", "<leader>j", ":BufferLineCyclePrev<CR>")
   map("n", "<leader>k", ":BufferLineCycleNext<CR>")
   map("n", "<leader>h", "<C-w>h<CR>0")
   -- map('n', '<leader>hh', '<C-w>h<CR>0')
   map("n", "<leader>l", "<C-w>l<CR>0")
   -- map('n', '<leader>t', ':BufferPick<CR>')
   map("n", "tt", ":BufferLinePick<CR>")
   map("n", "<leader>e", ":lua require('core/utils').close_buffer() <CR>")
   map("n", "<leader><leader>e", ":bdelete!<CR>")
   map("n", "<leader>gd", ":Gdiffsplit")
   map("n", "<leader>gw", ":Gw<cr>")
   map("n", "<leader>gg", ":Gw<cr><esc>:sleep 100m<cr><esc>:Git commit<cr>")
   map("n", "<leader>gc", ":Git commit<cr>")
   map("n", "<leader>gs", ":! git status<cr>")
   map("n", "<leader>gd", ":Gdiffsplit<cr>")
   map("n", "<leader>gb", ":Git blame<cr>")
   map("n", "<leader>fg", ":Telescope live_grep<cr>")
   map("n", "<leader>fc", ":Telescope commands<CR>")
   map("n", "<leader>fh", ":Telescope command_history<CR>")
   --    map("n", "<leader>cc", "gg0vG$d", opt) -- example to delete the buffer
   --    .... many more mappings ....
end)

-- To add new plugins, use the "install_plugin" hook,
-- NOTE: we heavily suggest using Packer's lazy loading (with the 'event' field)
-- see: https://github.com/wbthomason/packer.nvim
-- examples below:

hooks.add("install_plugins", function(use)
   -- use {
   --    "max397574/better-escape.nvim",
   --    event = "InsertEnter",
   -- }
   use {
      "python/black",
   }
   use {
      "tpope/vim-fugitive",
      cmd = {
         "Git",
         "Gdiff",
         "Gdiffsplit",
         "Gvdiffsplit",
         "Gwrite",
         "Gw",
      },
   }
   use {
      "vim-scripts/SQLUtilities",
      "vim-scripts/Align",
   }
   -- use {
   --   "williamboman/nvim-lsp-installer",
   -- }
   use {
      "williamboman/nvim-lsp-installer",
      config = function()
         local lsp_installer = require "nvim-lsp-installer"

         lsp_installer.on_server_ready(function(server)
            local opts = {}

            server:setup(opts)
            vim.cmd [[ do User LspAttachBuffers ]]
         end)
      end,
   }
   -- use {
   --   "averms/black-nvim"
   -- }

   -- use {
   --     "rhysd/clever-f.vim"
   -- }
   --
   use {
      "Pocco81/TrueZen.nvim",
   }

   use {
      "nvie/vim-flake8",
   }
   use {
      "brentyi/isort.vim",
   }
   -- use {
   --   'kabouzeid/nvim-lspinstall'
   -- }
end)

-- vim.o.guifont = "Azeret Mono,Noto Color Emoji:h16"
vim.o.guifont = "Azeret Mono,Hack Nerd Font Mono,Noto Color Emoji,NotoEmoji Nerd Font:h16"

vim.g["isort_vim_options"] = "--profile=black --multi-line=3"
vim.cmd "autocmd BufWritePre *py execute ':Black'"
vim.cmd "autocmd BufWritePre *py execute ':Isort'"

vim.cmd "autocmd BufWritePost *.py call flake8#Flake8()"

-- alternatively, put this in a sub-folder like "lua/custom/plugins/mkdir"
-- then source it with

-- require "custom.plugins.mkdir"
