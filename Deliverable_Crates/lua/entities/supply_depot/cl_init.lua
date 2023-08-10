include("shared.lua")

surface.CreateFont("supplyFont", {
    font = "Ubuntu-B.ttf",
    size = 72,
    weight = 700,
    blursize = 0,
    scanlines = 0, 
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
})

surface.CreateFont("interfaceFont", {
    font = "Ubuntu-B.ttf",
    size = 16,
    weight = 400,
    blursize = 0,
    scanlines = 0, 
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
})

surface.CreateFont("interfaceButtonFont", {
    font = "Ubuntu-B.ttf",
    size = 20,
    weight = 600,
    blursize = 0,
    scanlines = 0, 
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
})



local indicatorColors = {
    [1] = Color(241, 79, 79),
    [2] = Color(252, 231, 92),
    [3] = Color(124, 252, 112)
}

local interFaceText = {
    [1] = "Light Ammo Reserves",
    [2] = "Heavy Ammo Reserves",
    [3] = "Bacta Reserves",
    [4] = "Grenade Reserves",
    [5] = "Rocket Reserves"
}

local currentIndicator = indicatorColors[1]

local entityText = {}
entityText.value = "Supply Depot"
entityText.color = Color(223, 184, 86)
entityText.font = "supplyFont"

local invColorIndicator = nil

net.Receive("ColorIndicator", function()
    local num = net.ReadDouble()
    if(num < 0.4) then
        currentIndicator = indicatorColors[1]
    elseif (num >= 0.4 and num < 0.7) then
        currentIndicator = indicatorColors[2]
    elseif (num >= 0.7) then
        currentIndicator = indicatorColors[3]
    end

end)

function ENT:Draw()
    self:DrawModel()
    local pos = self:GetPos()
    local ang = self:GetAngles()
    local viewAngles = LocalPlayer():EyeAngles()
    ang:RotateAroundAxis(ang:Right(), 180)
    ang:RotateAroundAxis(ang:Forward(), 90)
    ang:RotateAroundAxis(ang:Up(), 180)
    

    local textOffset = Vector(0, 0, 10) -- Adjust the offset as needed to move the text above the prop
    local textPos = pos + textOffset

    -- Rotate the text to face the player
    local textAngle = Angle(0, viewAngles.y - 90, 90)

    -- hook.Add("PostDrawOpaqueRenderables", "Draw3D2D", function()
    --     cam.Start3D2D(Vector(0, 0, 0), Angle(0, 0, 0), 1)
    --         -- Your drawing code here
    --     cam.End3D2D()
    -- end)
    cam.Start3D2D(self:GetPos(), self:GetAngles(), 1)
        draw.RoundedBox(0,-128,-221, 255, 442, currentIndicator)
    cam.End3D2D()
    cam.Start3D2D(textPos, textAngle, 0.75)
        draw.DrawText(entityText.value, entityText.font, 0, -400, entityText.color, TEXT_ALIGN_CENTER, 1, 1)
    cam.End3D2D()

    

end

function createMeter(ratio, barColor, progressColor, meterElement)
    meterElement.Paint = function(self, w, h)
        surface.SetDrawColor(barColor)
        surface.DrawRect(0, 0, w, h)
        local fillMeter = ratio * h
        surface.SetDrawColor(progressColor)
        surface.DrawRect(0, h-fillMeter, w, fillMeter)
    end
end

