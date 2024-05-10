--[[ ===================================================== ]] --
--[[              MH Stashes Script by MaDHouSe            ]] --
--[[ ===================================================== ]] --
local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local Stashes = {}
local isLoggedIn = false
local isCooldown = false
local ishide = false
local isHoldingStash = true
local radialmenu = nil
local stashObj = nil
local stashClot = nil
local bossPed = nil
local missionPed = nil
local missionStart = false
local mission = nil
local jobvehicleBlip = nil
local missionBlip = nil
local homeBlip = nil
local pickupLocation = nil
local hasPickup = false

---@param title string
---@param message string
---@param type string
---@param length number
local function Notify(title, message, type, length)
    if length == nil then
        length = 5000
    end
    if type == nil then
        type = "primary"
    end
    if title == nil then
        title = Config.NotifyTitle
    end
    if Config.Notify == "okokNotify" then
        exports['okokNotify']:Alert(title, message, length, type)
    elseif Config.Notify == "qb-core" then
        if type == "info" then
            type = "primary"
        end
        QBCore.Functions.Notify({
            text = title,
            caption = message
        }, type, length)
    elseif Config.Notify == "roda-notify" then
        exports['Roda_Notifications']:showNotify(title, message, type, length)
    else
        print("mh-stashes: Your type of notify choice is not supported")
    end
end

--- Set Relationship
local function SetRelationship()
    SetRelationshipBetweenGroups(0, GetHashKey("Guards"), GetHashKey("Guards"))
    SetRelationshipBetweenGroups(5, GetHashKey("Guards"), GetHashKey("PLAYER"))
    SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("Guards"))
end

--- Reset Relationship
local function ResetRelationship()
    SetRelationshipBetweenGroups(0, GetHashKey("Guards"), GetHashKey("Guards"))
    SetRelationshipBetweenGroups(0, GetHashKey("Guards"), GetHashKey("PLAYER"))
    SetRelationshipBetweenGroups(0, GetHashKey("PLAYER"), GetHashKey("Guards"))
end

---Get the distance between 2 coords
---@param pos1 vector(x:number, y:number, z:number)
---@param pos2 vector(x:number, y:number, z:number)
---@return number
local function GetDistance(pos1, pos2)
    return #(vector3(pos1.x, pos1.y, pos1.z) - vector3(pos2.x, pos2.y, pos2.z))
end

---Remove Stuck Prop 
---Only work if a prop is attached to player ped
local function RemoveStuckProp()
    local ped = PlayerPedId()
    for _, v in pairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(ped, v) then
            SetEntityAsMissionEntity(v, true, true)
            DeleteObject(v)
            DeleteEntity(v)
        end
    end
end

---Load Model
---@param model string
local function LoadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(1)
    end
end

---Load Anim Dict
---@param dict string
local function LoadAnimDict(dict)
    RequestAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        Citizen.Wait(1)
    end
end

---RemoveAnimDict
local function RemoveAnimDict(animDict)
    RemoveAnimDict(animDict)
end

