local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

-- local epgpaisload = IsAddOnLoaded("EPGPAttandance")

if not AS:IsAddonLODorEnabled("EPGP_Auction") then return end
local EPAuc = true
local function epgpat_onshow()
	-- if EPGPAttendanceFrame then
	-- 	if EPGPAttendanceFrame:IsShown() then
			S:HandleScrollBar(ScrollTable1ScrollFrameScrollBar)
			S:HandleScrollBar(ScrollTable2ScrollFrameScrollBar)
			S:HandleScrollBar(ScrollTable3ScrollFrameScrollBar)
			S:HandleScrollBar(ScrollTable4ScrollFrameScrollBar)
	-- 	end
	-- end


		local frames = {
			-- "ScrollTable1ScrollFrame",
			"ScrollTable1",
			"ScrollTable2",
			"ScrollTable3",
			"ScrollTable4",
			-- "ScrollTable1ScrollFrameScrollChildFrame",
			-- "ScrollTable2",
			-- "ScrollTable3",

		}
		for _,frame in ipairs(frames) do
			frame = _G[frame]
			if frame then
				-- print(frame)
				frame:StripTextures()
				frame:CreateBackdrop("Transparent")
			end
		end

		local framess = {
			-- "ScrollTable1ScrollFrame",
			-- "ScrollTable1",
			-- "ScrollTable2",
			-- "ScrollTable3",
			-- "ScrollTable4",
			"ScrollTable1ScrollThroughBorder",
			"ScrollTable2ScrollThroughBorder",
			"ScrollTable3ScrollThroughBorder",
			"ScrollTable1ScrollTrough",
			"ScrollTable2ScrollTrough",
			"ScrollTable3ScrollTrough",
			-- "ScrollTable2",
			-- "ScrollTable3",

		}
		for _,sframe in ipairs(framess) do
			sframe = _G[sframe]
			if sframe then
				-- print(frame)
				sframe:StripTextures()
				-- frame:CreateBackdrop("Transparent")
			end
		end


		-- local frames = {
		-- 	"ScrollTable1ScrollFrameScrollChildFrame",
		-- 	"ScrollTable2ScrollFrameScrollChildFrame",
		-- 	"ScrollTable3ScrollFrameScrollChildFrame",

		-- }
		-- for frame in ipairs(frames) do
		-- 	if frame then
		-- 		frame:StripTextures()
		-- 		frame:SetBackdrop("Transparent")
		-- 	end
		-- end
end

