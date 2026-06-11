local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local LifeOverrider = ReactiveAttributes.CreateStorageComponent()
local ManaOverrider = ReactiveAttributes.CreateStorageComponent()

local container = ReactiveAttributes.CreateContainer()
local compare = function(key, index, expected_value)
    Test.Compare(container[key][index], expected_value)
end

function TestStorageComponent()
    Test.Start('Storage Component')

    -- test #1
    container:apply_change(LifeOverrider, 100)
    compare(LifeOverrider, 1, 100)

    -- test #2
    container:apply_change(LifeOverrider, 200)
    compare(LifeOverrider, 1, 100)
    -- test #3
    compare(LifeOverrider, 2, 200)

    -- test #4
    container:apply_change(ManaOverrider, 100)
    compare(LifeOverrider, 1, 100)
    -- test #5
    compare(LifeOverrider, 2, 200)
    -- test #6
    compare(ManaOverrider, 1, 100)

    -- test #7
    container:apply_change(ManaOverrider, 200)
    compare(LifeOverrider, 1, 100)
    -- test #8
    compare(LifeOverrider, 2, 200)
    -- test #9
    compare(ManaOverrider, 1, 100)
    -- test #10
    compare(ManaOverrider, 2, 200)

    -- test #11
    container:purge_change(LifeOverrider, 100)
    compare(LifeOverrider, 1, 200)
    -- test #12
    compare(ManaOverrider, 1, 100)
    -- test #13
    compare(ManaOverrider, 2, 200)

    -- test #14
    container:purge_change(ManaOverrider, 200)
    compare(LifeOverrider, 1, 200)
    -- test #15
    compare(ManaOverrider, 1, 100)

    -- test #16
    container:purge_change(LifeOverrider, 200)
    container:purge_change(ManaOverrider, 100)
    compare(LifeOverrider, 1, nil)
    -- test #17
    compare(ManaOverrider, 1, nil)

    Test.Finish()
end

return TestStorageComponent