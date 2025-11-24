-- reset_ascii_mode.lua
-- Reset ASCII mode to default on Alt+Tab

local M = {}

function M.init(env)
    local config = env.engine.schema.config
    local name_space = env.name_space:gsub('^*', '')
    M.trigger_inputs = config:get_list(name_space .. "/trigger_inputs")
end

function M.func(key_event, env)
    local context = env.engine.context

    -- Typing "jj" while composing (non-ASCII mode) switches to ASCII mode.
    -- This prevents accidental Vim movements when composition is active.
    -- The `is_composing()` check ensures this shortcut only triggers when an IME is active.
    if key_event:release() and context:is_composing() then
        for idx=1,M.trigger_inputs.size do
            if context.input == M.trigger_inputs:get_value_at(idx-1).value then
                -- ascii_composer/switch_key commit_code behavior
                -- https://gist.github.com/lotem/2981316
                -- https://github.com/rime/librime/blob/75bc43ae9acdd2042d150a8c446e9ac8b6d77c84/src/rime/gear/ascii_composer.cc#L243
                context:clear_non_confirmed_composition()
                context:commit()
                -- reset back to english mode
                context:set_option("ascii_mode", true)
                return 1
            end
        end
    end
    return 2
end

return M
