AddCSLuaFile("shared.lua")

include("shared.lua")
include("autorun/SupplyCrate.lua")


util.AddNetworkString("cargoType-SMG")

local secondCrate = nil
local tripleCrate = nil
local quadCrate = nil

function sendCargoDetailsSMG(cargoType)

    net.Start("cargoType-SMG")
    
    net.WriteString(cargoType)
    net.Broadcast()
end

function makeCluster(self, ent)

    if(self.Cargo.double == false) then
        local modelOffset = Vector(0, 30, 0)
        local rotation = self:GetAngles()
        local offset =  self:GetPos() + (rotation:Forward() * modelOffset.x) + (rotation:Right() * modelOffset.y) + (rotation:Up() * modelOffset.z)
        secondCrate = ents.Create("prop_physics")
        secondCrate:SetModel("models/kingpommes/starwars/misc/imp_crate_double_closed.mdl")
        secondCrate:SetPos(offset)
        secondCrate:SetAngles(rotation)
        secondCrate:SetSkin(0)
        secondCrate:Spawn()
        self:SetSolid(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS) 
        
        self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
        self:PhysicsInit(SOLID_VPHYSICS)
        secondCrate:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
        secondCrate:PhysicsInit(SOLID_VPHYSICS)
        secondCrate:SetSolid(SOLID_VPHYSICS)
        secondCrate:SetMoveType(MOVETYPE_VPHYSICS) 
        constraint.Weld(self, secondCrate, 0, 0, 0, true)

        self.Cargo.double = true
        ent.Cargo.double = true 
        self.Cargo.quantity = self.Cargo.quantity * 2
        self.Cargo.reward = self.Cargo.reward * 2
        --print(self.cluster)
        --secondCrate.Cargo.double = true
        
        ent:Remove()
        print("MADE IT 1st")

    -- elseif (self.Cargo.double == true and self.Cargo.triple == false and self.Cargo.quad == false) then
        
    -- end
    end
    return self
end

function makeTriple(self, ent)
    print("MADE IT")
    local modelOffset = Vector(0, 0, 30)
    local rotation = self:GetAngles()
    local offset =  self:GetPos() + (rotation:Forward() * modelOffset.x) + (rotation:Right() * modelOffset.y) + (rotation:Up() * modelOffset.z)
    tripleCrate = ents.Create("prop_physics")
    tripleCrate:SetModel("models/kingpommes/starwars/misc/imp_crate_double_closed.mdl")
    tripleCrate:SetPos(offset)
    tripleCrate:SetAngles(rotation)
    tripleCrate:SetSkin(0)
    tripleCrate:Spawn()
    --tripleCrate:GetPhysicsObject():EnableMotion(false)
    tripleCrate:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    tripleCrate:PhysicsInit(SOLID_VPHYSICS)
    tripleCrate:SetSolid(SOLID_VPHYSICS)
    tripleCrate:SetMoveType(MOVETYPE_VPHYSICS) 

    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS) 
    
    self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    self:PhysicsInit(SOLID_VPHYSICS)

    --constraint.Weld(secondCrate, self, 0, 0, 0, true)
    constraint.Weld(self, tripleCrate, 0, 0, 0, true)
    constraint.Weld(secondCrate, tripleCrate, 0, 0, 0, true)
    constraint.Weld(tripleCrate, secondCrate, 0, 0, 0, true)
    
    --ent.Cargo.triple = true 
    self.Cargo.triple = true 
    self.Cargo.quantity = self.Cargo.quantity * 1.5
    self.Cargo.reward = self.Cargo.reward * 1.5
    --secondCrate.Cargo.double = true
    ent:Remove()
    return self
end

function makeQuad(self, ent)
    --print("MADE IT FINALLY")
    local modelOffset = Vector(0, 30, 30)
    local rotation = self:GetAngles()
    local offset =  self:GetPos() + (rotation:Forward() * modelOffset.x) + (rotation:Right() * modelOffset.y) + (rotation:Up() * modelOffset.z)
    quadCrate = ents.Create("prop_physics")
    quadCrate:SetModel("models/kingpommes/starwars/misc/imp_crate_double_closed.mdl")
    quadCrate:SetPos(offset)
    quadCrate:SetAngles(rotation)
    quadCrate:SetSkin(0)
    quadCrate:Spawn()
    --tripleCrate:GetPhysicsObject():EnableMotion(false)
    quadCrate:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    quadCrate:PhysicsInit(SOLID_VPHYSICS)
    quadCrate:SetSolid(SOLID_VPHYSICS)
    quadCrate:SetMoveType(MOVETYPE_VPHYSICS) 

    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS) 
    
    self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    self:PhysicsInit(SOLID_VPHYSICS)

    --constraint.Weld(secondCrate, self, 0, 0, 0, true)
    constraint.Weld(self, quadCrate, 0, 0, 0, true)
    constraint.Weld(secondCrate, quadCrate, 0, 0, 0, true)
    constraint.Weld(tripleCrate, quadCrate, 0, 0, 0, true)
    constraint.Weld(quadCrate, tripleCrate, 0, 0, 0, true)
    
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
    self.Cargo = SupplyCrate.create(0, cargoTypes[indexToType[0+1]], 25, 200, indexToType[0+1], 100, false, false, false)
    self.cluster = false
    
    self:SetSkin(self.Cargo.identifier)
    sendCargoDetailsSMG(self.Cargo.cargoType)
    
end

local completed = false

function ENT:Use(activator)
    
    if(self.Cargo.double == false) then
        timer.Create("giveCargo", 0.65, 1, function()
            self:SetModel("models/kingpommes/starwars/misc/imp_crate_double_base.mdl")
            activator:ChatPrint("This crate contains " ..self.Cargo.cargoType.. " supplies.")
            local ammotype = game.GetAmmoID("SMG1")
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
        if(secondCrate) then
            secondCrate:Remove()
        end
        if(tripleCrate) then
            tripleCrate:Remove()
        end
        if(quadCrate) then
            quadCrate:Remove()
        end
    end

    if(ent:GetClass() == self:GetClass() and (not self.Cargo.double)) then
        
        makeCluster(self, ent)
        
    elseif (ent:GetClass() == self:GetClass() and self.Cargo.double and (not self.Cargo.triple) and (not self.Cargo.quad)) then
        
        makeTriple(self, ent)

    elseif (ent:GetClass() == self:GetClass() and self.Cargo.double and (self.Cargo.triple) and (not self.Cargo.quad)) then
        
        makeQuad(self, ent)
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
        self:Remove()
        if(secondCrate) then
            secondCrate:Remove()
        end
        if(tripleCrate) then
            tripleCrate:Remove()
        end
        if(quadCrate) then
            quadCrate:Remove()
        end
        
    end

end






