vim.api.nvim_create_user_command("Z", function(opts)
  print("Running Z with args: " .. opts.args)
  local term_cmd = "z-open" .. (opts.args or "")
  vim.fn.jobstart(term_cmd, {
    detach = true,
    stdout_buffered = true,
    on_stderr = function(_, data)
      if data then
        vim.notify(table.concat(data, "\n", vim.log.levels.ERROR))
      end
    end,
  })
end, {
  nargs = "*",
  desc = "Open file via z-open fuzzy finder",
})

vim.g.clipboard = {
  name = "wl-clipboard",
  copy = {
    ["+"] = "wl-copy --foreground --type text/plain",
    ["-"] = "wl-copy --foreground --type text/plain",
  },
  paste = {
    ["+"] = "wl-paste --no-newline",
    ["-"] = "wl-paste --no-newline",
  },
  cache_enabled = true,
}
