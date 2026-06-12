local CreateEvaluator = require('main.core-api.attribute-api.create-evaluator')
local CreateAmountComponent = require('main.base-api.base-components.numerics.create-amount-component')
local CreateFactorComponent = require('main.base-api.base-components.numerics.create-factor-component')
local CreateOverriderEvaluator = require('main.base-api.base-evaluators.create-overrider-evaluator')

--- @class ParameterEvaluator: Evaluator
--- @field add_amount AmountComponent
--- @field add_factor AmountComponent
--- @field mul_factor FactorComponent
--- @field add_soft_overrider CollectionComponent
--- @field add_hard_overrider CollectionComponent
--- @field soft_overrider OverriderEvaluator
--- @field hard_overrider OverriderEvaluator

--- @param evaluator ParameterEvaluator
--- @param container Container
function EvaluateParameter(evaluator, container)
    local hard_overrider = container[evaluator.hard_overrider]
    if hard_overrider then
        return hard_overrider.value
    end

    local amount
    local factor

    local soft_overrider = container[evaluator.soft_overrider]
    if soft_overrider then
        amount = soft_overrider.value or 0
    else
        amount = container[evaluator.add_amount]
    end
    factor = (1 + (container[evaluator.add_factor] or 0)) * (container[evaluator.mul_factor] or 1)
    return amount * factor
end

--- @param is_local boolean?
--- @return ParameterEvaluator
function CreateParameterEvaluator(is_local)
    local evaluator = CreateEvaluator(EvaluateParameter, is_local)
--- @cast evaluator ParameterEvaluator

    local add_amount = CreateAmountComponent()
    local add_factor = CreateAmountComponent()
    local mul_factor = CreateFactorComponent()
    local soft_overrider = CreateOverriderEvaluator()
    local hard_overrider = CreateOverriderEvaluator()

    add_amount:bind_evaluator(evaluator)
    add_factor:bind_evaluator(evaluator)
    mul_factor:bind_evaluator(evaluator)
    soft_overrider:bind_evaluator(evaluator)
    hard_overrider:bind_evaluator(evaluator)

    evaluator.add_amount = add_amount
    evaluator.add_factor = add_factor
    evaluator.mul_factor = mul_factor
    evaluator.add_soft_overrider = soft_overrider.collection
    evaluator.add_hard_overrider = hard_overrider.collection

    evaluator.soft_overrider = soft_overrider
    evaluator.hard_overrider = hard_overrider

    return evaluator
end

return CreateParameterEvaluator