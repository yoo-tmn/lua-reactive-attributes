local AttachListener = require('main.core-api.listener-api.attach-listener')
local DetachListener = require('main.core-api.listener-api.detach-listener')

--- @class Attribute: Reactive
--- @field bind_evaluator  fun(self: Attribute, evaluator: Evaluator)

local AttributeMT = {
    attach_listener = AttachListener,

    detach_listener = DetachListener,

    bind_evaluator = function(self, evaluator)
        local bound_evaluators = self.bound_evaluators
        if type(bound_evaluators) ~= 'table' then
            self.bound_evaluators = { evaluator }
        else
            bound_evaluators[#bound_evaluators + 1] = evaluator
        end
    end,
}
AttributeMT.__index = AttributeMT

--- @return Attribute
function CreateAttribute()
    return setmetatable({ }, AttributeMT)
end

return CreateAttribute