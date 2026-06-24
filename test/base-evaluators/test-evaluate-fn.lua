local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

function TestEvaluateFn()
    local life_amount = ReactiveAttributes.CreateCumulativeComponent()
    local life_factor = ReactiveAttributes.CreateCumulativeComponent()

    local life = ReactiveAttributes.Evaluate(function(_, container)
        local amount = (container[life_amount] or 0)
        local factor = (container[life_factor] or 0)

        return amount * (1 + factor)
    end, life_amount, life_factor)

    local container = ReactiveAttributes.CreateContainer()

    Test.Start('Evaluate Function')

    -- test #1
    container:apply_change(life_amount, 100)
    Test.Compare(container[life], 100)

    -- test #2
    container:apply_change(life_factor, 0.10)
    Test.Compare(container[life], 110, true)

    Test.Finish()
end

return TestEvaluateFn