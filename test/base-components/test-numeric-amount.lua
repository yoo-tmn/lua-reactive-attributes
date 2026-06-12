local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local LifeValue = ReactiveAttributes.CreateAmountComponent()
local LifeRatio = ReactiveAttributes.CreateAmountComponent()

local container = ReactiveAttributes.CreateContainer()
local compare = function(key, expected_value)
    Test.Compare(container[key], expected_value)
end

function TestNumericAmount()
    Test.Start('Amount Component')

    -- test #1
    container:apply_change(LifeValue, 100)
    compare(LifeValue, 100)

    -- test #2
    container:apply_change(LifeValue, 200)
    compare(LifeValue, 300)

    -- test #3
    container:apply_change(LifeRatio, 10)
    compare(LifeValue, 300)
    -- test #4
    compare(LifeRatio, 10)

    -- test #5
    container:purge_change(LifeRatio, 10)
    compare(LifeValue, 300)
    -- test #6
    compare(LifeRatio, 0)

    -- test #7
    container:purge_change(LifeValue, 100)
    compare(LifeValue, 200)
    -- test #8
    compare(LifeRatio, 0)

    -- test #9
    container:apply_change(LifeValue, 200)
    compare(LifeValue, 400)

    -- test #10
    container:purge_change(LifeValue, 200)
    compare(LifeValue, 200)

    -- test #11
    container:purge_change(LifeValue, 200)
    compare(LifeValue, 0)

    Test.Finish()
end

return TestNumericAmount