local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local DamageReduction = ReactiveAttributes.CreateReductionComponent()

local container = ReactiveAttributes.CreateContainer()

function TestNumericReduction()
    Test.Start('Reduction Component')

    -- test #1
    container:apply_change(DamageReduction, 0.20)
    Test.Compare(container[DamageReduction], 0.200, true)

    -- test #2
    container:apply_change(DamageReduction, 0.20)
    Test.Compare(container[DamageReduction], 0.360, true)

    -- test #3
    container:purge_change(DamageReduction, 0.20)
    Test.Compare(container[DamageReduction], 0.200, true)

    -- test #4
    container:apply_change(DamageReduction, 0.20)
    container:apply_change(DamageReduction, 0.30)
    Test.Compare(container[DamageReduction], 0.552, true)

    -- test #5
    container:apply_change(DamageReduction, 0.25)
    Test.Compare(container[DamageReduction], 0.664, true)

    -- test #6
    container:purge_change(DamageReduction, 0.30)
    Test.Compare(container[DamageReduction], 0.520, true)

    -- test #7
    container:purge_change(DamageReduction, 0.20)
    Test.Compare(container[DamageReduction], 0.400, true)

    -- test #8
    container:purge_change(DamageReduction, 0.20)
    Test.Compare(container[DamageReduction], 0.250, true)

    container:purge_change(DamageReduction, 0.25)
    Test.Compare(container[DamageReduction], 0.000, true)

    Test.Finish()
end

return TestNumericReduction