local NotifyListeners = require('main.core-api.listener-api.notify-listeners')

function NotifyContainer(container, attribute)
    NotifyListeners(container, attribute)

    if type(attribute) ~= 'table' then
        return
    end

    local bound_evaluators = attribute.bound_evaluators
    if type(bound_evaluators) ~= 'table' then
        return
    end

    local evaluator
    local queue = container.queue

    for n = 1, #bound_evaluators do
        evaluator = bound_evaluators[n]

        if not queue[evaluator] then
            queue.tail = queue.tail + 1
            queue[evaluator] = true
            queue[queue.tail] = evaluator
        end
    end
end

return NotifyContainer