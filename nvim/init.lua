local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[
  augroup packer_user_config
    autocmd!  
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]]

vim.cmd [[
  autocmd BufEnter * silent! lcd %:p:h
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Plugin configuration
packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'morhetz/gruvbox'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-tree/nvim-tree.lua'
    use 'lewis6991/gitsigns.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'preservim/nerdtree'
    use 'christoomey/vim-tmux-navigator'
    use 'tpope/vim-fugitive'


    vim.g.gruvbox_contrast_dark = 'hard'
    vim.o.background = "dark"
    vim.cmd('colorscheme gruvbox')
    

    
    -- Treesitter configuration
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {"javascript", "python", "lua"},
        highlight = {
            enable = true,
        },
    }
    
    -- LSP settings
    require'lspconfig'.tsserver.setup{}

    -- Telescope keybindings
    vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>Telescope find_files<cr>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>Telescope live_grep<cr>', {noremap = true, silent = true})

    -- Autocompletion setup
    local cmp = require'cmp'
    cmp.setup({
        snippet = {
            expand = function(args)
                require'luasnip'.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-1),
            ['<C-f>'] = cmp.mapping.scroll_docs(1),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
        }, {
            { name = 'buffer' },
        })
    })
end)

-- General settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.mouse = "a"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.guifont = "JetBrains Mono:h11"

-- Leader key mapping
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fr', ':Telescope oldfiles<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>nt', ':NERDTreeToggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>nf', ':NERDTreeFind<CR>', {noremap = true, silent = true})

