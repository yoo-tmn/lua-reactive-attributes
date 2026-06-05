local AttachListener = require('main.core-api.listener-api.attach-listener')
local DetachListener = require('main.core-api.listener-api.detach-listener')
local NotifyContainer = require('main.core-api.container-api.notify-container')
local UpdateContainer = require('main.core-api.container-api.update-container')

--- @class Container
--- @field update fun(self: Container)
--- @field attach_listener fun(self: Container, listener: Listener)
--- @field detach_listener fun(self: Container, listener: Listener)
--- @field apply_change fun(self: Container, component: Component, data: any, update: boolean?)
--- @field purge_change fun(self: Container, component: Component, data: any, update: boolean?)
--- @field listeners Listener[]?

local ContainerMT = {
    update = UpdateContainer,

    attach_listener = AttachListener,

    detach_listener = DetachListener,

    apply_change = function(self, component, data, update)
        component:apply_change(self, data)
        NotifyContainer(self, component)

        if update or update == nil then
            self:update()
        end
    end,

    purge_change = function(self, component, data, update)
        component:purge_change(self, data)
        NotifyContainer(self, component)

        if update or update == nil then
            self:update()
        end
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