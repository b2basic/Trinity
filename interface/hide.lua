local trinity = select (2, ...)

local hides =
{
    { frame = PlayerFrame },
    { frame = TargetFrame, dontReveal = true },
    { frame = FocusFrame, dontReveal = true },
    { frame = MinimapCluster },
    { frame = ObjectiveTrackerFrame },
    { frame = ChatFrame1 },
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

for k, hide in pairs (hides) do
    hide['OnEvent'] = hide['frame']:GetScript ('OnEvent')
end

trinity['hide'] = function()
    for k, hide in pairs (hides) do
        RegisterAttributeDriver (hide['frame'], "state-visibility", "hide")
        hide['frame']:SetScript ('OnEvent', nil)
    end
end

trinity['unhide'] = function()
    for k, hide in pairs (hides) do
        RegisterAttributeDriver (hide['frame'], "state-visibility", "")
        hide['frame']:SetScript ('OnEvent', hide['OnEvent'])
        if not hide['dontReveal'] then hide['frame']:Show() end
    end
end
