local LOGGER = CoreAPI.Utils.Logger.newLogger("SPAERZ")
local spearsModReg = CoreAPI.Items.newItemRegistry("SPAERZ") -- This must be the same as the mod name in mod.json

-- Tiers of Spears ^_^
local WoodTier = Game.Items.newToolTier()
WoodTier.MiningLevel = 0
WoodTier.Durability = 59
WoodTier.MiningEfficiency = 2
WoodTier.DamageBonus = 1
WoodTier.Enchantability = 15

local StoneTier = Game.Items.newToolTier()
StoneTier.MiningLevel = 1
StoneTier.Durability = 131
StoneTier.MiningEfficiency = 4
StoneTier.DamageBonus = 1
StoneTier.Enchantability = 5

local IronTier = Game.Items.newToolTier()
IronTier.MiningLevel = 2
IronTier.Durability = 250
IronTier.MiningEfficiency = 6
IronTier.DamageBonus = 2
IronTier.Enchantability = 14

local GoldTier = Game.Items.newToolTier()
GoldTier.MiningLevel = 0
GoldTier.Durability = 32
GoldTier.MiningEfficiency = 12
GoldTier.DamageBonus = 1
GoldTier.Enchantability = 22

local DiamondTier = Game.Items.newToolTier()
DiamondTier.MiningLevel = 3
DiamondTier.Durability = 1561
DiamondTier.MiningEfficiency = 8
DiamondTier.DamageBonus = 3
DiamondTier.Enchantability = 10

-- Basically a Helper Function for me to Find Freed ID's
--local function getFreeItemID(startID, endID)
  --  for id = startID, endID do
    --    local item = Game.Items.findItemByID(id)
      --  if item == nil then
        --    Core.Debug.log("[SPAERZ] Free real ID found: " .. id .. " | Returning: " .. (id - 256))
          --  return id - 256
      --  end
    -- end
  --  return nil
--end

-- Defs for registering my Spears \(^-^)/
local WOODEN_SPEAR = spearsModReg:registerItem("wooden_spear", 70, {
    texture = "items/wooden_spear.3dst",
    locales = {
        en_US = "Wooden Spear"
    },
    tool = "sword",
    tier = WoodTier
})
Core.Debug.log("[SPAERZ] Registered Spear - Name: " .. WOODEN_SPEAR.NameID .. " | ID: " .. WOODEN_SPEAR.ID)
-- WOODEN_SPEAR.StackSize = 1

local STONE_SPEAR = spearsModReg:registerItem("stone_spear", 71, {
    texture = "items/stone_spear.3dst",
    locales = {
        en_US = "Stone Spear"
    },
    tool = "sword",
    tier = StoneTier
})
Core.Debug.log("[SPAERZ] Registered Spear - Name: " .. STONE_SPEAR.NameID .. " | ID: " .. STONE_SPEAR.ID)
-- STONE_SPEAR.StackSize = 1

local IRON_SPEAR = spearsModReg:registerItem("iron_spear", 79, {
    texture = "items/iron_spear.3dst",
    locales = {
        en_US = "Iron Spear"
    },
    tool = "sword",
    tier = IronTier
})
Core.Debug.log("[SPAERZ] Registered Spear - Name: " .. IRON_SPEAR.NameID .. " | ID: " .. IRON_SPEAR.ID)
-- IRON_SPEAR.StackSize = 1

local GOLD_SPEAR = spearsModReg:registerItem("golden_spear", 87, {
    texture = "items/golden_spear.3dst",
    locales = {
        en_US = "Golden Spear"
    },
    tool = "sword",
    tier = GoldTier
})
Core.Debug.log("[SPAERZ] Registered Spear - Name: " .. GOLD_SPEAR.NameID .. " | ID: " .. GOLD_SPEAR.ID)
-- GOLD_SPEAR.StackSize = 1

local DIAMOND_SPEAR = spearsModReg:registerItem("diamond_spear", 130, {
    texture = "items/diamond_spear.3dst",
    locales = {
        en_US = "Diamond Spear"
    },
    tool = "sword",
    tier = DiamondTier
})
Core.Debug.log("[SPAERZ] Registered Spear - Name: " .. DIAMOND_SPEAR.NameID .. " | ID: " .. DIAMOND_SPEAR.ID)
-- DIAMOND_SPEAR.StackSize = 1


