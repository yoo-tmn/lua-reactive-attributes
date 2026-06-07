--- @param container Container
--- @param evaluator Evaluator
function ContainerHasEvaluator(container, evaluator)
    if evaluator.is_global then
        return true
    end
    local evaluators = container.evaluators
    if type(evaluators) ~= 'table' then
        return false
    end
    return evaluators[evaluator]
end

return ContainerHasEvaluator