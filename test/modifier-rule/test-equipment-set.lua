local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local Life = ReactiveAttributes.CreateCumulativeComponent()
local Mana = ReactiveAttributes.CreateCumulativeComponent()

local EquipmentCounter = ReactiveAttributes.CreateCounter()
local HasEquipmentSet = ReactiveAttributes.Evaluate(function(_, container)
    return container[EquipmentCounter] >= 2
end, EquipmentCounter)

ReactiveAttributes.CreateModifier({
    [Life] = 100,
    [Mana] = 100,
}, nil, nil, HasEquipmentSet)

function TestEquipmentSet()
    Test.Start('Equipment Set Modifier Rule')

    local container = ReactiveAttributes.CreateContainer()

    container:apply_change(Life, 300)
    container:apply_change(Mana, 200)
    -- test #1
    Test.Compare(container[Life], 300)
    -- test #2
    Test.Compare(container[Mana], 200)

    container:apply_change(EquipmentCounter, 1)
    -- test #3
    Test.Compare(container[Life], 300)
    -- test #4
    Test.Compare(container[Mana], 200)

    container:apply_change(EquipmentCounter, 1)
    -- test #5
    Test.Compare(container[Life], 400)
    -- test #6
    Test.Compare(container[Mana], 300)

    container:purge_change(EquipmentCounter, 1)
    -- test #7
    Test.Compare(container[Life], 300)
    -- test #8
    Test.Compare(container[Mana], 200)

    Test.Finish()
end

return TestEquipmentSet