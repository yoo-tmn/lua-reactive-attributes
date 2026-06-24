local CreateEvaluator = require('main.core-api.attribute-api.create-evaluator')

--- @param fn Evaluate
--- @param ... Attribute[]
function Evaluate(fn, ...)
    local evaluator = CreateEvaluator(fn)
    local attribute
    for n = 1, select('#', ...) do
        attribute = select(n, ...) --[[@as Attribute]]
        attribute:bind_evaluator(evaluator)
    end
    return evaluator
end

return Evaluate