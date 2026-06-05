local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local DamageReduction = ReactiveAttributes.CreateProductComponent()

local container = ReactiveAttributes.CreateContainer()
local compare = function(key, expected_value)
    Test.Compare(container[key], expected_value, true)
end

Test.Start('Product Component')

-- test #1
container:apply_change(DamageReduction, 0.8)
compare(DamageReduction, 0.80)

-- test #2
container:apply_change(DamageReduction, 0.8)
compare(DamageReduction, 0.64)

-- test #3
container:purge_change(DamageReduction, 0.8)
compare(DamageReduction, 0.80)

-- test #4
container:purge_change(DamageReduction, 0.8)
compare(DamageReduction, 1.00)

-- test #5
container:apply_change(DamageReduction, 1.2)
compare(DamageReduction, 1.20)

-- test #6
container:apply_change(DamageReduction, 1.3)
compare(DamageReduction, 1.56)

-- test #7
container:purge_change(DamageReduction, 1.2)
compare(DamageReduction, 1.30)

-- test #8
container:apply_change(DamageReduction, 0.5)
compare(DamageReduction, 0.65)

Test.Finish()