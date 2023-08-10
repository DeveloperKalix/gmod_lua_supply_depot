AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("DepotAccessed")
util.AddNetworkString("ColorIndicator")

local timeElapsed = 1200

SupplyDepot = {}
SupplyDepot.__index = SupplyDepot;

function SupplyDepot.create(depotname, integrity, smgammo, pulseAmmo, bacta, grenades, rocketlaunchers, inventoryInitial, subinventoryMax, inventoryMax)
    local instance = setmetatable({}, SupplyDepot)
    instance.DepotName = depotname
    instance.Integrity = integrity
    instance.smgAmmo = smgammo
    instance.pulseAmmo = pulseAmmo
    instance.Bacta = bacta
    instance.Grenades = grenades
    instance.RocketLauncher = rocketlaunchers
    instance.inventoryInitial = inventoryInitial
    instance.subInventoryMax = subinventoryMax
    instance.inventoryMax = inventoryMax

    return instance
end

function SupplyDepot:test()
    print("Name: " ..self.DepotName.." \n")
    print("Integrity: " ..self.Integrity.." \n")
    print("SMG Ammo: " ..self.smgAmmo.." \n")
    print("Pulse Ammo: " ..self.pulseAmmo.." \n")
    print("Bacta: " ..self.Bacta.." \n")
    print("Grenades: " ..self.Grenades.." \n")
    print("Rocket Launchers: " ..self.RocketLauncher.." \n")
    print("Inventory Max: " ..self.inventoryMax.." \n")
end

function SupplyDepot:openInterface(activator, caller, useType, value)

    -- print("Entity has been used by: ", activator)
    net.Start("DepotAccessed")
    net.WriteEntity(self)
    net.WriteTable({
        smgRatio = (self.smgAmmo / self.subInventoryMax),
        pulseRatio = (self.pulseAmmo / self.subInventoryMax),
        bactaRatio = (self.Bacta / self.subInventoryMax),
        grenadesRatio = (self.Grenades / self.subInventoryMax),
        rocketlauncherRatio = (self.RocketLauncher / self.subInventoryMax)
    })
    
    net.Send(caller)
end

function SupplyDepot:UpdateColor(currentInventory)
    local inventoryRatio = currentInventory / self.inventoryMax
    print(inventoryRatio)
    net.Start("ColorIndicator")
    net.WriteDouble(inventoryRatio)
    net.Broadcast()
end

function SupplyDepot:getInventorySize()
    local sum = (self.smgAmmo + self.pulseAmmo + self.Bacta + self.Grenades + self.RocketLauncher)
    return sum

end

function SupplyDepot:updateInventory(inventoryType, cargoQuantity, crateReward, supplier)
    
    --self.inventoryType = self.inventoryType + cargoQuantity
    if(self[inventoryType] < 1000) then
        self[inventoryType] = self[inventoryType] + cargoQuantity
        print(cargoQuantity .." WAS ADDED TO INV" .. " " .. self[inventoryType] .." is total")
        
        if(self[inventoryType] > 1000) then
            self[inventoryType] = 1000
        end
        self:test()
        currentInventory = self:getInventorySize()
        self:UpdateColor(currentInventory)
    end
    
end



