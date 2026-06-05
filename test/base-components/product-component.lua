local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local DamageReduction = ReactiveAttributes.CreateProductComponent()

local container = ReactiveAttributes.CreateContainer()
local compare = function(key, expected_value)
    Test.Check(math.abs(container[key] - expected_value) <= 1e-9)
end



Test.Start('Product Component')

-- step #1
container:apply_change(DamageReduction, 0.8)
compare(DamageReduction, 0.80)

-- step #2
container:apply_change(DamageReduction, 0.8)
compare(DamageReduction, 0.64)

-- step #3
container:purge_change(DamageReduction, 0.8)
compare(DamageReduction, 0.80)

-- step #4
container:purge_change(DamageReduction, 0.8)
compare(DamageReduction, 1.00)

-- step #5
container:apply_change(DamageReduction, 1.2)
compare(DamageReduction, 1.20)

-- step #6
container:apply_change(DamageReduction, 1.3)
compare(DamageReduction, 1.56)

-- step #7
container:purge_change(DamageReduction, 1.2)
compare(DamageReduction, 1.30)

-- step #8
container:apply_change(DamageReduction, 0.5)
compare(DamageReduction, 0.65)

Test.Finish()