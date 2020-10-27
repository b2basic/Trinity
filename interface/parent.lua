local children =
{
    { frame = MultiBarBottomLeft }
}

for k, child in pairs (children) do
    child['parent'] = child['frame']:GetParent()
end

local doParent = function()
    for k, child in pairs (children) do
        child['frame']:SetParent (nil)
    end
end

local undoParent = function()
    for k, child in pairs (children) do
        child['frame']:SetParent (child['parent'])
    end
end

local parented = false

local trinityParentFrame = CreateFrame ('Frame')
trinityParentFrame:SetScript ('OnKeyDown', function (self, key)
    if key == 'TAB' then
        if parented then undoParent() parented = false
        else doParent() parented = true end
    end
end)
trinityParentFrame:SetPropagateKeyboardInput (true)