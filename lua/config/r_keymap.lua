local project = string.gsub(vim.fn.system("basename $(pwd)"), "%s+", "")

local tmux_sk = function(cmds, session, window, pane) 
  local where = session .. ":" .. window .. "." .. pane
  for _, cmd in ipairs(cmds) do
    cmd = string.gsub(cmd, '"', '\\"')
    cmd = string.gsub(cmd, "%$", [[\$]])
    local call = 'tmux send-keys -t ' .. where .. ' "' .. cmd .. '" ENTER'
    vim.fn.system(call)
  end
end

--------------------------------------------------------------------------------

local send_to_console = function(cmds)
  tmux_sk(cmds, project, "1", "2")
end

local send_to_terminal = function(cmds)
  tmux_sk(cmds, project, "1", "1")
end

--------------------------------------------------------------------------------

local get_text_object_line = function()
  local line_start = vim.fn.line("'[")
  local line_end = vim.fn.line("']")
  if (line_start ~= nil and line_end ~= nil) then
    local text = vim.fn.getline(line_start, line_end)
    return text
  end
end

local get_text_object_char = function()
  vim.cmd('normal `["zyv`]')
  return vim.fn.getreg("z")
end

local get_selected_text = function()
  local line_start = vim.fn.line("v")
  local line_end = vim.fn.line(".")
  if (line_start ~= nil and line_end ~= nil) then
    local text = {""}
    if (line_start ~= line_end) then
      text = vim.fn.getline(line_start, line_end)
    else
      vim.cmd('normal "zy')
      text = {vim.fn.getreg("z")}
    end
    return text
  end
end

--------------------------------------------------------------------------------

local send_r_line = function()
  local cmd = vim.api.nvim_get_current_line()
  send_to_console({ cmd })
  vim.cmd("norm! j")
end

local send_r_region = function()
  local text = get_selected_text()
  send_to_console(text)
  vim.api.nvim_input("<esc>")
end

local get_r_help = function()
  vim.cmd('normal "zyiw')
  send_to_console({ "?" .. vim.fn.getreg("z")})
end

function SendRTextObject(motion)
  if motion == nil then
    vim.go.operatorfunc = "v:lua.ExecuteR"
    return "g@"
  end

  if motion == "char" then
    local cmd = get_text_object_char()
    send_to_console({ cmd })
  end

  if motion == "line" then
    local cmd = get_text_object_line()
    send_to_console(cmd)
  end
end

local source_r_file = function()
  local cmd = 'source(\'' .. vim.api.nvim_buf_get_name(0) .. '\', echo = TRUE, spaced = FALSE)'
  send_to_console({ cmd })
end

local reload_r_package = function()
  send_to_console({ "devtools::load_all()" })
end

local restart_r = function()
  send_to_console({"C-c", "q()", "clear", "R --quiet"})
end

local test_r_package = function()
  send_to_terminal({ "Rtest" }) 
end

local check_r_package = function()
  send_to_terminal({ "Rcheck" }) 
end

vim.keymap.set("n", "<s-cr>", SendRTextObject, { expr = true, desc = "Execute Text Object" })
vim.keymap.set("n", "<cr>", send_r_line, { expr = true, desc = "Execute R line" })
vim.keymap.set("v", "<cr>", send_r_region, { expr = true, desc = "Execute R Region"})
vim.keymap.set("n", "<leader>rl", reload_r_package, { expr = true, desc = "Reload R package" })
vim.keymap.set("n", "<leader>rr", restart_r, { expr = true, desc = "Restart R session" })
vim.keymap.set("n", "<leader>rt", test_r_package, { expr = true, desc = "Test R Package" })
vim.keymap.set("n", "<leader>re", check_r_package, { expr = true, desc = "Check R Package" })
vim.keymap.set("n", "<leader>rs", source_r_file, { expr = true, desc = "Source R file"})
vim.keymap.set("n", "<leader>r?", get_r_help, { expr = true, desc = "Get R Help"})