net.Receive("DepotAccessed", function()

    local ent = net.ReadEntity()
    local inventoryInformation = net.ReadTable()
    local clickedColor = Color(211, 189, 82)
    if IsValid(ent) then
        Msg("Entity has been used on the client:", ent)
        -- Add your client-side actions here
    end
    local interfaceImage = Material("materials/ardent/panelbkg.png")
    local depotMenu = vgui.Create("DFrame")
    depotMenu:SetSize(800, 600)
    depotMenu:Center()
    depotMenu:SetTitle("Supply Depot Interface")
    --depotMenu:GetTitle():SetFont("interfaceFont")
    depotMenu:SetBackgroundBlur(true)
    depotMenu.Paint = function(self, w, h)
        surface.SetMaterial(interfaceImage)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.DrawTexturedRect(0, 0, w, h)
    end
    --depotMenu:SetColor(Color(61, 81, 148))
    depotMenu:SetVisible(true)
    depotMenu:MakePopup()

    -- local button = vgui.Create("DButton", depotMenu)
    -- button:SetPos(10, 10)
    -- button:SetSize(200, 45)
    -- button:SetText("Testing")
    local meterBaseColor = Color(19, 60, 101)
    local progressColor = Color(38, 120, 202)
    local smgMeter = vgui.Create("DPanel", depotMenu)
    createMeter(inventoryInformation["smgRatio"], meterBaseColor, progressColor, smgMeter)
    local smgLabel = vgui.Create("DLabel", depotMenu)
    local pulseMeter = vgui.Create("DPanel", depotMenu)
    createMeter(inventoryInformation["pulseRatio"], meterBaseColor, progressColor, pulseMeter)
    local pulseLabel = vgui.Create("DLabel", depotMenu)
    local bactaMeter = vgui.Create("DPanel", depotMenu)
    createMeter(inventoryInformation["bactaRatio"], meterBaseColor, progressColor, bactaMeter)
    local bactaLabel = vgui.Create("DLabel", depotMenu)
    local grenadeMeter = vgui.Create("DPanel", depotMenu)
    createMeter(inventoryInformation["grenadesRatio"], meterBaseColor, progressColor, grenadeMeter)
    local grenadeLabel = vgui.Create("DLabel", depotMenu)
    local rocketLauncherMeter = vgui.Create("DPanel", depotMenu)
    createMeter(inventoryInformation["rocketlauncherRatio"], meterBaseColor, progressColor, rocketLauncherMeter)
    local rocketLabel = vgui.Create("DLabel", depotMenu)
    smgMeter:SetPos(260, 100)
    smgMeter:SetSize(40, 200)
    smgLabel:SetText(interFaceText[1] .." " ..(inventoryInformation["smgRatio"]*100) .."%")
    smgLabel:SetPos(250, 320)
    smgLabel:SetAutoStretchVertical(true)
    smgLabel:SetWrap(true)
    smgLabel:SetFont("interfaceFont")
    smgLabel:SetColor(Color(94, 232, 247))

    pulseMeter:SetPos(320, 100)
    pulseMeter:SetSize(40, 200)
    pulseLabel:SetText(interFaceText[2] .." " ..(inventoryInformation["pulseRatio"]*100) .."%")
    pulseLabel:SetPos(320, 320)
    pulseLabel:SetAutoStretchVertical(true)
    pulseLabel:SetWrap(true)
    pulseLabel:SetFont("interfaceFont")
    pulseLabel:SetColor(Color(94, 232, 247))

    bactaMeter:SetPos(380, 100)
    bactaMeter:SetSize(40, 200)
    bactaLabel:SetText(interFaceText[3] .." " ..(inventoryInformation["pulseRatio"]*100) .."%")
    bactaLabel:SetPos(380, 320)
    bactaLabel:SetAutoStretchVertical(true)
    bactaLabel:SetWrap(true)
    bactaLabel:SetFont("interfaceFont")
    bactaLabel:SetColor(Color(94, 232, 247))

    grenadeMeter:SetPos(440, 100)
    grenadeMeter:SetSize(40, 200)
    grenadeLabel:SetText(interFaceText[4] .." " ..(inventoryInformation["pulseRatio"]*100) .."%")
    grenadeLabel:SetPos(435, 320)
    grenadeLabel:SetAutoStretchVertical(true)
    grenadeLabel:SetWrap(true)
    grenadeLabel:SetFont("interfaceFont")
    grenadeLabel:SetColor(Color(94, 232, 247))

    rocketLauncherMeter:SetPos(500, 100)
    rocketLauncherMeter:SetSize(40, 200)
    rocketLabel:SetText(interFaceText[5] .." " ..(inventoryInformation["pulseRatio"]*100) .."%")
    rocketLabel:SetPos(500, 320)
    rocketLabel:SetAutoStretchVertical(true)
    rocketLabel:SetWrap(true)
    rocketLabel:SetFont("interfaceFont")
    rocketLabel:SetColor(Color(94, 232, 247))
    local closeButton = vgui.Create("DButton", depotMenu)
    closeButton:SetText("Exit")
    closeButton:SetSize(100, 50)
    closeButton:SetPos(360, 500)
    
    
    closeButton:SetColor(Color(94, 232, 247))
    closeButton:SetFont("interfaceButtonFont")
    closeButton.Paint = function(self, w, h)

        surface.SetDrawColor(Color(94, 232, 247, 100))
        surface.DrawOutlinedRect(0, 0, w, h)
    end
    closeButton.DoClick = function()
        
        depotMenu:SetVisible(false)
        depotMenu:Remove() -- Close the derma panel when the button is clicked
    end
 
end)



