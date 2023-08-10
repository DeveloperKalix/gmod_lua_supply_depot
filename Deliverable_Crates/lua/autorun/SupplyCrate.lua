SupplyCrate = {}
SupplyCrate.__index = SupplyCrate;

function SupplyCrate.create(identifier, cargotype, quantity, integrity, cargoreference, reward, double)
    local instance = setmetatable({}, SupplyCrate)
    instance.identifier = identifier
    instance.cargoType = cargotype
    instance.quantity = quantity
    instance.integrity = integrity
    instance.cargoReference = cargoreference
    instance.reward = reward
    instance.double = double
    instance.triple = triple
    instance.quad = quad
    return instance
end



cargoTypes = {
    smgAmmo = "SMG Ammunition",
    pulseAmmo = "Pulse Ammunition",
    Bacta = "Bacta",
    Grenades = "Grenades",
    RocketLauncher = "Rocket Launchers"
}

indexToType = {
    [1] = "smgAmmo",
    [2] = "pulseAmmo",
    [3] = "Bacta",
    [4] = "Grenades",
    [5] = "RocketLauncher"
}

