local CreateComponent = require('main.core-api.attribute-api.create-component')

function ApplyStorageChange(component, current, applied)
    if type(current) ~= 'table' then
        return { applied }
    else
        current[#current + 1] = applied
        return current
    end
end

function PurgeStorageChange(component, current, applied)
    if type(current) ~= 'table' then
        return nil
    end
    for n = 1, #current do
        if current[n] == applied then
            table.remove(current, n)
            return current
        end
    end
end

--- @class StorageComponent: Component

--- @return StorageComponent
function CreateStorageComponent()
    local component = CreateComponent(ApplyStorageChange, PurgeStorageChange)
--- @cast component StorageComponent
    return component
end

return CreateStorageComponent