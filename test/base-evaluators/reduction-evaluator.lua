local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local DamageReduction = ReactiveAttributes.CreateReduction()

local container = ReactiveAttributes.CreateContainer()
local compare = function(key, expected_value)
    Test.Check(container[key] - expected_value <= 1e-9)
end



Test.Start('Reduction Evaluator')

-- step #1
container:apply_change(DamageReduction.diminishing_rating, 25)
compare(DamageReduction, 1 - 25/125)

-- step #2
container:apply_change(DamageReduction.diminishing_factor, 25)
compare(DamageReduction, 1 - 25/150)

-- step #3
container:purge_change(DamageReduction.diminishing_factor, 25)
compare(DamageReduction, 1 - 25/125)

-- step #4
container:apply_change(DamageReduction.final_reduction, 0.05)
compare(DamageReduction, 0.95 * (1 - 25/125))

-- step #5
container:apply_change(DamageReduction.basic_reduction, 0.20)
compare(DamageReduction, 0.80 * 0.95 * (1 - 25/125))

-- step #6
container:apply_change(DamageReduction.basic_reduction, 0.20)
compare(DamageReduction, 0.64 * 0.95 * (1 - 25/125))

-- step #7
container:apply_change(DamageReduction.basic_reduction, 1.50)
compare(DamageReduction, 0.96 * 0.95 * (1 - 25/125))

Test.Finish()