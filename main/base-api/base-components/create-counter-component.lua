local CreateComponent = require('main.core-api.attribute-api.create-component')

function ApplyCounterChange(component, container)
    container[component] = (container[component] or 0) + 1
end

function PurgeCounterChange(component, container)
    container[component] = (container[component] or 0) - 1
end

--- @class CounterComponent: Component

--- @return CounterComponent
function CreateCounterComponent()
    local component = CreateComponent(ApplyCounterChange, PurgeCounterChange)
--- @cast component CounterComponent
    return component
end

return CreateCounterComponent