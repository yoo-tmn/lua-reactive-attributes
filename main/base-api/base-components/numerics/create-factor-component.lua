local CreateComponent = require('main.core-api.attribute-api.create-component')

--- @class FactorComponent: Component

function ApplyFactorChange(_, prev, change)
    return (prev or 1) * change
end

function PurgeFactorChange(_, prev, change)
    return (prev or 1) / change
end

--- @return FactorComponent
function CreateFactorComponent()
    local component = CreateComponent(ApplyFactorChange, PurgeFactorChange)
--- @cast component FactorComponent
    return component
end

return CreateFactorComponent