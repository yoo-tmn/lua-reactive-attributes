package.path = package.path .. ";./?.lua;./?/init.lua"

local TestCumulativeComponent = require('test.base-components.test-cumulative-component')
local TestCollectionComponent = require('test.base-components.test-collection-component')
local TestComplementComponent = require('test.base-components.test-complement-component')
local TestDiminishingComponent = require('test.base-components.test-diminishing-component')
local TestMultiplyingComponent = require('test.base-components.test-multiplying-component')
local TestEvaluateFn = require('test.base-evaluators.test-evaluate-fn')
local TestParameter = require('test.base-evaluators.parameter-evaluator')
local TestReduction = require('test.base-evaluators.reduction-evaluator')
local TestLocalEvaluator = require('test.local-evaluator.local-evaluator')
local TestConditionalModifier = require('test.local-modifiers.conditional-modifiers')
local TestProgressiveModifier = require('test.local-modifiers.progressive-modifiers')
local TestEquipmentSet = require('test.modifier-rule.test-equipment-set')

print("\nSTART UNIT TESTS\n")

TestCumulativeComponent()
TestCollectionComponent()
TestComplementComponent()
TestMultiplyingComponent()
TestDiminishingComponent()
TestEvaluateFn()

print()

TestParameter()
TestReduction()

print()

TestLocalEvaluator()
TestConditionalModifier()
TestProgressiveModifier()
TestEquipmentSet()

print()