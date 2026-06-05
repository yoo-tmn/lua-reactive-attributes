local CreateComponent = require('main.core-api.attribute-api.create-component')

--- @param container Container
--- @param component ProductComponent
function ApplyProductChange(component, container, data)
    if component.is_reduction then
        container[component] = (container[component] or 1) * (1 - data)
    else
        container[component] = (container[component] or 1) * data
    end
end

--- @param container Container
--- @param component ProductComponent
function PurgeProductChange(component, container, data)
    if component.is_reduction then
        container[component] = (container[component] or 1) / (1 - data)
    else
        container[component] = (container[component] or 1) / data
    end
end

--- @class ProductComponent: Component
--- @field is_reduction boolean?

--- @param is_reduction boolean?
--- @return ProductComponent
function CreateProductComponent(is_reduction)
    local component = CreateComponent(ApplyProductChange, PurgeProductChange)
--- @cast component ProductComponent
    component.is_reduction = is_reduction
    return component
end

return CreateProductComponent