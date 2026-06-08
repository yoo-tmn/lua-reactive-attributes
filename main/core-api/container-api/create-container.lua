local AttachListener = require('main.core-api.listener-api.attach-listener')
local DetachListener = require('main.core-api.listener-api.detach-listener')
local NotifyListeners = require('main.core-api.listener-api.notify-listeners')
local UpdateContainer = require('main.core-api.container-api.update-container')
local ContainerSetAttribute = require('main.core-api.container-api.container-set-attribute')
local ContainerHasEvaluator = require('main.core-api.container-api.container-has-evaluator')
local ContainerAttachEvaluator = require('main.core-api.container-api.container-attach-evaluator')
local ContainerDetachEvaluator = require('main.core-api.container-api.container-detach-evaluator')


--- @class Container
--- @field set fun(self: Container, attribute: Attribute, value: any)
--- @field update fun(self: Container)
--- @field attach_listener fun(self: Container, listener: Listener)
--- @field detach_listener fun(self: Container, listener: Listener)
--- @field apply_change fun(self: Container, component: Component, data: any, update: boolean?)
--- @field purge_change fun(self: Container, component: Component, data: any, update: boolean?)
--- @field listeners Listener[]?
--- @field has_evaluator fun(self: Container, evaluator: Evaluator): boolean
--- @field attach_evaluator fun(self: Container, evaluator: Evaluator)
--- @field detach_evaluator fun(self: Container, evaluator: Evaluator)
--- @field evaluators { [Evaluator]: boolean }?

local ContainerMT = {
    update = UpdateContainer,

    attach_listener = AttachListener,

    detach_listener = DetachListener,

    attach_evaluator = ContainerAttachEvaluator,

    detach_evaluator = ContainerDetachEvaluator,

    has_evaluator = ContainerHasEvaluator,

    set = ContainerSetAttribute,

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