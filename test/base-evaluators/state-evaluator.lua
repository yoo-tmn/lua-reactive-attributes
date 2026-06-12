local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local Stun = ReactiveAttributes.CreateStateEvaluator()

local container = ReactiveAttributes.CreateContainer()
local compare = function(key, expected_value)
    Test.Compare(container[key], expected_value)
end

function TestState()
    Test.Start('State Evaluator')

    -- test #1
    container:apply_change(Stun.normal)
    compare(Stun, true)

    -- test #2
    container:apply_change(Stun.immune)
    compare(Stun, false)

    -- test #3
    container:apply_change(Stun.normal)
    compare(Stun, false)

    -- test #4
    container:apply_change(Stun.strong)
    compare(Stun, true)

    -- test #5
    container:purge_change(Stun.strong)
    compare(Stun, false)

    -- test #6
    container:purge_change(Stun.immune)
    compare(Stun, true)

    -- test #7
    container:purge_change(Stun.normal)
    compare(Stun, true)

    -- test #8
    container:purge_change(Stun.normal)
    compare(Stun, false)

    Test.Finish()
end

return TestState