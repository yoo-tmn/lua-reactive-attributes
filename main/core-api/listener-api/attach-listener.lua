--- @type fun(target: Reactive, listener: Listener)
function AttachListener(target, listener)
    local listeners = target.listeners
    if type(listeners) ~= 'table' then
        target.listeners = { listener }
    else
        listeners[#listeners + 1] = listener
    end
end

return AttachListener