local CreateEvaluator = require('main.core-api.attribute-api.create-evaluator')
local CreateStorageComponent = require('main.base-api.base-components.create-storage-component')

--- @param overrider Overrider
--- @param container Container
function EvaluateOverrider(overrider, container)
    local storage = container[overrider.storage]
    if type(storage) ~= 'table' then
        return nil
    end

    if #storage == 0 then
        return nil
    end

    if not overrider.compare then
        return storage[#storage]
    end

    local result = storage[1]
    for n = 2, #storage do
        result = overrider.compare(result, storage[n])
    end
    return result
end

--- @class Overrider: Evaluator
--- @field storage StorageComponent
--- @field compare (fun(prev: table, next: table): boolean)?

--- @param is_global boolean?
--- @param is_urgent boolean?
--- @param compare (fun(prev: table, next: table): boolean)?
--- @return Overrider
function CreateOverrider(compare, is_global, is_urgent)
    local overrider = CreateEvaluator(EvaluateOverrider, is_global, is_urgent)
--- @cast overrider Overrider

    local storage = CreateStorageComponent()

    storage:bind_evaluator(overrider)

    overrider.storage = storage
    overrider.compare = compare

    return overrider
end

return CreateOverrider