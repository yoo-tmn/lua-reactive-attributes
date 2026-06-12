local CreateComponent = require('main.core-api.attribute-api.create-component')

--- @class CounterComponent: Component

function ApplyCounterChange(_, prev, _)
    return (prev or 0) + 1
end

function PurgeCounterChange(_, prev, _)
    return (prev or 0) - 1
end

--- @return CounterComponent
function CreateCounterComponent()
    local component = CreateComponent(ApplyCounterChange, PurgeCounterChange)
--- @cast component CounterComponent
    return component
end

return CreateCounterComponent