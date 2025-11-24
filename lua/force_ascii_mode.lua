-- force_ascii_mode.lua
-- Typing "jj" while composing (non-ASCII mode) switches to ASCII mode.
-- This prevents accidental Vim movements when composition is active.

local M = {}

function M.init(env)
    local config = env.engine.schema.config
    local name_space = env.name_space:gsub('^*', '')
    local trigger_list = config:get_list(name_space .. "/trigger_inputs")
    M.trigger_inputs = {}
    if trigger_list then
        for i = 0, trigger_list.size - 1 do
            local key = trigger_list:get_value_at(i).value
            M.trigger_inputs[key] = true
        end
    end
end

function M.func(key_event, env)
    local engine = env.engine
    local context = env.engine.context

    -- The `is_composing()` check ensures this shortcut only triggers when an IME is active.
    if key_event:release() and context:is_composing() then
        if M.trigger_inputs[context.input] then
            -- keep current input from dropping
            engine:commit_text(context.input)
            context:clear()
            -- reset back to english mode
            context:set_option("ascii_mode", true)
            return 1
        end
    end
    return 2
end

return M
