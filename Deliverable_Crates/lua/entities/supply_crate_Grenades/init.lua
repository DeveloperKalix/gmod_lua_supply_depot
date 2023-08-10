AddCSLuaFile("shared.lua")

include("shared.lua")
include("autorun/SupplyCrate.lua")


util.AddNetworkString("cargoType-Grenades")

local secondCrate_Grenades = nil
local tripleCrate_Grenades = nil
local quadCrate_Grenades = nil

function sendCargoDetailsGrenades(cargoType)

    net.Start("cargoType-Grenades")
    net.WriteString(cargoType)
    net.Broadcast()
end

function makeClusterGrenades(self, ent)

    if(self.Cargo.double == false) then
        local modelOffset = Vector(0, 30, 0)
        local rotation = self:GetAngles()
        local offset =  self:GetPos() + (rotation:Forward() * modelOffset.x) + (rotation:Right() * modelOffset.y) + (rotation:Up() * modelOffset.z)
        secondCrate_Grenades = ents.Create("prop_physics")
        secondCrate_Grenades:SetModel("models/kingpommes/starwars/misc/imp_crate_double_closed.mdl")
        secondCrate_Grenades:SetSkin(6)
        secondCrate_Grenades:SetPos(offset)
        secondCrate_Grenades:SetAngles(rotation)
        secondCrate_Grenades:Spawn()
        self:SetSolid(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS) 
        
        self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
        self:PhysicsInit(SOLID_VPHYSICS)
        secondCrate_Grenades:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
        secondCrate_Grenades:PhysicsInit(SOLID_VPHYSICS)
        secondCrate_Grenades:SetSolid(SOLID_VPHYSICS)
        secondCrate_Grenades:SetMoveType(MOVETYPE_VPHYSICS) 
        constraint.Weld(self, secondCrate_Grenades, 0, 0, 0, true)

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

function makeTripleGrenades(self, ent)
    --print("MADE IT")
    local modelOffset = Vector(0, 0, 30)
    local rotation = self:GetAngles()
    local offset =  self:GetPos() + (rotation:Forward() * modelOffset.x) + (rotation:Right() * modelOffset.y) + (rotation:Up() * modelOffset.z)
    tripleCrate_Grenades = ents.Create("prop_physics")
    tripleCrate_Grenades:SetModel("models/kingpommes/starwars/misc/imp_crate_double_closed.mdl")
    tripleCrate_Grenades:SetPos(offset)
    tripleCrate_Grenades:SetAngles(rotation)
    tripleCrate_Grenades:SetSkin(6)
    tripleCrate_Grenades:Spawn()
    --tripleCrate:GetPhysicsObject():EnableMotion(false)
    tripleCrate_Grenades:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    tripleCrate_Grenades:PhysicsInit(SOLID_VPHYSICS)
    tripleCrate_Grenades:SetSolid(SOLID_VPHYSICS)
    tripleCrate_Grenades:SetMoveType(MOVETYPE_VPHYSICS) 

    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS) 
    
    self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    self:PhysicsInit(SOLID_VPHYSICS)

    --constraint.Weld(secondCrate, self, 0, 0, 0, true)
    constraint.Weld(self, tripleCrate_Grenades, 0, 0, 0, true)
    constraint.Weld(secondCrate_Grenades, tripleCrate_Grenades, 0, 0, 0, true)
    constraint.Weld(tripleCrate_Grenades, secondCrate_Grenades, 0, 0, 0, true)
    
    --ent.Cargo.triple = true 
    self.Cargo.triple = true 
    self.Cargo.quantity = self.Cargo.quantity * 1.5
    self.Cargo.reward = self.Cargo.reward * 1.5
    --secondCrate.Cargo.double = true
    ent:Remove()
    return self
end

function makeQuadGrenades(self, ent)
    --print("MADE IT FINALLY")
    local modelOffset = Vector(0, 30, 30)
    local rotation = self:GetAngles()
    local offset =  self:GetPos() + (rotation:Forward() * modelOffset.x) + (rotation:Right() * modelOffset.y) + (rotation:Up() * modelOffset.z)
    quadCrate_Grenades = ents.Create("prop_physics")
    quadCrate_Grenades:SetModel("models/kingpommes/starwars/misc/imp_crate_double_closed.mdl")
    quadCrate_Grenades:SetPos(offset)
    quadCrate_Grenades:SetAngles(rotation)
    quadCrate_Grenades:SetSkin(6)
    quadCrate_Grenades:Spawn()
    --tripleCrate:GetPhysicsObject():EnableMotion(false)
    quadCrate_Grenades:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    quadCrate_Grenades:PhysicsInit(SOLID_VPHYSICS)
    quadCrate_Grenades:SetSolid(SOLID_VPHYSICS)
    quadCrate_Grenades:SetMoveType(MOVETYPE_VPHYSICS) 

    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS) 
    
    self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    self:PhysicsInit(SOLID_VPHYSICS)

    --constraint.Weld(secondCrate, self, 0, 0, 0, true)
    constraint.Weld(self, quadCrate_Grenades, 0, 0, 0, true)
    constraint.Weld(secondCrate_Grenades, quadCrate_Grenades, 0, 0, 0, true)
    constraint.Weld(tripleCrate_Grenades, quadCrate_Grenades, 0, 0, 0, true)
    constraint.Weld(quadCrate_Grenades, tripleCrate_Grenades, 0, 0, 0, true)
    
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
    self.Cargo = SupplyCrate.create(4, cargoTypes[indexToType[1+3]], 25, 200, indexToType[1+3], 100, false, false, false)
    self.cluster = false
    
    self:SetSkin(self.Cargo.identifier + 2)
    sendCargoDetailsGrenades(self.Cargo.cargoType)
    
end

local completed = false

function ENT:Use(activator)
    
    if(self.Cargo.double == false) then
        timer.Create("giveCargo", 0.65, 1, function()
            self:SetModel("models/kingpommes/starwars/misc/imp_crate_double_base.mdl")
            activator:ChatPrint("This crate contains " ..self.Cargo.cargoType.. " supplies.")
            local ammotype = game.GetAmmoID("Grenade")
            local ammoAmount = 5
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
        if(secondCrate_Grenades) then
            secondCrate_Grenades:Remove()
        end
        if(tripleCrate_Grenades) then
            tripleCrate_Grenades:Remove()
        end
        if(quadCrate_Grenades) then
            quadCrate_Grenades:Remove()
        end
    end

    if(ent:GetClass() == self:GetClass() and (not self.Cargo.double)) then
        
        makeClusterGrenades(self, ent)
        
    elseif (ent:GetClass() == self:GetClass() and self.Cargo.double and (not self.Cargo.triple) and (not self.Cargo.quad)) then
        
        makeTripleGrenades(self, ent)

    elseif (ent:GetClass() == self:GetClass() and self.Cargo.double and (self.Cargo.triple) and (not self.Cargo.quad)) then
        
        makeQuadGrenades(self, ent)
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
            secondCrate_Grenades:Remove()
        end
        if(tripleCrate_Pulse) then
            tripleCrate_Grenades:Remove()
        end
        if(quadCrate_Pulse) then
            quadCrate_Grenades:Remove()
        end
        self:Remove()
        
    end

end






