local CreateEvaluator = require('main.core-api.attribute-api.create-evaluator')

--- @class ModifierEvaluator: Evaluator, ModifierTag[]
--- @field counter Counter?
--- @field influence Attribute?
--- @field condition Attribute?
--- @field data { [Component]: any }

--- @param evaluator ModifierEvaluator
--- @param container Container
function EvaluateModifier(evaluator, container)
    local result
    local counter_key = evaluator.counter
    if not counter_key then
        result = 1
    else
        result = container[counter_key] or 0
    end
    if result == 0 then
        return 0
    end
    if evaluator.condition then
        if not container[evaluator.condition] then
            return 0
        end
    end
    local tag
    for n = 1, #evaluator do
        tag = evaluator[n]
        if (container[tag.disabled] or 0) > 0 then
            return 0
        end
        result = result * (1 + (container[tag.efficiency] or 0))
    end
    return result * ((evaluator.influence and container[evaluator.influence]) or 1)
end

--- @param container Container
--- @param evaluator ModifierEvaluator
function ListenModifierEvaluator(container, evaluator, next_level, prev_level)
    next_level = next_level or 0
    if type(next_level) ~= 'number' then return end

    prev_level = prev_level or 0
    if type(prev_level) ~= 'number' then return end

    local level = next_level - prev_level
    if level == 0 then return end

    if level > 0 then
        for component, value in pairs(evaluator.data) do
            if component.adjusting then
                container:apply_change(component, value * level, false)
            elseif prev_level == 0 then
                container:apply_change(component, value, false)
            end
        end
    else
        level = -level
        for component, value in pairs(evaluator.data) do
            if component.adjusting then
                container:purge_change(component, value * level, false)
            elseif next_level == 0 then
                container:purge_change(component, value, false)
            end
        end
    end
    container:update()
end

--- @param counter Counter?
--- @param influence Attribute?
--- @param condition Attribute?
--- @param modifiers { [Component]: any }
--- @return ModifierEvaluator
function CreateModifier(modifiers, counter, influence, condition)
    local evaluator = CreateEvaluator(EvaluateModifier) --[[@as ModifierEvaluator]]

    evaluator.data = modifiers
    if counter then
        evaluator.counter = counter
        counter:bind_evaluator(evaluator)
    end
    if influence then
        evaluator.influence = influence
        influence:bind_evaluator(evaluator)
    end
    if condition then
        evaluator.condition = condition
        condition:bind_evaluator(evaluator)
    end
    evaluator:attach_listener(ListenModifierEvaluator)

    return evaluator
end

return CreateModifier