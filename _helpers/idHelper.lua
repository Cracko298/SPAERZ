-- Basically a Helper Function for me to Find Freed ID's
local function getFreeItemID(startID, endID)
    for id = startID, endID do
        local item = Game.Items.findItemByID(id)
        if item == nil then
            Core.Debug.log("[SPAERZ] Free real ID found: " .. id .. " | Returning: " .. (id - 256))
            return id - 256
        end
     end
    return nil
end