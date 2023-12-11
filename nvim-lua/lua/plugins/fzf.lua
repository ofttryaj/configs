local m = { noremap = true }

return {
  "ibhagwan/fzf-lua",
  keys = { "mf" },
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require('fzf-lua')
    vim.keymap.set('n', '<C-p>', "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
    vim.keymap.set('n', '<c-f>', function()
        fzf.grep({ search = "", fzf_opts = { ['--layout'] = 'default' } })
    end, m)
    vim.keymap.set('x', '<c-f>', function()
        fzf.grep_visual({ fzf_opts = { ['--layout'] = 'default' } })
    end, m)
    fzf.setup()
  end
}