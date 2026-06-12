local CreateAttribute = require('main.core-api.attribute-api.create-attribute')
local CreateComponent = require('main.core-api.attribute-api.create-component')
local CreateEvaluator = require('main.core-api.attribute-api.create-evaluator')
local CreateContainer = require('main.core-api.container-api.create-container')
local CreateCounterComponent = require('main.base-api.base-components.create-counter-component')
local CreateCollectionComponent = require('main.base-api.base-components.create-collection-component')
local CreateAmountComponent = require('main.base-api.base-components.numerics.create-amount-component')
local CreateFactorComponent = require('main.base-api.base-components.numerics.create-factor-component')
local CreateReductionComponent = require('main.base-api.base-components.numerics.create-reduction-component')
local CreateStateEvaluator = require('main.base-api.base-evaluators.create-state-evaluator')
local CreateOverriderEvaluator = require('main.base-api.base-evaluators.create-overrider-evaluator')
local CreateParameterEvaluator = require('main.base-api.base-evaluators.create-parameter-evaluator')
local CreateReductionEvaluator = require('main.base-api.base-evaluators.create-reduction-evaluator')
local CreateConditionalModifier = require('main.base-api.reactive-modifiers.create-conditional-modifier')
local CreateProgressiveModifier = require('main.base-api.reactive-modifiers.create-progressive-modifier')

local ReactiveAttributes = {
    CreateAttribute = CreateAttribute,
    CreateComponent = CreateComponent,
    CreateEvaluator = CreateEvaluator,
    CreateContainer = CreateContainer,

    CreateCounterComponent = CreateCounterComponent,
    CreateCollectionComponent = CreateCollectionComponent,
    CreateAmountComponent = CreateAmountComponent,
    CreateFactorComponent = CreateFactorComponent,
    CreateReductionComponent = CreateReductionComponent,

    CreateStateEvaluator = CreateStateEvaluator,
    CreateOverriderEvaluator = CreateOverriderEvaluator,
    CreateParameterEvaluator = CreateParameterEvaluator,
    CreateReductionEvaluator = CreateReductionEvaluator,

    CreateConditionalModifier = CreateConditionalModifier,
    CreateProgressiveModifier = CreateProgressiveModifier,
}

return ReactiveAttributes