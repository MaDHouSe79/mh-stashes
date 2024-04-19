--[[ ===================================================== ]] --
--[[              MH Stashes Script by MaDHouSe            ]] --
--[[ ===================================================== ]] --
Config = {}

Config.Notify = "qb-core" -- Default:(qb-core), you can also use (roda-notify/okokNotify)
Config.NotifyTitle = "Stash System"

Config.Shop = {
    model = "g_m_y_korean_01",
    senario = "WORLD_HUMAN_STAND_MOBILE",
    coords = vector4(137.49, 170.77, 105.08, 157.01),
    entity = nil
}

Config.UseMissions = true
Config.Bosses = {
    {
        model = "g_m_m_armboss_01",
        senario = "WORLD_HUMAN_DRUG_DEALER",
        coords = vector4(1011.18, -2864.97, 39.16, 0.7),
        heading = 0.7,
        entity = nil,
        isMission = false,
        isAttacked = false,
        guards = {
            {
                model = "g_m_m_chicold_01",
                senario = "WORLD_HUMAN_GUARD_STAND_ARMY",
                coords = vector4(1011.18, -2873.76, 39.16, 2.84),
                heading = 2.84,
                weapons = {"weapon_assaultrifle_mk2", "weapon_assaultrifle", "weapon_specialcarbine_mk2", "weapon_combatmg_mk2"},
                walkstyle = 786603,
                isWalking = false,
                isAttack = false,
                entity = nil,
            }, {
                model = "g_m_m_chicold_01",
                senario = "WORLD_HUMAN_GUARD_STAND_ARMY",
                coords = vector4(1011.2, -2888.67, 39.16, 182.45),
                heading = 182.45,
                weapons = {"weapon_assaultrifle_mk2", "weapon_assaultrifle", "weapon_specialcarbine_mk2", "weapon_combatmg_mk2"},
                walkstyle = 786603,
                isWalking = false,
                isAttack = false,
                entity = nil,
            }, {
                model = "g_m_m_chicold_01",
                senario = "WORLD_HUMAN_GUARD_STAND_ARMY",
                coords = vector4(1005.1, -2893.97, 11.26, 272.3),
                heading = 272.3,
                weapons = {"weapon_assaultrifle_mk2", "weapon_assaultrifle", "weapon_specialcarbine_mk2", "weapon_combatmg_mk2"},
                walkstyle = 786603,
                isWalking = false,
                isAttack = false,
                entity = nil,
            }
        }
    },
    {
        model = "g_m_m_armboss_01",
        senario = "WORLD_HUMAN_DRUG_DEALER",
        coords = vector4(53.6543, -1026.9800, 79.7371, 161.4034),
        heading = 157.4553,
        entity = nil,
        isMission = false,
        isAttacked = false,
        guards = {
            {
                model = "g_m_m_chicold_01",
                senario = "WORLD_HUMAN_GUARD_STAND_ARMY",
                coords = vector4(60.7337, -1037.1489, 37.1814, 158.8067),
                heading = 158.8067,
                weapons = {"weapon_assaultrifle_mk2", "weapon_assaultrifle", "weapon_specialcarbine_mk2", "weapon_combatmg_mk2"},
                walkstyle = 786603,
                isWalking = false,
                isAttack = false,
                entity = nil,
            }, {
                model = "g_m_m_chicold_01",
                senario = "WORLD_HUMAN_GUARD_STAND_ARMY",
                coords = vector4(50.1878, -1018.2604, 79.7476, 175.3181),
                heading = 175.3181,
                weapons = {"weapon_assaultrifle_mk2", "weapon_assaultrifle", "weapon_specialcarbine_mk2", "weapon_combatmg_mk2"},
                walkstyle = 786603,
                isWalking = false,
                isAttack = false,
                entity = nil,
            },
        }
    },
}

