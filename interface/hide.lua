local trinity = select (2, ...)

local hides =
{
    { frame = PlayerFrame },
    { frame = TargetFrame },
    { frame = FocusFrame },
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
    { frame = CompactRaidFrameContainer },
    { frame = CompactRaidFrameManager },
    { frame = Boss1TargetFrame },
    { frame = Boss2TargetFrame },
    { frame = Boss3TargetFrame },
    { frame = PartyMemberFrame1 },
    { frame = PartyMemberFrame2 },
    { frame = PartyMemberFrame3 },
    { frame = PartyMemberFrame4 },
}

for k, hide in pairs (hides) do
    hide['parent'] = hide['frame']:GetParent()
end

local hideFrame = CreateFrame ('Frame')
RegisterAttributeDriver (hideFrame, 'state-visibility', 'hide')

trinity['hide'] = function()
    for k, hide in pairs (hides) do
        hide['frame']:SetParent (hideFrame)
    end
end

trinity['unhide'] = function()
    for k, hide in pairs (hides) do
        hide['frame']:SetParent (hide['parent'])
    end
end
