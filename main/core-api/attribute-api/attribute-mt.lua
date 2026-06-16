local AttachListener = require('main.core-api.listener-api.attach-listener')
local DetachListener = require('main.core-api.listener-api.detach-listener')

--- @class Attribute: Reactive
--- @field bind_evaluator fun(self: Attribute, evaluator: Evaluator)
--- @field bound_evaluators Evaluator[]?

local AttributeMT = {
    bind_evaluator = function(attribute, evaluator)
        local bound_evaluators = attribute.bound_evaluators
        if type(bound_evaluators) ~= 'table' then
            attribute.bound_evaluators = { evaluator }
        else
            bound_evaluators[#bound_evaluators + 1] = evaluator
        end
    end,
    attach_listener = AttachListener,
    detach_listener = DetachListener,
}
AttributeMT.__index = AttributeMT

return AttributeMT