Config.smallBagClotId = 81
Config.mediumBagClotId = 81
Config.largeBagClotId = 82
Config.Stashes = {
    ['walletstash'] = {                          -- Your Wallet Stash
        label = "Your Wallet",                   -- Label
        maxweight = 18000,                       -- Max Weight
        maxslots = 9,                            -- Max slots
        price = 1000,                            -- Price to buy
        item = "walletstash",                    -- Wallet item
        holdprop = "prop_ld_wallet_02",          -- Hold prop
        dropprop = "prop_ld_wallet_pickup",      -- Drop prop
        canloot = true,                          -- If true you can loot this stash, if false you can not loot this stash
        isOnMission = false,                     -- If true this stash is on a mission, if true you can not loot this stash
        allowedItems = {                         -- only items in this table with true are allowed in the stash.
            ["cash"] = true,                     -- if true this item is allowed in this stash
            ["black_money"] = true,              -- if true this item is allowed in this stash
            ["crypto"] = true,                   -- if true this item is allowed in this stash
            ["id_card"] = true,                  -- if true this item is allowed in this stash
            ["driver_license"] = true,           -- if true this item is allowed in this stash
            ["lawyerpass"] = true,               -- if true this item is allowed in this stash
            ["weaponlicense"] = true,            -- if true this item is allowed in this stash
            ["visa"] = true,                     -- if true this item is allowed in this stash
            ["mastercard"] = true,               -- if true this item is allowed in this stash
            ["security_card_01"] = true,         -- if true this item is allowed in this stash
            ["security_card_02"] = true,         -- if true this item is allowed in this stash
            -- you can add more items.
        },
        offset = {                               -- item holding offset.
            xPos = 0.020,                        -- X-axis offset from the center of entity2.
            yPos = 0.02,                         -- Y-axis offset from the center of entity2.
            zPos = -0.008,                       -- Z-axis offset from the center of entity2.
            xRot = 150.0,                        -- X-axis rotation.
            yRot = 50.0,                         -- Y-axis rotation.
            zRot = 200.0                         -- Z-axis rotation.
        }
    },
    ['cashstash'] = {                            -- Cash Stash            
        label = "Cash Stash",
        maxweight = 18000,
        maxslots = 9,
        price = 1000,
        item = "cashstash",
        holdprop = "w_am_case",
        dropprop = "prop_cash_case_02",
        canloot = true,
        isOnMission = false,
        allowedItems = {
            ["cash"] = true,
            ["markedbills"] = true,
            ["black_money"] = true,
            ["crypto"] = true,
        },
        offset = {
            xPos = 0.020,
            yPos = 0.02,
            zPos = -0.008,
            xRot = 150.0,
            yRot = 50.0,
            zRot = 200.0
        }
    },
    ['drugsstash'] = {                           -- Drugs Stash           
        label = "Drugs Stash",
        maxweight = 18000,
        maxslots = 9,
        price = 1000,
        item = "drugsstash",
        holdprop = "hei_prop_hei_security_case",
        dropprop = "hei_prop_hei_drug_case",
        canloot = true,
        isOnMission = false,
        allowedItems = {
            ["meth"] = true,
            ["coke"] = true,
            ["weed"] = true,
            ["joint"] = true,
            -- you can add more drug if you want
        },
        offset = {
            xPos = 0.2,
            yPos = 0.0,
            zPos = 0.0,
            xRot = 150.0,
            yRot = 50.0,
            zRot = 200.0
        }
    },
    ['weaponstash'] = {                          -- Weapon stash                 
        label = "Weapon Stash",
        maxweight = 18000,
        maxslots = 9,
        price = 1000,
        item = "weaponstash",
        holdprop = "prop_box_guncase_03a",
        dropprop = "bkr_prop_biker_gcase_s",
        canloot = true,
        isOnMission = false,
        allowedItems = {
            ["weapon_pistol"] = true,
            ["pistol_ammo"] = true,
            -- you can add more weapons and ammo if you want 
        },
        offset = {
            xPos = 0.3,
            yPos = 0.0,
            zPos = 0.0,
            xRot = 150.0,
            yRot = 50.0,
            zRot = 200.0
        }
    },
    ['smallbagstash'] = {                        -- Small bag stash
        label = "Small Bag",
        maxweight = 18000,
        maxslots = 9,
        price = 1000,
        item = "smallbagstash",
        holdprop = "bkr_prop_duffel_bag_01a",
        dropprop = "bkr_prop_duffel_bag_01a",
        canloot = true,
        isOnMission = false,
        allowedItems = {}, -- add all the items this stash can use
        offset = {
            xPos = 0.020,
            yPos = 0.02,
            zPos = -0.008,
            xRot = 150.0,
            yRot = 50.0,
            zRot = 200.0
        }
    },
    ['mediumbagstash'] = {                       -- Medium bag stash
        label = "Medium Bag",
        maxweight = 18000,
        maxslots = 9,
        price = 1000,
        item = "mediumbagstash",
        holdprop = "bkr_prop_duffel_bag_01a",
        dropprop = "bkr_prop_duffel_bag_01a",
        canloot = true,
        isOnMission = false,
        allowedItems = {}, -- add all the items this stash can use
        offset = {
            xPos = 0.020,
            yPos = 0.02,
            zPos = -0.008,
            xRot = 150.0,
            yRot = 50.0,
            zRot = 200.0
        }
    },
    ['largebagstash'] = {                        -- Large bag stash
        label = "Large Bag",
        maxweight = 18000,
        maxslots = 15,
        price = 1000,
        item = "largebagstash",
        holdprop = "bkr_prop_duffel_bag_01a",
        dropprop = "bkr_prop_duffel_bag_01a",
        canloot = true,
        isOnMission = false,
        allowedItems = {}, -- add all the items this stash can use
        offset = {
            xPos = 0.020,
            yPos = 0.02,
            zPos = -0.008,
            xRot = 150.0,
            yRot = 50.0,
            zRot = 200.0
        }
    },
    ['missionstash'] = {                         -- Mission Stash   
        label = "Mission Stash",
        maxweight = 18000,
        maxslots = 1,
        price = 0,
        item = "missionstash",
        holdprop = "w_am_case",
        dropprop = "prop_cash_case_02",
        canloot = false,
        isOnMission = true,
        allowedItems = {
            -- money
            ["cash"] = true,
            ["markedbills"] = true,
            ["black_money"] = true,
            ["crypto"] = true,
            -- drugs
            ["meth"] = true,
            ["coke"] = true,
            ["weed"] = true,
            ["joint"] = true,
            -- Weapons
            ["weapon_pistol"] = true,
            ["pistol_ammo"] = true,
        },
        offset = {
            xPos = 0.020,
            yPos = 0.02,
            zPos = -0.008,
            xRot = 150.0,
            yRot = 50.0,
            zRot = 200.0
        }
    }
}

Config.UseCustumPedModel = false
Config.CustumPedModel = "mp_m_freemode_01"
Config.Outfit = {
    ['hair'] = { item = 19, texture = 4 },    -- Hear
    ['beard'] = { item = 2, texture = 0 },    -- Beard
    ["pants"] = { item = 10, texture = 0 },   -- Pants
    ["arms"] = { item = 12, texture = 0 },    -- Arms
    ["t-shirt"] = { item = 21, texture = 0 }, -- T Shirt
    ["vest"] = { item = 0, texture = 0 },     -- Body Vest
    ["torso2"] = { item = 32, texture = 0 },  -- Jacket
    ["shoes"] = { item = 10, texture = 0 },   -- Shoes
    ["decals"] = { item = 0, texture = 0 },   -- Neck Accessory
    ["bag"] = { item = 0, texture = 0 },      -- Bag
    ["hat"] = { item = 0, texture = 0 },      -- Hat
    ["glass"] = { item = 23, texture = 11 },  -- Glasses
    ["mask"] = { item = 0, texture = 0 }      -- Mask
}