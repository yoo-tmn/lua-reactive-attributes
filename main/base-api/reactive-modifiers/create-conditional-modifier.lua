--- @param attribute Attribute
function CreateConditionalModifier(attribute, modifier_data)
    local is_applied = { }
    local condition_listener = function(container)
        local applied = is_applied[container]

        if container[attribute] then
            if applied then
                return
            else
                for component, data in pairs(modifier_data) do
                    container:apply_change(component, data, false)
                end
                container:update()
                is_applied[container] = true
            end
        else
            if not applied then
                return
            else
                for component, data in pairs(modifier_data) do
                    container:purge_change(component, data, false)
                end
                container:update()
                is_applied[container] = false
            end
        end
    end

    attribute:attach_listener(condition_listener)
end

return CreateConditionalModifier