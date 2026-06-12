local CreateComponent = require('main.core-api.attribute-api.create-component')

--- @class CollectionComponent: Component
--- @field get_head fun(self: CollectionComponent, container: Container)
--- @field get_tail fun(self: CollectionComponent, container: Container)
--- @field select fun(self: CollectionComponent, container: Container, compare: fun(prev, next): any)

local IS_COLLECTION = { }

function IsCollection(value)
    return type(value) == 'table' and value[IS_COLLECTION] == true
end

function ApplyCollectionChange(_, prev, change)
    if prev == nil then
        return change
    end

    if not IsCollection(prev) then
        local collection = { prev, change }
        collection[IS_COLLECTION] = true
        return collection
    end

    prev[#prev + 1] = change
    return prev
end

function PurgeCollectionChange(_, prev, change)
    if not IsCollection(prev) then
        if prev == change then
            return nil
        end
        return prev
    end

    for n = 1, #prev do
        if prev[n] == change then
            table.remove(prev, n)
            return prev
        end
    end
    return prev
end

function CollectionSelect(collection, container, compare)
    local data = container[collection]

    if not IsCollection(data) then
       return data
    end

    local result = data[1]
    for n = 2, #data do
        result = compare(result, data[n])
    end
    return result
end

function CollectionGetHead(collection, container)
    local data = container[collection]

    if not IsCollection(data) then
        return data
    end

    if #data == 0 then
        return nil
    end
    return data[1]
end

function CollectionGetTail(collection, container)
    local data = container[collection]

    if not IsCollection(data) then
        return data
    end

    if #data == 0 then
        return nil
    end
    return data[#data]
end

--- @return CollectionComponent
function CreateCollectionComponent()
    local component = CreateComponent(ApplyCollectionChange, PurgeCollectionChange)
--- @cast component CollectionComponent
    component.get_head = CollectionGetHead
    component.get_tail = CollectionGetTail
    component.select = CollectionSelect
    return component
end

return CreateCollectionComponent