local CreateEvaluator = require('main.core-api.attribute-api.create-evaluator')
local CreateCollectionComponent = require('main.base-api.base-components.create-collection-component')

--- @class OverriderEvaluator: Evaluator
--- @field collection CollectionComponent
--- @field comparator (fun(prev: table, next: table): any)?

--- @param evaluator OverriderEvaluator
--- @param container Container
function EvaluateOverrider(evaluator, container)
    return evaluator.collection:select(container, evaluator.comparator)
end

--- @param is_local boolean?
--- @param comparator (fun(prev: table, next: table): any)?
--- @return OverriderEvaluator
function CreateOverriderEvaluator(comparator, is_local)
    local evaluator = CreateEvaluator(EvaluateOverrider, is_local)
--- @cast evaluator OverriderEvaluator

    local collection = CreateCollectionComponent()
    collection:bind_evaluator(evaluator)
    evaluator.collection = collection
    evaluator.comparator = comparator

    return evaluator
end

return CreateOverriderEvaluator