function ENT:Initialize()

    self:SetModel("models/starwars/syphadias/props/sw_tor/bioware_ea/props/neutral/neu_bunker.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self.isRunning = false 
        local phys = self:GetPhysicsObject()

    if(phys:IsValid()) then 
        phys:Wake()

    end
    self.theDepotInv = SupplyDepot.create("Republic Inventory", 1000, 0, 0, 0, 0, 0, 0, 1000, 5000)
    self.supplyUsage = CurTime()
    self.theDepotInv:test()
end

function ENT:Think()

    if CurTime() > (self.supplyUsage + timeElapsed) then
        self.supplyUsage = CurTime()
        if(self.smgAmmo >= 0 or self.pulseAmmo > 0 or self.Bacta > 0 or self.Grenades > 0 or self.RocketLauncher > 0) then
            self.theDepotInv.smgAmmo = self.theDepotInv.smgAmmo - 100
            if(self.theDepotInv.smgAmmo  < 0) then
                self.theDepotInv.smgAmmo  = 0
            end
            self.theDepotInv.pulseAmmo = self.theDepotInv.pulseAmmo - 100
            if(self.theDepotInv.pulseAmmo  < 0) then
                self.theDepotInv.pulseAmmo  = 0
            end
            self.theDepotInv.Bacta = self.theDepotInv.Bacta - 100
            if(self.theDepotInv.Bacta  < 0) then
                self.theDepotInv.Bacta  = 0
            end
            self.theDepotInv.Grenades = self.theDepotInv.Grenades - 100
            if(self.theDepotInv.Grenades  < 0) then
                self.theDepotInv.Grenades  = 0
            end
            self.theDepotInv.RocketLauncher = self.theDepotInv.RocketLauncher - 100
            if(self.theDepotInv.RocketLauncher  < 0) then
                self.theDepotInv.RocketLauncher  = 0
            end
        end
    end

end

function ENT:StartTouch(ent)
    currentInventory = self.theDepotInv:getInventorySize()
    
    if(ent:IsPlayer()) then
        timer.Create("GreetingTimer", 0.5, 1, function()
            ent:ChatPrint("Welcome to the Supply Depot. You can find ammo, medical equipment, and explosives here.")
            self.theDepotInv:test()
        end)
        
    else
        
        if(ent:GetClass() == "supply_crate_smgammo" or ent:GetClass() == "supply_crate_pulseammo" or ent:GetClass() == "supply_crate_bacta" or ent:GetClass() == "supply_crate_grenades" or ent:GetClass() == "supply_crate_rocketlauncher") then
            local crate = ent.Cargo
            local crateContents = crate.quantity
            local crateReward = crate.reward
            
            -- print(supplier)
            
            if(self.theDepotInv.Integrity > 200 and self.theDepotInv.inventoryMax > currentInventory) then
                    --print("Aloha")
                    self.theDepotInv:updateInventory(crate.cargoReference, crateContents, crateReward, supplier)
            elseif (self.theDepotInv.Integrity <= 200) then
                -- timer.Create("IntegrityWarn", 0.5, 1, function()
                --     supplier:ChatPrint("The Supply Depot is in disrepair. Until it is repaired, new cargo cannot be added to it.")
                PrintMessage(HUD_PRINTTALK, "[Supply Depot Notification]: The Supply Depot is in disrepair. Repair it to store more cargo.")
                -- end)
                
            end
            ent:Remove()
        end
        if(ent:GetClass() == "repair_kit") and self.theDepotInv.Integrity < 1000 then
            ent:Remove()
            local outcome = math.random(100)
            if(outcome >= 40) then
                self.theDepotInv.Integrity  = 1000
                PrintMessage(HUD_PRINTTALK, "[Depot Interface Notification]: The Supply Depot's integrity has been fully restored.")
            else
                self.theDepotInv.Integrity = self.theDepotInv.Integrity + (1000-self.theDepotInv.Integrity)/2
                PrintMessage(HUD_PRINTTALK, "[Depot Interface Notification]: The Supply Depot requires further repairs.")
            end
        end
        
    end
    -- if(ent:GetClass() == "supply_crate_smgammo") and self.theDepotInv.Integrity > 200 and self.theDepotInv.inventoryMax > currentInventory then
    --     print("THIS IS THE RIGHT CLASS!!!")   
    -- end
    

end


function ENT:Use(activator, caller, useType, value)

    if(self.theDepotInv.Integrity > 200) then
        self.theDepotInv:openInterface(activator, caller, useType, value)
    else
        timer.Create("IntegrityWarn_Simple", 1, 1, function()
            activator:ChatPrint("The Supply Depot's Integrity has been compromised. Repair it to restore functionality.")
        end)
    end

    
end

function ENT:OnTakeDamage(dmginfo)

    self.theDepotInv.Integrity = self.theDepotInv.Integrity - dmginfo:GetDamage()
    local attacker = dmginfo:GetAttacker()
    if(IsValid(attacker) and attacker:IsPlayer()) then
        print("THE SUPPLY DEPOT TOOK " ..dmginfo:GetDamage() .." from " ..attacker:Nick() .. " " ..self.theDepotInv.Integrity)
    end
    if(self.theDepotInv.Integrity < 0) then
        self.theDepotInv.Integrity = 0
    end
end