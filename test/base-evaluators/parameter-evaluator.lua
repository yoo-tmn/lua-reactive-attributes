local Test = require('test.unit-test')
local ReactiveAttributes = require('reactive-attributes')

local LifeParameter = ReactiveAttributes.CreateParameter()

local Life250p5 = { priority = 5, value = 250 }
local Life250p1 = { priority = 1, value = 250 }

local container = ReactiveAttributes.CreateContainer()



Test.Start('Parameter Evaluator')

-- step #1
container:apply_change(LifeParameter.value, 100)
Test.Compare(container[LifeParameter], 100)

-- step #2
container:apply_change(LifeParameter.value, 200)
Test.Compare(container[LifeParameter], 300)

-- step #3
container:apply_change(LifeParameter.ratio, 0.1)
Test.Compare(container[LifeParameter], 330)

-- step #4
container:apply_change(LifeParameter.ratio, 0.1)
Test.Compare(container[LifeParameter], 360)

-- step #5
container:apply_change(LifeParameter.value_overrider.storage, Life250p5)
Test.Compare(container[LifeParameter], 300)

-- step #6
container:purge_change(LifeParameter.ratio, 0.1)
Test.Compare(container[LifeParameter], 275)

-- step #7
container:apply_change(LifeParameter.total_overrider.storage, Life250p1)
Test.Compare(container[LifeParameter], 250)

-- step #8
container:purge_change(LifeParameter.ratio, 0.10)
Test.Compare(container[LifeParameter], 250)

-- step #9
container:apply_change(LifeParameter.value, 100)
Test.Compare(container[LifeParameter], 250)

-- step #10
container:apply_change(LifeParameter.ratio, 0.2)
Test.Compare(container[LifeParameter], 250)

-- step #11
container:purge_change(LifeParameter.total_overrider.storage, Life250p1)
container:purge_change(LifeParameter.value_overrider.storage, Life250p5)
Test.Compare(container[LifeParameter], 480)

Test.Finish()