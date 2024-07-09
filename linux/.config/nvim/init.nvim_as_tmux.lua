-- Use NeoVim as a Tmux replacement
--
-- Have native Vim-like selection-mode and advanced search features in your
-- terminal by using Nvim as a wrapper instead of Tmux.
--
-- Usage
--   nvim -u ~/.config/nvim/init.nvim_as_tmux.lua "optional shell commands to execute"
--
--   Write it into a script file and set up your terminal to execute it as
--   default command.
--
-- Experiences
--
--   - It works well
--   - Easy to scroll, search for expressions and copy lines (without trailing whitespace)
--
--   - Refresh rate is slower even if I use from Alacritty or Kitty
--   - The content wrapping does not follows the resize of the window, the end of
--     the line is truncated

-- Disable UI to be as fast as possible
vim.opt.laststatus = 0
vim.opt.ruler = false

-- Do not show "-- TERMINAL --" on the bottom of the screen
-- It's hiding the UI at all, but you will not know the current mode and there are other caveats (see `:help 'cmdheight'`)
--vim.opt.cmdheight = 0

-- Allow true (24 bit) colors
vim.opt.termguicolors = true

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Disable mouse: when clicking into terminal window to gain focus, it's leaving insert mode
-- You can still use the terminal's mouse support for text selection
vim.opt.mouse = ""

-- Search-related options
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = false

-- Clear search highlight when going back to terminal / insert mode
-- Cannot achieve by autocommand, see `:help nohlsearch`
function my_insert_mode()
  vim.cmd("nohlsearch")
  vim.cmd("startinsert")
end
vim.keymap.set("n", "i", my_insert_mode)
vim.keymap.set("n", "I", my_insert_mode)
vim.keymap.set("n", "a", my_insert_mode)
vim.keymap.set("n", "A", my_insert_mode)

-- Use Shift+PageUp/PageDown to scroll
vim.keymap.set("n", "<s-pageup>", "<c-u>")
vim.keymap.set("n", "<s-pagedown>", "<c-d>")
-- ...or a simpler way to exit to normal mode (and start to scroll)
vim.keymap.set("t", "<s-pageup>", "<c-\\><c-n>")
vim.keymap.set("t", "<s-pagedown>", "<c-\\><c-n>")

-- Disable command mode to prevent accidentally hit `:q`
vim.keymap.set("n", ":", "")
-- Disable macro record to prevent accidentally git `q` (quit from pager)
vim.keymap.set("n", "q", "")

-- If you use Ctrl+S / Ctrl+Q to stop scrolling in terminal, these mappings could be handy:
-- Ctrl+S in normal mode sends stop signal without moving the cursor to the end of the buffer
vim.keymap.set("n", "<c-s>", function()
  local view = vim.fn.winsaveview()
  -- Emit of `<c-s>` does not work well with `startinsert` / `stopinsert`, have to execute in a single command
  vim.api.nvim_input("i<c-s><c-\\><c-n>")
  vim.schedule(function() vim.fn.winrestview(view) end)
end)
-- Ctrl+Q in normal mode moves you back to terminal mode before executing Ctrl+Q
vim.keymap.set("n", "<c-q>", function()
  my_insert_mode()
  vim.api.nvim_input("<c-q>")
end)

-- Autocommands
vim.api.nvim_create_augroup("nvim_as_tmux", {})
vim.api.nvim_create_autocmd({"TermOpen"}, {
  group = "nvim_as_tmux",
  desc = "Start terminal in insert mode",
  callback = function()
    vim.cmd("startinsert")
  end
})
vim.api.nvim_create_autocmd({"WinNew"}, {
  group = "nvim_as_tmux",
  desc = "Open terminal on split",
  nested = true,
  callback = function()
    vim.cmd("terminal")
  end
})
vim.api.nvim_create_autocmd({"TermClose"}, {
  group = "nvim_as_tmux",
  desc = "Quit from NeoVim if the terminal was the only buffer when deleted",
  callback = function(args)
    -- Remove "Process exited with XYZ status" buffer
    if vim.api.nvim_buf_is_loaded(args.buf) then
      vim.api.nvim_buf_delete(args.buf, {force = true})
    end
    -- Quit if terminal was the last buffer
    if #vim.api.nvim_list_bufs() <= 1 then
      vim.cmd("quit")
    end
  end
})
vim.api.nvim_create_autocmd({"UIEnter"}, {
  group = "nvim_as_tmux",
  desc = "Open terminal on start with the first command-line argument as arguments list",
  nested = true,
  callback = function()
    vim.cmd("terminal " .. vim.fn.argv(0))
  end
})
-- vim.api.nvim_create_autocmd({"WinResized"}, {
--   -- Resize of window leads to blank margin on the right, I have to press 0 in
--   -- normal mode to view the left side of the terminal content. To reproduce:
--   -- - Use i3 (it does not happens when using floating windows)
--   -- - Open Tmux
--   -- - Split vertically to have a pane on the left and right side
--   -- - Activate the right pane, let the cursor in it
--   -- - Open another terminal to the right of Tmux terminal window, it will
--   --   shrink Tmux window
--   -- - Close the new terminal
--   -- - The content of Tmux terminal is not aligned to the window
--   -- Happens only in Nvim, tested via xfce4-terminal
--   group = "nvim_as_tmux",
--   desc = "Align the window content if terminal window is resized by window manager",
--   callback = function()
--     vim.api.nvim_input("<c-\\><c-n>0i")
--   end
-- })

-- Optionally load plugins (colorscheme, EasyJump, etc.)
-- Indicate "NeoVim as Tmux mode" to be able to set conditions to plugins loading
NVIM_AS_TMUX = true
require("plugins")
