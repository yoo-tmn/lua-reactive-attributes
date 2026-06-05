local CreateEvaluator = require('main.core-api.attribute-api.create-evaluator')
local CreateNumericComponent = require('main.base-api.base-components.create-numeric-component')
local CreateProductComponent = require('main.base-api.base-components.create-product-component')

--- @param reduction Reduction
--- @param container Container
function EvaluateReduction(reduction, container)
    local final_reduction = container[reduction.final_reduction] or 0
    local basic_reduction = container[reduction.basic_reduction] or 0
    local diminishing_rating = container[reduction.diminishing_rating] or 0
    local diminishing_factor = container[reduction.diminishing_factor] or 0
    diminishing_factor = diminishing_factor + reduction.base_diminishing_factor

    return basic_reduction * (diminishing_rating / (diminishing_rating + diminishing_factor)) + final_reduction
end

--- @class Reduction: Evaluator
--- @field base_diminishing_factor integer
--- @field final_reduction NumericComponent
--- @field basic_reduction ProductComponent
--- @field diminishing_rating NumericComponent
--- @field diminishing_factor NumericComponent

--- @param base_diminishing_factor integer?
--- @return Reduction
function CreateReduction(base_diminishing_factor)
    local reduction = CreateEvaluator(EvaluateReduction)
--- @cast reduction Reduction

    reduction.base_diminishing_factor = base_diminishing_factor or 100
    local final_reduction = CreateNumericComponent()
    local basic_reduction = CreateProductComponent(true)
    local diminishing_rating = CreateNumericComponent()
    local diminishing_factor = CreateNumericComponent()

    final_reduction:bind_evaluator(reduction)
    basic_reduction:bind_evaluator(reduction)
    diminishing_rating:bind_evaluator(reduction)
    diminishing_factor:bind_evaluator(reduction)

    reduction.final_reduction = final_reduction
    reduction.basic_reduction = basic_reduction
    reduction.diminishing_factor = diminishing_factor
    reduction.diminishing_rating = diminishing_rating

    return reduction
end

return CreateReduction