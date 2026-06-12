local CreateComponent = require('main.core-api.attribute-api.create-component')

--- @class ReductionComponent: Component

function ApplyReductionChange(_, prev, change)
    return 1 - ((1 - (prev or 0)) * (1 - change))
end

function PurgeReductionChange(_, prev, change)
    return 1 - ((1 - (prev or 0)) / (1 - change))
end

--- @return ReductionComponent
function CreateReductionComponent()
    local component = CreateComponent(ApplyReductionChange, PurgeReductionChange)
--- @cast component ReductionComponent
    return component
end

return CreateReductionComponent