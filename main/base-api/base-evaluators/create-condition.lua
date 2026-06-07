local CreateEvaluator = require('main.core-api.attribute-api.create-evaluator')
local CreateCounterComponent = require('main.base-api.base-components.create-counter-component')

--- @param condition Condition
--- @param container Container
function EvaluateCondition(condition, container)
    if (container[condition.strong] or 0) > 0 then
        return true
    end

    if (container[condition.immune] or 0) > 0 then
        return false
    end

    if (container[condition.normal] or 0) > 0 then
        return true
    end

    return false
end

--- @class Condition: Evaluator
--- @field normal CounterComponent
--- @field immune CounterComponent
--- @field strong CounterComponent

--- @param is_global boolean?
--- @param is_urgent boolean?
--- @return Condition
function CreateCondition(is_global, is_urgent)
    local condition = CreateEvaluator(EvaluateCondition, is_global, is_urgent)
--- @cast condition Condition

    local normal = CreateCounterComponent()
    local immune = CreateCounterComponent()
    local strong = CreateCounterComponent()

    normal:bind_evaluator(condition)
    immune:bind_evaluator(condition)
    strong:bind_evaluator(condition)

    condition.normal = normal
    condition.immune = immune
    condition.strong = strong

    return condition
end

return CreateCondition