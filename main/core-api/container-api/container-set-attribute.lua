local NotifyListeners = require('main.core-api.listener-api.notify-listeners')

function HasDifference(prev, next)
    if type(prev) == 'table' and type(next) == 'table' then
        return true
    end
    return prev ~= next
end

--- @param container Container
--- @param attribute Attribute
function ContainerSetAttribute(container, attribute, data)
    local prev = container[attribute]
    if not HasDifference(prev, data) then
        return
    end

    container[attribute] = data

    NotifyListeners(container, attribute, data, prev)

    local bound_evaluators = attribute.bound_evaluators
    if type(bound_evaluators) ~= 'table' then
        return
    end

    local evaluator
    local queue = container.queue
    for n = 1, #bound_evaluators do
        evaluator = bound_evaluators[n]

        if not container:has_evaluator(evaluator) then
            goto continue
        end

        if not queue[evaluator] then
            queue.tail = queue.tail + 1
            queue[evaluator] = true
            queue[queue.tail] = evaluator
        end

        ::continue::
    end
end

return ContainerSetAttribute