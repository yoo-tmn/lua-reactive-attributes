--- @param container Container
--- @param evaluator Evaluator
function ContainerDetachEvaluator(container, evaluator)
    local evaluators = container.evaluators
    if type(evaluators) ~= 'table' then
        return
    end
    evaluators[evaluator] = nil
    container:set(evaluator, nil)
end

return ContainerDetachEvaluator