local CreateAttribute = require('main.core-api.attribute-api.create-attribute')

--- @alias EvaluateFn fun(evaluator: Evaluator, container: Container): boolean | number | integer | table | string | function

--- @class Evaluator: Attribute
--- @field evaluate EvaluateFn

--- @param evaluate EvaluateFn
--- @return Evaluator
function CreateEvaluator(evaluate)
    local evaluator = CreateAttribute()
--- @cast evaluator Evaluator

    evaluator.evaluate = evaluate
    return evaluator
end

return CreateEvaluator