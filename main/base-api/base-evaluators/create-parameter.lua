local CreateEvaluator = require('main.core-api.attribute-api.create-evaluator')
local CreateOverrider = require('main.base-api.base-evaluators.create-overrider')
local CreateNumericComponent = require('main.base-api.base-components.create-numeric-component')

--- @param parameter Parameter
--- @param container Container
function EvaluateParameter(parameter, container)
    local total_overrider = container[parameter.total_overrider]
    if total_overrider then
        return total_overrider.value
    end

    local value
    local ratio
    local value_overrider = container[parameter.value_overrider]
    local ratio_overrider = container[parameter.ratio_overrider]
    if value_overrider then
        value = value_overrider.value or 0
    else
        value = container[parameter.value] or 0
    end
    if ratio_overrider then
        ratio = ratio_overrider.value or 0
    else
        ratio = container[parameter.ratio] or 0
    end
    return value * (1 + ratio)
end

--- @class Parameter: Evaluator
--- @field value NumericComponent
--- @field ratio NumericComponent
--- @field value_overrider Overrider
--- @field ratio_overrider Overrider
--- @field total_overrider Overrider

--- @param is_global boolean?
--- @param is_urgent boolean?
--- @return Parameter
function CreateParameter(is_global, is_urgent)
    local parameter = CreateEvaluator(EvaluateParameter, is_global, is_urgent)
--- @cast parameter Parameter

    local value = CreateNumericComponent()
    local ratio = CreateNumericComponent()
    local value_overrider = CreateOverrider()
    local ratio_overrider = CreateOverrider()
    local total_overrider = CreateOverrider()

    value:bind_evaluator(parameter)
    ratio:bind_evaluator(parameter)
    value_overrider:bind_evaluator(parameter)
    ratio_overrider:bind_evaluator(parameter)
    total_overrider:bind_evaluator(parameter)

    parameter.value = value
    parameter.ratio = ratio
    parameter.value_overrider = value_overrider
    parameter.ratio_overrider = ratio_overrider
    parameter.total_overrider = total_overrider

    return parameter
end

return CreateParameter