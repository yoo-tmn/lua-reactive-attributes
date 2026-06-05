local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local StunCondition = ReactiveAttributes.CreateCondition()

local container = ReactiveAttributes.CreateContainer()
local compare = function(key, expected_value)
    Test.Check(container[key] == expected_value)
end



Test.Start('Condition Evaluator')

-- step #1
container:apply_change(StunCondition.normal)
compare(StunCondition, true)

-- step #2
container:apply_change(StunCondition.immune)
compare(StunCondition, false)

-- step #3
container:apply_change(StunCondition.normal)
compare(StunCondition, false)

-- step #4
container:apply_change(StunCondition.strong)
compare(StunCondition, true)

-- step #5
container:purge_change(StunCondition.strong)
compare(StunCondition, false)

-- step #6
container:purge_change(StunCondition.immune)
compare(StunCondition, true)

-- step #7
container:purge_change(StunCondition.normal)
compare(StunCondition, true)

-- step #8
container:purge_change(StunCondition.normal)
compare(StunCondition, false)

Test.Finish()