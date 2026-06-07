--- @alias Listener fun(container: Container, attribute: Attribute)

--- @param container Container
--- @param attribute Attribute
function Notify(container, attribute)
    local listeners

    listeners = container.listeners
    if type(listeners) ~= 'table' then
        goto next
    end
    for n = 1, #listeners do
        listeners[n](container, attribute)
    end

    ::next::
    listeners = attribute.listeners
    if type(listeners) ~= 'table' then
        return
    end
    for n = 1, #listeners do
        listeners[n](container, attribute)
    end
end

return Notify