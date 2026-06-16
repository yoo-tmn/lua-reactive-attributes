local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local AttackSpeed = ReactiveAttributes.CreateDiminishingComponent(400)

local container = ReactiveAttributes.CreateContainer()

function TestDiminishingComponent()
    Test.Start('Diminishing Component')

    -- test #1
    container:apply_change(AttackSpeed, 100)
    Test.Compare(container[AttackSpeed], 1/5, true)

    -- test #2
    container:apply_change(AttackSpeed, 100)
    Test.Compare(container[AttackSpeed], 2/6, true)

    -- test #3
    container:purge_change(AttackSpeed, 100)
    Test.Compare(container[AttackSpeed], 1/5, true)

    -- test #4
    container:purge_change(AttackSpeed, 100)
    Test.Compare(container[AttackSpeed], 0, true)

    -- test #5
    container:apply_change(AttackSpeed, 250)
    Test.Compare(container[AttackSpeed], 25/65, true)

    -- test #6
    container:apply_change(AttackSpeed, 150)
    Test.Compare(container[AttackSpeed], 1/2, true)

    -- test #7
    container:purge_change(AttackSpeed, 250)
    Test.Compare(container[AttackSpeed], 150/550, true)

    -- test #8
    container:apply_change(AttackSpeed, 600)
    Test.Compare(container[AttackSpeed], 750/1150, true)

    -- test #9
    container:purge_change(AttackSpeed, 750)
    Test.Compare(container[AttackSpeed], 0, true)

    -- test #10
    container:apply_change(AttackSpeed, 100)
    Test.Compare(container[AttackSpeed], 1/5, true)

    -- test #11
    container:apply_change(AttackSpeed, -200)
    Test.Compare(container[AttackSpeed], -1/5, true)

    -- test #12
    container:purge_change(AttackSpeed, -200)
    Test.Compare(container[AttackSpeed], 1/5, true)

    -- test #13
    container:apply_change(AttackSpeed, -300)
    Test.Compare(container[AttackSpeed], -1/3, true)

    -- test #14
    container:apply_change(AttackSpeed, -100)
    Test.Compare(container[AttackSpeed], -3/7, true)

    Test.Finish()
end

return TestDiminishingComponent