function RetroHelper_CreateOptionsFrame()
	local RH_ONSHOW = 1 -- for CBoxhander
	local RH_ONCLICK = 2 -- for CBoxhander

	local frame = CreateFrame("Frame", "RetroHelperOptionsFrame")
	tinsert(UISpecialFrames, "RetroHelperOptionsFrame")
	frame:SetScale(.80)

	frame:SetWidth(600)
	frame:SetHeight(560)

	frame:SetPoint("CENTER", nil, "CENTER", 0, 0)
	frame:SetBackdrop(
		{
			bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
			tile = true,
			tileSize = 32,
			edgeSize = 32,
			insets = {left = 11, right = 12, top = 12, bottom = 11}
		}
	)
	frame:SetBackdropColor(.01, .01, .01, .91)

	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetClampedToScreen(false)
	frame:RegisterForDrag("LeftButton")
	frame:Hide()
	frame:SetScript(
		"OnMouseDown",
		function()
			if arg1 == "LeftButton" and not this.isMoving then
				this:StartMoving()
				this.isMoving = true
			end
		end
	)
	frame:SetScript(
		"OnMouseUp",
		function()
			if arg1 == "LeftButton" and this.isMoving then
				this:StopMovingOrSizing()
				this.isMoving = false
			end
		end
	)
	frame:SetScript(
		"OnHide",
		function()
			if this.isMoving then
				this:StopMovingOrSizing()
				this.isMoving = false
			end
		end
	)
	-- MenuTitle Frame
	local texture_title = frame:CreateTexture("RetroHelperOptionFrameTitle")
	texture_title:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header", true)
	texture_title:SetWidth(300)
	texture_title:SetHeight(60)
	texture_title:SetPoint("CENTER", frame, "TOP", 0, -20)
	frame.texture_title = texture_title

	-- MenuTitle FontString
	local fs_title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	fs_title:SetPoint("CENTER", frame.texture_title, "CENTER", 0, 12)
	fs_title:SetText("|cff00D8FF" .. "Retro Helper" .. "|cffFFFFFF" .. " Config")
	frame.fs_title = fs_title
	--
	-- Close Setting Window Button
	local btn_close = CreateFrame("Button", "RetroHelperOptionFrameCloseButton", frame, "UIPanelCloseButton")
	btn_close:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -12, -12)
	btn_close:SetWidth(32)
	btn_close:SetHeight(32)

	frame.btn_close = btn_close

	frame.btn_close:SetScript(
		"OnClick",
		function()
			this:GetParent():Hide()
		end
	)

	local function CBoxHandler(option)
		local cbName = this:GetName()
		if (option == RH_ONSHOW) then
			for k1, v1 in ipairs(RetroHelper_CFG) do
				for k2, v2 in ipairs(RetroHelper_CFG[k1]) do
					if (v2[2] == cbName) then
						if (v2[4] == true) then
							this:SetChecked(true)
						else
							this:SetChecked(false)
						end
					end
				end
			end
		elseif (option == RH_ONCLICK) then
			for k1, v1 in ipairs(RetroHelper_CFG) do
				if (k1 == 4) then -- Broadcast
					for k2, v2 in ipairs(RetroHelper_CFG[k1]) do
						if (v2[2] == cbName) then
							RH_CheckboxQB01:SetChecked(false)
							RH_CheckboxQB02:SetChecked(false)
							RH_CheckboxQB03:SetChecked(false)
							RH_CheckboxQB04:SetChecked(false)
							for k3, v3 in ipairs(RetroHelper_CFG[k1]) do
								v3[4] = false
							end
							this:SetChecked(true)
							v2[4] = true
						end
					end
				elseif (k1 == 6) then -- Battle Ground
					for k2, v2 in ipairs(RetroHelper_CFG[k1]) do
						if (v2[2] == cbName) then
							RH_CheckboxBG01:SetChecked(false)
							RH_CheckboxBG02:SetChecked(false)
							RH_CheckboxBG03:SetChecked(false)
							RH_CheckboxBG04:SetChecked(false)							
							for k3, v3 in ipairs(RetroHelper_CFG[k1]) do
								v3[4] = false
							end
							this:SetChecked(true)
							v2[4] = true
							RetroHelper_Variables.lastchatCommand = ""
							RetroHelper_Queue()
						end
					end
				else -- another
					for k2, v2 in ipairs(RetroHelper_CFG[k1]) do
						if (v2[2] == cbName) then
							if (this:GetChecked()) then
								v2[4] = true
							else
								v2[4] = false
							end
						end
					end
				end
			end
		end
	end

	local function CreatCBoxs(hParent, offsetX, offsetY, gName, key)
		local cFrame = CreateFrame("Frame", gName, hParent)
		cFrame:SetPoint("TOPLEFT", hParent, "TOPLEFT", offsetX, offsetY)
		cFrame:SetWidth(11)
		cFrame:SetHeight(11)

		local fgTxt = cFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		fgTxt:SetPoint("TOPLEFT", cFrame, "TOPLEFT", 0, 0)
		fgTxt:SetTextColor(1, 1, 1, 1)
		fgTxt:SetText(gName)
		cFrame.fgTxt = fgTxt
		cFrame.checkBox = {}

		for k, v in ipairs(RetroHelper_CFG[key]) do
			local cb = CreateFrame("CheckButton", v[2], frame, "UICheckButtonTemplate")
			cb:SetPoint("TOPLEFT", cFrame, "BOTTOMLEFT", 8, -(4 + (k - 1) * 14))
			cb:SetWidth(16)
			cb:SetHeight(16)

			local labelString = getglobal(cb:GetName() .. "Text")
			labelString:SetText("  " .. v[3])

			cb:SetScript(
				"OnShow",
				function()
					CBoxHandler(RH_ONSHOW)
				end
			)
			cb:SetScript(
				"OnClick",
				function()
					CBoxHandler(RH_ONCLICK)
				end
			)

			cFrame.checkBox[k] = cb
		end
		return cFrame
	end

	frame.quests_world = CreatCBoxs(frame, 25, -45, "Auto Repeat : World Quests", 1)
	frame.quests_ragefire = CreatCBoxs(frame, 25, -311, "Auto Repeat : Ragefire Quests", 2)
	frame.quests_pvp = CreatCBoxs(frame, 25, -439, "Auto Repeat : PvP Quest Master", 3)
	frame.quest_broadcast = CreatCBoxs(frame, 315, -45, "Quest Broadcast", 4)
	frame.autoloot = CreatCBoxs(frame, 310, -133, "Autoloot & Need Roll", 5)
	frame.auto_queue = CreatCBoxs(frame, 315, -259, "Auto BG Queue", 6)
	frame.etc_cfg = CreatCBoxs(frame, 315, -345, "ETC Config", 7)

	return frame
end

function RetroHelper_Option()
	if RetroHelper_PopupMenuFrame:IsShown() then
		RetroHelper_PopupMenuFrame:Hide()
	else
		RetroHelper_PopupMenuFrame:Show()
	end
end
