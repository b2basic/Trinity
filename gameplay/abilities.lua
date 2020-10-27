local MacroButton=CreateFrame('Button','MyMacroButton',nil,'SecureActionButtonTemplate');
MacroButton:RegisterForClicks('AnyUp');--   Respond to all buttons
MacroButton:SetAttribute('type','target');-- Set type to 'macro'
MacroButton:SetAttribute('unit','player');-- Set our macro text

CreateFrame ('Frame'):SetScript ('OnKeyDown', function (self, key)
    SetBindingClick('R', 'MyMacroButton')
    self:SetPropagateKeyboardInput (true)
end)