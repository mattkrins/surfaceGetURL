--[[ Helper Function by StealthPaw/101kl/MattKrins. --]]
if SERVER then return end
local WebMaterials = {}
function surface.GetURL(url, w, h, time)
	if !url or !w or !h then return Material("error") end
	if WebMaterials[url] then return WebMaterials[url] end
	local WebPanel = vgui.Create( "HTML" )
	WebPanel:SetAlpha( 0 )
	WebPanel:SetSize( tonumber(w), tonumber(h) )
	WebPanel:OpenURL( url )
	WebPanel.Paint = function(self)
		if !WebMaterials[url] and self:GetHTMLMaterial() then
			WebMaterials[url] = self:GetHTMLMaterial()
			self:Remove()
		end
	end
	timer.Simple( 1 or tonumber(time), function() if IsValid(WebPanel) then WebPanel:Remove() end end ) // In case we do not render
	return Material("error")
end