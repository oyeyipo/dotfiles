return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  event = "BufReadPre",
  log_level = vim.log.levels.DEBUG,
  config = {
    ui = {
      icons = {
        package_installed = "✔",
        package_pending = "→",
        package_uninstalled = "❌",
      } 
    }
  }
}
