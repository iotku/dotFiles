M = {} -- Return table
-- Rust Tools for enhanced Rust LSP
require('rust-tools').setup({})
-- Go additional functionality 
require('go').setup{}

-- jdtls setup --> see autocmds.lua
M.java_config = {
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    'java', 
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', os.getenv("HOME")..'/.local/share/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', os.getenv("HOME")..'/.local/share/jdtls/config_linux', -- NOTE: config_linux directory must be writable!!!
    '-data', os.getenv("HOME")..'/workspace'
  }, -- ~/.local/share/jdtls
  on_attach = require('keybindings').on_attach,

  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  settings = {
    java = {
    }
  },
}
return M
