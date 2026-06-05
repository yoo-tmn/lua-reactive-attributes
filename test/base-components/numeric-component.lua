local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local LifeValue = ReactiveAttributes.CreateNumericComponent()
local LifeRatio = ReactiveAttributes.CreateNumericComponent()

local container = ReactiveAttributes.CreateContainer()
local compare = function(key, expected_value, next_step)
    Test.Check(container[key] == expected_value, next_step)
end



Test.Start('Numeric Component')

-- step #1
container:apply_change(LifeValue, 100)
compare(LifeValue, 100)

-- step #2
container:apply_change(LifeValue, 200)
compare(LifeValue, 300)

-- step #3
container:apply_change(LifeRatio, 10)
compare(LifeValue, 300, false)
compare(LifeRatio, 10)

-- step #4
container:purge_change(LifeRatio, 10)
compare(LifeValue, 300, false)
compare(LifeRatio, 0)

-- step #5
container:purge_change(LifeValue, 100)
compare(LifeValue, 200, false)
compare(LifeRatio, 0)

-- step #6
container:apply_change(LifeValue, 200)
compare(LifeValue, 400)

-- step #7
container:purge_change(LifeValue, 200)
compare(LifeValue, 200)

-- step #8
container:purge_change(LifeValue, 200)
compare(LifeValue, 0)

Test.Finish()