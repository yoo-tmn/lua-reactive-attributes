local CreateCollectionComponent = require('main.base-api.components.create-collection-component')
local CreateComplementComponent = require('main.base-api.components.create-complement-component')
local CreateCumulativeComponent = require('main.base-api.components.create-cumulative-component')
local CreateDiminishingComponent = require('main.base-api.components.create-diminishing-component')
local CreateMultiplyingComponent = require('main.base-api.components.create-multiplying-component')

local BaseComponents = {
    CreateCollectionComponent = CreateCollectionComponent,
    CreateCumulativeComponent = CreateCumulativeComponent,
    CreateComplementComponent = CreateComplementComponent,
    CreateDiminishingComponent = CreateDiminishingComponent,
    CreateMultiplyingComponent = CreateMultiplyingComponent,
}

return BaseComponents