package.path = package.path .. ";./?.lua;./?/init.lua"

local TestCounter = require('test.base-components.test-counter')
local TestCollection = require('test.base-components.test-collection')
local TestNumericAmount = require('test.base-components.test-numeric-amount')
local TestNumericFactor = require('test.base-components.test-numeric-factor')
local TestNumericReduction = require('test.base-components.test-numeric-reduction')
local TestState = require('test.base-evaluators.state-evaluator')
local TestOverrider = require('test.base-evaluators.overrider-evaluator')
local TestParameter = require('test.base-evaluators.parameter-evaluator')
local TestReduction = require('test.base-evaluators.reduction-evaluator')
local TestLocalEvaluator = require('test.local-evaluators.local-evaluator')
local TestConditionalModifier = require('test.modifiers.conditional-modifiers')
local TestProgressiveModifier = require('test.modifiers.progressive-modifiers')

print("\nSTART UNIT TESTS\n")

TestCounter()
TestCollection()
TestNumericAmount()
TestNumericFactor()
TestNumericReduction()

print()

TestState()
TestOverrider()
TestParameter()
TestReduction()

print()

TestLocalEvaluator()
TestConditionalModifier()
TestProgressiveModifier()

print()