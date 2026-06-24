local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local Life = ReactiveAttributes.CreateCumulativeComponent()
local Mana = ReactiveAttributes.CreateCumulativeComponent()
local Level = CreateCounter()

local MoreThan400Life = ReactiveAttributes.CreateEvaluator(function(_, container)
    return (container[Life] or 0) > 400
end, true)
Life:bind_evaluator(MoreThan400Life)

local ModifierEvaluator = ReactiveAttributes.CreateModifier({
    [Mana] = 100
}, Level, nil, MoreThan400Life)

local container = ReactiveAttributes.CreateContainer()

function TestConditionalModifier()
    Test.Start('Conditional Modifier')

    container:apply_change(Life, 300)
    container:apply_change(Mana, 200)
    -- test #1
    Test.Compare(container[Life], 300)
    -- test #2
    Test.Compare(container[Mana], 200)

    container:attach_evaluator(MoreThan400Life)
    -- test #3
    Test.Compare(container[Life], 300)
    -- test #4
    Test.Compare(container[MoreThan400Life], false)

    container:apply_change(Life, 100)
    -- test #5
    Test.Compare(container[Life], 400)
    -- test #6
    Test.Compare(container[MoreThan400Life], false)

    container:apply_change(Life, 20)
    -- test #7
    Test.Compare(container[Life], 420)
    -- test #8
    Test.Compare(container[MoreThan400Life], true)

    -- test #9
    container:apply_change(ModifierEvaluator.counter, 1)
    Test.Compare(container[Mana], 300)

    -- test #10
    container:purge_change(Life, 20)
    Test.Compare(container[Mana], 200)

    -- test #11
    container:apply_change(Life, 100)
    Test.Compare(container[Mana], 300)

    -- test #12
    container:purge_change(ModifierEvaluator.counter, 1)
    Test.Compare(container[Mana], 200)

    Test.Finish()
end

return TestConditionalModifier