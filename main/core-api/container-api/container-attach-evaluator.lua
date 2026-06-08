--- @param container Container
--- @param evaluator Evaluator
function ContainerAttachEvaluator(container, evaluator)
    local evaluators = container.evaluators
    if type(evaluators) ~= 'table' then
        evaluators = { }
        container.evaluators = evaluators
    end
    evaluators[evaluator] = true
    container:set(evaluator, evaluator:evaluate(container))
end

return ContainerAttachEvaluator