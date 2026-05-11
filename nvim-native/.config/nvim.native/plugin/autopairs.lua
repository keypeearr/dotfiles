vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    vim.pack.add({ gh("windwp/nvim-autopairs") })
    require("nvim-autopairs").setup({})
  end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    vim.pack.add({ gh("windwp/nvim-ts-autotag") })
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
      },
      per_filetype = {
        ["templ"] = {
          enable_close = true,
        },
      },
    })
  end,
})
