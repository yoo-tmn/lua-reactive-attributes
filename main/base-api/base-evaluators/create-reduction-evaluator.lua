local CreateEvaluator = require('main.core-api.attribute-api.create-evaluator')
local CreateAmountComponent = require('main.base-api.base-components.numerics.create-amount-component')
local CreateReductionComponent = require('main.base-api.base-components.numerics.create-reduction-component')
local CreateDiminishingEvaluator = require('main.base-api.base-evaluators.create-diminishing-evaluator')

--- @class ReductionEvaluator: Evaluator
--- @field flat_reduction AmountComponent
--- @field base_reduction ReductionComponent
--- @field diminishing DiminishingEvaluator
--- @field diminishing_rating AmountComponent
--- @field diminishing_factor AmountComponent

--- @param evaluator ReductionEvaluator
--- @param container Container
function EvaluateReduction(evaluator, container)
    local diminishing_reduction = container[evaluator.diminishing]
    if diminishing_reduction == nil or diminishing_reduction == 0 then
        return (container[evaluator.base_reduction] or 1) + (container[evaluator.flat_reduction] or 0)
    end
    return (container[evaluator.base_reduction] or 1) * (container[evaluator.diminishing] or 1) + (container[evaluator.flat_reduction] or 0)
end

--- @param is_local boolean?
--- @param base_diminishing_factor integer?
--- @return ReductionEvaluator
function CreateReductionEvaluator(base_diminishing_factor, is_local)
    local evaluator = CreateEvaluator(EvaluateReduction, is_local)
--- @cast evaluator ReductionEvaluator

    local flat_reduction = CreateAmountComponent()
    local base_reduction = CreateReductionComponent()
    local diminishing = CreateDiminishingEvaluator(base_diminishing_factor)

    diminishing:bind_evaluator(evaluator)
    flat_reduction:bind_evaluator(evaluator)
    base_reduction:bind_evaluator(evaluator)

    evaluator.diminishing = diminishing
    evaluator.flat_reduction = flat_reduction
    evaluator.base_reduction = base_reduction
    evaluator.diminishing_factor = diminishing.factor
    evaluator.diminishing_rating = diminishing.rating

    return evaluator
end

return CreateReductionEvaluator