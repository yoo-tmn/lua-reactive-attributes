local CreateComponent = require('main.core-api.attribute-api.create-component')
local CreateEvaluator = require('main.core-api.attribute-api.create-evaluator')
local CreateContainer = require('main.core-api.container-api.create-container')

local CreateCounterComponent = require('main.base-api.base-components.create-counter-component')
local CreateNumericComponent = require('main.base-api.base-components.create-numeric-component')
local CreateProductComponent = require('main.base-api.base-components.create-product-component')
local CreateStorageComponent = require('main.base-api.base-components.create-storage-component')

local CreateCondition = require('main.base-api.base-evaluators.create-condition')
local CreateOverrider = require('main.base-api.base-evaluators.create-overrider')
local CreateParameter = require('main.base-api.base-evaluators.create-parameter')
local CreateReduction = require('main.base-api.base-evaluators.create-reduction')

local CreateConditionalModifier = require('main.base-api.reactive-modifiers.create-conditional-modifier')
local CreateProgressiveModifier = require('main.base-api.reactive-modifiers.create-progressive-modifier')

local ReactiveAttributes = {
    CreateComponent = CreateComponent,
    CreateEvaluator = CreateEvaluator,
    CreateContainer = CreateContainer,

    CreateCounterComponent = CreateCounterComponent,
    CreateNumericComponent = CreateNumericComponent,
    CreateProductComponent = CreateProductComponent,
    CreateStorageComponent = CreateStorageComponent,

    CreateCondition = CreateCondition,
    CreateOverrider = CreateOverrider,
    CreateParameter = CreateParameter,
    CreateReduction = CreateReduction,

    CreateConditionalModifier = CreateConditionalModifier,
    CreateProgressiveModifier = CreateProgressiveModifier,
}

return ReactiveAttributes