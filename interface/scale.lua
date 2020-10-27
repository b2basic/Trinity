local toscales =
{
    { frame = MultiBarBottomLeft, scale = 0.711 }
}

for k, toscale in pairs (toscales) do
    toscale['defaultScale'] = toscale['frame']:GetScale()
end

local doScale = function()
    for k, toscale in pairs (toscales) do toscale['frame']:SetScale (toscale['scale']) end
end

local undoScale = function()
    for k, toscale in pairs (toscales) do toscale['frame']:SetScale (toscale['defaultScale']) end
end

local scaled = false

local trinityScaleFrame = CreateFrame ('Frame')
trinityScaleFrame:SetScript ('OnKeyDown', function (self, key)
    if key == 'TAB' then
        if scaled then undoScale() scaled = false
        else doScale() scaled = true end
    end
end)
trinityScaleFrame:SetPropagateKeyboardInput (true)
