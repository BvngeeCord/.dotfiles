-- rust has a special setup with both the rust_analyzer lsp, and rust-tools.nvim
return {
    tools = {
        --[[ on_initialized = function()
            vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter', 'CursorHold', 'InsertLeave' }, {
                pattern = { '*.rs' },
                callback = function()
                    vim.lsp.codelens.refresh()
                end,
            })
        end, ]]

        inlay_hints = { -- all of this is irrelevant, as lsp-inlayhints is used instead
            auto = false,

            -- Only show inlay hints for the current line
            only_current_line = false,

            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = 'CursorHold',

            -- whether to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = false,

            -- whether to show variable name before type hints with the inlay hints or not
            -- default: false
            show_variable_name = false,

            -- prefix for parameter hints
            -- default: "<-"
            -- parameter_hints_prefix = "<- ",
            parameter_hints_prefix = ' ',

            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            -- other_hints_prefix = "=> ",
            other_hints_prefix = ' ',

            -- whether to align to the lenght of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,

            -- The color of the hints
            highlight = 'Comment',
        },
        hover_actions = {
            auto_focus = false,
            border = 'rounded',
            width = 60,
            -- height = 30,
        },
    },
    server = {
        -- cmd = { 'rustup', 'run', 'nightly', os.getenv('HOME') .. '/.local/bin/rust-analyzer' },
        on_attach = require('user.plugconf.lsp.utils').common_on_attach,
        capabilities = require('user.plugconf.lsp.utils').capabilities,

        settings = {
            ['rust-analyzer'] = {
                --rust-analyzer settings, in addition to the default added rust-tools
                
                lens = {
                    enable = true,
                },
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    },
}
