<p align="center">
    <img width="140" src="https://icons.iconarchive.com/icons/iconarchive/red-orb-alphabet/128/Letter-M-icon.png" />  
    <h1 align="center">Hi 👋, I'm MaDHouSe</h1>
    <h3 align="center">A passionate allround developer </h3>    
</p>

<p align="center">
    <a href="https://github.com/MaDHouSe79/mh-stashes/issues">
        <img src="https://img.shields.io/github/issues/MaDHouSe79/mh-stashes"/> 
    </a>
    <a href="https://github.com/MaDHouSe79/mh-stashes/watchers">
        <img src="https://img.shields.io/github/watchers/MaDHouSe79/mh-stashes"/> 
    </a> 
    <a href="https://github.com/MaDHouSe79/mh-stashes/network/members">
        <img src="https://img.shields.io/github/forks/MaDHouSe79/mh-stashes"/> 
    </a>  
    <a href="https://github.com/MaDHouSe79/mh-stashes/stargazers">
        <img src="https://img.shields.io/github/stars/MaDHouSe79/mh-stashes?color=white"/> 
    </a>
    <a href="https://github.com/MaDHouSe79/mh-stashes/blob/main/LICENSE">
        <img src="https://img.shields.io/github/license/MaDHouSe79/mh-stashes?color=black"/> 
    </a>      
</p>

