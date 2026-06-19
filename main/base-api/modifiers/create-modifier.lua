--- @class ModifierEvaluator: Evaluator, ModifierTag[]
--- @field flag CumulativeComponent
--- @field influence Attribute?
--- @field condition Attribute?

local CreateEvaluator = require('main.core-api.attribute-api.create-evaluator')
local BaseComponents = require('main.base-api.components.export')

--- @param evaluator ModifierEvaluator
--- @param container Container
function EvaluateModifier(evaluator, container)
    local flag = container[evaluator.flag]
    if not flag or flag == 0 then
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
        flag = flag * (1 + (container[tag.efficiency] or 0))
    end
    return flag * ((evaluator.influence and container[evaluator.influence]) or 1)
end

--- @param influence Attribute?
--- @param condition Attribute?
--- @param modifiers { [Component]: any }
--- @return ModifierEvaluator
function CreateModifier(modifiers, influence, condition)
    local evaluator = CreateEvaluator(EvaluateModifier) --[[@as ModifierEvaluator]]
    evaluator.flag = BaseComponents.CreateCumulativeComponent(evaluator, false)
    if influence then
        evaluator.influence = influence
        influence:bind_evaluator(evaluator)
    end
    if condition then
        evaluator.condition = condition
        condition:bind_evaluator(evaluator)
    end

    local listener = function(container, _, next_level, prev_level)
        next_level = next_level or 0
        if type(next_level) ~= 'number' then return end

        prev_level = prev_level or 0
        if type(prev_level) ~= 'number' then return end

        local level = next_level - prev_level
        if level == 0 then return end

        if level > 0 then
            for component, value in pairs(modifiers) do
                if component.adjusting then
                    container:apply_change(component, value * level, false)
                elseif prev_level == 0 then
                    container:apply_change(component, value, false)
                end
            end
        else
            level = -level
            for component, value in pairs(modifiers) do
                if component.adjusting then
                    container:purge_change(component, value * level, false)
                elseif next_level == 0 then
                    container:purge_change(component, value, false)
                end
            end
        end
        container:update()
    end
    evaluator:attach_listener(listener)

    return evaluator
end

return CreateModifier