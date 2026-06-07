local CreateAttribute = require('main.core-api.attribute-api.create-attribute')

--- @alias EvaluateFn fun(evaluator: Evaluator, container: Container): boolean | number | integer | table | string | function

--- @class Evaluator: Attribute
--- @field evaluate EvaluateFn
--- @field is_global boolean
--- @field is_urgent boolean

--- @param evaluate EvaluateFn
--- @param is_global boolean?
--- @param is_urgent boolean?
--- @return Evaluator
function CreateEvaluator(evaluate, is_global, is_urgent)
    local evaluator = CreateAttribute()
--- @cast evaluator Evaluator

    if is_global or is_global == nil then
        evaluator.is_global = true
    else
        evaluator.is_global = false
    end

    if is_urgent or is_urgent == nil then
        evaluator.is_urgent = true
    else
        evaluator.is_urgent = false
    end

    evaluator.evaluate = evaluate
    return evaluator
end

return CreateEvaluator