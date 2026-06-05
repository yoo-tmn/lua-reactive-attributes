local CreateComponent = require('main.core-api.attribute-api.create-component')

--- @param component ProductComponent
function ApplyProductChange(component, current, data)
    if component.is_reduction then
        return (current or 1) * (1 - data)
    else
        return (current or 1) * data
    end
end

--- @param component ProductComponent
function PurgeProductChange(component, current, data)
    if component.is_reduction then
        return (current or 1) / (1 - data)
    else
        return (current or 1) / data
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