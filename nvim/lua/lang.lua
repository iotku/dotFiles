M = {} -- Return table
-- jdtls setup --> see autocmds.lua
-- Here we get the jdtls bin throguh Mason (jdtls)
-- -- this may conflict eventually but I never got it working anyways...
-- config from https://www.reddit.com/r/neovim/comments/12gaetp/how_to_use_nvimjdtls_for_java_and_nvimlspconfig/
-- For non-Mason config, see: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
M.java_config = {
  cmd = {vim.fn.stdpath("data") .. "/mason/bin/jdtls"},
  on_attach = require('keybindings').on_attach,

  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  settings = {
  },
}
return M
