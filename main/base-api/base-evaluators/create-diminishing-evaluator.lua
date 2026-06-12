local CreateEvaluator = require('main.core-api.attribute-api.create-evaluator')
local CreateAmountComponent = require('main.base-api.base-components.numerics.create-amount-component')

--- @class DiminishingEvaluator: Evaluator
--- @field rating AmountComponent
--- @field factor AmountComponent
--- @field base_factor integer

--- @param evaluator DiminishingEvaluator
--- @param container Container
function EvaluateDiminishing(evaluator, container)
    local rating = container[evaluator.rating]
    if rating == nil or rating == 0 then
        return 0
    end
    return rating / (rating + (container[evaluator.factor] or 0) + evaluator.base_factor)
end

--- @param base_factor integer?
--- @param is_local boolean?
--- @return DiminishingEvaluator
function CreateDiminishingEvaluator(base_factor, is_local)
    local evaluator = CreateEvaluator(EvaluateDiminishing, is_local)
--- @cast evaluator DiminishingEvaluator

    evaluator.base_factor = base_factor or 100
    local rating = CreateAmountComponent()
    local factor = CreateAmountComponent()

    rating:bind_evaluator(evaluator)
    factor:bind_evaluator(evaluator)

    evaluator.rating = rating
    evaluator.factor = factor

    return evaluator
end

return CreateDiminishingEvaluator