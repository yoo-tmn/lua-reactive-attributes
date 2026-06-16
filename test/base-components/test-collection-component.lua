local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local LifeOverrider = ReactiveAttributes.CreateCollectionComponent()

local container = ReactiveAttributes.CreateContainer()

function TestCollectionComponent()
    Test.Start('Collection Component')

    -- test #1
    Test.Compare(container[LifeOverrider], nil)

    -- test #2
    container:apply_change(LifeOverrider, 100)
    Test.Compare(container[LifeOverrider], 100)

    -- test #3
    container:apply_change(LifeOverrider, 200)
    Test.Compare(container[LifeOverrider][1], 100)
    -- test #4
    Test.Compare(container[LifeOverrider][2], 200)

    -- test #5
    container:purge_change(LifeOverrider, 100)
    Test.Compare(#container[LifeOverrider], 1)
    -- test #6
    Test.Compare(container[LifeOverrider][1], 200)

    -- test #7
    container:apply_change(LifeOverrider, 100)
    Test.Compare(#container[LifeOverrider], 2)
    -- test #8
    Test.Compare(LifeOverrider:get_tail(container), 100)
    -- test #9
    Test.Compare(LifeOverrider:get_head(container), 200)
    -- test #10
    Test.Compare(LifeOverrider:select(container, function(prev, next)
        if prev > next then return prev else return next end
    end), 200)

    -- test #11
    container:purge_change(LifeOverrider, 250)
    Test.Compare(#container[LifeOverrider], 2)

    -- test #12
    container:purge_change(LifeOverrider, 100)
    Test.Compare(#container[LifeOverrider], 1)
    -- test #13
    Test.Compare(LifeOverrider:get_tail(container), 200)
    -- test #14
    Test.Compare(LifeOverrider:get_head(container), 200)
    -- test #15
    Test.Compare(LifeOverrider:select(container, function(prev, next)
        if prev > next then return prev else return next end
    end), 200)

    -- test #16
    container:purge_change(LifeOverrider, 200)
    Test.Compare(#container[LifeOverrider], 0)

    Test.Finish()
end

return TestCollectionComponent