S:AddCallbackForAddon("EPGP_Auction", "EPGP_Auction", function()
	if not E.private.addOnSkins.EPGP_Auction then return end

	local EPGPUI = EPGP and EPGP:GetModule("ui", true)
	if not EPGPUI then return end

	local function SkinEPGP()
		-- Main Frame
		-- if GetAddOnMetadata("EPGP_Auction","Version") == "6.01" then
		-- 	EPAuc = true
		-- end
		EPGPFrame:StripTextures()
		EPGPFrame:CreateBackdrop("Transparent")
		EPGPFrame.backdrop:Point("TOPLEFT", 11, -12)
		EPGPFrame.backdrop:Point("BOTTOMRIGHT", -32, 76)

		S:SetUIPanelWindowInfo(EPGPFrame, "width", nil, nil, nil, true)
		S:SetBackdropHitRect(EPGPFrame)
		-- for https://github.com/fxpw/EPGP
		local num = select("#",EPGPFrame:GetChildren())
		local closeButton, checkBoxBorder, main, _
		if num == 8 then
			closeButton, checkBoxBorder, _, _, _,_, main = EPGPFrame:GetChildren()
		else
			closeButton, checkBoxBorder, _, _, _, main = EPGPFrame:GetChildren()
		end

		S:HandleCloseButton(closeButton, EPGPFrame.backdrop)

		checkBoxBorder:StripTextures()
		checkBoxBorder:Point("TOPRIGHT", EPGPFrame, "TOPRIGHT", -49, -38)
		S:HandleCheckBox(checkBoxBorder:GetChildren())

		main:Width(329)
		main:Point("TOPLEFT", 20, -70)

		EPGPScrollFrame:SetTemplate("Transparent")
		EPGPScrollFrame:Width(304)
		EPGPScrollFrame:Point("TOPRIGHT", 1, 1)
		EPGPScrollFrame:Point("BOTTOMRIGHT", 1, 8)

		EPGPScrollFrameScrollBarBorder:StripTextures()
		S:HandleScrollBar(EPGPScrollFrameScrollBar)
		EPGPScrollFrameScrollBar:Point("TOPLEFT", EPGPScrollFrame, "TOPRIGHT", 3, -19)
		EPGPScrollFrameScrollBar:Point("BOTTOMLEFT", EPGPScrollFrame, "BOTTOMRIGHT", 3, 19)

		local awardEP, awardGP, logButton, decay, tabl
		num = select("#",main:GetChildren())
		if num == 5 then
			awardEP, awardGP, logButton, decay, tabl = main:GetChildren()
		else
			awardEP, logButton, decay, tabl = main:GetChildren()
		end
		for _, header in ipairs(tabl.headers) do
			header:StripTextures()
			header:StyleButton()
		end

		for _, row in ipairs(tabl.rowFrame.rows) do
			row.check:SetDrawLayer("BORDER")
		end

		S:HandleButton(awardEP)
		if awardGP then
			S:HandleButton(awardGP)
		end
		S:HandleButton(logButton)
		S:HandleButton(decay)
		-- logButton:ClearAllPoints()
		logButton:Point("BOTTOMRIGHT", -5, 0)
		decay:Point("RIGHT", logButton, "LEFT", -3, 0)

		local statusText = select(2, main:GetRegions())
		statusText:Point("BOTTOMLEFT", awardEP, "TOPLEFT", 0, 7)
		statusText:Point("BOTTOMRIGHT", logButton, "TOPRIGHT", 0, 7)
		-- logButton:Point("BOTTOMRIGHT", -5, 0)
		-- decay:Point("RIGHT", logButton, "LEFT", -3, 0)

		-- local statusText = select(2, main:GetRegions())
		-- statusText:Point("BOTTOMLEFT", awardEP, "TOPLEFT", 0, 7)
		-- statusText:Point("BOTTOMRIGHT", logButton, "TOPRIGHT", 0, 7)

		-- First Side Frame
		EPGPSideFrame:StripTextures()
		EPGPSideFrame:SetTemplate("Transparent")
		EPGPSideFrame:Point("TOPLEFT", EPGPFrame, "TOPRIGHT", -33, -12)

		S:HandleCloseButton(EPGPSideFrame:GetChildren(), EPGPSideFrame)

		S:HandleDropDownBox(EPGPSideFrameEPControlDropDown, 190)

		S:HandleEditBox(EPGPSideFrameEPControlOtherEditBox)
		S:HandleEditBox(EPGPSideFrameEPControlEditBox)

		EPGPSideFrameEPControlOtherEditBox:Height(22)
		EPGPSideFrameEPControlEditBox:Height(22)
		EPGPSideFrameEPControlOtherEditBox:Point("RIGHT", -14, 0)


		local parentFrame = EPGPSideFrameEPControlEditBox:GetParent()
		S:HandleButton(parentFrame.button)
		EPGPSideFrameEPControlEditBox:Point("RIGHT", parentFrame.button, "LEFT", -4, 0)
		parentFrame.button:Point("RIGHT", EPGPSideFrameEPControlOtherEditBox, "RIGHT", 1, 0)

		-- Second Side Frame
		EPGPSideFrame2:EnableMouse(true)
		EPGPSideFrame2:SetTemplate("Transparent")
		EPGPSideFrame2:Point("BOTTOMLEFT", EPGPFrame, "BOTTOMRIGHT", -33, 76)

		S:HandleCloseButton(EPGPSideFrame2:GetChildren(), EPGPSideFrame2)

		S:HandleDropDownBox(EPGPSideFrame2EPControlDropDown, 190)

		S:HandleEditBox(EPGPSideFrame2EPControlOtherEditBox)
		S:HandleEditBox(EPGPSideFrame2EPControlEditBox)

		EPGPSideFrame2EPControlOtherEditBox:Point("RIGHT", -14, 0)
		EPGPSideFrame2EPControlOtherEditBox:Height(22)
		EPGPSideFrame2EPControlEditBox:Height(22)

		parentFrame = EPGPSideFrame2EPControlEditBox:GetParent()

		S:HandleButton(parentFrame.button)
		parentFrame.button:Point("RIGHT", EPGPSideFrame2EPControlOtherEditBox, "RIGHT", 1, 0)
		EPGPSideFrame2EPControlEditBox:Point("RIGHT", parentFrame.button, "LEFT", -4, 0)

		S:HandleCheckBox(parentFrame.recurring)
		parentFrame.recurring:Point("TOP", EPGPSideFrame2EPControlEditBox, "BOTTOMLEFT", 0, -6)

		S:HandleNextPrevButton(parentFrame.decButton, "down")
		parentFrame.decButton:Size(18)

		S:HandleNextPrevButton(parentFrame.incButton, "up")
		parentFrame.incButton:Size(18)

		parentFrame.decButton:Point("TOP", parentFrame.recurring, "TOP", 0, -3)
		parentFrame.decButton:Point("RIGHT", -13, 0)
		parentFrame.incButton:Point("RIGHT", parentFrame.decButton, "LEFT", -5, 0)

		-- Log Frame
		EPGPLogFrame:EnableMouse(true)
		EPGPLogFrame:StripTextures()
		EPGPLogFrame:SetTemplate("Transparent")
		EPGPLogFrame:Height(424)
		-- EPGPLogFrame:SetMinResize(600, 424)
		-- EPGPLogFrame:SetMaxResize(1200, 424)
		EPGPLogFrame:Point("TOPLEFT", EPGPFrame, "TOPRIGHT", -33, -12)

		num = select("#",EPGPLogFrame:GetChildren())
		local searchBox, searchButt, sizer, closeButton2, export, import, trimLog, undo, redo, scrollParent
		if num == 10 then
			searchBox, searchButt, sizer, closeButton2, export, import, trimLog, undo, redo, scrollParent = EPGPLogFrame:GetChildren()
			S:HandleEditBox(searchBox)
			searchBox:Height(20)
			searchBox:ClearAllPoints()
			searchBox:SetPoint("TOPLEFT", EPGPLogFrame, "TOPLEFT", 23, -5)
			searchBox:SetPoint("TOPRIGHT", EPGPLogFrame, "TOPRIGHT", -117, -5)
			S:HandleButton(searchButt)
		else
			sizer, closeButton2, export, import, trimLog, undo, redo, scrollParent = EPGPLogFrame:GetChildren()
		end

		S:HandleCloseButton(closeButton2, EPGPLogFrame)

		scrollParent:StripTextures()
		scrollParent:Point("LEFT", 7, 0)
		scrollParent:Point("RIGHT", 1, 0)
		scrollParent:CreateBackdrop("Transparent")
		scrollParent.backdrop:Point("TOPLEFT", 1, 2)
		scrollParent.backdrop:Point("BOTTOMRIGHT", -30, 7)

		EPGPLogRecordScrollFrame:Size(368, 350)
		EPGPLogRecordScrollFrame:Point("TOPRIGHT", -0, -3)

		EPGPLogRecordFrame1:Point("TOPLEFT", 3, 0)

		EPGPLogRecordScrollFrameScrollBarBorder:StripTextures()
		S:HandleScrollBar(EPGPLogRecordScrollFrameScrollBar)

		EPGPLogRecordScrollFrameScrollBar:Point("TOPLEFT", EPGPLogRecordScrollFrame, "TOPRIGHT", -27, -14)
		EPGPLogRecordScrollFrameScrollBar:Point("BOTTOMLEFT", EPGPLogRecordScrollFrame, "BOTTOMRIGHT", -27, 18)

		S:HandleButton(export)
		S:HandleButton(import)
		S:HandleButton(trimLog)
		S:HandleButton(undo)
		S:HandleButton(redo)

		-- export:Point("BOTTOMLEFT", 8, 8)
		-- import:Point("LEFT", export, "RIGHT", 3, 0)

		-- undo:Point("BOTTOMRIGHT", -8, 8)
		-- redo:Point("RIGHT", undo, "LEFT", -3, 0)

		sizer:Size(14)

		local line1, line2 = sizer:GetRegions()
		-- print(line1, line2)
		line1:Size(12)
		line1:Point("BOTTOMRIGHT", -1, 1)
		line2:Size(8)
		line2:Point("BOTTOMRIGHT", -1, 1)
		local x = 0.1 * 14/17
		line1:SetTexCoord(1/32 - x, 0.5, 1/32, 0.5 + x, 1/32, 0.5 - x, 1/32 + x, 0.5)
		x = 0.1 * 11/17
		line2:SetTexCoord(1/32 - x, 0.5, 1/32, 0.5 + x, 1/32, 0.5 - x, 1/32 + x, 0.5)

		sizer:HookScript("OnMouseUp", function(self)
			self:GetParent():ClearAllPoints()
			self:GetParent():Point("TOPLEFT", EPGPFrame, "TOPRIGHT", -33, -12)
		end)

		-- ExportImport Frame
		EPGPExportImportFrame:EnableMouse(true)
		EPGPExportImportFrame:SetTemplate("Transparent")
		EPGPExportImportFrame:Width(480)

		EPGPExportImportFrame.help:Point("TOP", 0, -10)

		EPGPExportImportFrame.editbox:Width(438)

		EPGPExportScrollFrame:EnableMouse(true)
		EPGPExportScrollFrame:StripTextures()
		EPGPExportScrollFrame:Point("TOPLEFT", EPGPExportImportFrame.help, "BOTTOMLEFT", 0, -10)
		EPGPExportScrollFrame:Point("TOPRIGHT", EPGPExportImportFrame.help, "BOTTOMRIGHT", -17, 0)
		EPGPExportScrollFrame:Point("BOTTOM", EPGPExportImportFrame.button1, "TOP", 0, 9)

		EPGPExportScrollFrame:CreateBackdrop("Transparent")
		EPGPExportScrollFrame.backdrop:Point("TOPLEFT", -2, 2)
		EPGPExportScrollFrame.backdrop:Point("BOTTOMRIGHT", -2, -2)

		S:HandleScrollBar(EPGPExportScrollFrameScrollBar)
		EPGPExportScrollFrameScrollBar:Point("TOPLEFT", EPGPExportScrollFrame, "TOPRIGHT", 1, -17)
		EPGPExportScrollFrameScrollBar:Point("BOTTOMLEFT", EPGPExportScrollFrame, "BOTTOMRIGHT", 1, 17)

		S:HandleButton(EPGPExportImportFrame.button1)
		S:HandleButton(EPGPExportImportFrame.button2)

		EPGPExportImportFrame.button1:Point("BOTTOM", 0, 8)

		if not EPGPExportScrollFrame:GetScript("OnMouseUp") then
			EPGPExportScrollFrame:SetScript("OnMouseUp", function(self, button)
				if button == "LeftButton" then
					EPGPExportImportFrame.editbox:SetFocus()
				end
			end)
		end
		-- if epgpaisload == 1 then
			if EPGPAT then
				S:HandleButton(EPGPAT)
				EPGPAT:SetPoint("RIGHT", import, "RIGHT",90,0)
				hooksecurefunc(EPGPAttendance,"ShowFrameAndCurrentPage",epgpat_onshow)
			end
		-- end

	end
	if EPGPFrame then
		SkinEPGP()
	else
		S:SecureHook(EPGPUI, "OnEnable", function(self)
			SkinEPGP()
			S:Unhook(self, "OnEnable")
		end)
	end
end)