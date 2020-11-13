local trinity = select (2, ...)

local bindings = {}

for i = 1, 12 do
    local t = CreateFrame ('Button', 'TrinityTargetAbilityButton' .. i, nil, 'SecureActionButtonTemplate')
    t:SetAttribute ('type', 'macro')
    local f = CreateFrame ('Button', 'TrinityFocusAbilityButton' .. i, nil, 'SecureActionButtonTemplate')
    f:SetAttribute ('type', 'macro')
end

local collectBindings = function()
    bindings = {}
    for i = 1, 12 do
        actionType, id, subType = GetActionInfo (i)
        key = GetBindingKey ('ACTIONBUTTON' .. i)
        if actionType and key then
            bindings[i] = { key = key:sub (7) }
            if actionType == 'spell' then
                bindings[i]['spell'] = GetSpellInfo (id)
            end
        end
    end
end

local setBindings = function()
    for i, binding in pairs (bindings) do
        SetBinding ('SHIFT-' .. binding['key'], 'CLICK TrinityTargetAbilityButton' .. i .. ':LeftButton')
        SetBinding ('CTRL-' .. binding['key'], 'CLICK TrinityFocusAbilityButton' .. i .. ':LeftButton')
        if (binding['spell']) then
            _G['TrinityTargetAbilityButton' .. i]:SetAttribute ('macrotext', '/cast [@target] ' .. binding['spell'])
            _G['TrinityFocusAbilityButton' .. i]:SetAttribute ('macrotext', '/cast [@focus, exists] ' .. binding['spell'])
        end
    end
end

local resetBindings = function()
    for i, binding in pairs (bindings) do
        SetBinding ('SHIFT-' .. binding['key'], 'ACTIONBUTTON' .. i)
    end
end

trinity['abilities'] = function()
    collectBindings()
    setBindings()
end

trinity['unabilities'] = function()
    resetBindings()
end