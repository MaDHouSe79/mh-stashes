--[[ ===================================================== ]] --
--[[              MH Stashes Script by MaDHouSe            ]] --
--[[ ===================================================== ]] --
local QBCore = exports['qb-core']:GetCoreObject()
local Stashes = {}
local Players = {}

--- Exploit Ban
---@param src number
---@param reason string
local function ExploitBan(src, reason)
    MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)',
        {GetPlayerName(src), QBCore.Functions.GetIdentifier(src, 'license'),
         QBCore.Functions.GetIdentifier(src, 'discord'), QBCore.Functions.GetIdentifier(src, 'ip'), reason, 2147483647,
         'mh-stashes'})
    TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Banned', 'red',
        string.format('%s was banned by %s for %s', GetPlayerName(src), 'mh-stashes', reason), true)
    DropPlayer(src, 'You were permanently banned by the server for: Exploiting')
end

--- is Close By Shop Coords
---@param src number
local function isCloseByShopCoords(src)
    local coords = GetEntityCoords(GetPlayerPed(src))
    if #(vector3(Config.Shop.coords.x, Config.Shop.coords.y, Config.Shop.coords.z) -
        vector3(coords.x, coords.y, coords.z)) < 2.0 then
        return true
    end
    return false
end

--- is Close By Boss Coords
---@param src number
local function isCloseByBossCoords(src)
    local coords = GetEntityCoords(GetPlayerPed(src))
    for k, boss in ipairs(Config.Bosses) do
        if #(vector3(boss.coords.x, boss.coords.y, boss.coords.z) - vector3(coords.x, coords.y, coords.z)) < 2.0 then
            return true
        end
    end
    return false
end

--- is Close By Pickup Coords
---@param src number
local function isCloseByPickupCoords(src)
    local coords = GetEntityCoords(GetPlayerPed(src))
    for k, mission in ipairs(SV_Config.Missions) do
        if #(vector3(mission.coords.x, mission.coords.y, mission.coords.z) - vector3(coords.x, coords.y, coords.z)) <
            2.0 then
            return true
        end
    end
    return false
end

---@param owner number
---@param item table
---@param coords vector3(x: number, y: number, z: number)
local function AddStash(owner, item, coords)
    local Player = QBCore.Functions.GetPlayer(owner)
    if not Stashes[item.info.stashid] then
        Stashes[item.info.stashid] = {}
    end
    Stashes[item.info.stashid] = {
        item = item,
        coords = coords,
        owner = Player.PlayerData.citizenid
    }
end

---@param item table
local function DeleteStash(item)
    Stashes[item.info.stashid] = nil
end

