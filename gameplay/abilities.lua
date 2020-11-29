local trinity = select (2, ...)

for _, trinityUnit in pairs ({ 'target', 'focus' }) do
    for i = 1, 12 do
        local b = CreateFrame ('Button', 'TrinityAbility' .. trinityUnit .. i, nil, 'SecureActionButtonTemplate')
        b:SetAttribute ('type', 'macro')
    end
end

local bindings = {}

local collectBindings = function()
    bindings = {}
    for i = 1, 12 do
        actionType, id, subType = GetActionInfo (i)
        key = GetBindingKey ('ACTIONBUTTON' .. i)
        if actionType and key and key:sub (1, 6) == 'SHIFT-' then
            bindings[i] = { key = key:sub (7) }
            if actionType == 'spell' then
                bindings[i]['macrotext'] = '/cast [] ' .. GetSpellInfo (id)
            elseif actionType == 'macro' then
                bindings[i]['macrotext'] = GetMacroBody (id)
            end
        end
    end
end

local deleteTrinityMacros = function()
    local trinityMacros = {}
    for i = 1, GetNumMacros() do
        local name = GetMacroInfo (i)
        if name:sub (1, 8) == '_trinity' then
            trinityMacros[#trinityMacros + 1] = name
        end
    end
    for _, name in pairs (trinityMacros) do
        DeleteMacro (name)
    end
end

local createTrinityMacros = function()
    for arenaIndex = 1, 3 do
        for i, binding in pairs (bindings) do
            local name = '_trinity_t' .. arenaIndex .. 'b' .. i
            local macrotext = binding['macrotext']:gsub ('%[', '[@arena' .. arenaIndex .. ',')
            CreateMacro (name, "INV_MISC_QUESTIONMARK", macrotext)
        end
    end
end

local setBindings = function()
    deleteTrinityMacros()
    createTrinityMacros()
    for i, binding in pairs (bindings) do
        for trinityUnit, mod in pairs (trinity['mods']) do
            if trinityUnit ~= 'other' then
                SetBindingClick (mod .. '-' .. binding['key'], 'TrinityAbility' .. trinityUnit .. i)
                local macrotext = binding['macrotext']:gsub ('%[', '[@' .. trinityUnit .. ',')
                _G['TrinityAbility' .. trinityUnit .. i]:SetAttribute ('macrotext', macrotext)
            end
        end
        SetBinding ('ALT-CTRL-' .. binding['key'], 'ACTIONBUTTON' .. i)
        for arenaIndex = 1, 3 do
            PickupMacro ('_trinity_t' .. arenaIndex .. 'b' .. i)
            PlaceAction (i + arenaIndex * 12)
        end
    end
end

local resetBindings = function()
    for i, binding in pairs (bindings) do
        SetBinding ('ALT-CTRL-' .. binding['key'])
        SetBinding ('SHIFT-' .. binding['key'], 'ACTIONBUTTON' .. i)
    end
end

trinity['abilities'] = function()
    collectBindings()
    setBindings()
    ChangeActionBarPage (2)
end

trinity['unabilities'] = function()
    resetBindings()
    deleteTrinityMacros()
    ChangeActionBarPage (1)
end