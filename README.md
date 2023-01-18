# Maker
Provides two functions : `cmd` and `feed_diagnostics`. Running `cmd('my_command)` creates an output buffer, registers it for further `cmd` runs and runs `my_command`.
`feed_diagnostics` reads the output buffer content and feeds the diagnostics window with its content.
## Usage
```lua
vim.api.nvim_set_keymap('n', '<Leader>feed', ':lua require("Maker").feed_diagnostics()<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>cc', ':lua require("Maker").cmd("./configure.sh .")<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>bb', ':lua require("Maker").cmd("./build.sh")<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>rr', ':lua require("Maker").cmd("./run.sh")<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>cb', ':lua require("Maker").cmd("./configure.sh .; ./build.sh")<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>br', ':lua require("Maker").cmd("./build.sh; ./run.sh")<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>cbr', ':lua require("Maker").cmd("./configure.sh .; ./build.sh; ./run.sh")<CR>', opts)
```
