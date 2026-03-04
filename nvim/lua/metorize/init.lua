require("metorize.remap")
require("metorize.set")
-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git","clone","--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git","--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- loading specifications lua/metorize/plugins/*
require("lazy").setup("metorize.plugins", { ui = { border = "rounded" } })

