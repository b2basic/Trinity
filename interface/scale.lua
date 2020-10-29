local trinity = select (2, ...)

local toscales =
{
    { frame = MultiBarBottomLeft, scale = 0.711 }
}

for k, toscale in pairs (toscales) do
    toscale['defaultScale'] = toscale['frame']:GetScale()
end

trinity['scale'] = function()
    for k, toscale in pairs (toscales) do toscale['frame']:SetScale (toscale['scale']) end
end

trinity['unscale'] = function()
    for k, toscale in pairs (toscales) do toscale['frame']:SetScale (toscale['defaultScale']) end
end
