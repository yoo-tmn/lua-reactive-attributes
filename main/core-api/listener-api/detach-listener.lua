--- @type fun(target: Attribute | Container, listener: Listener)
function DetachListener(target, listener)
    local listeners = target.listeners
    if type(listeners) ~= 'table' then
        return
    end
    for n = 1, #listeners do
        if listener == listeners[n] then
            table.remove(listeners, n)
            break
        end
    end
end

return DetachListener