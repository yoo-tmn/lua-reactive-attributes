--- @class Reactive
--- @field listeners Listener[]?
--- @field attach_listener fun(self, listener: Listener)
--- @field detach_listener fun(self, listener: Listener)

--- @alias Listener fun(container: Container, attribute: Attribute, data: any, prev: any)

--- @param container Container
--- @param attribute Attribute
function NotifyListeners(container, attribute, data, prev)
    local listeners

    listeners = container.listeners
    if type(listeners) == 'table' then    
        for n = 1, #listeners do
            listeners[n](container, attribute, data, prev)
        end
    end
    listeners = attribute.listeners
    if type(listeners) == 'table' then
        for n = 1, #listeners do
            listeners[n](container, attribute, data, prev)
        end
    end
end

return NotifyListeners