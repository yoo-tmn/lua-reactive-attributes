local NotifyContainer = require('main.core-api.container-api.notify-container')

function UpdateContainer(container)
    local queue = container.queue

    local value
    local evaluator

    while queue.head <= queue.tail do
        evaluator = queue[queue.head]
        queue.head = queue.head + 1
        queue[evaluator] = nil

        if not evaluator then
            break
        end

        value = evaluator:evaluate(container)
        if value ~= container[evaluator] then
            container[evaluator] = value
            NotifyContainer(container, evaluator)
        end
    end

    queue.head = 1
    queue.tail = 0
end

return UpdateContainer