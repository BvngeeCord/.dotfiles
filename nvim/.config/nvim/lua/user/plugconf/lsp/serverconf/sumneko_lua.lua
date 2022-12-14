return {
  settings = {
    Lua = {
      type = {
        -- weakUnionCheck = true,
        -- weakNilCheck = true,
        -- castNumberToInteger = true,
      },
      format = {
        enable = false,
      },
      hint = {
        enable = true,
        arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
        await = true,
        paramName = "Disable", -- "All", "Literal", "Disable"
        paramType = false,
        semicolon = "Disable", -- "All", "SameLine", "Disable"
        setType = true,
      },
      runtime = {
        version = "LuaJIT",
        special = {
          reload = "require",
        },
      },
      diagnostics = {
        globals = { "vim" }, --lua-dev handles this (in some locations??)
        disable = { "trailing-space", "unused-local", "unused-function", "unused-vararg", }
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true, --necessary
          [vim.fn.stdpath "config" .. "/lua"] = true,
          -- [vim.fn.datapath "config" .. "/lua"] = true, --seems to cause problems? be careful
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
