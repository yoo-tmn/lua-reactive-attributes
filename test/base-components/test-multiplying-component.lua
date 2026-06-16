local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local HealingEfficiency = ReactiveAttributes.CreateMultiplyingComponent()

local container = ReactiveAttributes.CreateContainer()

function TestMultiplyingComponent()
    Test.Start('Multiplying Component')

    -- test #1
    container:apply_change(HealingEfficiency, 0.8)
    Test.Compare(container[HealingEfficiency], 0.80, true)

    -- test #2
    container:apply_change(HealingEfficiency, 0.8)
    Test.Compare(container[HealingEfficiency], 0.64, true)

    -- test #3
    container:purge_change(HealingEfficiency, 0.8)
    Test.Compare(container[HealingEfficiency], 0.80, true)

    -- test #4
    container:purge_change(HealingEfficiency, 0.8)
    Test.Compare(container[HealingEfficiency], 1.00, true)

    -- test #5
    container:apply_change(HealingEfficiency, 1.2)
    Test.Compare(container[HealingEfficiency], 1.20, true)

    -- test #6
    container:apply_change(HealingEfficiency, 1.3)
    Test.Compare(container[HealingEfficiency], 1.56, true)

    -- test #7
    container:purge_change(HealingEfficiency, 1.2)
    Test.Compare(container[HealingEfficiency], 1.30, true)

    -- test #8
    container:apply_change(HealingEfficiency, 0.5)
    Test.Compare(container[HealingEfficiency], 0.65, true)

    Test.Finish()
end

return TestMultiplyingComponent