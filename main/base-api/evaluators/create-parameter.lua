local AttributeMT = require('main.core-api.attribute-api.attribute-mt')
local BaseComponents = require('main.base-api.components.export')

--- @class Parameter: Evaluator
--- @field base_value CumulativeComponent
--- @field add_factor CumulativeComponent
--- @field mul_factor MultiplyingComponent
--- @field soft_overriders CollectionComponent
--- @field hard_overriders CollectionComponent
--- @field soft_overrider_comparator (fun(prev, next): any)?
--- @field hard_overrider_comparator (fun(prev, next): any)?

local ParameterComponentFactory = {
    base_value = function(parameter)
        return BaseComponents.CreateCumulativeComponent(parameter)
    end,

    add_factor = function(parameter)
        return BaseComponents.CreateCumulativeComponent(parameter)
    end,

    mul_factor = function(parameter)
        return BaseComponents.CreateMultiplyingComponent(parameter)
    end,

    soft_overriders = function(parameter)
        return BaseComponents.CreateCollectionComponent(parameter)
    end,

    hard_overriders = function(parameter)
        return BaseComponents.CreateCollectionComponent(parameter)
    end
}

local ParameterMT = {
    __index = function(self, key)
        local factory = ParameterComponentFactory[key]
        if factory then
            local component = factory(self)
            rawset(self, key, component)
            return component
        end
        return AttributeMT[key]
    end,
}

function GetOverriderValue(container, collection, comparator)
    local overrider
    if comparator == nil then
        overrider = collection:get_tail(container)
    else
        overrider = collection:select(container, comparator)
    end
    if not overrider then
        return nil
    else
        return overrider.value
    end
end

--- @param parameter Parameter
--- @param container Container
function EvaluateParameter(parameter, container)
    local hard_overriders = rawget(parameter, 'hard_overriders')
    local hard_overrider_value = hard_overriders and GetOverriderValue(container, hard_overriders, parameter.hard_overrider_comparator)
    if hard_overrider_value then
        return hard_overrider_value
    end

    local factor
    factor = ((rawget(parameter, 'add_factor') and container[parameter.add_factor]) or 0) + 1
    factor = ((rawget(parameter, 'mul_factor') and container[parameter.mul_factor]) or 1) * factor

    local soft_overriders = rawget(parameter, 'soft_overriders')
    local soft_overrider_value = soft_overriders and GetOverriderValue(container, soft_overriders, parameter.soft_overrider_comparator)
    if soft_overrider_value then
        return soft_overrider_value * factor
    end

    return (container[parameter.base_value] or 0) * factor
end

--- @param is_local boolean?
--- @return Parameter
function CreateParameter(is_local)
    return setmetatable({
        is_local = is_local,
        evaluate = EvaluateParameter,
    }, ParameterMT)
end

return CreateParameter