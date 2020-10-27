local hides =
{
    { frame = PlayerFrame },
    { frame = TargetFrame, suppressShow = true, dontReveal = true },
    { frame = FocusFrame, suppressShow = true, dontReveal = true },
    { frame = MinimapCluster },
    { frame = ObjectiveTrackerFrame },
    { frame = ChatFrame1, suppressShow = true, onShow = ChatFrame1:GetScript ('OnShow') },
    { frame = ChatFrame1EditBox },
    { frame = ChatFrame1EditBox },
    { frame = GeneralDockManager },
    { frame = QuickJoinToastButton },
    { frame = ChatFrameMenuButton },
    { frame = ChatFrameChannelButton },
    { frame = MainMenuBar },
    { frame = MultiBarLeft },
    { frame = MultiBarRight }
}

local doHide = function()
    for k, hide in pairs (hides) do
        hide['frame']:Hide()
        if hide['suppressShow'] then hide['frame']:SetScript ('OnShow', function (self) self:Hide() end) end
    end
end

local undoHide = function()
    for k, hide in pairs (hides) do
        if hide['suppressShow'] then hide['frame']:SetScript ('OnShow', hide['onShow']) end
        if not hide['dontReveal'] then hide['frame']:Show() end
    end
end

local hidden = false

local trinityHideFrame = CreateFrame ('Frame')
trinityHideFrame:SetScript ('OnKeyDown', function (self, key)
    if key == 'TAB' then
        if hidden then undoHide() hidden = false
        else doHide() hidden = true end
    end
end)
trinityHideFrame:SetPropagateKeyboardInput (true)
