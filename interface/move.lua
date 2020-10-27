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

local doMoves = function()
    for k, move in pairs (moves) do
        move['frame']:ClearAllPoints()
        for k, point in pairs (move['points']) do
            move['frame']:SetPoint (unpack (point))
        end
    end
end

local undoMoves = function()
    for k, move in pairs (moves) do
        move['frame']:ClearAllPoints()
        for k, point in pairs (move['defaultPoints']) do
            move['frame']:SetPoint (unpack (point))
        end
    end
end

local moved = false

local trinityMoveFrame = CreateFrame ('Frame')
trinityMoveFrame:SetScript ('OnKeyDown', function (self, key)
    if key == 'TAB' then
        if moved then undoMoves() moved = false
        else doMoves() moved = true end
    end
end)
trinityMoveFrame:SetPropagateKeyboardInput (true)
