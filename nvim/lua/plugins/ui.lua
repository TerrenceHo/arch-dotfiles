return {
    {
        'monsonjeremy/onedark.nvim',
        branch = 'treesitter',
        config = function()
            require("onedark").setup()
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require("lualine").setup({
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
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                autoinstall = true,
                sync_install = false,
                ensure_installed = {
                    "c",
                    "comment",
                    "cpp",
                    "css",
                    "diff",
                    "dockerfile",
                    "gitcommit",
                    "git_config",
                    "gitignore",
                    "go",
                    "gomod",
                    "gosum",
                    "haskell",
                    "hcl",
                    "html",
                    "javascript",
                    "lua",
                    "make",
                    "ocaml",
                    "ocaml_interface",
                    "ocamllex",
                    "proto",
                    "python",
                    "requirements",
                    "rust",
                    "starlark",
                    "terraform",
                    "tsx",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "yaml",
                },
                highlight = { enable = true },
                indent = { enable = true },
                autotag = { enable = true },
            })
        end
    },
}
