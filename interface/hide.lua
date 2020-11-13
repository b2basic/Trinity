local trinity = select (2, ...)

local hides =
{
    { frame = PlayerFrame },
    { frame = TargetFrame, dontReveal = true, conditional = "[@target, exists] show; [@target, noexists] hide" },
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
    { frame = MicroButtonAndBagsBar },
    { frame = MainMenuMicroButton },
    { frame = StoreMicroButton },
    { frame = EJMicroButton },
    { frame = CollectionsMicroButton },
    { frame = LFDMicroButton },
    { frame = GuildMicroButton },
    { frame = QuestLogMicroButton },
    { frame = AchievementMicroButton },
    { frame = TalentMicroButton },
    { frame = SpellbookMicroButton },
    { frame = CharacterMicroButton },
    { frame = CompactRaidFrameContainer, dontReveal = true },
    { frame = CompactRaidFrameManager, dontReveal = true },
    { frame = Boss1TargetFrame, dontReveal = true },
}

trinity['hide'] = function()
    for k, hide in pairs (hides) do
        RegisterAttributeDriver (hide['frame'], "state-visibility", "hide")
    end
end

trinity['unhide'] = function()
    for k, hide in pairs (hides) do
        RegisterAttributeDriver (hide['frame'], "state-visibility", hide['conditional'] or "")
        if not hide['dontReveal'] then hide['frame']:Show() end
    end
end
