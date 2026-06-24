local CreateAttribute = require('main.core-api.attribute-api.create-attribute')
local CreateComponent = require('main.core-api.attribute-api.create-component')
local CreateEvaluator = require('main.core-api.attribute-api.create-evaluator')
local CreateContainer = require('main.core-api.container-api.create-container')
local Evaluate = require('main.core-api.attribute-api.evaluate')
local CreateCounter = require('main.util.counter.create-counter-component')
local CreateModifier = require('main.base-api.modifiers.create-modifier')
local BaseComponents = require('main.base-api.components.export')
local BaseEvaluators = require('main.base-api.evaluators.export')
local CreateModifierTag = require('main.base-api.modifiers.create-modifier-tag')
local AttachModifierTag = require('main.base-api.modifiers.attach-modifier-tag')


local ReactiveAttributes = {
    -- core-api
    CreateAttribute = CreateAttribute,
    CreateComponent = CreateComponent,
    CreateEvaluator = CreateEvaluator,
    CreateContainer = CreateContainer,
    Evaluate = Evaluate,

    -- util
    CreateCounter = CreateCounter,

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
    CreateModifier = CreateModifier,
    CreateModifierTag = CreateModifierTag,
    AttachModifierTag = AttachModifierTag,
}

return ReactiveAttributes