---Take Anim
---@param ped number
local function TakeGiveAnim(ped)
    LoadAnimDict("mp_safehouselost@")
    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
        if not IsEntityPlayingAnim(ped, "mp_safehouselost@", "package_dropoff", 3) then
            TaskPlayAnim(ped, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
            Wait(2000)
            ClearPedTasks(ped)
        end
    end
end

---Pickup Animation
---@param ped number
local function PickupAnimation(ped)
    LoadAnimDict("pickup_object")
    if not IsEntityPlayingAnim(ped, "pickup_object", "pickup_low", 3) then
        TaskPlayAnim(ped, "pickup_object", "pickup_low", 8.0, -8.0, -1, 1, 0, false, false, false)
        Wait(2000)
        ClearPedTasks(ped)
    end
end

---Walk Away
---@param ped number
local function WalkAway(ped)
    if DoesEntityExist(ped) then
        SetEntityAsMissionEntity(ped, true, true)
        FreezeEntityPosition(ped, false)
        ClearPedTasks(ped)
        ClearPedTasksImmediately(ped)
        ClearPedSecondaryTask(ped)
        SetPedKeepTask(ped, false)
        TaskSetBlockingOfNonTemporaryEvents(ped, false)
        TaskWanderStandard(ped, 100.0, 20)
        SetPedAsNoLongerNeeded(ped)
        if ped == Config.Shop.entity then
            Citizen.Wait(20000)
            DeletePed(Config.Shop.entity)
            Config.Shop.entity = nil
        elseif ped == missionPed then
            Citizen.Wait(20000)
            DeletePed(missionPed)
            missionPed = nil
        end
    end
end

--- Remove Guards Peds
local function RemoveGuardsPeds()
    for k, boss in pairs(Config.Bosses) do
        for k, v in pairs(boss.guards) do
            if DoesEntityExist(v.entity) then
                DeletePed(v.entity)
                DeleteEntity(v.entity)
            end
        end
    end
end

---Delete Current Ped
local function DeleteShopPed()
    if Config.Shop.entity ~= nil then
        WalkAway(Config.Shop.entity)
    end
end

---Delete Current Ped
local function DeleteMissionPed()
    if missionPed ~= nil then
        WalkAway(missionPed)
    end
end

--- Reset Boss
---@param entity number
---@param coords table
---@param heading number
local function ResetBoss(entity, coords, heading)
    ClearPedTasks(entity)
    ClearPedTasksImmediately(entity)
    ClearPedSecondaryTask(entity)
    SetEntityCoords(entity, vector3(coords.x, coords.y, coords.z - 1))
    SetEntityHeading(entity, heading)
    TaskStartScenarioInPlace(entity, "WORLD_HUMAN_GUARD_STAND_ARMY", true)
    FreezeEntityPosition(entity, true)
end

--- Reset Guard
---@param entity number
---@param coords table
---@param heading number
local function ResetGuard(entity, coords, heading)
    ClearPedTasks(entity)
    ClearPedTasksImmediately(entity)
    ClearPedSecondaryTask(entity)
    SetEntityCoords(entity, vector3(coords.x, coords.y, coords.z - 1))
    SetEntityHeading(entity, heading)
    TaskStartScenarioInPlace(entity, "WORLD_HUMAN_GUARD_STAND_ARMY", true)
    FreezeEntityPosition(entity, true)
end

--- Attack
local function Attack()
    SetRelationship()
    for _, boss in pairs(Config.Bosses) do
        for _, v in pairs(boss.guards) do
            if DoesEntityExist(v.entity) then
                FreezeEntityPosition(v.entity, false)
                v.isAttack = true
            end
        end
    end
end

---Create Stash Object
---@param itemName string
---@return table
local function CreateItemObject(itemName)
    if itemName ~= nil and Config.Stashes[itemName] then
        local prop = Config.Stashes[itemName].holdprop
        local current = GetHashKey(prop)
        LoadModel(current)
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
        local stash = CreateObject(current, x, y, z + 0.9, false, false, false)
        return stash
    end
end

---Detach Entity Object From Player
local function DetachEntityObjectFromPlayer()
    if stashObj ~= nil then
        if DoesEntityExist(stashObj) then
            SetEntityAsMissionEntity(stashObj, true, true)
            if IsEntityAttachedToEntity(PlayerPedId(), stashObj) then DetachEntity(stashObj, true, true) end
            DeleteObject(stashObj)
            DeleteEntity(stashObj)
            stashObj = nil
        end
    end
    RemoveStuckProp()
end

---Attach Object To Player
---@param player number
---@param item string
local function AttachObjectToPlayer(player, item)
    if stashObj ~= nil then
        local offset = Config.Stashes[item].offset
        local bone = 60309 -- 6286   -- 64097
        AttachEntityToEntity(stashObj, player, GetPedBoneIndex(player, bone), offset.xPos, offset.yPos, offset.zPos, offset.xRot, offset.yRot, offset.zRot, true, true, false, true, 1, true)
    end
end

---Buy Menu
local function BuyMenu()
    local menu = exports["qb-input"]:ShowInput({
        header = Lang:t('shop.header'),
        submitText = "",
        inputs = {{
            text = Lang:t('shop.select'),
            name = "item",
            type = "select",
            options = {{
                value = "walletstash",
                text = Lang:t('shop.wallet')
            }, {
                value = "smallbagstash",
                text = Lang:t('shop.smallbag')
            }, {
                value = "mediumbagstash",
                text = Lang:t('shop.mediumbag')
            }, {
                value = "largebagstash",
                text = Lang:t('shop.largebag')
            }, {
                value = "cashstash",
                text = Lang:t('shop.cash')
            }, {
                value = "drugsstash",
                text = Lang:t('shop.drugs')
            }, {
                value = "weaponstash",
                text = Lang:t('shop.weapon')
            }},
            isRequired = true
        }}
    })
    if menu then
        if not menu.item then
            return
        else
            TriggerServerEvent('mh-stashes:server:buy', tostring(menu.item))
        end
    end
end

---Create Mission Blip
---@param name string
---@param coords vector3
---@param sprite number
local function CreateMissionBlip(name, coords, sprite)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, 5)
    SetBlipScale(blip, 0.5)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(name)
    EndTextCommandSetBlipName(blip)
    SetBlipRoute(blip, 1)
    return blip
