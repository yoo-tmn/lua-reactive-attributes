--- @param attribute Attribute
--- @param modifier_data { [Component]: any }
function CreateConditionalModifier(attribute, modifier_data)
    local condition_listener = function(container, _, need_apply, is_applied)
        if need_apply then
            if is_applied then
                return
            else
                for component, data in pairs(modifier_data) do
                    container:apply_change(component, data, false)
                end
                container:update()
            end
        else
            if not is_applied then
                return
            else
                for component, data in pairs(modifier_data) do
                    container:purge_change(component, data, false)
                end
                container:update()
            end
        end
    end

    attribute:attach_listener(condition_listener)
end

return CreateConditionalModifier