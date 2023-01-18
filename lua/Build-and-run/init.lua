local M = {}

M.ready_buffer = function()
    -- If the output buffer is invalid, (re-)create it
    if not M.output_buf or not vim.api.nvim_buf_is_valid(M.output_buf) then
        M.output_buf = vim.api.nvim_create_buf({}, false)
    end

    M.output_term = vim.api.nvim_open_term(M.output_buf, {})
    print("[Build-and-run]: Output to buffer " .. M.output_buf)
end

function M.send_to_term(_, data)
    data = table.concat(data, "\n")
    data = data.gsub(data, "\n", "\n\r")
    vim.api.nvim_chan_send(M.output_term, data)
end

function M.run_with_output(cmd)
    vim.fn.jobstart(cmd, {
        channel_buffered = true,
        on_stdout = M.send_to_term,
        on_stderr = M.send_to_term,
    })
end

function M.open_output_term()
    vim.api.nvim_win_set_buf(0, M.output_buf)
end

function M.feed_diagnostics()
    local data = vim.api.nvim_buf_get_lines(M.output_buf, 0, -1, true)
    data = table.concat(data, '\n')
    vim.g._cexpr_lines = data
    vim.cmd(":cexpr g:_cexpr_lines")
end

function M.cmd(cmd)
    -- Splitting the string command to make it a table
    vim.api.nvim_command('wa')
    M.ready_buffer()
    M.run_with_output(cmd)
    M.open_output_term()
    M.feed_diagnostics()
end

return M
