local CreateAttribute = require('main.core-api.attribute-api.create-attribute')

--- @alias ApplyChangeFn fun(component: Component, current: any, data: any)
--- @alias PurgeChangeFn fun(component: Component, current: any, data: any)

--- @class Component: Attribute
--- @field apply_change ApplyChangeFn
--- @field purge_change PurgeChangeFn

--- @return Component
--- @param apply_change ApplyChangeFn
--- @param purge_change PurgeChangeFn
--- @param evaluator Evaluator?
function CreateComponent(apply_change, purge_change, evaluator)
    local component = CreateAttribute() --[[@as Component]]
    component.apply_change = apply_change
    component.purge_change = purge_change
    if evaluator then
        component:bind_evaluator(evaluator)
    end
    return component
end

return CreateComponent