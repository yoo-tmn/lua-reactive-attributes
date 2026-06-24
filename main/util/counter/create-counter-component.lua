local CreateComponent = require('main.core-api.attribute-api.create-component')

--- @class Counter: Component

function ApplyCounterChange(_, prev) return (prev or 0) + 1 end

function PurgeCounterChange(_, prev) return (prev or 0) - 1 end

--- @param evaluator Evaluator?
--- @return Counter
function CreateCounter(evaluator)
    return CreateComponent(ApplyCounterChange, PurgeCounterChange, evaluator, false) --[[@as Counter]]
end

return CreateCounter