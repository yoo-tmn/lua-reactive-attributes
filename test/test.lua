package.path = package.path .. ";./?.lua;./?/init.lua"

local TestCumulativeComponent = require('test.base-components.test-cumulative-component')
local TestCollectionComponent = require('test.base-components.test-collection-collection')
local TestComplementComponent = require('test.base-components.test-complement-component')
local TestDiminishingComponent = require('test.base-components.test-diminishing-component')
local TestMultiplyingComponent = require('test.base-components.test-multiplying-component')
local TestParameter = require('test.base-evaluators.parameter-evaluator')
local TestReduction = require('test.base-evaluators.reduction-evaluator')
local TestLocalEvaluator = require('test.local-evaluator.local-evaluator')
local TestConditionalModifier = require('test.modifiers.conditional-modifiers')
local TestProgressiveModifier = require('test.modifiers.progressive-modifiers')

print("\nSTART UNIT TESTS\n")

TestCumulativeComponent()
TestCollectionComponent()
TestComplementComponent()
TestMultiplyingComponent()
TestDiminishingComponent()

print()

TestParameter()
TestReduction()

print()

TestLocalEvaluator()
TestConditionalModifier()
TestProgressiveModifier()

print()