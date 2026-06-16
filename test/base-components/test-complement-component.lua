local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local DamageReduction = ReactiveAttributes.CreateComplementComponent()

local container = ReactiveAttributes.CreateContainer()

function TestComplementComponent()
    Test.Start('Complement Component')

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

    -- test #9
    container:purge_change(DamageReduction, 0.25)
    Test.Compare(container[DamageReduction], 0.000, true)

    -- test #10
    container:apply_change(DamageReduction, -0.25)
    Test.Compare(container[DamageReduction], -0.25, true)

    -- test #11
    container:apply_change(DamageReduction, -0.20)
    Test.Compare(container[DamageReduction], -0.50, true)

    -- test #12
    container:apply_change(DamageReduction, 0.25)
    Test.Compare(container[DamageReduction], -0.125, true)

    -- test #13
    container:apply_change(DamageReduction, 0.25)
    Test.Compare(container[DamageReduction], 0.15625, true)

    -- test #14
    container:purge_change(DamageReduction, -0.25)
    Test.Compare(container[DamageReduction], 0.325, true)

    -- test #15
    container:purge_change(DamageReduction, -0.20)
    Test.Compare(container[DamageReduction], 0.4375, true)

    Test.Finish()
end

return TestComplementComponent