-- Register Entries for Items >.<"
CoreAPI.ItemGroups.registerEntries(CoreAPI.ItemGroups.TOOLS, function (entries)
    entries:addBefore(WOODEN_SPEAR, "wooden_sword")
    entries:addBefore(STONE_SPEAR, "stone_sword")
    entries:addBefore(IRON_SPEAR, "iron_sword")
    entries:addBefore(GOLD_SPEAR, "golden_sword")
    entries:addBefore(DIAMOND_SPEAR, "diamond_sword")
end)

-- Register Recipes :3c
Game.Recipes.OnRegisterRecipes:Connect(function (recipesTable)
    local stick = Game.Items.findItemByID(280)
    local plank = Game.Items.findItemByID(5)
    local stone = Game.Items.findItemByID(4)
    local iron = Game.Items.findItemByID(265)
    local gold = Game.Items.findItemByID(266)
    local diamond = Game.Items.findItemByID(264)
    if stick and plank and stone and iron and gold and diamond then -- Check no nil
        local stickInst = Game.Items.getItemInstance(stick, 1, 0)
        local plankInst = Game.Items.getItemInstance(plank, 1, 0)
        local stoneInst = Game.Items.getItemInstance(stone, 1, 0)
        local ironInst = Game.Items.getItemInstance(iron, 1, 0)
        local goldInst = Game.Items.getItemInstance(gold, 1, 0)
        local diamondInst = Game.Items.getItemInstance(diamond, 1, 0)
        local woodenSpearInst = Game.Items.getItemInstance(WOODEN_SPEAR, 1, 0)
        local stoneSpearInst = Game.Items.getItemInstance(STONE_SPEAR, 1, 0)
        local ironSpearInst = Game.Items.getItemInstance(IRON_SPEAR, 1, 0)
        local goldSpearInst = Game.Items.getItemInstance(GOLD_SPEAR, 1, 0)
        local diamondSpearInst = Game.Items.getItemInstance(DIAMOND_SPEAR, 1, 0)
        Game.Recipes.registerShapedRecipe(recipesTable, woodenSpearInst, 2, 505, "  M", " S ", "S  ", {{"M", plankInst}, {"S", stickInst}})
        Game.Recipes.registerShapedRecipe(recipesTable, stoneSpearInst, 2, 506, "  M", " S ", "S  ", {{"M", stoneInst}, {"S", stickInst}})
        Game.Recipes.registerShapedRecipe(recipesTable, ironSpearInst, 2, 507, "  M", " S ", "S  ", {{"M", ironInst}, {"S", stickInst}})
        Game.Recipes.registerShapedRecipe(recipesTable, goldSpearInst, 2, 508, "  M", " S ", "S  ", {{"M", goldInst}, {"S", stickInst}})
        Game.Recipes.registerShapedRecipe(recipesTable, diamondSpearInst, 2, 509, "  M", " S ", "S  ", {{"M", diamondInst}, {"S", stickInst}})
    end
end)

-- Build these damn recources
spearsModReg:buildResources()

-- Spear Logic System
local SPEAR_RUNTIME = {
    spearBaseDamage = {
        [70]  = 1,
        [71]  = 1,
        [79]  = 2,
        [87]  = 1,
        [130] = 3
    },

    damageMultiplier = 6.0,
    dashStrength     = 2.6,
    dashDuration     = 0.10,
    dashCooldown     = 3.00,

    dashActive       = false,
    dashEndTime      = 0,
    nextDashTime     = 0,

    lastItemPtr      = nil,
    lastDamageAddr   = nil,
    lastBaseDamage   = nil
}

local function _floor(n)
    return math.floor(n)
end

local function _clampToU32(n)
    if n < 0 then
        return 0
    end
    if n > 0xFFFFFFFF then
        return 0xFFFFFFFF
    end
    return n
end

local function _getHeldItem()
    local hand = Game.LocalPlayer.Inventory.Slots["hand"]
    if not hand then
        return nil
    end
    if hand:isEmpty() then
        return nil
    end
    return hand.Item
end

local function _isHeldItemSpear(item)
    if not item then
        return false
    end
    return SPEAR_RUNTIME.spearBaseDamage[item.ID] ~= nil
end

local function _getHeldSpearBaseDamage(item)
    if not item then
        return nil
    end
    return SPEAR_RUNTIME.spearBaseDamage[item.ID]
end

local function _getRealItemPointer(item)
    if not item then
        return nil
    end

    local userdataHex = tostring(item):match("userdata: (.+)")
    if not userdataHex then
        return nil
    end

    local userdataAddr = tonumber(userdataHex, 16)
    if not userdataAddr then
        return nil
    end

    return Core.Memory.readU32(userdataAddr)
