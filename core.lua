local threshold = -5;


if(select(2, UnitClass('player')) ~= 'SHAMAN') then return end

local f = CreateFrame('Frame', 'FulminateHelper', UIParent);
f.buttons = {};

local function GetFulminationCharges()
	aura = GetSpellInfo(324);
	local name, rank, icon, count, debuffType, duration, expirationTime, caster = UnitAura('player', aura, nil, 'HELPFUL');
	return (count or 0);
end

local function RetrieveButtons(self)
	local action = self.action;
	local _, globalID, _ = GetActionInfo(action);
	if globalID == 8042 then
		f.buttons[self:GetName()] = self;
	end
end

local function UpdateCount(self)
	for name, button in pairs(self.buttons) do
		if(button) then
			local text = _G[name..'Count'];
			local count = GetFulminationCharges();
			if(count>1) then
				if(count >= f.maxCharges + f.threshold) then 
					ActionButton_ShowOverlayGlow(button);
				else 
					ActionButton_HideOverlayGlow(button);
				end
				text:SetText(count);
			else
				text:SetText("");
				ActionButton_HideOverlayGlow(button);
			end
		end
	end
end

local function CheckSpec(self)
	if GetSpecialization()==1 then 
		self:RegisterEvent('UNIT_AURA');
		f.maxCharges = IsSpellKnown(157774) and 20 or 15;
		hooksecurefunc('ActionButton_Update', RetrieveButtons)
		UpdateCount(self)
	else
		self:UnregisterEvent("UNIT_AURA");
	end
end


f.threshold = threshold;

f:RegisterEvent("PLAYER_ENTERING_WORLD");
f:RegisterEvent("PLAYER_LOGIN");
f:RegisterEvent('PLAYER_TALENT_UPDATE');

f:SetScript("OnEvent", function(self, event, ...) 
	if(event=="UNIT_AURA") then 
		UpdateCount(self);
	elseif(event=="PLAYER_LOGIN" or event=="PLAYER_ENTERING_WORLD" or event=="PLAYER_TALENT_UPDATE") then
		CheckSpec(self)
	end
end);


