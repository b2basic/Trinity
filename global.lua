local trinity = select (2, ...)

trinity['trinitied'] = false

local frame = CreateFrame ('Frame')
frame:SetScript ('OnKeyDown', function (self, key)
    if key == 'TAB' then
        if trinity['trinitied'] then
            trinity['unhide']()
            trinity['unmove']()
            trinity['unparent']()
            trinity['unscale']()
            trinity['untarget']()
            trinity['trinitied'] = false
        else
            trinity['hide']()
            trinity['move']()
            trinity['parent']()
            trinity['scale']()
            trinity['target']()
            trinity['trinitied'] = true
        end
    end
end)
frame:SetPropagateKeyboardInput (true)