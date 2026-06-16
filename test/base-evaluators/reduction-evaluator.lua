local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local DamageReduction = ReactiveAttributes.CreateReduction()

local container = ReactiveAttributes.CreateContainer()
local compare = function(key, expected_value)
    Test.Compare(container[key], expected_value, true)
end

function TestReduction()
    Test.Start('Reduction Evaluator')

    -- test #1
    container:apply_change(DamageReduction.rate, 25)
    compare(DamageReduction, 0.200) -- 20%

    -- test #2
    container:apply_change(DamageReduction.flat, 0.05)
    compare(DamageReduction, 0.250) -- 25%

    -- test #3
    container:apply_change(DamageReduction.base, 0.20)
    compare(DamageReduction, 0.410) -- 41%

    -- test #4
    container:apply_change(DamageReduction.base, 0.20)
    compare(DamageReduction, 0.538) -- 54%

    -- test #5
    container:apply_change(DamageReduction.base, 0.30)
    compare(DamageReduction, 0.6916)

    -- test #6
    container:purge_change(DamageReduction.base, 0.20)
    compare(DamageReduction, 0.6020)

    -- test #7
    container:purge_change(DamageReduction.base, 0.20)
    compare(DamageReduction, 0.49)

    -- test #8
    container:purge_change(DamageReduction.flat, 0.05)
    compare(DamageReduction, 0.44)

    -- test #9
    container:purge_change(DamageReduction.rate, 25)
    compare(DamageReduction, 0.30)

    -- test #10
    container:purge_change(DamageReduction.base, 0.30)
    compare(DamageReduction, 0)

    Test.Finish()
end

return TestReduction