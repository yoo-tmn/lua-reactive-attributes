local CreateComponent = require('main.core-api.attribute-api.create-component')

--- @param current number
--- @param applied number
--- @param component ProductComponent
function ApplyProductChange(component, current, applied)
    if component.is_reduction then
        return (current or 1) * (1 - applied)
    else
        return (current or 1) * applied
    end
end

--- @param current number
--- @param applied number
--- @param component ProductComponent
function PurgeProductChange(component, current, applied)
    if component.is_reduction then
        return (current or 1) / (1 - applied)
    else
        return (current or 1) / applied
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