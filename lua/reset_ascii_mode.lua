-- reset_ascii_mode.lua
-- Reset ASCII mode to default on Alt+Tab

local M = {}

function M.init(env)
    local switches = env.engine.schema.config:get_list("switches")
    if switches == nil then
        return
    end

    for idx=1,switches.size do
        local switch = switches:get_at(idx-1)
        if switch.type == "kMap" then
            local element = switch:get_map()
            local switchName = element:get_value("name"):get_string()
            if switchName == "ascii_mode" then
                local resetValue = element:get_value("reset"):get_int() == 1
                M.default_ascii_mode = resetValue
                log.info("default ascii_mode will reset to " .. tostring(M.default_ascii_mode))
                return
            end
        end
    end
end

function M.func(key_event, env)
    local context = env.engine.context

    -- when triggered with no key is pressed or released,
    -- such as windows switchment, alt+tab, mouse click,
    -- reset ascii_mode to default
    if (not key_event:release()) and key_event:repr() == "0x0000" then
        -- additional check to avoid unnecessary status prompt by Weasel
        if not (context:get_option("ascii_mode") == M.default_ascii_mode) then
            context:set_option("ascii_mode", M.default_ascii_mode)
            return 1
        end
    end
    return 2
end

return M
