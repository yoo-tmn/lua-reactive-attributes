local AttributeMT = require('main.core-api.attribute-api.attribute-mt')

--- @return Attribute
function CreateAttribute()
    return setmetatable({ }, AttributeMT)
end

return CreateAttribute