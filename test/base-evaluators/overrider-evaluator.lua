local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

function LastHighestPriority(prev, next)
    if prev.priority > next.priority then
        return prev
    end
    return next
end

local LifeOverrider = ReactiveAttributes.CreateOverrider(LastHighestPriority)

local Life100p5 = { value = 100, priority = 5 }
local Life200p1 = { value = 200, priority = 1 }
local Life300p9 = { value = 300, priority = 9 }

local container = ReactiveAttributes.CreateContainer()
local compare = function(key, expected_value)
    Test.Check(container[key].value == expected_value)
end



Test.Start('Overrider Evaluator')

-- step #1
container:apply_change(LifeOverrider.storage, Life100p5)
compare(LifeOverrider, 100)

-- step #2
container:apply_change(LifeOverrider.storage, Life200p1)
compare(LifeOverrider, 100)

-- step #3
container:apply_change(LifeOverrider.storage, Life300p9)
compare(LifeOverrider, 300)

-- step #4
container:purge_change(LifeOverrider.storage, Life300p9)
compare(LifeOverrider, 100)

-- step #5
container:purge_change(LifeOverrider.storage, Life100p5)
compare(LifeOverrider, 200)

-- step #6
container:purge_change(LifeOverrider.storage, Life200p1)
Test.Check(container[LifeOverrider] == nil)

Test.Finish()