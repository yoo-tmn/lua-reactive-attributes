local CreateEvaluator = require('main.core-api.attribute-api.create-evaluator')
local CreateCounterComponent = require('main.base-api.base-components.create-counter-component')

--- @class State: Evaluator
--- @field normal CounterComponent
--- @field immune CounterComponent
--- @field strong CounterComponent

--- @param evaluator State
--- @param container Container
function EvaluateState(evaluator, container)
    if (container[evaluator.strong] or 0) > 0 then
        return true
    end

    if (container[evaluator.immune] or 0) > 0 then
        return false
    end

    if (container[evaluator.normal] or 0) > 0 then
        return true
    end

    return false
end

--- @param is_local boolean?
--- @return State
function CreateStateEvaluator(is_local)
    local evaluator = CreateEvaluator(EvaluateState, is_local)
--- @cast evaluator State

    local normal = CreateCounterComponent()
    local immune = CreateCounterComponent()
    local strong = CreateCounterComponent()

    normal:bind_evaluator(evaluator)
    immune:bind_evaluator(evaluator)
    strong:bind_evaluator(evaluator)

    evaluator.normal = normal
    evaluator.immune = immune
    evaluator.strong = strong

    return evaluator
end

return CreateStateEvaluator