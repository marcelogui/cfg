-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Opens Git Diff View", remap = true })
map("n", "<leader>gD", "<cmd>DiffviewClose<cr>", { desc = "Closes Git Diff View", remap = true })