end

local function CreateHomeBlip()
    for _, v in pairs(Config.Bosses) do
        if v.isMission then 
            homeBlip = CreateMissionBlip('Go back', v.coords, 351)
            break
        end
    end
end

--- Pick Up And Go Back
---@param entity number
local function PickUpAndGoBack(entity)
    if not hasPickup then
        hasPickup = true
        FreezeEntityPosition(entity, false)
        TaskTurnPedToFaceEntity(entity, PlayerPedId(), 5000)
        TaskTurnPedToFaceEntity(PlayerPedId(), entity, 5000)
        Wait(1500)
        FreezeEntityPosition(entity, true)
        TakeGiveAnim(PlayerPedId())
        TakeGiveAnim(entity)
        Wait(1000)
        RemoveBlip(missionBlip)
        TriggerServerEvent('mh-stashes:server:getPickup')
        CreateHomeBlip()
        Wait(1000)
        DeleteMissionPed()
    end
end

---Delete All stash Drops
local function DeleteAllStashDrops()
    for k, stash in pairs(Stashes) do
        if stash then
            SetEntityAsMissionEntity(stash.entity, true, true)
            DeleteObject(stash.entity)
            DeleteEntity(stash.entity)
        end
    end
    Stashes = {}
end

---Remove Drop
---@param item object
local function RemoveDrop(item)
    for k, v in pairs(Stashes) do
        if v and v.stashid == item.info.stashid then
            SetEntityAsMissionEntity(v.entity, true, true)
            DeleteEntity(v.entity)
            DeleteObject(v.entity)
            Stashes[item.info.stashid] = nil
        end
    end
end

---Remove Drop
---@param owner number
---@param item table
---@param coords vector3(x: number, y: number, z: number)
local function AddDrop(owner, item, coords)
    local hash = GetHashKey(Config.Stashes[item.name].dropprop)
    LoadModel(hash)
    local dropItem = CreateObject(hash, coords.x, coords.y, coords.z, false, false, false)
    PlaceObjectOnGroundProperly(dropItem)
    FreezeEntityPosition(dropItem, true)
    exports['qb-target']:AddTargetEntity(dropItem, {
        options = {{
            icon = 'suitcase',
            label = Lang:t('target.pickup'),
            action = function()
                PickupAnimation(PlayerPedId())
                TriggerServerEvent("mh-stashes:server:pickup", item)
            end
        }, {
            icon = 'suitcase',
            label = Lang:t('target.open'),
            action = function()
                TriggerServerEvent("mh-stashes:server:open", item)
            end
        }, {
            icon = 'suitcase',
            label = Lang:t('target.delete'),
            action = function()
                TriggerServerEvent("mh-stashes:server:delete", item)
            end,
            canInteract = function(entity, distance, data)
                if PlayerData.citizenid ~= owner then
                    return false
                end
                if missionStart then
                    return false
                end
                return true
            end
        }},
        distance = 2.5
    })
    Stashes[#Stashes + 1] = {
        entity = dropItem,
        stashid = item.info.stashid,
        owner = owner
    }
end

