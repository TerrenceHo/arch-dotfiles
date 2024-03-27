return {
    {
        'elentok/format-on-save.nvim',
        config = function()
            local format_on_save = require("format-on-save")
            local formatters = require("format-on-save.formatters")
            format_on_save.setup({
                formatter_by_ft = {
                    c = formatters.shell({ cmd = { "clang-format" } }),
                    cmake = formatters.shell({ cmd = { "cmake-format", "-" } }),
                    cpp = formatters.shell({ cmd = { "clang-format" } }),
                    go = formatters.shell({ cmd = { "gofmt" } }),
                    lua = formatters.lsp,
                    ocaml = formatters.shell({ cmd = { "ocamlformat", "--name", "%", "-" } }),
                    proto = formatters.shell({ cmd = { "clang-format" } }),
                    python = {
                        formatters.remove_trailing_whitespace,
                        formatters.black,
                    },
                    rust = formatters.shell({ cmd = { "rustfmt" } }),
                    sh = formatters.shfmt,
                    terraform = formatters.shell({ cmd = { "terraform", "fmt", "-" } }),
                }
            })
        end
    },
}
