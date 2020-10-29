local trinity = select (2, ...)

local moves =
{
    { frame = BuffFrame, points = { {'TOPRIGHT', WorldFrame, 'TOPRIGHT', -10, -10 } } }
}

for k, move in pairs (moves) do
    move['defaultPoints'] = {}
    for i = 1, move['frame']:GetNumPoints() do
        move['defaultPoints'][i] = { move['frame']:GetPoint (i) }
    end
end

trinity['move'] = function()
    for k, move in pairs (moves) do
        move['frame']:ClearAllPoints()
        for k, point in pairs (move['points']) do
            move['frame']:SetPoint (unpack (point))
        end
    end
end

trinity['unmove'] = function()
    for k, move in pairs (moves) do
        move['frame']:ClearAllPoints()
        for k, point in pairs (move['defaultPoints']) do
            move['frame']:SetPoint (unpack (point))
        end
    end
end
