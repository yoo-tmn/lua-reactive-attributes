local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local LifeParameter = ReactiveAttributes.CreateParameter()

local Life250p5 = { priority = 5, value = 250 }
local Life250p1 = { priority = 1, value = 250 }

local container = ReactiveAttributes.CreateContainer()

function TestParameter()
    Test.Start('Parameter Evaluator')

    -- test #1
    container:apply_change(LifeParameter.value, 100)
    Test.Compare(container[LifeParameter], 100)

    -- test #2
    container:apply_change(LifeParameter.value, 200)
    Test.Compare(container[LifeParameter], 300)

    -- test #3
    container:apply_change(LifeParameter.ratio, 0.1)
    Test.Compare(container[LifeParameter], 330)

    -- test #4
    container:apply_change(LifeParameter.ratio, 0.1)
    Test.Compare(container[LifeParameter], 360)

    -- test #5
    container:apply_change(LifeParameter.value_overrider.storage, Life250p5)
    Test.Compare(container[LifeParameter], 300)

    -- test #6
    container:purge_change(LifeParameter.ratio, 0.1)
    Test.Compare(container[LifeParameter], 275)

    -- test #7
    container:apply_change(LifeParameter.total_overrider.storage, Life250p1)
    Test.Compare(container[LifeParameter], 250)

    -- test #8
    container:purge_change(LifeParameter.ratio, 0.10)
    Test.Compare(container[LifeParameter], 250)

    -- test #9
    container:apply_change(LifeParameter.value, 100)
    Test.Compare(container[LifeParameter], 250)

    -- test #10
    container:apply_change(LifeParameter.ratio, 0.2)
    Test.Compare(container[LifeParameter], 250)

    -- test #11
    container:purge_change(LifeParameter.total_overrider.storage, Life250p1)
    Test.Compare(container[LifeParameter], 300)

    -- test #12
    container:purge_change(LifeParameter.value_overrider.storage, Life250p5)
    Test.Compare(container[LifeParameter], 480)

    Test.Finish()
end

return TestParameter