---Do Action
---@param action string
---@param item string
local function DoAction(action, item)
    local ped = PlayerPedId()
    SetCurrentPedWeapon(ped, "WEAPON_UNARMED", true)
    RemoveStuckProp()
    if action == "add" then
        if item == "smallbagstash" then
            stashClot = item
            SetPedComponentVariation(ped, 5, Config.smallBagClotId, 0, 0)
        elseif item == "mediumbagstash" then
            stashClot = item
            SetPedComponentVariation(ped, 5, Config.mediumBagClotId, 0, 0)
        elseif item == "largebagstash" then
            stashClot = item
            SetPedComponentVariation(ped, 5, Config.largeBagClotId, 0, 0)
        else
            stashObj = CreateItemObject(item)
            AttachObjectToPlayer(PlayerPedId(), item)
        end
    elseif action == "remove" then
        if stashClot ~= nil then
            SetPedComponentVariation(ped, 5, 0, 0, 0)
            stashClot = nil
        end
        if stashObj ~= nil then
            DetachEntityObjectFromPlayer()
        end
    end
end

---Does The Player Has A stash Item
---@return boolean, nil or string
local function DoesThePlayerHasAStashItem()
    if QBCore.Functions.HasItem("cashstash", 1) then
        return true, "cashstash"
    elseif QBCore.Functions.HasItem("drugsstash", 1) then
        return true, "drugsstash"
    elseif QBCore.Functions.HasItem("weaponstash", 1) then
        return true, "weaponstash"
    elseif QBCore.Functions.HasItem("smallbagstash", 1) then
        return true, "smallbagstash"
    elseif QBCore.Functions.HasItem("mediumbagstash", 1) then
        return true, "mediumbagstash"
    elseif QBCore.Functions.HasItem("largebagstash", 1) then
        return true, "largebagstash"
    elseif QBCore.Functions.HasItem("missionstash", 1) then
        return true, "missionstash"
    end
    return false, nil
end

---Run CoolDown
local function RunCoolDown()
    isCooldown = true
    SetTimeout(5000, function()
        isCooldown = false
    end)
end

---Set Ped Outfit
---@param ped number
local function SetPedOutfit(ped, outfit)
    local data = Config.Outfit
    if outfit ~= nil then data = outfit end
    if data["hair"] ~= nil then SetPedComponentVariation(ped, 2, data["hair"].item, data["hair"].texture, 0) end
    if data["beard"] ~= nil then SetPedComponentVariation(ped, 1, data["beard"].item, data["beard"].texture, 0) end
    if data["pants"] ~= nil then SetPedComponentVariation(ped, 4, data["pants"].item, data["pants"].texture, 0) end
    if data["arms"] ~= nil then SetPedComponentVariation(ped, 3, data["arms"].item, data["arms"].texture, 0) end
    if data["t-shirt"] ~= nil then SetPedComponentVariation(ped, 8, data["t-shirt"].item, data["t-shirt"].texture, 0) end
    if data["vest"] ~= nil then SetPedComponentVariation(ped, 9, data["vest"].item, data["vest"].texture, 0) end
    if data["torso2"] ~= nil then SetPedComponentVariation(ped, 11, data["torso2"].item, data["torso2"].texture, 0) end
    if data["shoes"] ~= nil then SetPedComponentVariation(ped, 6, data["shoes"].item, data["shoes"].texture, 0) end
    if data["bag"] ~= nil then SetPedComponentVariation(ped, 5, data["bag"].item, data["bag"].texture, 0) end
    if data["decals"] ~= nil then SetPedComponentVariation(ped, 10, data["decals"].item, data["decals"].texture, 0) end
    if data["mask"] ~= nil then SetPedComponentVariation(ped, 1, data["mask"].item, data["mask"].texture, 0) end
    if data["bag"] ~= nil then SetPedComponentVariation(ped, 5, data["bag"].item, data["bag"].texture, 0) end
    if data["hat"] ~= nil and data["hat"].item ~= -1 and data["hat"].item ~= 0 then SetPedPropIndex(ped, 0, data["hat"].item, data["hat"].texture, true) end
    if data["glass"] ~= nil and data["glass"].item ~= -1 and data["glass"].item ~= 0 then SetPedPropIndex(ped, 1, data["glass"].item, data["glass"].texture, true) end
    if data["ear"] ~= nil and data["ear"].item ~= -1 and data["ear"].item ~= 0 then SetPedPropIndex(ped, 2, data["ear"].item, data["ear"].texture, true) end
