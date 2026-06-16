local AttributeMT = require('main.core-api.attribute-api.attribute-mt')
local BaseComponents = require('main.base-api.components.export')

--- @class Reduction: Evaluator
--- @field flat CumulativeComponent
--- @field base ComplementComponent
--- @field rate DiminishingComponent
--- @field diminishing_constant integer

local ReductionComponentFactory = {
    flat = function(reduction)
        return BaseComponents.CreateCumulativeComponent(reduction)
    end,

    base = function(reduction)
        return BaseComponents.CreateComplementComponent(reduction)
    end,

    rate = function(reduction)
        return BaseComponents.CreateDiminishingComponent(reduction.diminishing_constant, reduction)
    end,
}

local ReductionMT = {
    __index = function(self, key)
        local factory = ReductionComponentFactory[key]
        if factory then
            local component = factory(self)
            rawset(self, key, component)
            return component
        end
        return AttributeMT[key]
    end,
}

--- @param reduction Reduction
--- @param container Container
function EvaluateReduction(reduction, container)
    local base_reduction = (rawget(reduction, 'base') and container[reduction.base]) or 0
    local flat_reduction = (rawget(reduction, 'flat') and container[reduction.flat]) or 0
    local reduction_rate = (rawget(reduction, 'rate') and container[reduction.rate]) or 0

    local total_reduction = (1 - (1 - base_reduction) * (1 - reduction_rate))
    if total_reduction < 0 then
        total_reduction = total_reduction - flat_reduction
    else
        total_reduction = total_reduction + flat_reduction
    end
    if total_reduction > 1 then
        return 1
    end
    return total_reduction
end

--- @param diminishing_constant integer?
--- @param is_local boolean?
--- @return Reduction
function CreateReduction(diminishing_constant, is_local)
    return setmetatable({
        is_local = is_local,
        evaluate = EvaluateReduction,
        diminishing_constant = diminishing_constant or 100,
    }, ReductionMT)
end

return CreateReduction