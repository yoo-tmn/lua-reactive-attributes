local CreateComponent = require('main.core-api.attribute-api.create-component')

function ApplyNumericChange(component, current, data)
    return (current or 0) + data
end

function PurgeNumericChange(component, current, data)
    return (current or 0) - data
end

--- @class NumericComponent: Component

--- @return NumericComponent
function CreateNumericComponent()
    local component = CreateComponent(ApplyNumericChange, PurgeNumericChange)
--- @cast component NumericComponent
    return component
end

return CreateNumericComponent