local AttachListener = require('main.core-api.listener-api.attach-listener')
local DetachListener = require('main.core-api.listener-api.detach-listener')
local NotifyListeners = require('main.core-api.listener-api.notify-listeners')
local UpdateContainer = require('main.core-api.container-api.update-container')
local ContainerHasEvaluator = require('main.core-api.container-api.container-has-evaluator')
local ContainerAppendEvaluator = require('main.core-api.container-api.container-append-evaluator')
local ContainerDeleteEvaluator = require('main.core-api.container-api.container-delete-evaluator')


--- @class Container
--- @field set fun(self: Container, attribute: Attribute, value: any)
--- @field update fun(self: Container)
--- @field attach_listener fun(self: Container, listener: Listener)
--- @field detach_listener fun(self: Container, listener: Listener)
--- @field apply_change fun(self: Container, component: Component, data: any, update: boolean?)
--- @field purge_change fun(self: Container, component: Component, data: any, update: boolean?)
--- @field listeners Listener[]?
--- @field append_evaluator fun(self: Container, evaluator: Evaluator)
--- @field delete_evaluator fun(self: Container, evaluator: Evaluator)
--- @field evaluators { [Evaluator]: boolean }?

local ContainerMT = {
    update = UpdateContainer,

    attach_listener = AttachListener,

    detach_listener = DetachListener,

    append_evaluator = ContainerAppendEvaluator,

    delete_evaluator = ContainerDeleteEvaluator,

    set = function(self, attribute, value)
        self[attribute] = value
        NotifyListeners(self, attribute)

        local bound_evaluators = attribute.bound_evaluators
        if type(bound_evaluators) ~= 'table' then
            return
        end

        local evaluator
        local queue = self.queue
        for n = 1, #bound_evaluators do
            evaluator = bound_evaluators[n]

            if not ContainerHasEvaluator(self, evaluator) then
                goto continue
            end

            if not queue[evaluator] then
                queue.tail = queue.tail + 1
                queue[evaluator] = true
                queue[queue.tail] = evaluator
            end

            ::continue::
        end
    end,

    apply_change = function(self, component, data, update)
        self:set(component, component:apply_change(self[component], data))
        if update or update == nil then self:update() end
    end,

    purge_change = function(self, component, data, update)
        self:set(component, component:purge_change(self[component], data))
        if update or update == nil then self:update() end
    end,
}
ContainerMT.__index = ContainerMT

--- @return Container
function CreateContainer()
    return setmetatable({
        queue = {
            head = 1,
            tail = 0,
        }
    }, ContainerMT)
end

return CreateContainer