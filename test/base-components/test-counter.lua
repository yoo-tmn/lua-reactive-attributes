local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local StunCounter = ReactiveAttributes.CreateCounterComponent()
local SlowCounter = ReactiveAttributes.CreateCounterComponent()

local container = ReactiveAttributes.CreateContainer()
local compare = function(key, expected_value)
    Test.Compare(container[key], expected_value)
end

function TestCounter()
    Test.Start('Counter Component')

    -- test #1
    container:apply_change(StunCounter)
    compare(StunCounter, 1)

    -- test #2
    container:apply_change(StunCounter)
    compare(StunCounter, 2)

    -- test #3
    container:apply_change(SlowCounter)
    compare(StunCounter, 2)
    -- test #4
    compare(SlowCounter, 1)

    -- test #5
    container:apply_change(SlowCounter)
    compare(StunCounter, 2)
    -- test #6
    compare(SlowCounter, 2)

    -- test #7
    container:purge_change(StunCounter)
    compare(StunCounter, 1)
    -- test #8
    compare(SlowCounter, 2)

    -- test #9
    container:purge_change(SlowCounter)
    compare(StunCounter, 1)
    -- test #10
    compare(SlowCounter, 1)

    -- test #11
    container:purge_change(StunCounter)
    compare(StunCounter, 0)
    -- test #12
    compare(SlowCounter, 1)

    -- test #13
    container:purge_change(SlowCounter)
    compare(StunCounter, 0)
    -- test #14
    compare(SlowCounter, 0)

    Test.Finish()
end

return TestCounter