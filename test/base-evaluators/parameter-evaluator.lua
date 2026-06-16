local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local LifeParameter = ReactiveAttributes.CreateParameter()

local Life250p5 = { priority = 5, value = 250 }

local container = ReactiveAttributes.CreateContainer()

function TestParameter()
    Test.Start('Parameter Evaluator')

    -- test #1
    container:apply_change(LifeParameter.base_value, 100)
    Test.Compare(container[LifeParameter], 100)

    -- test #2
    container:apply_change(LifeParameter.base_value, 200)
    Test.Compare(container[LifeParameter], 300)

    -- test #3
    container:apply_change(LifeParameter.add_factor, 0.1)
    Test.Compare(container[LifeParameter], 330)

    -- test #4
    container:apply_change(LifeParameter.add_factor, 0.1)
    Test.Compare(container[LifeParameter], 360)

    -- test #5
    container:purge_change(LifeParameter.add_factor, 0.1)
    Test.Compare(container[LifeParameter], 330)

    -- test #6
    container:apply_change(LifeParameter.mul_factor, 1.1)
    Test.Compare(container[LifeParameter], 363, true)

    -- test #7
    container:apply_change(LifeParameter.mul_factor, 1.2)
    Test.Compare(container[LifeParameter], 435.6, true)

    -- test #8
    container:purge_change(LifeParameter.mul_factor, 1.1)
    Test.Compare(container[LifeParameter], 396, true)

    -- test #9
    container:apply_change(LifeParameter.soft_overriders, Life250p5)
    Test.Compare(container[LifeParameter], 330)

    -- test #10
    container:purge_change(LifeParameter.base_value, 100)
    Test.Compare(container[LifeParameter], 330)

    -- test #11
    container:purge_change(LifeParameter.soft_overriders, Life250p5)
    Test.Compare(container[LifeParameter], 264)

    -- test #12
    container:apply_change(LifeParameter.hard_overriders, Life250p5)
    Test.Compare(container[LifeParameter], 250)

    Test.Finish()
end

return TestParameter