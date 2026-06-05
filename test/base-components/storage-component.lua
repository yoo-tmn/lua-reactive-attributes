local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local LifeOverrider = ReactiveAttributes.CreateStorageComponent()
local ManaOverrider = ReactiveAttributes.CreateStorageComponent()

local container = ReactiveAttributes.CreateContainer()
local compare = function(key, index, expected_value, next_step)
    Test.Check(container[key][index] == expected_value, next_step)
end



Test.Start('Storage Component')

-- step #1
container:apply_change(LifeOverrider, 100)
compare(LifeOverrider, 1, 100)

-- step #2
container:apply_change(LifeOverrider, 200)
compare(LifeOverrider, 1, 100, false)
compare(LifeOverrider, 2, 200)

-- step #3
container:apply_change(ManaOverrider, 100)
compare(LifeOverrider, 1, 100, false)
compare(LifeOverrider, 2, 200, false)
compare(ManaOverrider, 1, 100)

-- step #4
container:apply_change(ManaOverrider, 200)
compare(LifeOverrider, 1, 100, false)
compare(LifeOverrider, 2, 200, false)
compare(ManaOverrider, 1, 100, false)
compare(ManaOverrider, 2, 200)

-- step #5
container:purge_change(LifeOverrider, 100)
compare(LifeOverrider, 1, 200, false)
compare(ManaOverrider, 1, 100, false)
compare(ManaOverrider, 2, 200)

-- step #6
container:purge_change(ManaOverrider, 200)
compare(LifeOverrider, 1, 200, false)
compare(ManaOverrider, 1, 100)

-- step #7
container:purge_change(LifeOverrider, 200)
container:purge_change(ManaOverrider, 100)
compare(LifeOverrider, 1, nil, false)
compare(ManaOverrider, 1, nil)

Test.Finish()