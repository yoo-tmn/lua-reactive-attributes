package.path = package.path .. ";./?.lua;./?/init.lua"

local TestCounterComponent = require('test.base-components.counter-component')
local TestNumericComponent = require('test.base-components.numeric-component')
local TestProductComponent = require('test.base-components.product-component')
local TestStorageComponent = require('test.base-components.storage-component')
local TestCondition = require('test.base-evaluators.condition-evaluator')
local TestOverrider = require('test.base-evaluators.overrider-evaluator')
local TestParameter = require('test.base-evaluators.parameter-evaluator')
local TestReduction = require('test.base-evaluators.reduction-evaluator')
local TestLocalEvaluator = require('test.local-evaluators.local-evaluator')
local TestConditionalModifier = require('test.modifiers.conditional-modifiers')
local TestProgressiveModifier = require('test.modifiers.progressive-modifiers')

print("\nSTART UNIT TESTS\n")

TestCounterComponent()
TestNumericComponent()
TestProductComponent()
TestStorageComponent()

print()

TestCondition()
TestOverrider()
TestParameter()
TestReduction()

print()

TestLocalEvaluator()
TestConditionalModifier()
TestProgressiveModifier()

print()