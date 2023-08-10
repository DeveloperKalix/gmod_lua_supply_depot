include("shared.lua")

surface.CreateFont("supplyFont-Small", {
    font = "Ubuntu-B.ttf",
    size = 24,
    weight = 500,
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

local cargoTypeTitle = nil


net.Receive("cargoType-Pulse", function()
    
    cargoTypeTitle = net.ReadString()
    -- crate.cargoType = cargoTypeTitle
    -- cargoTypeTitle = crate.cargoType
    
end)

local titleColor = Color(math.floor(math.random(0, 255)), math.floor(math.random(0, 255)), math.floor(math.random(0, 255)))

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
    cam.Start3D2D(textPos, textAngle, 0.5)
        draw.DrawText(cargoTypeTitle, "supplyFont-Small", 0, -100, titleColor, TEXT_ALIGN_CENTER, 0.25, 0.25)
    cam.End3D2D() 

    
end





