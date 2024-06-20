-- Ref: https://m4xshen.dev/posts/build-your-modern-neovim-config-in-lua/
require('config.settings').setup()
require('config.keybindings').setup()
require('config.utils').setup()
require('config.lazy')
