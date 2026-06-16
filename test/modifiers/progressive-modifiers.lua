local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local PassiveSkillLevel = ReactiveAttributes.CreateCumulativeComponent()
local Life = ReactiveAttributes.CreateCumulativeComponent()
local Mana = ReactiveAttributes.CreateCumulativeComponent()

ReactiveAttributes.CreateProgressiveModifier(PassiveSkillLevel, {
    [Life] = 40,
    [Mana] = 20,
})

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

    Test.Finish()
end

return TestProgressiveModifier