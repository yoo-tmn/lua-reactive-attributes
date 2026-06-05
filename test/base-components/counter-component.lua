local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local StunCounter = ReactiveAttributes.CreateCounterComponent()
local SlowCounter = ReactiveAttributes.CreateCounterComponent()

local container = ReactiveAttributes.CreateContainer()
local compare = function(key, expected_value, next_step)
    Test.Check(container[key] == expected_value, next_step)
end



Test.Start('Counter Component')

-- step #1
container:apply_change(StunCounter, nil)
compare(StunCounter, 1)

-- step #2
container:apply_change(StunCounter, nil)
compare(StunCounter, 2)

-- step #3
container:apply_change(SlowCounter, nil)
compare(StunCounter, 2, false)
compare(SlowCounter, 1)

-- step #4
container:apply_change(SlowCounter, nil)
compare(StunCounter, 2, false)
compare(SlowCounter, 2)

-- step #5
container:purge_change(StunCounter, nil)
compare(StunCounter, 1, false)
compare(SlowCounter, 2)

-- step #6
container:purge_change(SlowCounter, nil)
compare(StunCounter, 1, false)
compare(SlowCounter, 1)

-- step #7
container:purge_change(StunCounter, nil)
compare(StunCounter, 0, false)
compare(SlowCounter, 1)

-- step #8
container:purge_change(SlowCounter, nil)
compare(StunCounter, 0, false)
compare(SlowCounter, 0)

Test.Finish()