---@param source number
---@param item table
local function DeleteStashItemFromDatabase(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Stashes[item.info.stashid] and Stashes[item.info.stashid].owner == Player.PlayerData.citizenid then
        MySQL.Async.fetchAll('SELECT * FROM stashitems WHERE stash = ?', {item.info.item .. '_' .. item.info.stashid},
            function(result)
                if result[1] then
                    MySQL.Async.execute('DELETE FROM stashitems WHERE stash = ?',
                        {item.info.item .. '_' .. item.info.stashid})
                    QBCore.Functions.Notify(source, Lang:t('notify.stash_deleted'), "success")
                    TriggerClientEvent('mh-stashes:client:syncRemoveDrop', -1, item)
                    Stashes[item.info.stashid] = nil
                end
            end)
    end
end

---@param item string
---@param stashid number
---@param items table
local function SaveMissionStashItem(item, stashid, items)
    local stash = item .. "_" .. stashid
    MySQL.insert('INSERT INTO stashitems (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items',
        {
            ['stash'] = stash,
            ['items'] = json.encode(items)
        })
end

---@param item string
local function GenerateWalletID(itemName)
    local id = QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomInt(1) ..
                   QBCore.Shared.RandomInt(2)
    local result = MySQL.scalar.await('SELECT stash FROM stashitems WHERE stash = ?', {itemName .. "_" .. id})
    if result then
        return GenerateWalletID(itemName)
    else
        return id
    end
end

---@param item string
local function GenerateMissionStashID(itemName)
    local id = QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomInt(1) ..
                   QBCore.Shared.RandomInt(2)
    local result = MySQL.scalar.await('SELECT stash FROM stashitems WHERE stash = ?', {itemName .. "_" .. id})
    if result then
        return GenerateMissionStashID(itemName)
    else
        return id
    end
end

---@param item string
---@param info table
---@param amount number
local function CreateStashMissionItem(itemName, info, amount)
    local tmpItem = {}
    local itemInfo = QBCore.Shared.Items["cash"]
    if itemInfo then
        local slot = 1
        if not tmpItem[slot] then
            tmpItem[slot] = {}
        end
        tmpItem[slot] = {
            name = itemInfo['name'],
            amount = amount,
            info = info,
            label = itemInfo['label'],
            description = itemInfo['description'] or '',
            weight = itemInfo['weight'],
            type = itemInfo['type'],
            unique = itemInfo['unique'],
            useable = itemInfo['useable'],
            image = itemInfo['image'],
            shouldClose = itemInfo['shouldClose'],
            slot = slot,
            combinable = itemInfo['combinable']
        }
        SaveMissionStashItem(itemName, info.stashid, tmpItem)
    end
end

---Delete all mission stashes
local function ResetMissionStashes()
    MySQL.Async.fetchAll("SELECT * FROM stashitems", {}, function(rs)
        if #rs > 0 then
            for k, v in pairs(rs) do
                if v and v.stash ~= nil then
                    local stash = QBCore.Shared.SplitStr(v.stash, "_")[1]
                    if stash == "missionstash" then
                        MySQL.Async.execute('DELETE FROM stashitems WHERE id = ?', {v.id})
                    end
                end
            end
        end
    end)
end

---@param src number
---@param mission table
---@return boolean, nil or table
local function CheckIsPlayerHasMissionItem(src, mission)
    if Players[src] and mission ~= nil then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            for _, v in pairs(Player.PlayerData.items) do
                if v ~= nil and v.name == mission.pickup then
                    local stash = mission.pickup .. "_" .. mission.stashid
                    local result = MySQL.scalar.await('SELECT items FROM stashitems WHERE stash = ?', {stash})
                    if result then
                        local stashItems = json.decode(result)
                        for _, item in pairs(stashItems) do
                            if item and item.name == mission.item then
                                if item.amount == mission.amount then
                                    return true, item
                                elseif item.amount < mission.amount then
                                    return false, item
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return false, nil
end

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        ResetMissionStashes()
        Stashes = {}
        Players = {}
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        ResetMissionStashes()
        Stashes = {}
        Players = {}
    end
end)

RegisterServerEvent('mh-stashes:server:open', function(item)
    local src = source
    if Stashes[item.info.stashid] ~= nil then
        TriggerClientEvent('mh-stashes:client:open', src, item.info.stashid, item.info.item)
    end
end)

RegisterServerEvent('mh-stashes:server:buy', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if isCloseByShopCoords(src) then
        if QBCore.Functions.HasItem(src, item, 1) then
            TriggerClientEvent('mh-stashes:client:notify', src, Lang:t('notify.you_have_a_stash'), "error")
        else
            local price = Config.Shop.stashprices[item]
            if Player.PlayerData.money.cash >= Config.Shop.stashprices[item] then
                if Player.Functions.RemoveMoney(src, 'cash', Config.Shop.stashprices[item], "stash-paid") then
                    local new_stash_id = GenerateWalletID(item)
                    local info = {
                        owner = Player.PlayerData.citizenid,
                        stashid = new_stash_id,
                        item = Config.Stashes[item].item,
                        allowedItems = Config.Stashes[item].allowedItems,
                        canloot = Config.Stashes[item].canloot,
                        isOnMission = Config.Stashes[item].isOnMission
                    }
                    Player.Functions.AddItem(item, 1, false, info)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", 1)
                    TriggerClientEvent('mh-stashes:client:notify', src, Config.NotifyTitle,
                        Lang:t('notify.purchased_a_stash', {
                            price = item.price
                        }), "success")
                    TriggerClientEvent('mh-stashes:client:open', src, info.stashid, item)
                    TriggerClientEvent('mh-stashes:client:give', src, item)
                end
            else
                TriggerClientEvent('mh-stashes:client:notify', src, Lang:t('notify.not_enough_cash'), "error")
            end
        end
    else
        ExploitBan(src, "Exploit")
    end
end)