# My Youtube/Discord Channel
- [Subscribe](https://www.youtube.com/c/@MaDHouSe79)
- [Discord](https://discord.gg/vJ9EukCmJQ)

# Preview
- [Preview](https://www.youtube.com/watch?v=KGW8CVwHZ5E)

# mh-stashes
With this stash item you can give a stash with items in it to other players for example money, drugs or weapons, 
it works also with mh-cashasitem.
it also hase a wallet you can use to put all your cash and or card in it.

# Possibilities
- Your own Wallet (only cash or cards, see `config.lua` `Config.Stashes` look for `allowedItems`)
- A Cash Suitcase (only cash or markedmoney is allowed, see `config.lua` `Config.Stashes` look for `allowedItems`)
- Drugs Suitcase  (only drugs is allowed, see `config.lua` `Config.Stashes` look for `allowedItems`)
- Weapon Suitcase (only weapons is allowed, see `config.lua` `Config.Stashes` look for `allowedItems`)

# Dependencies
- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-target](https://github.com/qbcore-framework/qb-target)
- [qb-radialmenu](https://github.com/qbcore-framework/qb-radialmenu)
- [qb-inventiory](https://github.com/qbcore-framework/qb-inventory)
- [mh-cashasitem](https://github.com/MaDHouSe79/mh-cashasitem)

# NOTE
- Before you start make sure you add all your items you want to use in Config.Stashes.
- You can not spawn in a stash item with `/giveitem` that does not work, you need to buy the stash in game by the ped.
- when you want to buy a stash item you can't have one in your inventory, you can use stash item at the time.
- if you change any value you need to restart the server
- make sure the items in the inventory and mh-stashes config files are the same with the items.

# When you add more items in (allowedItems) in (Config.Stashes) 
- This will not update the item in the Database.
- The item data can change and than the item does not work.
- Players need te delete the item from there inventory or stash and get a new item.

# Missions
- There are a maffia missions, and if you fail you lose all your money on cash and bank,
- The boss will rob you and kill you if you don't bring the item where he ask for.

# NOTE mh-cashasitem
- if you already have mh-cashasitem you need to replace the code with this code below.

# Item Images
![alttext](https://github.com/MaDHouSe79/mh-stashes/blob/main/images/walletstash.png)
![alttext](https://github.com/MaDHouSe79/mh-stashes/blob/main/images/cashstash.png)
![alttext](https://github.com/MaDHouSe79/mh-stashes/blob/main/images/drugsstash.png)
![alttext](https://github.com/MaDHouSe79/mh-stashes/blob/main/images/weaponstash.png)
![alttext](https://github.com/MaDHouSe79/mh-stashes/blob/main/images/largebagstash.png)
![alttext](https://github.com/MaDHouSe79/mh-stashes/blob/main/images/mediumbagstash.png)
![alttext](https://github.com/MaDHouSe79/mh-stashes/blob/main/images/smallbagstash.png)
![alttext](https://github.com/MaDHouSe79/mh-stashes/blob/main/images/missionstash.png)


# Add in qb-core/shared/items.lua
```lua
-- mh-stashes
walletstash                  = { name = 'walletstash',  label = 'Your Wallet', weight = 0, type = 'item', image = 'walletstash.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A wallet.' },
cashstash                    = { name = "cashstash", label = "Cash Suitcase", weight = 1000, type = "item", image = "cashstash.png", unique = true, useable = true, shouldClose = false, combinable = nil, description = "a cash suitcase" },
drugsstash                   = { name = "drugsstash", label = "Drugs Suitcase", weight = 1000, type = "item", image = "drugsstash.png", unique = true, useable = true, shouldClose = false, combinable = nil, description = "a drugs suitcase" },
weaponstash                  = { name = "weaponstash", label = "Weapon Suitcase", weight = 1000, type = "item", image = "weaponstash.png", unique = true, useable = true, shouldClose = false, combinable = nil, description = "a weapon suitcase" },
smallbagstash                = { name = "smallbagstash", label = "Small Bag", weight = 1000, type = "item", image = "smallbagstash.png", unique = true, useable = true, shouldClose = false, combinable = nil, description = "a small bag" },
mediumbagstash               = { name = "mediumbagstash", label = "Medium Bag", weight = 1000, type = "item", image = "mediumbagstash.png", unique = true, useable = true, shouldClose = false, combinable = nil, description = "a medium bag" },
largebagstash                = { name = "largebagstash", label = "largebagstash", weight = 1000, type = "item", image = "largebagstash.png", unique = true, useable = true, shouldClose = false, combinable = nil, description = "a large bag " },
missionstash                 = { name = 'missionstash', label = 'Mission Suitcase', weight = 0, type = 'item', image = 'missionstash.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A mission suitcase.'},
```

# Add in qb-inventory/config.lua
```lua
Config.Stashes = { 
    ["walletstash"] = true, 
    ["cashstash"] = true, 
    ["drugsstash"] = true, 
    ["weaponstash"] = true,
    ['smallbagstash'] = true,
    ['mediumbagstash'] = true,
    ['largebagstash'] = true,
    ['missionstash'] = true,
}
```

# To Add For qb-invenroty server/main.lua at line 12
```lua
local CashAsItemUpdateTrigger = "mh-cashasitem:server:updateCash" -- you need mh-cashasitem for this
local lastUsedStashItem = nil
local function IsItemAllowedToAdd(src, stash, item)
    if Config.Stashes[stash] then
        if lastUsedStashItem ~= nil and lastUsedStashItem.info.allowedItems ~= nil and
            not lastUsedStashItem.info.allowedItems[item] then
            TriggerEvent('mh-stashes:server:allowed_items_error', src, lastUsedStashItem.info.allowedItems)
            lastUsedStashItem = nil
            return false
        end
    end
    return true
end

local function IsStashItemLootable(src, stash)
    if Config.Stashes[stash] and lastUsedStashItem ~= nil and lastUsedStashItem.info and
        not lastUsedStashItem.info.canloot then
        lastUsedStashItem = nil
        TriggerEvent('mh-stashes:server:not_allowed_to_loot', src)
        return false
    end
    return true
end
```

# Add this code in qb-inventory/server/main.lua
- find: `inventory:server:UseItemSlot`
```lua
if Config.Stashes[itemData.name] then lastUsedStashItem = itemData end
```
# It should look like this
```lua
RegisterNetEvent('inventory:server:UseItemSlot', function(slot)
    local src = source
    local itemData = GetItemBySlot(src, slot)
    if not itemData then return end
    local itemInfo = QBCore.Shared.Items[itemData.name]
    if itemData.type == 'weapon' then
        TriggerClientEvent('inventory:client:UseWeapon', src, itemData, itemData.info.quality and itemData.info.quality > 0)
        TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, 'use')
    elseif itemData.useable then
        if Config.Stashes[itemData.name] then lastUsedStashItem = itemData end -- <-- ADD HERE
        UseItem(itemData.name, src, itemData)
        TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, 'use')
    end
end)
```

# Add this code in qb-inventory/server/main.lua
- find: `inventory:server:UseItem`
```lua
if Config.Stashes[itemData.name] then lastUsedStashItem = itemData end
```
# It should look like this
```lua
RegisterNetEvent('inventory:server:UseItem', function(inventory, item)
    local src = source
    if inventory ~= 'player' and inventory ~= 'hotbar' then return end
    local itemData = GetItemBySlot(src, item.slot)
    if not itemData then return end
    local itemInfo = QBCore.Shared.Items[itemData.name]
    if itemData.type == 'weapon' then
        TriggerClientEvent('inventory:client:UseWeapon', src, itemData, itemData.info.quality and itemData.info.quality > 0)
        TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, 'use')
    else
        if Config.Stashes[itemData.name] then lastUsedStashItem = itemData end -- <-- ADD HERE
        UseItem(itemData.name, src, itemData)
        TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, 'use')
    end
end)
```


# For qb-invenroty server/main.lua
```lua
RegisterNetEvent('inventory:server:SetInventoryData', function(fromInventory, toInventory, fromSlot, toSlot, fromAmount, toAmount)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	fromSlot = tonumber(fromSlot)
	toSlot = tonumber(toSlot)
	if (fromInventory == "player" or fromInventory == "hotbar") and
		(QBCore.Shared.SplitStr(toInventory, "-")[1] == "itemshop" or toInventory == "crafting") then
		return
	end
	if fromInventory == "player" or fromInventory == "hotbar" then
		local fromItemData = Player.Functions.GetItemBySlot(fromSlot)
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot)
				TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "remove", false)
				TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
				if toItemData ~= nil then
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
						TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "remove", false)
						Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info)
						TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "add", false)
					end
				end
				Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info)
				TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "add", false)
			elseif QBCore.Shared.SplitStr(toInventory, "-")[1] == "otherplayer" then
				local playerId = tonumber(QBCore.Shared.SplitStr(toInventory, "-")[2])
				local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
				local toItemData = OtherPlayer.PlayerData.items[toSlot]
				Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot)
				TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "remove", true)
				TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						OtherPlayer.Functions.RemoveItem(itemInfo["name"], toAmount, fromSlot)
						TriggerEvent(CashAsItemUpdateTrigger, playerId, toItemData, toAmount, "remove",
							true)
						Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info)
						TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "add", true)
						TriggerEvent("qb-log:server:CreateLog", "robbing", "Swapped Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | *" .. src .. "*) swapped item; name: **" .. itemInfo["name"] ..
								"**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name ..
								"**, amount: **" .. fromAmount .. "** with player: **" ..
								GetPlayerName(OtherPlayer.PlayerData.source) .. "** (citizenid: *" ..
								OtherPlayer.PlayerData.citizenid .. "* | id: *" .. OtherPlayer.PlayerData.source ..
								"*)")
					end
				else
					local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
					TriggerEvent("qb-log:server:CreateLog", "robbing", "Dropped Item", "red",
						"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid .. "* | *" ..
							src .. "*) dropped new item; name: **" .. itemInfo["name"] .. "**, amount: **" ..
							fromAmount .. "** to player: **" .. GetPlayerName(OtherPlayer.PlayerData.source) ..
							"** (citizenid: *" .. OtherPlayer.PlayerData.citizenid .. "* | id: *" ..
							OtherPlayer.PlayerData.source .. "*)")
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				OtherPlayer.Functions.AddItem(itemInfo["name"], fromAmount, toSlot, fromItemData.info)
				TriggerEvent(CashAsItemUpdateTrigger, playerId, fromItemData, fromAmount, "add", true)
			elseif QBCore.Shared.SplitStr(toInventory, "-")[1] == "trunk" then
				local plate = QBCore.Shared.SplitStr(toInventory, "-")[2]
				local toItemData = Trunks[plate].items[toSlot]
				Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot)
				TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "remove", true)
				TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						RemoveFromTrunk(plate, fromSlot, itemInfo["name"], toAmount)
						Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info)
						TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "add", true)
						TriggerEvent("qb-log:server:CreateLog", "trunk", "Swapped Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) swapped item; name: **" .. itemInfo["name"] ..
								"**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name ..
								"**, amount: **" .. fromAmount .. "** - plate: *" .. plate .. "*")
					end
				else
					local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
					TriggerEvent("qb-log:server:CreateLog", "trunk", "Dropped Item", "red",
						"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
							"* | id: *" .. src .. "*) dropped new item; name: **" .. itemInfo["name"] ..
							"**, amount: **" .. fromAmount .. "** - plate: *" .. plate .. "*")
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				AddToTrunk(plate, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
			elseif QBCore.Shared.SplitStr(toInventory, "-")[1] == "glovebox" then
				local plate = QBCore.Shared.SplitStr(toInventory, "-")[2]
				local toItemData = Gloveboxes[plate].items[toSlot]
				Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot)
				if Config.Stashes[fromItemData.name:lower()] then
					TriggerEvent('mh-stashes:client:RemoveProp', src)
				end
				TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "remove", true)
				TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						RemoveFromGlovebox(plate, fromSlot, itemInfo["name"], toAmount)
						Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info)
						TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "add", true)
						TriggerEvent("qb-log:server:CreateLog", "glovebox", "Swapped Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) swapped item; name: **" .. itemInfo["name"] ..
								"**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name ..
								"**, amount: **" .. fromAmount .. "** - plate: *" .. plate .. "*")
					end
				else
					local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
					TriggerEvent("qb-log:server:CreateLog", "glovebox", "Dropped Item", "red",
						"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
							"* | id: *" .. src .. "*) dropped new item; name: **" .. itemInfo["name"] ..
							"**, amount: **" .. fromAmount .. "** - plate: *" .. plate .. "*")
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				AddToGlovebox(plate, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
			elseif QBCore.Shared.SplitStr(toInventory, "-")[1] == "stash" then
				local stashId = QBCore.Shared.SplitStr(toInventory, "-")[2]
				local toItemData = Stashes[stashId].items[toSlot]
				local stashName = QBCore.Shared.SplitStr(stashId, "_")[1]
				local allowedToAdd = IsItemAllowedToAdd(src, stashName, fromItemData.name)
				if allowedToAdd then
					Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot)
					TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "remove", true)
					TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
					if toItemData ~= nil then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
						if toItemData.name ~= fromItemData.name then
							RemoveFromStash(stashId, toSlot, itemInfo["name"], toAmount)
							Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info)
							TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "add", true)
							TriggerEvent("qb-log:server:CreateLog", "stash", "Swapped Item", "orange", "**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid .. "* | id: *" .. src .. "*) swapped item; name: **" .. itemInfo["name"] .. "**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name .. "**, amount: **" .. fromAmount .. "** - stash: *" .. stashId .. "*")
						end
					else
						local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
						TriggerEvent("qb-log:server:CreateLog", "stash", "Dropped Item", "red", "**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid .. "* | id: *" .. src .. "*) dropped new item; name: **" .. itemInfo["name"] .. "**, amount: **" .. fromAmount .. "** - stash: *" .. stashId .. "*")
					end
					local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
					AddToStash(stashId, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
				end
			elseif QBCore.Shared.SplitStr(toInventory, "-")[1] == "traphouse" then
				-- Traphouse
				local traphouseId = QBCore.Shared.SplitStr(toInventory, "-")[2]
				local toItemData = exports['qb-traphouse']:GetInventoryData(traphouseId, toSlot)
				local IsItemValid = exports['qb-traphouse']:CanItemBeSaled(fromItemData.name:lower())
				if IsItemValid then
					Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot)
					TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "remove", true)
					TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
					if toItemData ~= nil then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
						if toItemData.name ~= fromItemData.name then
							exports['qb-traphouse']:RemoveHouseItem(traphouseId, fromSlot, itemInfo["name"],
								toAmount)
							Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info)
							TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "add", true)
							TriggerEvent("qb-log:server:CreateLog", "traphouse", "Swapped Item", "orange",
								"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
									"* | id: *" .. src .. "*) swapped item; name: **" .. itemInfo["name"] ..
									"**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name ..
									"**, amount: **" .. fromAmount .. "** - traphouse: *" .. traphouseId .. "*")
						end
					else
						local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
						TriggerEvent("qb-log:server:CreateLog", "traphouse", "Dropped Item", "red",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) dropped new item; name: **" .. itemInfo["name"] ..
								"**, amount: **" .. fromAmount .. "** - traphouse: *" .. traphouseId .. "*")
					end
					local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
					exports['qb-traphouse']:AddHouseItem(traphouseId, toSlot, itemInfo["name"], fromAmount,
						fromItemData.info, src)
				else
					TriggerClientEvent('QBCore:Notify', src, "You can\'t sell this item..", 'error')
				end
			else
				-- drop
				toInventory = tonumber(toInventory)
				if toInventory == nil or toInventory == 0 then
					if Config.Stashes[fromItemData.name:lower()] then
						local coords = GetEntityCoords(GetPlayerPed(src))
						local pos = {["x"] = coords.x + 0.5, ["y"] = coords.y + 0.5, ["z"] = coords.z }
						TriggerEvent('mh-stashes:server:dropstash', src, fromItemData, pos)
					else
						CreateNewDrop(src, fromSlot, toSlot, fromAmount)
						TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "remove", true)
					end
				else
					local toItemData = Drops[toInventory].items[toSlot]
					Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot)
					TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "remove", true)
					TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
					if toItemData ~= nil then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
						if toItemData.name ~= fromItemData.name then
							Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info)
							TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "add",
								true)
							RemoveFromDrop(toInventory, fromSlot, itemInfo["name"], toAmount)
							TriggerEvent("qb-log:server:CreateLog", "drop", "Swapped Item", "orange",
								"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
									"* | id: *" .. src .. "*) swapped item; name: **" .. itemInfo["name"] ..
									"**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name ..
									"**, amount: **" .. fromAmount .. "** - dropid: *" .. toInventory .. "*")
						end
					else
						local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
						TriggerEvent("qb-log:server:CreateLog", "drop", "Dropped Item", "red",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) dropped new item; name: **" .. itemInfo["name"] ..
								"**, amount: **" .. fromAmount .. "** - dropid: *" .. toInventory .. "*")
					end
					local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
					AddToDrop(toInventory, toSlot, itemInfo["name"], fromAmount, fromItemData.info)
					if itemInfo["name"] == "radio" then
						TriggerClientEvent('Radio.Set', src, false)
					end
				end
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "You don\'t have this item!", "error")
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "otherplayer" then
		local playerId = tonumber(QBCore.Shared.SplitStr(fromInventory, "-")[2])
		local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
		local fromItemData = OtherPlayer.PlayerData.items[fromSlot]
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				OtherPlayer.Functions.RemoveItem(itemInfo["name"], fromAmount, fromSlot)
				TriggerEvent(CashAsItemUpdateTrigger, playerId, fromItemData, fromAmount, "remove", true)
				TriggerClientEvent("inventory:client:CheckWeapon", OtherPlayer.PlayerData.source, fromItemData.name)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
						TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "remove", true)
						OtherPlayer.Functions.AddItem(itemInfo["name"], toAmount, fromSlot, toItemData.info)
						TriggerEvent(CashAsItemUpdateTrigger, playerId, toItemData, toAmount, "add", true)
						TriggerEvent("qb-log:server:CreateLog", "robbing", "Swapped Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) swapped item; name: **" .. toItemData.name ..
								"**, amount: **" .. toAmount .. "** with item; **" .. itemInfo["name"] ..
								"**, amount: **" .. toAmount .. "** from player: **" ..
								GetPlayerName(OtherPlayer.PlayerData.source) .. "** (citizenid: *" ..
								OtherPlayer.PlayerData.citizenid .. "* | *" .. OtherPlayer.PlayerData.source .. "*)")
					end
				else
					TriggerEvent("qb-log:server:CreateLog", "robbing", "Retrieved Item", "green",
						"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
							"* | id: *" .. src .. "*) took item; name: **" .. fromItemData.name .. "**, amount: **" ..
							fromAmount .. "** from player: **" .. GetPlayerName(OtherPlayer.PlayerData.source) ..
							"** (citizenid: *" .. OtherPlayer.PlayerData.citizenid .. "* | *" ..
							OtherPlayer.PlayerData.source .. "*)")
				end
				Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info)
				TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "add", true)
			else
				local toItemData = OtherPlayer.PlayerData.items[toSlot]
				OtherPlayer.Functions.RemoveItem(itemInfo["name"], fromAmount, fromSlot)
				TriggerEvent(CashAsItemUpdateTrigger, playerId, toItemData, fromAmount, "remove", true)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						OtherPlayer.Functions.RemoveItem(itemInfo["name"], toAmount, toSlot)
						TriggerEvent(CashAsItemUpdateTrigger, playerId, toItemData, toAmount, "remove",
							true)
						OtherPlayer.Functions.AddItem(itemInfo["name"], toAmount, fromSlot, toItemData.info)
						TriggerEvent(CashAsItemUpdateTrigger, playerId, toItemData, toAmount, "add", true)
					end
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				OtherPlayer.Functions.AddItem(itemInfo["name"], fromAmount, toSlot, fromItemData.info)
				TriggerEvent(CashAsItemUpdateTrigger, playerId, fromItemData, fromAmount, "add", true)
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "Item doesn\'t exist??", "error")
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "trunk" then
		local plate = QBCore.Shared.SplitStr(fromInventory, "-")[2]
		local fromItemData = Trunks[plate].items[fromSlot]
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				RemoveFromTrunk(plate, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
						TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "remove", true)
						AddToTrunk(plate, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
						TriggerEvent("qb-log:server:CreateLog", "trunk", "Swapped Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) swapped item; name: **" .. toItemData.name ..
								"**, amount: **" .. toAmount .. "** with item; name: **" .. itemInfo["name"] ..
								"**, amount: **" .. toAmount .. "** plate: *" .. plate .. "*")
					else
						TriggerEvent("qb-log:server:CreateLog", "trunk", "Stacked Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) stacked item; name: **" .. toItemData.name ..
								"**, amount: **" .. toAmount .. "** from plate: *" .. plate .. "*")
					end
				else
					TriggerEvent("qb-log:server:CreateLog", "trunk", "Received Item", "green",
						"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
							"* | id: *" .. src .. "*) received item; name: **" .. fromItemData.name ..
							"**, amount: **" .. fromAmount .. "** plate: *" .. plate .. "*")
				end
				Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info)
				TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "add", true)
			else
				local toItemData = Trunks[plate].items[toSlot]
				RemoveFromTrunk(plate, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						RemoveFromTrunk(plate, toSlot, itemInfo["name"], toAmount)
						AddToTrunk(plate, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
					end
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				AddToTrunk(plate, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "Item doesn\'t exist??", "error")
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "glovebox" then
		local plate = QBCore.Shared.SplitStr(fromInventory, "-")[2]
		local fromItemData = Gloveboxes[plate].items[fromSlot]
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				RemoveFromGlovebox(plate, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
						TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "remove", true)
						AddToGlovebox(plate, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
						TriggerEvent("qb-log:server:CreateLog", "glovebox", "Swapped", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. ")* swapped item; name: **" .. toItemData.name ..
								"**, amount: **" .. toAmount .. "** with item; name: **" .. itemInfo["name"] ..
								"**, amount: **" .. toAmount .. "** plate: *" .. plate .. "*")
					else
						TriggerEvent("qb-log:server:CreateLog", "glovebox", "Stacked Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) stacked item; name: **" .. toItemData.name ..
								"**, amount: **" .. toAmount .. "** from plate: *" .. plate .. "*")
					end
				else
					TriggerEvent("qb-log:server:CreateLog", "glovebox", "Received Item", "green",
						"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
							"* | id: *" .. src .. "*) received item; name: **" .. fromItemData.name ..
							"**, amount: **" .. fromAmount .. "** plate: *" .. plate .. "*")
				end
				Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info)
				TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "add", true)
			else
				local toItemData = Gloveboxes[plate].items[toSlot]
				RemoveFromGlovebox(plate, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						RemoveFromGlovebox(plate, toSlot, itemInfo["name"], toAmount)
						AddToGlovebox(plate, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
					end
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				AddToGlovebox(plate, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "Item doesn\'t exist??", "error")
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "stash" then
		local stashId = QBCore.Shared.SplitStr(fromInventory, "-")[2]
		local fromItemData = Stashes[stashId].items[fromSlot]
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local stashName = QBCore.Shared.SplitStr(stashId, "_")[1]
				local isLootable = IsStashItemLootable(src, stashName)
				if isLootable then
					local toItemData = Player.Functions.GetItemBySlot(toSlot)
					RemoveFromStash(stashId, fromSlot, itemInfo["name"], fromAmount)
					if toItemData ~= nil then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
						if toItemData.name ~= fromItemData.name then
							Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
							TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "remove", true)
							AddToStash(stashId, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
							TriggerEvent("qb-log:server:CreateLog", "stash", "Swapped Item", "orange",
								"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
									"* | id: *" .. src .. "*) swapped item; name: **" .. toItemData.name ..
									"**, amount: **" .. toAmount .. "** with item; name: **" .. fromItemData.name ..
									"**, amount: **" .. fromAmount .. "** stash: *" .. stashId .. "*")
						else
							TriggerEvent("qb-log:server:CreateLog", "stash", "Stacked Item", "orange",
								"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
									"* | id: *" .. src .. "*) stacked item; name: **" .. toItemData.name ..
									"**, amount: **" .. toAmount .. "** from stash: *" .. stashId .. "*")
						end
					else
						TriggerEvent("qb-log:server:CreateLog", "stash", "Received Item", "green",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) received item; name: **" .. fromItemData.name ..
								"**, amount: **" .. fromAmount .. "** stash: *" .. stashId .. "*")
					end
					SaveStashItems(stashId, Stashes[stashId].items)
					Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info)
					TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "add", true)
				end

			else
				local toItemData = Stashes[stashId].items[toSlot]
				RemoveFromStash(stashId, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						RemoveFromStash(stashId, toSlot, itemInfo["name"], toAmount)
						AddToStash(stashId, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
					end
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				AddToStash(stashId, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
			end

		else
			TriggerClientEvent("QBCore:Notify", src, "Item doesn\'t exist??", "error")
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "traphouse" then
		local traphouseId = QBCore.Shared.SplitStr(fromInventory, "-")[2]
		local fromItemData = exports['qb-traphouse']:GetInventoryData(traphouseId, fromSlot)
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				exports['qb-traphouse']:RemoveHouseItem(traphouseId, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
						TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "remove", true)
						exports['qb-traphouse']:AddHouseItem(traphouseId, fromSlot, itemInfo["name"], toAmount,
							toItemData.info, src)
						TriggerEvent("qb-log:server:CreateLog", "stash", "Swapped Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) swapped item; name: **" .. toItemData.name ..
								"**, amount: **" .. toAmount .. "** with item; name: **" .. fromItemData.name ..
								"**, amount: **" .. fromAmount .. "** stash: *" .. traphouseId .. "*")
					else
						TriggerEvent("qb-log:server:CreateLog", "stash", "Stacked Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) stacked item; name: **" .. toItemData.name ..
								"**, amount: **" .. toAmount .. "** from stash: *" .. traphouseId .. "*")
					end
				else
					TriggerEvent("qb-log:server:CreateLog", "stash", "Received Item", "green",
						"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
							"* | id: *" .. src .. "*) received item; name: **" .. fromItemData.name ..
							"**, amount: **" .. fromAmount .. "** stash: *" .. traphouseId .. "*")
				end
				Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info)
				TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "add", true)
			else
				local toItemData = exports['qb-traphouse']:GetInventoryData(traphouseId, toSlot)
				exports['qb-traphouse']:RemoveHouseItem(traphouseId, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						exports['qb-traphouse']:RemoveHouseItem(traphouseId, toSlot, itemInfo["name"], toAmount)
						exports['qb-traphouse']:AddHouseItem(traphouseId, fromSlot, itemInfo["name"], toAmount,
							toItemData.info, src)
					end
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				exports['qb-traphouse']:AddHouseItem(traphouseId, toSlot, itemInfo["name"], fromAmount,
					fromItemData.info, src)
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "Item doesn't exist??", "error")
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "itemshop" then
		local shopType = QBCore.Shared.SplitStr(fromInventory, "-")[2]
		local itemData = ShopItems[shopType].items[fromSlot]
		local itemInfo = QBCore.Shared.Items[itemData.name:lower()]
		local bankBalance = Player.PlayerData.money["bank"]
		local price = tonumber((itemData.price * fromAmount))

		if QBCore.Shared.SplitStr(shopType, "_")[1] == "Dealer" then
			if QBCore.Shared.SplitStr(itemData.name, "_")[1] == "weapon" then
				price = tonumber(itemData.price)
				if Player.Functions.RemoveMoney("cash", price, "dealer-item-bought") then
					itemData.info.serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) ..
													   QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) ..
													   QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
					Player.Functions.AddItem(itemData.name, 1, toSlot, itemData.info)
					TriggerClientEvent('qb-drugs:client:updateDealerItems', src, itemData, 1)
					TriggerClientEvent('QBCore:Notify', src, itemInfo["label"] .. " bought!", "success")
					TriggerEvent("qb-log:server:CreateLog", "dealers", "Dealer item bought", "green", "**" ..
						GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. " for $" .. price)
				else
					TriggerClientEvent('QBCore:Notify', src, "You don\'t have enough cash..", "error")
				end
			else
				if Player.Functions.RemoveMoney("cash", price, "dealer-item-bought") then
					Player.Functions.AddItem(itemData.name, fromAmount, toSlot, itemData.info)
					TriggerClientEvent('qb-drugs:client:updateDealerItems', src, itemData, fromAmount)
					TriggerClientEvent('QBCore:Notify', src, itemInfo["label"] .. " bought!", "success")
					TriggerEvent("qb-log:server:CreateLog", "dealers", "Dealer item bought", "green", "**" ..
						GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. "  for $" .. price)
				else
					TriggerClientEvent('QBCore:Notify', src, "You don't have enough cash..", "error")
				end
			end
		elseif QBCore.Shared.SplitStr(shopType, "_")[1] == "Itemshop" then
			if Player.Functions.RemoveMoney("cash", price, "itemshop-bought-item") then
				if QBCore.Shared.SplitStr(itemData.name, "_")[1] == "weapon" then
					itemData.info.serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) ..
													   QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) ..
													   QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
				end
				if itemData.name:lower() == 'wallet' then
					itemData.info.walletid = math.random(11111, 99999)
				end
				Player.Functions.AddItem(itemData.name, fromAmount, toSlot, itemData.info)
				TriggerClientEvent('qb-shops:client:UpdateShop', src, QBCore.Shared.SplitStr(shopType, "_")[2],
					itemData, fromAmount)
				TriggerClientEvent('QBCore:Notify', src, itemInfo["label"] .. " bought!", "success")
				TriggerEvent("qb-log:server:CreateLog", "shops", "Shop item bought", "green",
					"**" .. GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. " for $" .. price)
			elseif bankBalance >= price then
				Player.Functions.RemoveMoney("bank", price, "itemshop-bought-item")
				if QBCore.Shared.SplitStr(itemData.name, "_")[1] == "weapon" then
					itemData.info.serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) ..
													   QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) ..
													   QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
				end
				if itemData.name:lower() == 'wallet' then
					itemData.info.walletid = math.random(11111, 99999)
				end
				Player.Functions.AddItem(itemData.name, fromAmount, toSlot, itemData.info)
				TriggerClientEvent('qb-shops:client:UpdateShop', src, QBCore.Shared.SplitStr(shopType, "_")[2],
					itemData, fromAmount)
				TriggerClientEvent('QBCore:Notify', src, itemInfo["label"] .. " bought!", "success")
				TriggerEvent("qb-log:server:CreateLog", "shops", "Shop item bought", "green",
					"**" .. GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. " for $" .. price)
			else
				TriggerClientEvent('QBCore:Notify', src, "You don't have enough cash..", "error")
			end

		elseif QBCore.Shared.SplitStr(shopType, "_")[1] == "market" then
			if Player.Functions.RemoveMoney("blackmoney", price, "blackmarket-item-bought") then
				AddItem(src, itemData.name, fromAmount, toSlot, itemData.info)
				TriggerEvent(CashAsItemUpdateTrigger, src, itemData.name, price, "remove", true)
				QBCore.Functions.Notify(src, itemInfo["label"] .. " bought!", "success")
				TriggerEvent("qb-log:server:CreateLog", "blackmarket", "Blackmarket item bought", "green", "**" ..
					GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. "  for $" .. price)
			else
				QBCore.Functions.Notify(src, "You don't have blackmoney", "error")
			end

		else
			if Player.Functions.RemoveMoney("cash", price, "unkown-itemshop-bought-item") then
				Player.Functions.AddItem(itemData.name, fromAmount, toSlot, itemData.info)
				TriggerClientEvent('QBCore:Notify', src, itemInfo["label"] .. " bought!", "success")
				TriggerEvent("qb-log:server:CreateLog", "shops", "Shop item bought", "green",
					"**" .. GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. " for $" .. price)
			elseif bankBalance >= price then
				Player.Functions.RemoveMoney("bank", price, "unkown-itemshop-bought-item")
				Player.Functions.AddItem(itemData.name, fromAmount, toSlot, itemData.info)
				TriggerClientEvent('QBCore:Notify', src, itemInfo["label"] .. " bought!", "success")
				TriggerEvent("qb-log:server:CreateLog", "shops", "Shop item bought", "green",
					"**" .. GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. " for $" .. price)
			else
				TriggerClientEvent('QBCore:Notify', src, "You don\'t have enough cash..", "error")
			end
		end
	elseif fromInventory == "crafting" then
		local itemData = Config.CraftingItems[fromSlot]
		if hasCraftItems(src, itemData.costs, fromAmount) then
			TriggerClientEvent("inventory:client:CraftItems", src, itemData.name, itemData.costs, fromAmount,
				toSlot, itemData.points)
		else
			TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, true)
			TriggerClientEvent('QBCore:Notify', src, "You don't have the right items..", "error")
		end
	elseif fromInventory == "attachment_crafting" then
		local itemData = Config.AttachmentCrafting["items"][fromSlot]
		if hasCraftItems(src, itemData.costs, fromAmount) then
			TriggerClientEvent("inventory:client:CraftAttachment", src, itemData.name, itemData.costs, fromAmount,
				toSlot, itemData.points)
		else
			TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, true)
			TriggerClientEvent('QBCore:Notify', src, "You don't have the right items..", "error")
		end
	else
		-- drop
		fromInventory = tonumber(fromInventory)
		local fromItemData = Drops[fromInventory].items[fromSlot]
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				RemoveFromDrop(fromInventory, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
						TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "remove", true)
						AddToDrop(fromInventory, toSlot, itemInfo["name"], toAmount, toItemData.info)
						if itemInfo["name"] == "radio" then
							TriggerClientEvent('Radio.Set', src, false)
						end
						TriggerEvent("qb-log:server:CreateLog", "drop", "Swapped Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) swapped item; name: **" .. toItemData.name ..
								"**, amount: **" .. toAmount .. "** with item; name: **" .. fromItemData.name ..
								"**, amount: **" .. fromAmount .. "** - dropid: *" .. fromInventory .. "*")
					else
						TriggerEvent("qb-log:server:CreateLog", "drop", "Stacked Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) stacked item; name: **" .. toItemData.name ..
								"**, amount: **" .. toAmount .. "** - from dropid: *" .. fromInventory .. "*")
					end
				else
					TriggerEvent("qb-log:server:CreateLog", "drop", "Received Item", "green",
						"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
							"* | id: *" .. src .. "*) received item; name: **" .. fromItemData.name ..
							"**, amount: **" .. fromAmount .. "** -  dropid: *" .. fromInventory .. "*")
				end
				Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info)
				TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "add", true)
			else
				toInventory = tonumber(toInventory)
				local toItemData = Drops[toInventory].items[toSlot]
				RemoveFromDrop(fromInventory, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						RemoveFromDrop(toInventory, toSlot, itemInfo["name"], toAmount)
						AddToDrop(fromInventory, fromSlot, itemInfo["name"], toAmount, toItemData.info)
						if itemInfo["name"] == "radio" then
							TriggerClientEvent('Radio.Set', src, false)
						end
					end
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				AddToDrop(toInventory, toSlot, itemInfo["name"], fromAmount, fromItemData.info)
				if itemInfo["name"] == "radio" then
					TriggerClientEvent('Radio.Set', src, false)
				end
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "Item doesn't exist??", "error")
		end
	end
end)
```

# LICENSE
[GPL LICENSE](./LICENSE)<br />
&copy; [MaDHouSe79](https://www.youtube.com/@MaDHouSe79)
