local CreateAttribute = require('main.core-api.attribute-api.create-attribute')

--- @alias ApplyChangeFn fun(component: Component, current: any, data: any)
--- @alias PurgeChangeFn fun(component: Component, current: any, data: any)

--- @class Component: Attribute
--- @field apply_change ApplyChangeFn
--- @field purge_change PurgeChangeFn
--- @field adjusting boolean

--- @return Component
--- @param apply_change ApplyChangeFn
--- @param purge_change PurgeChangeFn
--- @param evaluator Evaluator?
--- @param adjusting boolean?
function CreateComponent(apply_change, purge_change, evaluator, adjusting)
    local component = CreateAttribute() --[[@as Component]]
    component.apply_change = apply_change
    component.purge_change = purge_change
    component.adjusting = adjusting or false
    if evaluator then
        component:bind_evaluator(evaluator)
    end
    return component
end

return CreateComponent