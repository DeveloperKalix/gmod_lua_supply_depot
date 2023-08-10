AddCSLuaFile("shared.lua")

include("shared.lua")
include("autorun/SupplyCrate.lua")


util.AddNetworkString("cargoType-RocketLauncher")

local secondCrate_RocketLauncher = nil
local tripleCrate_RocketLauncher = nil
local quadCrate_RocketLauncher = nil

function sendCargoDetailsRocketLauncher(cargoType)

    net.Start("cargoType-RocketLauncher")
    net.WriteString(cargoType)
    net.Broadcast()
end

function makeClusterRocketLauncher(self, ent)

    if(self.Cargo.double == false) then
        local modelOffset = Vector(0, 30, 0)
        local rotation = self:GetAngles()
        local offset =  self:GetPos() + (rotation:Forward() * modelOffset.x) + (rotation:Right() * modelOffset.y) + (rotation:Up() * modelOffset.z)
        secondCrate_RocketLauncher = ents.Create("prop_physics")
        secondCrate_RocketLauncher:SetModel("models/kingpommes/starwars/misc/imp_crate_double_closed.mdl")
        secondCrate_RocketLauncher:SetSkin(7)
        secondCrate_RocketLauncher:SetPos(offset)
        secondCrate_RocketLauncher:SetAngles(rotation)
        secondCrate_RocketLauncher:Spawn()
        self:SetSolid(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS) 
        
        self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
        self:PhysicsInit(SOLID_VPHYSICS)
        secondCrate_RocketLauncher:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
        secondCrate_RocketLauncher:PhysicsInit(SOLID_VPHYSICS)
        secondCrate_RocketLauncher:SetSolid(SOLID_VPHYSICS)
        secondCrate_RocketLauncher:SetMoveType(MOVETYPE_VPHYSICS) 
        constraint.Weld(self, secondCrate_RocketLauncher, 0, 0, 0, true)

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

function makeTripleRocketLauncher(self, ent)
    --print("MADE IT")
    local modelOffset = Vector(0, 0, 30)
    local rotation = self:GetAngles()
    local offset =  self:GetPos() + (rotation:Forward() * modelOffset.x) + (rotation:Right() * modelOffset.y) + (rotation:Up() * modelOffset.z)
    tripleCrate_RocketLauncher = ents.Create("prop_physics")
    tripleCrate_RocketLauncher:SetModel("models/kingpommes/starwars/misc/imp_crate_double_closed.mdl")
    tripleCrate_RocketLauncher:SetPos(offset)
    tripleCrate_RocketLauncher:SetAngles(rotation)
    tripleCrate_RocketLauncher:SetSkin(7)
    tripleCrate_RocketLauncher:Spawn()
    --tripleCrate:GetPhysicsObject():EnableMotion(false)
    tripleCrate_RocketLauncher:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    tripleCrate_RocketLauncher:PhysicsInit(SOLID_VPHYSICS)
    tripleCrate_RocketLauncher:SetSolid(SOLID_VPHYSICS)
    tripleCrate_RocketLauncher:SetMoveType(MOVETYPE_VPHYSICS) 

    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS) 
    
    self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    self:PhysicsInit(SOLID_VPHYSICS)

    --constraint.Weld(secondCrate, self, 0, 0, 0, true)
    constraint.Weld(self, tripleCrate_RocketLauncher, 0, 0, 0, true)
    constraint.Weld(secondCrate_RocketLauncher, tripleCrate_RocketLauncher, 0, 0, 0, true)
    constraint.Weld(tripleCrate_RocketLauncher, secondCrate_RocketLauncher, 0, 0, 0, true)
    
    --ent.Cargo.triple = true 
    self.Cargo.triple = true 
    self.Cargo.quantity = self.Cargo.quantity * 1.5
    self.Cargo.reward = self.Cargo.reward * 1.5
    --secondCrate.Cargo.double = true
    ent:Remove()
    return self
end

function makeQuadRocketLauncher(self, ent)
    --print("MADE IT FINALLY")
    local modelOffset = Vector(0, 30, 30)
    local rotation = self:GetAngles()
    local offset =  self:GetPos() + (rotation:Forward() * modelOffset.x) + (rotation:Right() * modelOffset.y) + (rotation:Up() * modelOffset.z)
    quadCrate_RocketLauncher = ents.Create("prop_physics")
    quadCrate_RocketLauncher:SetModel("models/kingpommes/starwars/misc/imp_crate_double_closed.mdl")
    quadCrate_RocketLauncher:SetPos(offset)
    quadCrate_RocketLauncher:SetAngles(rotation)
    quadCrate_RocketLauncher:SetSkin(7)
    quadCrate_RocketLauncher:Spawn()
    --tripleCrate:GetPhysicsObject():EnableMotion(false)
    quadCrate_RocketLauncher:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    quadCrate_RocketLauncher:PhysicsInit(SOLID_VPHYSICS)
    quadCrate_RocketLauncher:SetSolid(SOLID_VPHYSICS)
    quadCrate_RocketLauncher:SetMoveType(MOVETYPE_VPHYSICS) 

    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS) 
    
    self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    self:PhysicsInit(SOLID_VPHYSICS)

    --constraint.Weld(secondCrate, self, 0, 0, 0, true)
    constraint.Weld(self, quadCrate_RocketLauncher, 0, 0, 0, true)
    constraint.Weld(secondCrate_RocketLauncher, quadCrate_RocketLauncher, 0, 0, 0, true)
    constraint.Weld(tripleCrate_RocketLauncher, quadCrate_RocketLauncher, 0, 0, 0, true)
    constraint.Weld(quadCrate_RocketLauncher, tripleCrate_RocketLauncher, 0, 0, 0, true)
    
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
    self.Cargo = SupplyCrate.create(5, cargoTypes[indexToType[1+4]], 25, 200, indexToType[1+4], 100, false, false, false)
    self.cluster = false
    
    self:SetSkin(self.Cargo.identifier + 2)
    sendCargoDetailsRocketLauncher(self.Cargo.cargoType)
    
end

local completed = false

function ENT:Use(activator)
    
    if(self.Cargo.double == false) then
        timer.Create("giveCargo", 0.65, 1, function()
            self:SetModel("models/kingpommes/starwars/misc/imp_crate_double_base.mdl")
            activator:ChatPrint("This crate contains " ..self.Cargo.cargoType.. " supplies.")
            local ammotype = game.GetAmmoID("RPG_Round")
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
        if(secondCrate_RocketLauncher) then
            secondCrate_RocketLauncher:Remove()
        end
        if(tripleCrate_RocketLauncher) then
            tripleCrate_RocketLauncher:Remove()
        end
        if(quadCrate_RocketLauncher) then
            quadCrate_RocketLauncher:Remove()
        end
    end

    if(ent:GetClass() == self:GetClass() and (not self.Cargo.double)) then
        
        makeClusterRocketLauncher(self, ent)
        
    elseif (ent:GetClass() == self:GetClass() and self.Cargo.double and (not self.Cargo.triple) and (not self.Cargo.quad)) then
        
        makeTripleRocketLauncher(self, ent)

    elseif (ent:GetClass() == self:GetClass() and self.Cargo.double and (self.Cargo.triple) and (not self.Cargo.quad)) then
        
        makeQuadRocketLauncher(self, ent)
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
            secondCrate_RocketLauncher:Remove()
        end
        if(tripleCrate_Pulse) then
            tripleCrate_RocketLauncher:Remove()
        end
        if(quadCrate_Pulse) then
            quadCrate_RocketLauncher:Remove()
        end
        self:Remove()
        
    end

end






