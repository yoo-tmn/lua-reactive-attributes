--- @class ModifierTag
--- @field disabled CumulativeComponent
--- @field efficiency CumulativeComponent

local BaseComponents = require('main.base-api.components.export')

--- @return ModifierTag
function CreateModifierTag()
    return {
        disabled = BaseComponents.CreateCumulativeComponent(nil, false),
        efficiency = BaseComponents.CreateCumulativeComponent(nil, false),
    }
end

return CreateModifierTag