RegisterServerEvent('mh-stashes:server:dropstash', function(source, item, coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    if QBCore.Functions.HasItem(src, item.name, 1) then
        if Stashes[item.info.stashid] == nil then
            AddStash(src, item, coords)
            TriggerClientEvent('inventory:client:DropItemAnim', src)
            TriggerClientEvent('mh-stashes:client:syncAddDrop', -1, Player.PlayerData.citizenid, item, coords)
            TriggerClientEvent('mh-stashes:client:RemoveProp', src)
            Player.Functions.RemoveItem(item.name, 1, item.slot, nil)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove", 1)
        else
            TriggerClientEvent('mh-stashes:client:notify', src, Lang:t('notify.stash_is_dropped'), "error")
        end
    else
        TriggerClientEvent('mh-stashes:client:notify', src, Lang:t('notify.no_stash'), "error")
    end
end)

RegisterServerEvent('mh-stashes:server:getPickup', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player and Players[src] then
        if isCloseByPickupCoords(src) then
            local item = Players[src].pickup
            local amount = Players[src].amount
            local stashid = Players[src].stashid
            local info = {
                owner = Player.PlayerData.citizenid,
                stashid = stashid,
                item = item,
                allowedItems = Config.Stashes[item].allowedItems,
                canloot = false,
                isOnMission = true
            }
            Player.Functions.AddItem(item, 1, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", 1)
            CreateStashMissionItem(item, info, amount)
            local text = "Go Back and deliver the suitcase to your boss and don't steal or you lose everyting!"
            QBCore.Functions.Notify(src, {
                text = "Mission",
                caption = text
            }, nil, 8000)
        else
            ExploitBan(src, "Exploit")
        end
    end
end)

RegisterServerEvent('mh-stashes:server:pickup', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Stashes[item.info.stashid] ~= nil then
        local info = {
            owner = item.info.citizenid,
            stashid = item.info.stashid,
            item = item.info.item,
            allowedItems = item.info.allowedItems,
            canloot = item.info.canloot,
            isOnMission = item.info.isOnMission
        }
        Player.Functions.AddItem(item.name, 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "add", 1)
        TriggerClientEvent('mh-stashes:client:notify', src, Lang:t('notify.pickup_a_stash', {
            item = item.name
        }), "success")
        TriggerClientEvent('mh-stashes:client:syncRemoveDrop', -1, item)
        TriggerClientEvent('mh-stashes:client:give', src, item.name)
        DeleteStash(item)
    else
        TriggerClientEvent('mh-stashes:client:notify', src, Lang:t('notify.stash_not_exsist'), "error")
    end
end)

RegisterServerEvent('mh-stashes:server:delete', function(item)
    local src = source
    DeleteStashItemFromDatabase(src, item)
end)

RegisterServerEvent('mh-stashes:server:allowed_items_error', function(source, allowedItems)
    local src = source
    local items = ""
    for k, v in pairs(allowedItems) do
        items = items .. " " .. k
    end
    QBCore.Functions.Notify(src, {
        text = "Stashes",
        caption = Lang:t('notify.allowed_items_error', {
            items = items
        })
    }, "error", 5000)
    TriggerClientEvent('qb-inventory:client:closeinv', src)
end)

RegisterServerEvent('mh-stashes:server:max_carry_stash', function(source)
    local src = source
    TriggerClientEvent('mh-stashes:client:notify', src, Lang:t('notify.max_carry_stash'), "error")
    TriggerClientEvent('qb-inventory:client:closeinv', src)
end)

RegisterServerEvent('mh-stashes:server:not_allowed_to_loot', function(source)
    local src = source
    TriggerClientEvent('mh-stashes:client:notify', src, Lang:t('notify.not_allowed_to_loot'), "error")
    TriggerClientEvent('qb-inventory:client:closeinv', src)
end)

RegisterServerEvent('mh-stashes:server:StartMission', function()
    local src = source
    if isCloseByBossCoords(src) then
        if not Players[src] then
            Players[src] = {}
        end
        local id = math.random(1, #SV_Config.Missions)
        local mission = SV_Config.Missions[id]
        local stashid = GenerateMissionStashID(mission.pickup)
        Players[src] = {
            id = id,
            stashid = stashid,
            pickup = mission.pickup,
            item = mission.item,
            amount = mission.amount,
            coords = mission.coords,
            reward = mission.reward,
            model = mission.model
        }
        TriggerClientEvent('mh-stashes:client:StartMission', src, Players[src])
        QBCore.Functions.Notify(src, {
            text = Lang:t('mission.notify.title'),
            caption = Lang:t("mission.notify.start")
        })
    else
        ExploitBan(src, "Exploit")
    end
end)

RegisterServerEvent('mh-stashes:server:DeliverItem', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if isCloseByBossCoords(src) then
            local isFound, item = CheckIsPlayerHasMissionItem(src, Players[src])
            if isFound and item then
                DeleteStashItemFromDatabase(src, item)
                Player.Functions.RemoveItem(Players[src].pickup, 1, nil)
                Player.Functions.AddMoney(Players[src].reward.item, Players[src].reward.amount)
                TriggerClientEvent('mh-stashes:client:StopMission', src)
                QBCore.Functions.Notify(src, {
                    text = Lang:t('mission.notify.title'),
                    caption = Lang:t("mission.notify.stop")
                })
            elseif not isFound then
                Player.Functions.ClearInventory()
                Player.Functions.SetMoney('cash', 0, nil)
                Player.Functions.SetMoney('bank', 0, nil)
                TriggerClientEvent('mh-stashes:client:KillPlayer', src)
                TriggerClientEvent('mh-stashes:client:DeleteAllStashDrops', src)
                QBCore.Functions.Notify(src, {
                    text = Lang:t('mission.notify.title'),
                    caption = Lang:t('mission.notify.failed')
                }, "error", 8000)
            end
        else
            ExploitBan(src, "Exploit")
        end
    end
end)

---Get Current Stashes Callback
---@param source number
---@return table
QBCore.Functions.CreateCallback('mh-stashes:server:GetCurrentStashes', function(source, cb)
    cb(Stashes)
end)

---Useable Item (walletstash)
---@param source number
---@param item table
QBCore.Functions.CreateUseableItem("walletstash", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        item.info.cash = Player.Functions.GetMoney('cash')
        TriggerClientEvent('mh-stashes:client:open', source, item.info.stashid, item.name)
        TriggerClientEvent('mh-stashes:client:give', source, item.name)
    end
end)

---Useable Item (cashstash)
---@param source number
---@param item table
QBCore.Functions.CreateUseableItem("cashstash", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mh-stashes:client:open', source, item.info.stashid, item.name)
        TriggerClientEvent('mh-stashes:client:give', source, item.name)
    end
end)

---Useable Item (drugsstash)
---@param source number
---@param item table
QBCore.Functions.CreateUseableItem("drugsstash", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mh-stashes:client:open', source, item.info.stashid, item.name)
        TriggerClientEvent('mh-stashes:client:give', source, item.name)
    end
end)

---Useable Item (weaponstash)
---@param source number
---@param item table
QBCore.Functions.CreateUseableItem("weaponstash", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mh-stashes:client:open', source, item.info.stashid, item.name)
        TriggerClientEvent('mh-stashes:client:give', source, item.name)
    end
end)

---Useable Item (smallbagstash)
---@param source number
---@param item table
QBCore.Functions.CreateUseableItem("smallbagstash", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mh-stashes:client:open', source, item.info.stashid, item.name)
        TriggerClientEvent('mh-stashes:client:give', source, item.name)
    end
end)

---Useable Item (mediumbagstash)
---@param source number
---@param item table
QBCore.Functions.CreateUseableItem("mediumbagstash", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mh-stashes:client:open', source, item.info.stashid, item.name)
        TriggerClientEvent('mh-stashes:client:give', source, item.name)
    end
end)

---Useable Item (largebagstash)
---@param source number
---@param item table
QBCore.Functions.CreateUseableItem("largebagstash", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mh-stashes:client:open', source, item.info.stashid, item.name)
        TriggerClientEvent('mh-stashes:client:give', source, item.name)
    end
end)

---Useable Item (missionstash)
---@param source number
---@param item table
QBCore.Functions.CreateUseableItem("missionstash", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mh-stashes:client:open', source, item.info.stashid, item.name)
        TriggerClientEvent('mh-stashes:client:give', source, item.name)
    end
end)
