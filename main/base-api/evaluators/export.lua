local CreateParameter = require('main.base-api.evaluators.create-parameter')
local CreateReduction = require('main.base-api.evaluators.create-reduction')

local BaseEvaluators = {
    CreateParameter = CreateParameter,
    CreateReduction = CreateReduction,
}

return BaseEvaluators