local CreateComponent = require('main.core-api.attribute-api.create-component')

--- Modifying: arithmetic multiplication
--- #### Example:
--- ``` Lua
--- local damage_factor = CreateMultiplyingComponent()
--- container:apply(damage_factor, 0.20)    -- apply x1.20    120%    (100 * 120%)
--- container:apply(damage_factor, 0.30)    -- apply x1.30    160%    (100 * 120% * 130%)
--- container:apply(damage_factor, 0.25)    -- apply x1.25    200%    (100 * 120% * 130% * 125%)
--- container:purge(damage_factor, 0.30)    -- purge x1.30    150%    (100 * 120% * 125%)
--- ```
--- #### Also works with negative values:  
--- ``` Lua
--- container:apply(damage_factor, -0.2)    -- apply x0.80    80%    (100 * 80%)
--- container:apply(damage_factor, -0.3)    -- apply x0.70    56%    (100 * 80% * 70%)
--- ```
--- @class MultiplyingComponent: Component

function ApplyMultiplyingChange(_, prev, change)
    return (prev or 1) * change
end

function PurgeMultiplyingChange(_, prev, change)
    return (prev or 1) / change
end

--- Modifying: arithmetic multiplication
--- #### Example:
--- ``` Lua
--- local damage_factor = CreateMultiplyingComponent()
--- container:apply(damage_factor, 0.20)    -- apply x1.20    120%    (100 * 120%)
--- container:apply(damage_factor, 0.30)    -- apply x1.30    160%    (100 * 120% * 130%)
--- container:apply(damage_factor, 0.25)    -- apply x1.25    200%    (100 * 120% * 130% * 125%)
--- container:purge(damage_factor, 0.30)    -- purge x1.30    150%    (100 * 120% * 125%)
--- ```
--- #### Also works with negative values:  
--- ``` Lua
--- container:apply(damage_factor, -0.2)    -- apply x0.80    80%    (100 * 80%)
--- container:apply(damage_factor, -0.3)    -- apply x0.70    56%    (100 * 80% * 70%)
--- ```
--- @param evaluator Evaluator?
--- @param adjusting boolean?
--- @return MultiplyingComponent
function CreateMultiplyingComponent(evaluator, adjusting)
    return CreateComponent(ApplyMultiplyingChange, PurgeMultiplyingChange, evaluator, adjusting or true) --[[@as MultiplyingComponent]]
end

return CreateMultiplyingComponent