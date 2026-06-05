local CreateComponent = require('main.core-api.attribute-api.create-component')

function ApplyNumericChange(component, current, applied)
    return (current or 0) + applied
end

function PurgeNumericChange(component, current, applied)
    return (current or 0) - applied
end

--- @class NumericComponent: Component

--- @return NumericComponent
function CreateNumericComponent()
    local component = CreateComponent(ApplyNumericChange, PurgeNumericChange)
--- @cast component NumericComponent
    return component
end

return CreateNumericComponent