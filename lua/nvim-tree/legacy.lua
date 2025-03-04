local utils = require'nvim-tree.utils'

local M = {}

-- TODO update git.io/JPhyt when adding a migration

-- migrate the g: to o if the user has not specified that when calling setup
local migrations = {
  nvim_tree_disable_netrw = function(o)
    if o.disable_netrw == nil then
      o.disable_netrw = vim.g.nvim_tree_disable_netrw ~= 0
    end
  end,

  nvim_tree_hijack_netrw = function(o)
    if o.hijack_netrw == nil then
      o.hijack_netrw = vim.g.nvim_tree_hijack_netrw ~= 0
    end
  end,

  nvim_tree_auto_open = function(o)
    if o.open_on_setup == nil then
      o.open_on_setup = vim.g.nvim_tree_auto_open ~= 0
    end
  end,

  nvim_tree_auto_close = function(o)
    if o.auto_close == nil then
      o.auto_close = vim.g.nvim_tree_auto_close ~= 0
    end
  end,

  nvim_tree_tab_open = function(o)
    if o.open_on_tab == nil then
      o.open_on_tab = vim.g.nvim_tree_tab_open ~= 0
    end
  end,

  nvim_tree_update_cwd = function(o)
    if o.update_cwd == nil then
      o.update_cwd = vim.g.nvim_tree_update_cwd ~= 0
    end
  end,

  nvim_tree_hijack_cursor = function(o)
    if o.hijack_cursor == nil then
      o.hijack_cursor = vim.g.nvim_tree_hijack_cursor ~= 0
    end
  end,

  nvim_tree_system_open_command = function(o)
    utils.table_create_missing(o, "system_open")
    if o.system_open.cmd == nil then
      o.system_open.cmd = vim.g.nvim_tree_system_open_command
    end
  end,

  nvim_tree_system_open_command_args = function(o)
    utils.table_create_missing(o, "system_open")
    if o.system_open.args == nil then
      o.system_open.args = vim.g.nvim_tree_system_open_command_args
    end
  end,

  nvim_tree_follow = function(o)
    utils.table_create_missing(o, "update_focused_file")
    if o.update_focused_file.enable == nil then
      o.update_focused_file.enable = vim.g.nvim_tree_follow ~= 0
    end
  end,

  nvim_tree_follow_update_path = function(o)
    utils.table_create_missing(o, "update_focused_file")
    if o.update_focused_file.update_cwd == nil then
      o.update_focused_file.update_cwd = vim.g.nvim_tree_follow_update_path ~= 0
    end
  end,

  nvim_tree_lsp_diagnostics = function(o)
    utils.table_create_missing(o, "diagnostics")
    if o.diagnostics.enable == nil then
      o.diagnostics.enable = vim.g.nvim_tree_lsp_diagnostics ~= 0
      if o.diagnostics.show_on_dirs == nil then
        o.diagnostics.show_on_dirs = vim.g.nvim_tree_lsp_diagnostics ~= 0
      end
    end
  end,

  nvim_tree_auto_resize = function(o)
    utils.table_create_missing(o, "actions.open_file")
    if o.actions.open_file.resize_window == nil then
      o.actions.open_file.resize_window = vim.g.nvim_tree_auto_resize ~= 0
    end
  end,

  nvim_tree_bindings = function(o)
    utils.table_create_missing(o, "view.mappings")
    if o.view.mappings.list == nil then
      o.view.mappings.list = vim.g.nvim_tree_bindings
    end
  end,

  nvim_tree_disable_keybindings = function(o)
    utils.table_create_missing(o, "view.mappings")
    if o.view.mappings.custom_only == nil then
      if vim.g.nvim_tree_disable_keybindings ~= 0 then
        o.view.mappings.custom_only = true
        -- specify one mapping so that defaults do not apply
        o.view.mappings.list = {
          { key = "g?", action = "" },
        }
      end
    end
  end,

  nvim_tree_disable_default_keybindings = function(o)
    utils.table_create_missing(o, "view.mappings")
    if o.view.mappings.custom_only == nil then
      o.view.mappings.custom_only = vim.g.nvim_tree_disable_default_keybindings ~= 0
    end
  end,

  nvim_tree_hide_dotfiles = function(o)
    utils.table_create_missing(o, "filters")
    if o.filters.dotfiles == nil then
      o.filters.dotfiles = vim.g.nvim_tree_hide_dotfiles ~= 0
    end
  end,

  nvim_tree_ignore = function(o)
    utils.table_create_missing(o, "filters")
    if o.filters.custom == nil then
      o.filters.custom = vim.g.nvim_tree_ignore
    end
  end,

  nvim_tree_gitignore = function(o)
    utils.table_create_missing(o, "git")
    if o.git.ignore == nil then
      o.git.ignore = vim.g.nvim_tree_gitignore ~= 0
    end
  end,

  nvim_tree_disable_window_picker = function(o)
    utils.table_create_missing(o, "actions.open_file.window_picker")
    if o.actions.open_file.window_picker.enable == nil then
      o.actions.open_file.window_picker.enable = vim.g.nvim_tree_disable_window_picker == 0
    end
  end,

  nvim_tree_window_picker_chars = function(o)
    utils.table_create_missing(o, "actions.open_file.window_picker")
    if o.actions.open_file.window_picker.chars == nil then
      o.actions.open_file.window_picker.chars = vim.g.nvim_tree_window_picker_chars
    end
  end,

  nvim_tree_window_picker_exclude = function(o)
    utils.table_create_missing(o, "actions.open_file.window_picker")
    if o.actions.open_file.window_picker.exclude == nil then
      o.actions.open_file.window_picker.exclude = vim.g.nvim_tree_window_picker_exclude
    end
  end,

  nvim_tree_quit_on_open = function(o)
    utils.table_create_missing(o, "actions.open_file")
    if o.actions.open_file.quit_on_open == nil then
      o.actions.open_file.quit_on_open = vim.g.nvim_tree_quit_on_open == 1
    end
  end,

  nvim_tree_change_dir_global = function(o)
    utils.table_create_missing(o, "actions.change_dir")
    if o.actions.change_dir.global == nil then
      o.actions.change_dir.global = vim.g.nvim_tree_change_dir_global == 1
    end
  end,
}

function M.migrate_legacy_options(opts)
  local msg = nil

  for g, m in pairs(migrations) do
    if vim.fn.exists('g:'..g) ~= 0 then
      m(opts)
      msg = (msg and msg .. ", " or "Following options were moved to setup, see git.io/JPhyt: ") .. g
    end
  end

  if msg then
    require'nvim-tree.utils'.warn(msg)
  end
end

return M