end

---Create Shop Ped
local function CreateShopPed()
    if not Config.Shop.entity then 
        local model = Config.Shop.model
        if Config.UseCustumPedModel then model = Config.CustumPedModel end
        local current = GetHashKey(model)
        LoadModel(current)
        local ped = CreatePed(0, current, Config.Shop.coords.x, Config.Shop.coords.y, Config.Shop.coords.z - 1, Config.Shop.coords.w, false, false)
        if Config.UseCustumPedModel then SetPedOutfit(ped, Config.Outfit) end
        SetEntityAsMissionEntity(ped, true, true)
        TaskStartScenarioInPlace(ped, Config.Shop.scenario, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        Config.Shop.entity = ped
        exports['qb-target']:AddTargetEntity(ped, {
            options = {{
                label = Lang:t('shop.buy_a_stash'),
                icon = 'fa-solid fa-stash',
                action = function()
                    BuyMenu()
                end,
                canInteract = function(entity, distance, data)
                    if Config.InventoryStashItemLimiet then
                        if QBCore.Functions.HasItem("cashstash", 1) then return false end
                        if QBCore.Functions.HasItem("drugsstash", 1) then return false end
                        if QBCore.Functions.HasItem("weaponstash", 1) then return false end
                        if QBCore.Functions.HasItem("smallbagstash", 1) then return false end
                        if QBCore.Functions.HasItem("mediumbagstash", 1) then return false end
                        if QBCore.Functions.HasItem("largebagstash", 1) then return false end
                        if QBCore.Functions.HasItem("missionstash", 1) then return false end
                    end
                    return true
                end
            }},
            distance = 1.5
        })
    end
end

--- Spawn Guards
---@param guards table
local function SpawnGuards(guards)
    if Config.UseMissions then
        for k, v in pairs(guards) do
            if v.entity == nil then
                local model = v.model
                if Config.UseCustumPedModel then model = Config.CustumPedModel end
                local current = GetHashKey(model)
                LoadModel(current)
                local ped = CreatePed(0, current, v.coords.x, v.coords.y, v.coords.z - 1, v.coords.w, false, false)
                if Config.UseCustumPedModel then SetPedOutfit(ped, Config.Outfit) end
                local weapon = v.weapons[math.random(1, #v.weapons)]
                GiveWeaponToPed(ped, weapon, 999, false, true)
                SetCurrentPedWeapon(ped, weapon, true)
                SetEntityAsMissionEntity(ped, true, true)
                TaskStartScenarioInPlace(ped, v.scenario, true)
                FreezeEntityPosition(ped, true)
                SetPedFiringPattern(ped, 0xC6EE6B4C)
                SetEntityInvincible(ped, true)
                SetBlockingOfNonTemporaryEvents(ped, true)
                SetPedKeepTask(ped, true)
                SetEntityHealth(ped, 250)
                SetPedArmour(ped, 100)
                SetPedAccuracy(ped, 100)
                SetPedDropsWeaponsWhenDead(ped, false)
                SetCanAttackFriendly(ped, false, false)
                SetPedCanSwitchWeapon(ped, true)
                SetPedCombatAbility(ped, 2)
                SetPedCombatMovement(ped, 3)
                SetPedCombatRange(ped, 2)
                SetPedCombatAttributes(ped, 46, true)
                SetPedFleeAttributes(ped, 0, 0)
                SetPedSeeingRange(ped, 150.0)
                SetPedHearingRange(ped, 150.0)
                SetPedAlertness(ped, 3)
                SetPedPathAvoidFire(ped, true)
                SetPedPathCanUseLadders(ped, true)
                SetPedPathCanDropFromHeight(ped, true)
                SetPedPathCanUseClimbovers(ped, true)
                SetPedRelationshipGroupHash(ped, GetHashKey("Guards"))
                SetModelAsNoLongerNeeded(model)
                v.entity = ped
            end
        end
    end
end

-- Create Boss Ped
local function CreateBossPed()
    if Config.UseMissions then
        for k, v in pairs(Config.Bosses) do
            if v.entity == nil then
                local model = v.model
                local current = GetHashKey(model)
                LoadModel(current)
                local ped = CreatePed(0, current, v.coords.x, v.coords.y, v.coords.z - 1, v.coords.w, false, false)
                SetEntityAsMissionEntity(ped, true, true)
                TaskStartScenarioInPlace(ped, v.scenario, true)
                FreezeEntityPosition(ped, true)
                SetEntityInvincible(ped, true)
                SetPedKeepTask(ped, true)
                SetBlockingOfNonTemporaryEvents(ped, true)
                SetEntityHealth(ped, 100)
                SetModelAsNoLongerNeeded(model)
                exports['qb-target']:AddTargetEntity(ped, {
                    options = {{
                        label = "Speek to the boss",
                        icon = 'fa-solid fa-stash',
                        action = function()
                            if not isCooldown then
                                TriggerServerEvent('mh-stashes:server:StartMission')
                                v.isMission = true
                            elseif isCooldown then
                                QBCore.Functions.Notify({text = Lang:t('mission.notify.title'), caption = Lang:t('mission.notify.no_job')})
                            end
                        end,
                        canInteract = function(entity, distance, data)
                            if missionStart then return false end
                            if hasPickup then return false end
                            return true
                        end
                    }, {
                        label = "Deliver Item",
                        icon = 'fa-solid fa-stash',
                        action = function(entity)
                            RunCoolDown()
                            TaskTurnPedToFaceEntity(PlayerPedId(), entity, 5000)
                            Wait(1500)
                            TakeGiveAnim(PlayerPedId())
                            TriggerServerEvent('mh-stashes:server:DeliverItem')
                        end,
                        canInteract = function(entity, distance, data)
                            if not missionStart then return false end
                            if not hasPickup then return false end
                            return true
                        end
                    }},
                    distance = 1.5
                })
                v.entity = ped
                SpawnGuards(v.guards)
            end
        end
    end
end

---Create Mission Ped
local function CreateMissionPed(data)
    if Config.UseMissions then
        if data then 
            local model = data.model
            print(model)
            if Config.UseCustumPedModel then model = Config.CustumPedModel end
            local current = GetHashKey(model)
            LoadModel(current)
            missionPed = CreatePed(0, current, data.coords.x, data.coords.y, data.coords.z - 1, data.coords.w, false, false)
            if Config.UseCustumPedModel then SetPedOutfit(missionPed, Config.Outfit) end
            SetEntityAsMissionEntity(missionPed, true, true)
            TaskStartScenarioInPlace(missionPed, data.scenario, true)
            FreezeEntityPosition(missionPed, true)
            ClearPedTasks(missionPed)
            ClearPedSecondaryTask(missionPed)
            TaskSetBlockingOfNonTemporaryEvents(missionPed, true)
            SetPedFleeAttributes(missionPed, 0, 0)
            SetPedCombatAttributes(missionPed, 17, 1)
            SetPedSeeingRange(missionPed, 0.0)
            SetPedHearingRange(missionPed, 0.0)
            SetPedAlertness(missionPed, 0)
            SetPedKeepTask(missionPed, true)
            exports['qb-target']:AddTargetEntity(missionPed, {
                options = {{
                    label = Lang:t('mission.notify.take_the_suitcase'),
                    icon = 'fa-solid fa-stash',
                    action = function(entity)
                        PickUpAndGoBack(entity)
                    end,
                    canInteract = function(entity, distance, data)
                        if hasPickup then return false end
                        return true
                    end
                }},
                distance = 1.5
            })
        end
    end
end

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    isLoggedIn = true
    CreateShopPed()
    CreateBossPed()
    isHoldingStash = true
    QBCore.Functions.TriggerCallback("mh-stashes:server:GetCurrentStashes", function(theStashes)
        Stashes = theStashes
    end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
    isLoggedIn = false
    Stashes = {}
    DeleteShopPed()
    RemoveGuardsPeds()
    DeleteAllStashDrops()
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        PlayerData = QBCore.Functions.GetPlayerData()
        isLoggedIn = true
        for _, v in pairs(Config.Bosses) do ClearAreaOfPeds(v.coords.x, v.coords.y, v.coords.z, 100.0, true) end
        CreateShopPed()
        CreateBossPed()
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        PlayerData = {}
        isLoggedIn = false
        DeleteShopPed()
        RemoveGuardsPeds()
        DeleteAllStashDrops()
        DeletePed(Config.Shop.entity)
        ClearAreaOfPeds(Config.Boss.coords.x, Config.Boss.coords.y, Config.Boss.coords.z, 100.0, true)
    end
end)

RegisterNetEvent('mh-stashes:client:StartMission', function(mission)
    if mission ~= nil then
        missionStart = true
        pickupLocation = mission.coords
        CreateMissionPed(mission)
    end
end)

RegisterNetEvent('mh-stashes:client:StopMission', function()
    FreezeEntityPosition(entity, false)
    RemoveBlip(homeBlip)
    missionStart = false
end)

RegisterNetEvent('mh-stashes:client:KillPlayer', function()
    for _, boss in pairs(Config.Bosses) do
        local distance = GetDistance(GetEntityCoords(boss.entity), GetEntityCoords(PlayerPedId()))
        if distance < 50 then
            if not boss.isAttacked then
                boss.isAttacked = true
                for _, v in pairs(boss.guards) do
                    if DoesEntityExist(v.entity) then
                        SetRelationship()
                        FreezeEntityPosition(v.entity, false)
                        v.isAttack = true
                    end
                end
                missionStart = false
                ishide = false
                isHoldingStash = false
                RemoveBlip(homeBlip)
                RemoveStuckProp()
            end
        end
    end
end)

RegisterNetEvent('mh-stashes:client:open', function(id, item)
    ishide = false
    TriggerServerEvent("inventory:server:OpenInventory", "stash", item .. '_' .. id, {maxweight = Config.Stashes[item].maxweight, slots = Config.Stashes[item].maxslots})
    TriggerEvent("inventory:client:SetCurrentStash", item .. '_' .. id)
end)

RegisterNetEvent('mh-stashes:client:give', function(item)
    isHoldingStash = true
    if stashObj == nil or stashClot == nil then
        DoAction("add", item)
    end
end)

RegisterNetEvent('mh-stashes:client:take', function()
    isHoldingStash = false
    DoAction("remove")
end)

RegisterNetEvent('mh-stashes:client:syncAddDrop', function(owner, item, coords)
    AddDrop(owner, item, coords)
end)

RegisterNetEvent('mh-stashes:client:RemoveProp', function()
    DetachEntityObjectFromPlayer()
end)

RegisterNetEvent('mh-stashes:client:syncRemoveDrop', function(item)
    RemoveDrop(item)
end)

RegisterNetEvent('mh-stashes:client:hide', function()
    if stashObj ~= nil then
        ishide = true
        SetEntityVisible(stashObj, true, 0)
    end
end)

RegisterNetEvent('mh-stashes:client:show', function()
    if stashObj ~= nil then
        ishide = false
        SetEntityVisible(stashObj, false, 0)
    end
end)

RegisterNetEvent('qb-radialmenu:client:onRadialmenuOpen', function()
    local hasItem, current = DoesThePlayerHasAStashItem()
    if hasItem and current ~= "walletstash" then
        if radialmenu ~= nil then
            exports['qb-radialmenu']:RemoveOption(radialmenu)
            radialmenu = nil
        end
        radialmenu = exports['qb-radialmenu']:AddOption({
            id = 'stash00',
            title = Lang:t('menu.title'),
            icon = 'suitcase',
            items = {{
                id = 'stash01',
                title = Lang:t('menu.hide'),
                icon = "suitcase",
                type = 'client',
                event = "mh-stashes:client:hide",
                shouldClose = true
            }, {
                id = 'stash02',
                title = Lang:t('menu.show'),
                icon = "suitcase",
                type = 'client',
                event = "mh-stashes:client:show",
                shouldClose = true
            }}
        }, radialmenu)
    else
        if radialmenu ~= nil then
            exports['qb-radialmenu']:RemoveOption(radialmenu)
            radialmenu = nil
        end
    end
end)

RegisterNetEvent('mh-stashes:client:notify', function(title, message, type, time)
    Notify(Config.NotifyTitle, message, type, time)
end)

RegisterNetEvent('mh-stashes:client:DeleteAllStashDrops', function()
    DeleteAllStashDrops()
end)

CreateThread(function()
    while true do
        if isLoggedIn then
            local ped = PlayerPedId()
            local hasItem, current = DoesThePlayerHasAStashItem()
            for prop, v in pairs(Config.IgnorePropsInHand) do
                if GetHashKey(current) ~= GetHashKey(prop) then
                    if hasItem and isHoldingStash then
                        if not ishide and current ~= nil then
                            TriggerEvent('mh-stashes:client:give', current)
                        else
                            TriggerEvent('mh-stashes:client:take')
                        end
                    elseif hasItem and not isHoldingStash then
                        if not ishide and current ~= nil then
                            TriggerEvent('mh-stashes:client:give', current)
                        else
                            TriggerEvent('mh-stashes:client:take')
                        end
                    elseif not hasItem then
                        if stashObj ~= nil then
                            TriggerEvent('mh-stashes:client:take')
                        elseif stashClot ~= nil then
                            TriggerEvent('mh-stashes:client:take')
                        end
                    end
                end
            end
        end
        Wait(1000)
    end
end)

CreateThread(function()
    while true do
        if isLoggedIn then
            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(ped)
            if vehicle ~= 0 then
                if GetPedInVehicleSeat(vehicle, -1) == ped then
                    local hasItem, current = DoesThePlayerHasAStashItem()
                    if hasItem then
                        if stashObj then
                            SetEntityVisible(stashObj, false, 0)
                        elseif stashClot then
                            SetPedComponentVariation(ped, 5, 0, 0, 0)
                        end
                    end
                end
            elseif vehicle == 0 and not ishide then
                local hasItem, current = DoesThePlayerHasAStashItem()
                if hasItem then
                    if stashObj then
                        SetEntityVisible(stashObj, true, 0)
                    elseif stashClot then
                        if current == "smallbagstash" then
                            SetPedComponentVariation(ped, 5, Config.smallBagClotId, 0, 0)
                        elseif current == "mediumbagstash" then
                            SetPedComponentVariation(ped, 5, Config.mediumBagClotId, 0, 0)
                        elseif current == "largebagstash" then
                            SetPedComponentVariation(ped, 5, Config.largeBagClotId, 0, 0)
                        end
                    end
                end
            end
        end
        Wait(10)
    end
end)

CreateThread(function()
    while true do
        if isLoggedIn and Config.UseMissions then
            for _, boss in pairs(Config.Bosses) do
                if boss.isAttacked then
                    for _, v in pairs(boss.guards) do
                        if DoesEntityExist(v.entity) then
                            local coords = GetEntityCoords(PlayerPedId())
                            if GetDistance(GetEntityCoords(v.entity), coords) < 50 then
                                if v.isWalking then
                                    v.isWalking = false
                                    ResetGuard(v.entity, v.coords, v.heading)
                                    if boss.isAttacked then
                                        boss.isAttacked = false
                                        ResetBoss(boss.entity, boss.coords, boss.heading)
                                    end                                    
                                elseif v.isAttack then
                                    TaskGoToCoordAnyMeans(v.entity, coords, 2.0, 0, 0, 786603, 0xbf800000)
                                    --TaskGoToEntity(v.entity, PlayerPedId(), -1, 0.0, 5.0, 1073741824, 0)
                                    if not QBCore.Functions.GetPlayerData().metadata['isdead'] then
                                        TaskCombatPed(v.entity, PlayerPedId(), 0, 16)
                                    else
                                        ResetRelationship()
                                        v.isAttack = false
                                        v.isWalking = true
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        Wait(10)
    end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        if isLoggedIn and Config.UseMissions then
            sleep = 10
            for _, boss in pairs(Config.Bosses) do
                if DoesEntityExist(boss.entity) and not boss.isAttacked then
                    if GetDistance(GetEntityCoords(boss.entity), GetEntityCoords(PlayerPedId())) < 25 then
                        if IsPedPerformingMeleeAction(PlayerPedId()) or IsPedShooting(PlayerPedId()) then
                            boss.isAttacked = true
                            Attack()
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        if isLoggedIn and Config.UseMissions and missionStart and missionBlip == nil then
            sleep = 10
            missionBlip = CreateMissionBlip("Pickup location", pickupLocation, 527)
            Notify("Mission", "Go to tha location on your map!")
        end
        Wait(sleep)
    end
end)
