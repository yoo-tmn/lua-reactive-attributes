local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local StunCondition = ReactiveAttributes.CreateCondition()

local container = ReactiveAttributes.CreateContainer()
local compare = function(key, expected_value)
    Test.Compare(container[key], expected_value)
end

Test.Start('Condition Evaluator')

-- test #1
container:apply_change(StunCondition.normal)
compare(StunCondition, true)

-- test #2
container:apply_change(StunCondition.immune)
compare(StunCondition, false)

-- test #3
container:apply_change(StunCondition.normal)
compare(StunCondition, false)

-- test #4
container:apply_change(StunCondition.strong)
compare(StunCondition, true)

-- test #5
container:purge_change(StunCondition.strong)
compare(StunCondition, false)

-- test #6
container:purge_change(StunCondition.immune)
compare(StunCondition, true)

-- test #7
container:purge_change(StunCondition.normal)
compare(StunCondition, true)

-- test #8
container:purge_change(StunCondition.normal)
compare(StunCondition, false)

Test.Finish()