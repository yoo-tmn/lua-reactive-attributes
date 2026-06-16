local CreateComponent = require('main.core-api.attribute-api.create-component')

--- Modifying: simply stores provided data in a list
--- #### Example:
--- ``` Lua
--- local life_overrider = CreateCollectionComponent()
--- container:apply(life_overrider, 100) -- apply 100   result: { 100 }
--- container:apply(life_overrider, 200) -- apply 200   result: { 100, 200 }
--- container:purge(life_overrider, 100) -- purge 100   result: { 200 }
--- ```
--- Actually does not create a list for first element.  
--- Use methods `:get_head`, `:get_tail` and `:select(comparator)` for aggregation
--- @class CollectionComponent: Component
--- @field get_head fun(self: CollectionComponent, container: Container)
--- @field get_tail fun(self: CollectionComponent, container: Container)
--- @field select fun(self: CollectionComponent, container: Container, comparator: fun(prev, next): any)

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

function CollectionSelect(collection, container, comparator)
    local data = container[collection]

    if not IsCollection(data) then
       return data
    end

    local result = data[1]
    for n = 2, #data do
        result = comparator(result, data[n])
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

--- Modifying: simply stores provided data in a list
--- #### Example:
--- ``` Lua
--- local life_overrider = CreateCollectionComponent()
--- container:apply(life_overrider, 100) -- apply 100   result: { 100 }
--- container:apply(life_overrider, 200) -- apply 200   result: { 100, 200 }
--- container:purge(life_overrider, 100) -- purge 100   result: { 200 }
--- ```
--- Actually does not create a list for first element.  
--- Use methods `:get_head`, `:get_tail` and `:select(comparator)` for aggregation
--- @param evaluator Evaluator?
--- @return CollectionComponent
function CreateCollectionComponent(evaluator)
    local component = CreateComponent(ApplyCollectionChange, PurgeCollectionChange, evaluator) --[[@as CollectionComponent]]
    component.get_head = CollectionGetHead
    component.get_tail = CollectionGetTail
    component.select = CollectionSelect
    return component
end

return CreateCollectionComponent