local trinity = select (2, ...)

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

trinity['hide'] = function()
    for k, hide in pairs (hides) do
        hide['frame']:Hide()
        if hide['suppressShow'] then hide['frame']:SetScript ('OnShow', function (self) self:Hide() end) end
    end
end

trinity['unhide'] = function()
    for k, hide in pairs (hides) do
        if hide['suppressShow'] then hide['frame']:SetScript ('OnShow', hide['onShow']) end
        if not hide['dontReveal'] then hide['frame']:Show() end
    end
end
