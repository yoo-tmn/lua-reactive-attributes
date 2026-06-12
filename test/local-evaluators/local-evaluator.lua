local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local Life = ReactiveAttributes.CreateAmountComponent()
local NGLifeEvaluator = ReactiveAttributes.CreateEvaluator(function(_, container)
    return container[Life] / 5
end, true)
Life:bind_evaluator(NGLifeEvaluator)

local container = ReactiveAttributes.CreateContainer()

function TestLocalEvaluator()
    Test.Start('Local Evaluator')

    -- test #1
    container:apply_change(Life, 100)
    Test.Compare(container[NGLifeEvaluator], nil)

    -- test #2
    container:attach_evaluator(NGLifeEvaluator)
    Test.Compare(container[NGLifeEvaluator], 20)

    -- test #3
    container:apply_change(Life, 100)
    Test.Compare(container[NGLifeEvaluator], 40)

    -- test #4
    container:detach_evaluator(NGLifeEvaluator)
    Test.Compare(container[NGLifeEvaluator], nil)

    -- test #5
    container:purge_change(Life, 100)
    Test.Compare(container[NGLifeEvaluator], nil)

    Test.Finish()
end

return TestLocalEvaluator