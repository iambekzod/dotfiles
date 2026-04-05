require("options")
require("keymaps")

if vim.g.vscode then
  -- VSCode Neovim specific config
else
  -- Bootstrap lazy.nvim
  local lazypath = vim.fn.stdpath("data") .. "/site/pack/packer/start/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup("plugins", {
    change_detection = {
      notify = false,
    },
  })
end
