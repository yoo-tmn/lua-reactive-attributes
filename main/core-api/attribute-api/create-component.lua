local CreateAttribute = require('main.core-api.attribute-api.create-attribute')

--- @alias ApplyChangeFn fun(component: Component, current: any, data: any)
--- @alias PurgeChangeFn fun(component: Component, current: any, data: any)

--- @class Component: Attribute
--- @field apply_change ApplyChangeFn
--- @field purge_change PurgeChangeFn

--- @return Component
--- @param apply_change ApplyChangeFn
--- @param purge_change PurgeChangeFn
function CreateComponent(apply_change, purge_change)
    local component = CreateAttribute()
--- @cast component Component

    component.apply_change = apply_change
    component.purge_change = purge_change
    return component
end

return CreateComponent