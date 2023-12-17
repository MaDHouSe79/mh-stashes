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

# My Youtube Channel
- [Subscribe](https://www.youtube.com/c/@MaDHouSe79) 

# mh-stashes
With this stash item you can give a stash with items in it to other players for example money, drugs or weapons, 
it works also with mh-cashasitem.
it also hase a wallet you can use to put all your cash and or card in it.

# Possibilities
- Your own Wallet (only cash or cards, see `config.lua` `Config.Stashes` look for `allowedItems` if you want limit items)
- A Cash Suitcase (only cash or markedmoney is allowed, see `config.lua` `Config.Stashes` look for `allowedItems` if you want limit items)
- Drugs Suitcase  (only drugs is allowed, see `config.lua` `Config.Stashes` look for `allowedItems` if you want limit items)
- Weapon Suitcase (only weapons is allowed, see `config.lua` `Config.Stashes` look for `allowedItems` if you want limit items)
- Small Bag (all items can be placed in this stash, see `config.lua` `Config.Stashes` look for `allowedItems` if you want limit items)
- Medium Bag (all items can be placed in this stash, see `config.lua` `Config.Stashes` look for `allowedItems` if you want limit items)
- Large Bag (all items can be placed in this stash, see `config.lua` `Config.Stashes` look for `allowedItems` if you want limit items)

# Dependencies
- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-target](https://github.com/qbcore-framework/qb-target)
- [qb-radialmenu](https://github.com/qbcore-framework/qb-radialmenu)
- [mh-core](https://github.com/MaDHouSe79/mh-core)
- [mh-inventory](https://github.com/MaDHouSe79/mh-inventory) or [qb-inventiory](https://github.com/MaDHouSe79/qb-inventory)
- [mh-cashasitem](https://github.com/MaDHouSe79/mh-cashasitem)


# NOTE
- Before you start make sure you add all your items you want to use in Config.Stashes.
- 
- if you change any value you need to restart the server
- make sure the items in the inventory and mh-stashes config files are the same with the items.

# When you add more items in (allowedItems) in (Config.Stashes) 
- This will not update the item in the Database.
- The item data can change and than the item does not work.
- Players need te delete the item from there inventory or stash and get a new item.

# Missions
- There are a few missions, and if you fail you lose all your money on cash and bank,
- The boss will rob you and kill you if you don't bring the suitecase where he ask for.

# Add in qb-core/shared/items.lua
```lua
-- mh-stashes
['walletstash'] = {
    ['name'] = 'walletstash', 
    ['label'] = 'Your Wallet', 
    ['weight'] = 0, 
    ['type'] = 'item', 
    ['image'] = 'walletstash.png', 
    ['unique'] = false,
    ['useable'] = false,
    ['shouldClose'] = true,
    ['combinable'] = nil,
    ['description'] = 'A wallet.'
},

["cashstash"] = {
    ["name"] = "cashstash",
    ["label"] = "Cash Suitcase",
    ["weight"] = 1000,
    ["type"] = "item",
    ["image"] = "cashstash.png",
    ["unique"] = true,
    ["useable"] = true,
    ["shouldClose"] = false,
    ["combinable"] = nil,   
    ["description"] = "a cash suitcase"
},

["drugsstash"] = {
    ["name"] = "drugsstash",
    ["label"] = "Drugs Suitcase",
    ["weight"] = 1000,
    ["type"] = "item",
    ["image"] = "drugsstash.png",
    ["unique"] = true,
    ["useable"] = true,
    ["shouldClose"] = false,
    ["combinable"] = nil,   
    ["description"] = "a drugs suitcase"
},

["weaponstash"] = {
    ["name"] = "weaponstash",
    ["label"] = "Weapon Suitcase",
    ["weight"] = 1000,
    ["type"] = "item",
    ["image"] = "weaponstash.png",
    ["unique"] = true,
    ["useable"] = true,
    ["shouldClose"] = false,
    ["combinable"] = nil,   
    ["description"] = "a weapon suitcase"
},

["smallbagstash"] = {
    ["name"] = "smallbagstash",
    ["label"] = "Small Bag",
    ["weight"] = 1000,
    ["type"] = "item",
    ["image"] = "smallbagstash.png",
    ["unique"] = true,
    ["useable"] = true,
    ["shouldClose"] = false,
    ["combinable"] = nil,   
    ["description"] = "a small bag"
},

["mediumbagstash"] = {
    ["name"] = "mediumbagstash",
    ["label"] = "Medium Bag",
    ["weight"] = 1000,
    ["type"] = "item",
    ["image"] = "mediumbagstash.png",
    ["unique"] = true,
    ["useable"] = true,
    ["shouldClose"] = false,
    ["combinable"] = nil,   
    ["description"] = "a medium bag"
},

["largebagstash"] = {
    ["name"] = "largebagstash",
    ["label"] = "largebagstash",
    ["weight"] = 1000,
    ["type"] = "item",
    ["image"] = "largebagstash.png",
    ["unique"] = true,
    ["useable"] = true,
    ["shouldClose"] = false,
    ["combinable"] = nil,   
    ["description"] = "a large bag "
},

['missionstash'] = {
    ['name'] = 'missionstash', 
    ['label'] = 'Mission Suitcase', 
    ['weight'] = 0, 
    ['type'] = 'item', 
    ['image'] = 'missionstash.png', 
    ['unique'] = false,
    ['useable'] = false,
    ['shouldClose'] = true,
    ['combinable'] = nil,
    ['description'] = 'A mission suitcase.'
},
```

# LICENSE
[GPL LICENSE](./LICENSE)<br />
&copy; [MaDHouSe79](https://www.youtube.com/@MaDHouSe79)
