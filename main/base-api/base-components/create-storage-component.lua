local CreateComponent = require('main.core-api.attribute-api.create-component')

function ApplyStorageChange(component, container, data)
    local storage = container[component]
    if type(storage) ~= 'table' then
        container[component] = { data }
    else
        storage[#storage + 1] = data
    end
end

function PurgeStorageChange(component, container, data)
    local storage = container[component]
    if type(storage) ~= 'table' then
        return
    end
    for n = 1, #storage do
        if storage[n] == data then
            table.remove(storage, n)
            break
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