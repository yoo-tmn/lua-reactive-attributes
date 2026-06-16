local CreateAttribute = require('main.core-api.attribute-api.create-attribute')

--- @alias Evaluate fun(evaluator: Evaluator, container: Container): boolean | number | integer | table | string | function

--- @class Evaluator: Attribute
--- @field evaluate Evaluate
--- @field is_local boolean?

--- @param evaluate Evaluate
--- @param is_local boolean?
--- @return Evaluator
function CreateEvaluator(evaluate, is_local)
    local evaluator = CreateAttribute() --[[@as Evaluator]]

    evaluator.is_local = is_local
    evaluator.evaluate = evaluate

    return evaluator
end

return CreateEvaluator