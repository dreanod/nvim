local wk = require("which-key")

local nmap = function(key, effect)
	vim.keymap.set("n", key, effect, { silent = true, noremap = true })
end

local vmap = function(key, effect)
	vim.keymap.set("v", key, effect, { silent = true, noremap = true })
end

local imap = function(key, effect)
	vim.keymap.set("i", key, effect, { silent = true, noremap = true })
end

local project = string.gsub(vim.fn.system("basename $(pwd)"), "%s+", "")

vim.g.slime_default_config = {
  socket_name = "default",
  target_pane = project .. ":1.2",
}

vim.g.slime_dont_ask_default = 1

-- send code with ctrl+Enter
-- just like in e.g. RStudio
-- needs kitty (or other terminal) config:
-- map shift+enter send_text all \x1b[13;2u
-- map ctrl+enter send_text all \x1b[13;5u
nmap("<c-cr>", ":call slime#send_cell()<cr>")
imap("<c-cr>", "<esc>:call slime#send_cell()<cr>i")

-- send code with Enter and leader Enter
vmap("<cr>", "<Plug>SlimeRegionSend")
-- nmap("<leader><cr>", ":SlimeSend")

local tmux_sk = function(cmds, session, window, pane) 
  local where = session .. ":" .. window .. "." .. pane
  for _, cmd in ipairs(cmds) do
    cmd = string.gsub(cmd, '"', '\\"')
    cmd = string.gsub(cmd, "%$", [[\$]])
    local call = 'tmux send-keys -t ' .. where .. ' "' .. cmd .. '" ENTER'
    -- vim.print(call)
    vim.fn.system(call)
  end
end

local send_r_line = function()
  local cmd = vim.api.nvim_get_current_line()
  vim.print(cmd)
  tmux_sk({cmd}, project, "1", "2")
  vim.cmd("norm! j")
end

local get_selected_text = function()
  local line_start = vim.fn.line("v")
  local line_end = vim.fn.line(".")
  local text = {""}
  if (line_start ~= line_end) then
    text = vim.fn.getline(line_start, line_end)
  else
    vim.cmd('normal "zy')
    text = {vim.fn.getreg("z")}
  end
  return text
end

local send_r_region = function()
  local text = get_selected_text()
  tmux_sk(text, project, "1", "2")
  vim.api.nvim_input("<esc>")
end

local get_r_help = function()
  vim.cmd('normal "zyaw')
  tmux_sk({ "?" .. vim.fn.getreg("z")}, project, "1", "2")
end

wk.register({
  r = {
    name = "R",
    l = { function() tmux_sk({"devtools::load_all()"}, project, "1", "2") end, "reload R package" },
    r = { function() tmux_sk({"q()", "clear", "R --quiet"}, project, "1", "2") end, "restart R session" },
    t = { function() tmux_sk({"Rtest"}, project, "1", "1") end, "test R package"},
    c = { function() tmux_sk({"Rcheck"}, project, "1", "1") end, "check R package"},
    s = { function() tmux_sk({'source(\'' .. vim.api.nvim_buf_get_name(0) .. '\', echo = TRUE, spaced = FALSE)'}, project, "1", "2") end, "source R file"},
    ["?"] = { function() get_r_help() end, "print help"}
  },
  -- ["<cr>"] = { ":SlimeSend<cr>j", "Send current line to R" }
  ["<cr>"] = { function() send_r_line() end, "Send current line to R" }
}, { mode = "n", prefix = "<leader>" })

wk.register({
  ["<cr>"] = { function() send_r_line() end, "Send currend line to R"},
}, { mode = 'n'})
wk.register({
  ["<cr>"] = { function() send_r_region() end, "Send current region to R"}
}, { mode = "v"})
