local CreateComponent = require('main.core-api.attribute-api.create-component')

--- Modifying Method: Multiplication by complement (1 - change)
--- #### Example:
--- ``` Lua
--- local damage_reduction = CreateComplementComponent()
--- container:apply(damage_reduction,  0.2) -- apply +20%   result: 20%
--- container:apply(damage_reduction,  0.3) -- apply +30%   result: 44%
--- container:apply(damage_reduction,  0.5) -- apply +50%   result: 72%
--- container:apply(damage_reduction, -0.5) -- apply -50%   result: 58%
--- ```
--- @class ComplementComponent: Component

function ApplyComplementChange(_, prev, change)
    return 1 - ((1 - (prev or 0)) * (1 - change))
end

function PurgeComplementChange(_, prev, change)
    return 1 - ((1 - (prev or 0)) / (1 - change))
end

--- Modifying Method: Multiplication by complement (1 - change)
--- #### Example:
--- ``` Lua
--- local damage_reduction = CreateComplementComponent()
--- container:apply(damage_reduction,  0.2) -- apply +20%   result: 20%
--- container:apply(damage_reduction,  0.3) -- apply +30%   result: 44%
--- container:apply(damage_reduction,  0.5) -- apply +50%   result: 72%
--- container:apply(damage_reduction, -0.5) -- apply -50%   result: 58%
--- ```
--- @param evaluator Evaluator?
--- @param adjusting boolean?
--- @return ComplementComponent
function CreateComplementComponent(evaluator, adjusting)
    return CreateComponent(ApplyComplementChange, PurgeComplementChange, evaluator, adjusting or true) --[[@as ComplementComponent]]
end

return CreateComplementComponent