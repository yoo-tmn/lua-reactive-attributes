local CreateComponent = require('main.core-api.attribute-api.create-component')

--- Modifying: arithmetic addition
--- #### Example:
--- ``` Lua
--- local life_base_value = CreateCumulativeComponent()
--- container:apply(life_base_value, 100)    -- apply +100    100
--- container:apply(life_base_value, 200)    -- apply +200    300
--- container:apply(life_base_value, -50)    -- apply -50     250
--- container:purge(life_base_value, 100)    -- purge +100    150
--- ```
--- @class CumulativeComponent: Component

function ApplyCumulativeChange(_, prev, change) return (prev or 0) + change end

function PurgeCumulativeChange(_, prev, change) return (prev or 0) - change end

--- Modifying: arithmetic addition
--- #### Example:
--- ``` Lua
--- local life_base_value = CreateCumulativeComponent()
--- container:apply(life_base_value, 100)    -- apply +100    100
--- container:apply(life_base_value, 200)    -- apply +200    300
--- container:apply(life_base_value, -50)    -- apply -50     250
--- container:purge(life_base_value, 100)    -- purge +100    150
--- ```
--- @param evaluator Evaluator?
--- @param adjusting boolean?
--- @return CumulativeComponent
function CreateCumulativeComponent(evaluator, adjusting)
    return CreateComponent(ApplyCumulativeChange, PurgeCumulativeChange, evaluator, adjusting or true) --[[@as CumulativeComponent]]
end

return CreateCumulativeComponent