end

local function _getDamageBonusAddress(item)
    local itemPtr = _getRealItemPointer(item)
    if not itemPtr then
        return nil, nil
    end
    return itemPtr + 0xAC, itemPtr
end

local function _getHorizontalSpeed()
    local vx, vy, vz = Game.LocalPlayer.Velocity.get()
    vx = vx or 0.0
    vz = vz or 0.0
    return math.sqrt((vx * vx) + (vz * vz)), vx, vy or 0.0, vz
end

local function _writeHeldSpearDamageBonus(newBonus)
    local heldItem = _getHeldItem()
    if not _isHeldItemSpear(heldItem) then
        return false
    end

    local damageAddr, itemPtr = _getDamageBonusAddress(heldItem)
    if not damageAddr then
        return false
    end

    newBonus = _clampToU32(_floor(newBonus))
    local ok = Core.Memory.writeU32(damageAddr, newBonus)

    if ok then
        SPEAR_RUNTIME.lastItemPtr = itemPtr
        SPEAR_RUNTIME.lastDamageAddr = damageAddr
        SPEAR_RUNTIME.lastBaseDamage = _getHeldSpearBaseDamage(heldItem)
    end

    return ok
end

local function _restoreHeldSpearBaseDamage()
    local heldItem = _getHeldItem()
    if not _isHeldItemSpear(heldItem) then
        return
    end

    local base = _getHeldSpearBaseDamage(heldItem)
    if not base then
        return
    end

    _writeHeldSpearDamageBonus(base)
end

local function _doDash()
    local now = Core.System.getTime()

    if now < SPEAR_RUNTIME.nextDashTime then
        return
    end

    local heldItem = _getHeldItem()
    if not _isHeldItemSpear(heldItem) then
        return
    end

    local speed, vx, vy, vz = _getHorizontalSpeed()

    local dx, dz
    if speed > 0.001 then
        dx = vx / speed
        dz = vz / speed
    else
        dx = 0.0
        dz = 1.0
    end

    Game.LocalPlayer.Velocity.add(
        dx * SPEAR_RUNTIME.dashStrength,
        0.0,
        dz * SPEAR_RUNTIME.dashStrength
    )

    SPEAR_RUNTIME.dashActive = true
    SPEAR_RUNTIME.dashEndTime = now + SPEAR_RUNTIME.dashDuration
    SPEAR_RUNTIME.nextDashTime = now + SPEAR_RUNTIME.dashCooldown

    Core.Debug.log("[SPAERZ] Dash used. Cooldown until " .. tostring(SPEAR_RUNTIME.nextDashTime))
end

local function updateSpearVelocityDamage()
    if not Game.LocalPlayer.Loaded then
        return
    end

    local heldItem = _getHeldItem()
    if not _isHeldItemSpear(heldItem) then
        return
    end

    local now = Core.System.getTime()

    if SPEAR_RUNTIME.dashActive and now >= SPEAR_RUNTIME.dashEndTime then
        SPEAR_RUNTIME.dashActive = false
    end

    if Game.Gamepad.isPressed(Game.Gamepad.KeyCodes.L) then
        _doDash()
    end

    if Game.Gamepad.isDown(Game.Gamepad.KeyCodes.R) then
        local baseDamage = _getHeldSpearBaseDamage(heldItem)
        if baseDamage then
            local horizSpeed = _getHorizontalSpeed()
            local scaledBonus = _floor(horizSpeed * SPEAR_RUNTIME.damageMultiplier)
            local finalDamageBonus = baseDamage + scaledBonus

            _writeHeldSpearDamageBonus(finalDamageBonus)
        end
    else
        _restoreHeldSpearBaseDamage()
    end
end

local function startSpearVelocitySystem()
    Async.run(function()
        while true do
            updateSpearVelocityDamage()
            Async.wait(0.01) -- ~10ms polling
        end
    end)
end

local rootFolder = Core.Menu.getMenuFolder()
local mainFolder = rootFolder:newFolder("SPAERZ (Spears)")
mainFolder:newEntry("Credit(s)", function()
    Core.Menu.showMessageBox("Modname(s): SPAERZ\nDeveloper: Cracko298\n\nRelease Build")
end)

if Game.LocalPlayer.Loaded and Game.World.Loaded then
    Core.Debug.message("SPAERZ has Loaded.")
    startSpearVelocitySystem()
end