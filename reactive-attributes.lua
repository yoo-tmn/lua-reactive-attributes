local CreateAttribute = require('main.core-api.attribute-api.create-attribute')
local CreateComponent = require('main.core-api.attribute-api.create-component')
local CreateEvaluator = require('main.core-api.attribute-api.create-evaluator')
local CreateContainer = require('main.core-api.container-api.create-container')
local BaseComponents = require('main.base-api.components.export')
local BaseEvaluators = require('main.base-api.evaluators.export')
local CreateConditionalModifier = require('main.base-api.modifiers.create-conditional-modifier')
local CreateProgressiveModifier = require('main.base-api.modifiers.create-progressive-modifier')

local ReactiveAttributes = {
    -- core-api
    CreateAttribute = CreateAttribute,
    CreateComponent = CreateComponent,
    CreateEvaluator = CreateEvaluator,
    CreateContainer = CreateContainer,

    -- base-api components
    CreateCollectionComponent = BaseComponents.CreateCollectionComponent,
    CreateCumulativeComponent = BaseComponents.CreateCumulativeComponent,
    CreateComplementComponent = BaseComponents.CreateComplementComponent,
    CreateDiminishingComponent = BaseComponents.CreateDiminishingComponent,
    CreateMultiplyingComponent = BaseComponents.CreateMultiplyingComponent,

    -- base-api evaluators
    CreateParameter = BaseEvaluators.CreateParameter,
    CreateReduction = BaseEvaluators.CreateReduction,

    -- base-api modifiers
    CreateConditionalModifier = CreateConditionalModifier,
    CreateProgressiveModifier = CreateProgressiveModifier,
}

return ReactiveAttributes