local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local DamageReduction = ReactiveAttributes.CreateReductionEvaluator()

local container = ReactiveAttributes.CreateContainer()
local compare = function(key, expected_value)
    Test.Compare(container[key], expected_value, true)
end

function TestReduction()
    Test.Start('Reduction Evaluator')

    -- test #1
    container:apply_change(DamageReduction.diminishing_rating, 25)
    compare(DamageReduction, 25/125)

    -- test #2
    container:apply_change(DamageReduction.diminishing_factor, 25)
    compare(DamageReduction, 25/150)

    -- test #3
    container:purge_change(DamageReduction.diminishing_factor, 25)
    compare(DamageReduction, 25/125)

    -- test #4
    container:apply_change(DamageReduction.flat_reduction, 0.05)
    compare(DamageReduction, 25/125 + 0.05)

    -- test #5
    container:apply_change(DamageReduction.base_reduction, 0.20)
    compare(DamageReduction, 0.200 * 25/125 + 0.05)

    -- test #6
    container:apply_change(DamageReduction.base_reduction, 0.20)
    compare(DamageReduction, 0.360 * 25/125 + 0.05)

    -- test #7
    container:apply_change(DamageReduction.base_reduction, 0.30)
    compare(DamageReduction, 0.552 * 25/125 + 0.05)

    -- test #8
    container:purge_change(DamageReduction.base_reduction, 0.20)
    compare(DamageReduction, 0.440 * 25/125 + 0.05)

    -- test #9
    container:purge_change(DamageReduction.base_reduction, 0.20)
    compare(DamageReduction, 0.300 * 25/125 + 0.05)

    -- test #10
    container:purge_change(DamageReduction.flat_reduction, 0.05)
    compare(DamageReduction, 0.300 * 25/125)

    -- test #11
    container:purge_change(DamageReduction.diminishing_rating, 25)
    compare(DamageReduction, 0.300)

    -- test #12
    container:purge_change(DamageReduction.base_reduction, 0.30)
    compare(DamageReduction, 0)

    Test.Finish()
end

return TestReduction