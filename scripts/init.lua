if (PopVersion >= "0.30.4") then
  Tracker.AllowDeferredLogicUpdate = true
end


ScriptHost:LoadScript("scripts/Lists.lua")
ScriptHost:LoadScript("scripts/autotracking.lua")
ScriptHost:LoadScript("scripts/locations.lua")
--ScriptHost:LoadScript("scripts/logic/logic.lua")
--ScriptHost:LoadScript("scripts/watches.lua")

Tracker:AddItems("items/items.json")
Tracker:AddMaps("maps/maps.json")
Tracker:AddLayouts("layouts/item_grids.json")
Tracker:AddLayouts("layouts/layouts.json")

function LoadWorlds()
  for i = 2, 10, 1 do
    local world = Tracker:FindObjectForCode("floor" .. i).CurrentStage
    if world == 8 then
      Tracker:AddLayouts("layouts/Wood F" .. i .. ".json")
    else
      Tracker:AddLayouts("layouts/F" .. i .. ".json")
    end
  end
end
ScriptHost:AddWatchForCode("Load Worlds", "read",LoadWorlds)
LoadWorlds()

function CheckFloor(num, world)
  local stage = Tracker:FindObjectForCode("Floor" .. num).CurrentStage
  if INVERSE_WORLDORDER[world] == stage then
    return false
  else
    return true
  end
end

function HasAmount(item, num)
	return Tracker:ProviderCountForCode(item) >= tonumber(num)
end

function CastleAccess()
  if HasAmount("friends",8) and HasAmount("worlds",8) then
    Tracker:FindObjectForCode("Castle Oblivion").Active = true
  end
end
ScriptHost:AddWatchForCode("castle 1","friends",CastleAccess)
ScriptHost:AddWatchForCode("castle 2","worlds",CastleAccess)

function Level()
  if Tracker:FindObjectForCode("levels").Active == true then
  Tracker:AddLayouts("layouts/item_grids_levels.json")
  else
    Tracker:AddLayouts("layouts/item_grids.json")
  end
end

ScriptHost:AddWatchForCode("level ups","levels",Level)