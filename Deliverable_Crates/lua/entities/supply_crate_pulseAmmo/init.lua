AddCSLuaFile("shared.lua")

include("shared.lua")
include("autorun/SupplyCrate.lua")


util.AddNetworkString("cargoType-Pulse")

local secondCrate_Pulse = nil
local tripleCrate_Pulse = nil
local quadCrate_Pulse = nil

function sendCargoDetailsPulse(cargoType)

    net.Start("cargoType-Pulse")
    net.WriteString(cargoType)
    net.Broadcast()
end

function makeClusterPulse(self, ent)

    if(self.Cargo.double == false) then
        local modelOffset = Vector(0, 30, 0)
        local rotation = self:GetAngles()
        local offset =  self:GetPos() + (rotation:Forward() * modelOffset.x) + (rotation:Right() * modelOffset.y) + (rotation:Up() * modelOffset.z)
        secondCrate_Pulse = ents.Create("prop_physics")
        secondCrate_Pulse:SetModel("models/kingpommes/starwars/misc/imp_crate_double_closed.mdl")
        secondCrate_Pulse:SetSkin(2)
        secondCrate_Pulse:SetPos(offset)
        secondCrate_Pulse:SetAngles(rotation)
        secondCrate_Pulse:Spawn()
        self:SetSolid(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS) 
        
        self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
        self:PhysicsInit(SOLID_VPHYSICS)
        secondCrate_Pulse:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
        secondCrate_Pulse:PhysicsInit(SOLID_VPHYSICS)
        secondCrate_Pulse:SetSolid(SOLID_VPHYSICS)
        secondCrate_Pulse:SetMoveType(MOVETYPE_VPHYSICS) 
        constraint.Weld(self, secondCrate_Pulse, 0, 0, 0, true)

        self.Cargo.double = true
        ent.Cargo.double = true 
        self.Cargo.quantity = self.Cargo.quantity * 2
        self.Cargo.reward = self.Cargo.reward * 2
        --print(self.cluster)
        --secondCrate.Cargo.double = true
        
        ent:Remove()
        --print("MADE IT 1st")

    -- elseif (self.Cargo.double == true and self.Cargo.triple == false and self.Cargo.quad == false) then
        
    -- end
    end
    return self
end

function makeTriplePulse(self, ent)
    --print("MADE IT")
    local modelOffset = Vector(0, 0, 30)
    local rotation = self:GetAngles()
    local offset =  self:GetPos() + (rotation:Forward() * modelOffset.x) + (rotation:Right() * modelOffset.y) + (rotation:Up() * modelOffset.z)
    tripleCrate_Pulse = ents.Create("prop_physics")
    tripleCrate_Pulse:SetModel("models/kingpommes/starwars/misc/imp_crate_double_closed.mdl")
    tripleCrate_Pulse:SetPos(offset)
    tripleCrate_Pulse:SetAngles(rotation)
    tripleCrate_Pulse:SetSkin(2)
    tripleCrate_Pulse:Spawn()
    --tripleCrate:GetPhysicsObject():EnableMotion(false)
    tripleCrate_Pulse:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    tripleCrate_Pulse:PhysicsInit(SOLID_VPHYSICS)
    tripleCrate_Pulse:SetSolid(SOLID_VPHYSICS)
    tripleCrate_Pulse:SetMoveType(MOVETYPE_VPHYSICS) 

    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS) 
    
    self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    self:PhysicsInit(SOLID_VPHYSICS)

    --constraint.Weld(secondCrate, self, 0, 0, 0, true)
    constraint.Weld(self, tripleCrate_Pulse, 0, 0, 0, true)
    constraint.Weld(secondCrate_Pulse, tripleCrate_Pulse, 0, 0, 0, true)
    constraint.Weld(tripleCrate_Pulse, secondCrate_Pulse, 0, 0, 0, true)
    
    --ent.Cargo.triple = true 
    self.Cargo.triple = true 
    self.Cargo.quantity = self.Cargo.quantity * 1.5
    self.Cargo.reward = self.Cargo.reward * 1.5
    --secondCrate.Cargo.double = true
    ent:Remove()
    return self
end

