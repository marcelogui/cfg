-- ~/.config/nvim/lua/plugins/searchcount.lua

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local search_result = function()
        local ok, search = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 500 })
        if not ok or search.total == 0 then
          return ""
        end
        return string.format("[%d/%d]", search.current, search.total)
      end

      -- Add search count to lualine_x (you can change the section if needed)
      table.insert(opts.sections.lualine_x, search_result)
    end,
  },

}
