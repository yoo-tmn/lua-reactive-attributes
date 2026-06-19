local CreateComponent = require('main.core-api.attribute-api.create-component')

--- Modifying: Tends to 100% according to the rules of diminishing returns 
--- #### Example:
--- ``` Lua
--- local attack_speed = CreateDiminishingComponent(100) -- here 100 is diminishing constant
--- container:apply(attack_speed,  25)    -- apply 25     result:  25/125    20%
--- container:apply(attack_speed, 125)    -- apply 100    result: 150/250    60%
--- container:apply(attack_speed, 250)    -- apply 250    result: 400/500    80%
--- container:purge(attack_speed, 125)    -- purge 125    result: 275/375   ~73%
--- ```
--- Also works with negative numbers
--- @class DiminishingComponent: Component
--- @field constant integer

function ApplyDiminishingChange(component, prev, change)
    if prev == nil or prev == 0 then
        return change / (change + component.constant)
    end

    local value = component.constant * prev / (1 - (prev > 0 and prev or -prev)) + change
    return value / (component.constant + (value > 0 and value or -value))
end

function PurgeDiminishingChange(component, prev, change)
    if prev == nil or prev == 0 then
        return change / (change + component.constant)
    end

    local value = component.constant * prev / (1 - (prev > 0 and prev or -prev)) - change
    return value / (component.constant + (value > 0 and value or -value))
end

--- Modifying: Tends to 100% according to the rules of diminishing returns 
--- #### Example:
--- ``` Lua
--- local attack_speed = CreateDiminishingComponent(100) -- here 100 is diminishing constant
--- container:apply(attack_speed,  25)    -- apply 25     result:  25/125    20%
--- container:apply(attack_speed, 125)    -- apply 100    result: 150/250    60%
--- container:apply(attack_speed, 250)    -- apply 250    result: 400/500    80%
--- container:purge(attack_speed, 125)    -- purge 125    result: 275/375   ~73%
--- ```
--- Also works with negative numbers
--- @param constant integer?
--- @param evaluator Evaluator?
--- @param adjusting boolean?
--- @return DiminishingComponent
function CreateDiminishingComponent(constant, evaluator, adjusting)
    local component = CreateComponent(ApplyDiminishingChange, PurgeDiminishingChange, evaluator, adjusting or true) --[[@as DiminishingComponent]]
    component.constant = constant or 100
    return component
end

return CreateDiminishingComponent