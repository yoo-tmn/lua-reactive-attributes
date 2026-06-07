local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local Life = ReactiveAttributes.CreateNumericComponent()
local NGLifeEvaluator = ReactiveAttributes.CreateEvaluator(function(evaluator, container)
    return container[Life] / 5
end, false, true)
Life:bind_evaluator(NGLifeEvaluator)

local container = ReactiveAttributes.CreateContainer()

Test.Start('Not Global Evaluator')

-- test #1
container:apply_change(Life, 100)
Test.Compare(container[NGLifeEvaluator], nil)

container:append_evaluator(NGLifeEvaluator)
Test.Compare(container[NGLifeEvaluator], 20)

container:apply_change(Life, 100)
Test.Compare(container[NGLifeEvaluator], 40)

container:delete_evaluator(NGLifeEvaluator)
Test.Compare(container[NGLifeEvaluator], nil)

container:purge_change(Life, 100)
Test.Compare(container[NGLifeEvaluator], nil)

Test.Finish()