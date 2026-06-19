local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local PassiveSkillLevel = ReactiveAttributes.CreateCumulativeComponent()
local Life = ReactiveAttributes.CreateCumulativeComponent()
local Mana = ReactiveAttributes.CreateCumulativeComponent()

local ModifierEvaluator = ReactiveAttributes.CreateModifier({
    [Life] = 40,
    [Mana] = 20,
}, PassiveSkillLevel)

local EquipmentTag = ReactiveAttributes.CreateModifierTag()
AttachModifierTag(ModifierEvaluator, EquipmentTag)

local container = ReactiveAttributes.CreateContainer()

function TestProgressiveModifier()
    Test.Start('Progressive Modifier')

    -- test #1
    container:apply_change(Life, 300)
    container:apply_change(Mana, 200)
    Test.Compare(container[Life], 300)
    -- test #2
    Test.Compare(container[Mana], 200)

    -- test #3
    container:apply_change(ModifierEvaluator.flag, 1)
    container:apply_change(PassiveSkillLevel, 1)
    Test.Compare(container[Life], 340)
    -- test #4
    Test.Compare(container[Mana], 220)

    -- test #5
    container:apply_change(PassiveSkillLevel, 3)
    Test.Compare(container[Life], 460)
    -- test #6
    Test.Compare(container[Mana], 280)

    -- test #7
    container:purge_change(PassiveSkillLevel, 1)
    Test.Compare(container[Life], 420)
    -- test #8
    Test.Compare(container[Mana], 260)

    -- test #9
    container:purge_change(PassiveSkillLevel, 2)
    Test.Compare(container[Life], 340)
    -- test #10
    Test.Compare(container[Mana], 220)

    -- test #11
    container:apply_change(PassiveSkillLevel, 1.5)
    Test.Compare(container[Life], 400)
    -- test #12
    Test.Compare(container[Mana], 250)

    -- test #13
    container:apply_change(ModifierEvaluator.flag, 1)
    Test.Compare(container[Life], 500)
    -- test #14
    Test.Compare(container[Mana], 300)

    -- test #15
    container:apply_change(EquipmentTag.disabled, 1)
    Test.Compare(container[Life], 300)
    -- test #16
    Test.Compare(container[Mana], 200)

    -- test #17
    container:purge_change(EquipmentTag.disabled, 1)
    container:apply_change(EquipmentTag.efficiency, 0.25)
    Test.Compare(container[Life], 550)
    -- test #18
    Test.Compare(container[Mana], 325)

    Test.Finish()
end

return TestProgressiveModifier