function makeQuadPulse(self, ent)
    --print("MADE IT FINALLY")
    local modelOffset = Vector(0, 30, 30)
    local rotation = self:GetAngles()
    local offset =  self:GetPos() + (rotation:Forward() * modelOffset.x) + (rotation:Right() * modelOffset.y) + (rotation:Up() * modelOffset.z)
    quadCrate_Pulse = ents.Create("prop_physics")
    quadCrate_Pulse:SetModel("models/kingpommes/starwars/misc/imp_crate_double_closed.mdl")
    quadCrate_Pulse:SetPos(offset)
    quadCrate_Pulse:SetAngles(rotation)
    quadCrate_Pulse:SetSkin(2)
    quadCrate_Pulse:Spawn()
    --tripleCrate:GetPhysicsObject():EnableMotion(false)
    quadCrate_Pulse:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    quadCrate_Pulse:PhysicsInit(SOLID_VPHYSICS)
    quadCrate_Pulse:SetSolid(SOLID_VPHYSICS)
    quadCrate_Pulse:SetMoveType(MOVETYPE_VPHYSICS) 

    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS) 
    
    self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    self:PhysicsInit(SOLID_VPHYSICS)

    --constraint.Weld(secondCrate, self, 0, 0, 0, true)
    constraint.Weld(self, quadCrate_Pulse, 0, 0, 0, true)
    constraint.Weld(secondCrate_Pulse, quadCrate_Pulse, 0, 0, 0, true)
    constraint.Weld(tripleCrate_Pulse, quadCrate_Pulse, 0, 0, 0, true)
    constraint.Weld(quadCrate_Pulse, tripleCrate_Pulse, 0, 0, 0, true)
    
    --ent.Cargo.triple = true 
    self.Cargo.quad = true 
    self.Cargo.quantity = self.Cargo.quantity * 2
    self.Cargo.reward = self.Cargo.reward * 2
    --secondCrate.Cargo.double = true
    ent:Remove()
    print(self:GetClass())
    return self
end

function ENT:Initialize()

    self:SetModel("models/kingpommes/starwars/misc/imp_crate_double_closed.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self.isRunning = false 
        local phys = self:GetPhysicsObject()

    if(phys:IsValid()) then 
        phys:Wake()

    end
    self.Cargo = SupplyCrate.create(1, cargoTypes[indexToType[1+1]], 25, 200, indexToType[1+1], 100, false, false, false)
    self.cluster = false
    
    self:SetSkin(self.Cargo.identifier + 1)
    sendCargoDetailsPulse(self.Cargo.cargoType)
    
end

local completed = false

function ENT:Use(activator)
    
    if(self.Cargo.double == false) then
        timer.Create("giveCargo", 0.65, 1, function()
            self:SetModel("models/kingpommes/starwars/misc/imp_crate_double_base.mdl")
            activator:ChatPrint("This crate contains " ..self.Cargo.cargoType.. " supplies.")
            local ammotype = game.GetAmmoID("AR2")
            local ammoAmount = 100
            if(self.Cargo.quantity > 0) then
                activator:GiveAmmo(ammoAmount, ammotype)
                self.Cargo.quantity = self.Cargo.quantity - 1
            end
            timer.Create("closeCrate", 0.5, 1, function()
                self:SetModel("models/kingpommes/starwars/misc/imp_crate_double_closed.mdl")
            end)
        end)
    end
    print(self.Cargo.quantity)
    --self:SetModel("models/kingpommes/starwars/misc/imp_crate_double_closed.mdl")
    
end

function ENT:StartTouch(ent)

    if(ent:GetClass() == "supply_depot") then
        --self:Remove()
        if(secondCrate_Pulse) then
            secondCrate_Pulse:Remove()
        end
        if(tripleCrate_Pulse) then
            tripleCrate_Pulse:Remove()
        end
        if(quadCrate_Pulse) then
            quadCrate_Pulse:Remove()
        end
    end

    if(ent:GetClass() == self:GetClass() and (not self.Cargo.double)) then
        
        makeClusterPulse(self, ent)
        
    elseif (ent:GetClass() == self:GetClass() and self.Cargo.double and (not self.Cargo.triple) and (not self.Cargo.quad)) then
        
        makeTriplePulse(self, ent)

    elseif (ent:GetClass() == self:GetClass() and self.Cargo.double and (self.Cargo.triple) and (not self.Cargo.quad)) then
        
        makeQuadPulse(self, ent)
    end

    
end

function ENT:OnTakeDamage(dmginfo)
    local dmgTaken = dmginfo:GetDamage() * 2
    self.Cargo.integrity = self.Cargo.integrity - dmgTaken
    if(self.Cargo.integrity <= 0) then
        --local blastRadius = 200
        --local position = self:GetPos()
        --util.BlastDamage(self, dmginfo:GetAttacker(), position, blastRadius, 30)
        sound.Play("ambient/explosions/explode_1.wav", self:GetPos(), 100, 100, 1)
        if(secondCrate_Pulse) then
            secondCrate_Pulse:Remove()
        end
        if(tripleCrate_Pulse) then
            tripleCrate_Pulse:Remove()
        end
        if(quadCrate_Pulse) then
            quadCrate_Pulse:Remove()
        end
        self:Remove()
        
    end

end






