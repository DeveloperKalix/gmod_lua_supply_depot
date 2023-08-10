AddCSLuaFile("shared.lua")

include("shared.lua")
include("autorun/SupplyCrate.lua")


util.AddNetworkString("cargoType-Bacta")

local secondCrate_Bacta = nil
local tripleCrate_Bacta = nil
local quadCrate_Bacta = nil

function sendCargoDetailsBacta(cargoType)

    net.Start("cargoType-Bacta")
    net.WriteString(cargoType)
    net.Broadcast()
end

function makeClusterBacta(self, ent)

    if(self.Cargo.double == false) then
        local modelOffset = Vector(0, 30, 0)
        local rotation = self:GetAngles()
        local offset =  self:GetPos() + (rotation:Forward() * modelOffset.x) + (rotation:Right() * modelOffset.y) + (rotation:Up() * modelOffset.z)
        secondCrate_Bacta = ents.Create("prop_physics")
        secondCrate_Bacta:SetModel("models/kingpommes/starwars/misc/imp_crate_double_closed.mdl")
        secondCrate_Bacta:SetSkin(4)
        secondCrate_Bacta:SetPos(offset)
        secondCrate_Bacta:SetAngles(rotation)
        secondCrate_Bacta:Spawn()
        self:SetSolid(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS) 
        
        self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
        self:PhysicsInit(SOLID_VPHYSICS)
        secondCrate_Bacta:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
        secondCrate_Bacta:PhysicsInit(SOLID_VPHYSICS)
        secondCrate_Bacta:SetSolid(SOLID_VPHYSICS)
        secondCrate_Bacta:SetMoveType(MOVETYPE_VPHYSICS) 
        constraint.Weld(self, secondCrate_Bacta, 0, 0, 0, true)

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

function makeTripleBacta(self, ent)
    --print("MADE IT")
    local modelOffset = Vector(0, 0, 30)
    local rotation = self:GetAngles()
    local offset =  self:GetPos() + (rotation:Forward() * modelOffset.x) + (rotation:Right() * modelOffset.y) + (rotation:Up() * modelOffset.z)
    tripleCrate_Bacta = ents.Create("prop_physics")
    tripleCrate_Bacta:SetModel("models/kingpommes/starwars/misc/imp_crate_double_closed.mdl")
    tripleCrate_Bacta:SetPos(offset)
    tripleCrate_Bacta:SetAngles(rotation)
    tripleCrate_Bacta:SetSkin(4)
    tripleCrate_Bacta:Spawn()
    --tripleCrate:GetPhysicsObject():EnableMotion(false)
    tripleCrate_Bacta:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    tripleCrate_Bacta:PhysicsInit(SOLID_VPHYSICS)
    tripleCrate_Bacta:SetSolid(SOLID_VPHYSICS)
    tripleCrate_Bacta:SetMoveType(MOVETYPE_VPHYSICS) 

    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS) 
    
    self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    self:PhysicsInit(SOLID_VPHYSICS)

    --constraint.Weld(secondCrate, self, 0, 0, 0, true)
    constraint.Weld(self, tripleCrate_Bacta, 0, 0, 0, true)
    constraint.Weld(secondCrate_Bacta, tripleCrate_Bacta, 0, 0, 0, true)
    constraint.Weld(tripleCrate_Bacta, secondCrate_Bacta, 0, 0, 0, true)
    
    --ent.Cargo.triple = true 
    self.Cargo.triple = true 
    self.Cargo.quantity = self.Cargo.quantity * 1.5
    self.Cargo.reward = self.Cargo.reward * 1.5
    --secondCrate.Cargo.double = true
    ent:Remove()
    return self
end

function makeQuadBacta(self, ent)
    --print("MADE IT FINALLY")
    local modelOffset = Vector(0, 30, 30)
    local rotation = self:GetAngles()
    local offset =  self:GetPos() + (rotation:Forward() * modelOffset.x) + (rotation:Right() * modelOffset.y) + (rotation:Up() * modelOffset.z)
    quadCrate_Bacta = ents.Create("prop_physics")
    quadCrate_Bacta:SetModel("models/kingpommes/starwars/misc/imp_crate_double_closed.mdl")
    quadCrate_Bacta:SetPos(offset)
    quadCrate_Bacta:SetAngles(rotation)
    quadCrate_Bacta:SetSkin(4)
    quadCrate_Bacta:Spawn()
    --tripleCrate:GetPhysicsObject():EnableMotion(false)
    quadCrate_Bacta:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    quadCrate_Bacta:PhysicsInit(SOLID_VPHYSICS)
    quadCrate_Bacta:SetSolid(SOLID_VPHYSICS)
    quadCrate_Bacta:SetMoveType(MOVETYPE_VPHYSICS) 

    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS) 
    
    self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    self:PhysicsInit(SOLID_VPHYSICS)

    --constraint.Weld(secondCrate, self, 0, 0, 0, true)
    constraint.Weld(self, quadCrate_Bacta, 0, 0, 0, true)
    constraint.Weld(secondCrate_Bacta, quadCrate_Bacta, 0, 0, 0, true)
    constraint.Weld(tripleCrate_Bacta, quadCrate_Bacta, 0, 0, 0, true)
    constraint.Weld(quadCrate_Bacta, tripleCrate_Bacta, 0, 0, 0, true)
    
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
    self.Cargo = SupplyCrate.create(2, cargoTypes[indexToType[2+1]], 25, 200, indexToType[2+1], 100, false, false, false)
    self.cluster = false
    
    self:SetSkin(self.Cargo.identifier + 2)
    sendCargoDetailsBacta(self.Cargo.cargoType)
    
end

local completed = false

function ENT:Use(activator)
    
    if(self.Cargo.double == false) then
        timer.Create("giveCargo", 0.65, 1, function()
            self:SetModel("models/kingpommes/starwars/misc/imp_crate_double_base.mdl")
            activator:ChatPrint("This crate contains " ..self.Cargo.cargoType.. " supplies.")
            local health = activator:GetMaxHealth()
            
            if(self.Cargo.quantity > 0) then
                activator:SetHealth(health)
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
        if(secondCrate_Bacta) then
            secondCrate_Bacta:Remove()
        end
        if(tripleCrate_Bacta) then
            tripleCrate_Bacta:Remove()
        end
        if(quadCrate_Bacta) then
            quadCrate_Bacta:Remove()
        end
    end

    if(ent:GetClass() == self:GetClass() and (not self.Cargo.double)) then
        
        makeClusterBacta(self, ent)
        
    elseif (ent:GetClass() == self:GetClass() and self.Cargo.double and (not self.Cargo.triple) and (not self.Cargo.quad)) then
        
        makeTripleBacta(self, ent)

    elseif (ent:GetClass() == self:GetClass() and self.Cargo.double and (self.Cargo.triple) and (not self.Cargo.quad)) then
        
        makeQuadBacta(self, ent)
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
        if(secondCrate_Bacta) then
            secondCrate_Bacta:Remove()
        end
        if(tripleCrate_Bacta) then
            tripleCrate_Bacta:Remove()
        end
        if(quadCrate_Bacta) then
            quadCrate_Bacta:Remove()
        end
        
        
    end

end






