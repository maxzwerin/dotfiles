-- GOALS:
-- this program should be like flash.nvim
-- but 1000x more simple. i want to:

-- "dim" text
-- highlight UP TO 52 targets while typing
-- also highlight the text that i am searching for

-- IF only one target, instantly jump to it
-- ELSE only jump to target if target button is pressed
-- undim text on ESC or QUIT or target press
-- make sure no targets == the next letter of a search

-- MASH.NVIM - Simple, fast motion plugin
-- Jump to any visible text with minimal keystrokes

local M = {}

-- Configuration
local config = {
    labels = "asdfghjklqwertyuiopzxcvbnmASDFGHJKLQWERTYUIOPZXCVBNM",
    highlights = {
        dim = { fg = "#606079", italic = true, ctermfg = 242 },
        target_bg = { bg = "#404065", ctermbg = 13 },
        target_text = { fg = "#c3c3d5", ctermfg = 13 },
        label_bg = { bg = "#333738", ctermbg = 13 },
        label_text = { fg = "#9bb4bc", ctermfg = 13 },
    }
}

-- State
local state = {
    ns = vim.api.nvim_create_namespace("mash"),
    targets = {},
    excluded_labels = {},
}

-- Constants
local KEYS = {
    CR = vim.api.nvim_replace_termcodes("<cr>", true, true, true),
    ESC = vim.api.nvim_replace_termcodes("<esc>", true, true, true),
    BS = vim.api.nvim_replace_termcodes("<bs>", true, true, true),
}

-- Setup highlight groups
local function setup_highlights()
    vim.api.nvim_set_hl(0, "MashDim", config.highlights.dim)
    vim.api.nvim_set_hl(0, "MashTargetBg", config.highlights.target_bg)
    vim.api.nvim_set_hl(0, "MashTargetText", config.highlights.target_text)
    vim.api.nvim_set_hl(0, "MashLabelBg", config.highlights.label_bg)
    vim.api.nvim_set_hl(0, "MashLabelText", config.highlights.label_text)
end

-- Get visible window bounds
local function get_visible_range()
    return vim.fn.line("w0") - 1, vim.fn.line("w$")
end

-- Dim all visible text
local function dim_visible_text()
    local bufnr = vim.api.nvim_get_current_buf()
    local start_line, end_line = get_visible_range()

    for lnum = start_line, end_line - 1 do
        vim.api.nvim_buf_add_highlight(bufnr, state.ns, "MashDim", lnum, 0, -1)
    end
end

-- Clear all highlights and state
local function clear_state()
    vim.api.nvim_buf_clear_namespace(0, state.ns, 0, -1)
    state.targets = {}
    state.excluded_labels = {}
end

-- Build set of labels that would conflict with next character after matches
local function get_excluded_labels(lines, query, start_line)
    local excluded = {}

    for idx, line in ipairs(lines) do
        local pos = 1
        while true do
            local s, e = string.find(line, query, pos, true)
            if not s then break end

            -- Get character immediately after match
            local next_char = line:sub(e + 1, e + 1)
            if next_char ~= "" then
                excluded[next_char] = true
            end

            pos = e + 1
        end
    end

    return excluded
end

-- Get available labels (excluding conflicts)
local function get_available_labels()
    local available = {}

    for i = 1, #config.labels do
        local label = config.labels:sub(i, i)
        if not state.excluded_labels[label] then
            table.insert(available, label)
        end
    end

    return available
end

-- Find and highlight all matches for query
local function highlight_matches(query)
    clear_state()
    dim_visible_text()

    if query == "" then
        vim.cmd("redraw")
        return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local start_line, end_line = get_visible_range()
    local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line, false)

    -- First pass: identify excluded labels
    state.excluded_labels = get_excluded_labels(lines, query, start_line)

    -- Second pass: assign labels and create highlights
    local available_labels = get_available_labels()
    local label_idx = 1

    for idx, line in ipairs(lines) do
        local lnum = start_line + idx - 1
        local pos = 1

        while true do
            local s, e = string.find(line, query, pos, true)
            if not s then break end
            if label_idx > #available_labels then break end

            local label = available_labels[label_idx]

            -- Highlight the matched text
            vim.api.nvim_buf_add_highlight(bufnr, state.ns, "MashTargetBg", lnum, s - 1, e)
            vim.api.nvim_buf_add_highlight(bufnr, state.ns, "MashTargetText", lnum, s - 1, e)

            -- Add label as virtual text overlay
            vim.api.nvim_buf_set_extmark(bufnr, state.ns, lnum, e, {
                virt_text = { { label, "MashLabelText" } },
                virt_text_pos = "overlay",
                hl_mode = "combine",
            })

            -- Store target for jumping
            table.insert(state.targets, {
                label = label,
                lnum = lnum,
                col = s - 1,
            })

            label_idx = label_idx + 1
            pos = e + 1
        end
    end

    vim.cmd("redraw")
end

-- Jump to cursor position and center screen
local function jump_to_target(target)
    vim.api.nvim_win_set_cursor(0, { target.lnum + 1, target.col })
    vim.cmd("normal! zz")
end

-- Try to jump to a target by label
local function try_jump_to_label(input)
    for _, target in ipairs(state.targets) do
        if target.label == input then
            jump_to_target(target)
            return true
        end
    end
    return false
end

-- Display status message
local function show_status(query)
    local msg = "mash: " .. (query ~= "" and query or "")
    vim.api.nvim_echo({ { msg, "Normal" } }, false, {})
end

-- Auto-jump if only one target
local function auto_jump_if_single_target()
    if #state.targets == 1 then
        jump_to_target(state.targets[1])
        clear_state()
        vim.cmd("redraw")
        return true
    end
    return false
end

-- Prompt for label selection
local function prompt_for_label()
    local ok, input = pcall(vim.fn.getcharstr)
    if not ok or not input then return end

    if try_jump_to_label(input) then
        clear_state()
        vim.cmd("redraw")
    end
end

-- Main jump function
function M.jump()
    clear_state()
    dim_visible_text()
    vim.cmd("redraw")

    local query = ""

    while true do
        local ok, input = pcall(vim.fn.getcharstr)
        if not ok or not input then break end

        -- Handle special keys
        if input == KEYS.ESC then
            clear_state()
            vim.cmd("redraw")
            return
        elseif input == KEYS.CR then
            break
        elseif input == KEYS.BS then
            if #query > 0 then
                query = query:sub(1, -2)
                highlight_matches(query)
            end
        else
            -- Check if input matches a target label
            if try_jump_to_label(input) then
                clear_state()
                vim.cmd("redraw")
                return
            end

            -- Add to query
            query = query .. input
            highlight_matches(query)

            -- Auto-jump if only one target
            if auto_jump_if_single_target() then
                return
            end
        end

        show_status(query)
    end

    -- If Enter was pressed, prompt for label
    if #state.targets > 0 then
        prompt_for_label()
    else
        clear_state()
        vim.cmd("redraw")
    end
end

-- Setup function (optional, for custom config)
function M.setup(opts)
    if opts then
        config = vim.tbl_deep_extend("force", config, opts)
    end
    setup_highlights()
end

-- Initialize highlights on load
setup_highlights()

return M
