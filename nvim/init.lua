-- TODO:
-- - autocompletion without C-x C-o
-- - go LSP server
-- - investigate which python lsp server
-- - buffer number:name on status bar
-- - fix fzf? depends on preference
-- - figure out how to modularize my configs
-- - push to github

-- setup lazy plugin manager
local lazy = {}
function lazy.install(path)
    if not vim.loop.fs_stat(path) then
        print('Installing lazy.nvim....')
        vim.fn.system({
            'git',
            'clone',
            '--filter=blob:none',
            'https://github.com/folke/lazy.nvim.git',
            '--branch=stable', -- latest stable release
            path,
        })
    end
end

function lazy.setup(plugins)
    if vim.g.plugins_ready then
        return
    end

    -- You can "comment out" the line below after lazy.nvim is installed
    lazy.install(lazy.path)

    vim.opt.rtp:prepend(lazy.path)

    require('lazy').setup(plugins, lazy.opts)
    vim.g.plugins_ready = true
end

-- plugin installs
lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {} -- set configurations here later
lazy.setup({
    -- { 'folke/tokyonight.nvim' },
    { 'nvim-lualine/lualine.nvim' },
    -- {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},

    {
        'monsonjeremy/onedark.nvim', branch = 'treesitter',
    },
    {
        'ibhagwan/fzf-lua',
    },
    {
        'christoomey/vim-tmux-navigator',
        event = "VimEnter"
    },
    {
        'neovim/nvim-lspconfig',
    },
    {

        'elentok/format-on-save.nvim',
    },
    {
        "numToStr/Comment.nvim",
        lazy = false,
    },
})


-- UI and colorscheme
require("onedark").setup()
vim.opt.termguicolors = true
-- vim.cmd.colorscheme('')
require('lualine').setup({
    options = {
        -- theme = "onedark",
        icons_enabled = false,
        section_separators = '',
        component_separators = '',
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            {
                "buffers",
                mode = 4, --[[ buffer name + buffer index ]]
                buffers_color = {
                    inactive = "lualine_c_inactive", -- Color for active buffer.
                    active = "lualine_a_inactive",   -- Color for inactive buffer.
                },
            }
        },
        lualine_c = {},
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
    },
})

-- default ui options
vim.opt.lazyredraw = true
vim.opt.hidden = true

-- number bar
vim.opt.relativenumber = true
vim.opt.number = true

-- show the command with 2 bars, match possible commands
vim.opt.showcmd = true
vim.opt.cmdheight = 2
vim.opt.showmatch = true
vim.opt.wildmenu = true

-- tabbing
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
-- vim.opt.textwidth = 80

-- correct splits behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

-- split navigation shortcuts
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')
vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')

-- commentary
require("Comment").setup()

-- misc settings
vim.opt.mouse = ""                -- disable mouse
vim.opt.clipboard = "unnamedplus" -- copying into the system clipboard

-- set leader key
vim.g.mapleader = ';'

-- general keybindings
vim.keymap.set('n', '<leader>d', ':bd')         -- delete the current buffer
vim.keymap.set('n', '<leader>l', ':nohlsearch<CR>') -- get rid of the highlights

-- fzf search utilities
local actions = require("fzf-lua").actions
require('fzf-lua').setup({
    winopts = {
    },
    actions = {
        files = {
            ["default"] = actions.file_edit_or_qf,
            ["ctrl-x"]  = actions.file_split,
            ["ctrl-v"]  = actions.file_vsplit,
            ["ctrl-t"]  = actions.file_tabedit,
            ["alt-q"]   = actions.file_sel_to_qf,
            ["alt-l"]   = actions.file_sel_to_ll,
        },
    },
})
vim.keymap.set('n', '<leader>f', "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
vim.keymap.set('n', '<leader>b', "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })

-- TODO: make this more lua friendly in the future!
-- ensure nvim opens at the same location for a file
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = { "*" },
    callback = function()
        if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.api.nvim_exec("normal! g'\"", false)
        end
    end
})

------ LSP Settings
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.lua_ls.setup {}

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

-- Format on Save
local format_on_save = require("format-on-save")
local formatters = require("format-on-save.formatters")
format_on_save.setup({
    formatter_by_ft = {
        c = formatters.shell({ cmd = { "clang-format" } }),
        cpp = formatters.shell({ cmd = { "clang-format" } }),
        go = formatters.shell({ cmd = { "gofmt" } }),
        lua = formatters.lsp,
        ocaml = formatters.shell({ cmd = { "ocamlformat" } }),
        proto = formatters.shell({ cmd = { "clang-format" } }),
        python = {
            formatters.remove_trailing_whitespace,
            formatters.black,
        },
        rust = formatters.shell({ cmd = { "rustfmt" } }),
        sh = formatters.shfmt,
    }
})
