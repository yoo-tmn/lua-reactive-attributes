--- @param attribute Attribute
--- @param modifier_data { [Component]: number }
function CreateProgressiveModifier(attribute, modifier_data)
    local levels = { }
    local condition_listener = function(container)
        local level = container[attribute]
        if type(level) ~= 'number' then
            return
        end

        local prev_level = levels[container] or 0
        levels[container] = level
        level = level - prev_level

        if level == 0 then
            return
        end

        if level > 0 then
            for component, data in pairs(modifier_data) do
                container:apply_change(component, data * level, false)
            end
        else
            level = -1 * level
            for component, data in pairs(modifier_data) do
                container:purge_change(component, data * level, false)
            end
        end
        container:update()
    end

    attribute:attach_listener(condition_listener)
end

return CreateProgressiveModifier