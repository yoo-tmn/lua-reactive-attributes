local CreateComponent = require('main.core-api.attribute-api.create-component')

--- @class AmountComponent: Component

function ApplyAmountChange(_, prev, change)
    return (prev or 0) + change
end

function PurgeAmountChange(_, prev, change)
    return (prev or 0) - change
end

--- @return AmountComponent
function CreateAmountComponent()
    local component = CreateComponent(ApplyAmountChange, PurgeAmountChange)
--- @cast component AmountComponent
    return component
end

return CreateAmountComponent