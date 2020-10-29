local trinity = select (2, ...)

local children =
{
    { frame = MultiBarBottomLeft }
}

for k, child in pairs (children) do
    child['parent'] = child['frame']:GetParent()
end

trinity['parent'] = function()
    for k, child in pairs (children) do
        child['frame']:SetParent (nil)
    end
end

trinity['unparent'] = function()
    for k, child in pairs (children) do
        child['frame']:SetParent (child['parent'])
    end
end
