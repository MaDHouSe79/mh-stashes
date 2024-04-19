--[[ ===================================================== ]] --
--[[              MH Stashes Script by MaDHouSe            ]] --
--[[ ===================================================== ]] --
local Translations = {
    notify = {
        ['purchased_a_stash'] = "You purchased a stash item for €%{price}",
        ['not_enough_cash'] = "You don't have enough cash.",
        ['you_have_a_stash'] = "You already have this item in your inventory!",
        ['stash_not_exsist'] = "The stash you're trying to grab doesn't exist!",
        ['stash_is_dropped'] = "The stash you're trying to put down is already on the ground!",
        ['no_stash'] = "You have no stash to put down!",
        ['stash_deleted'] = "The stash has been deleted!",
        ['max_carry_item'] = "You can only take one of this item at a time!",
        ['allowed_items_error'] = "You can't put this item in this stash!",
        ['pickup_a_stash'] = "You picked up a %{item} stash",
        ['not_allowed_to_loot'] = "You can't empty this stash!"
    },
    target = {
        ["pickup"] = "Take",
        ["open"] = "Open",
        ["delete"] = "Delete"
    },
    menu = {
        ['title'] = 'My Stash',
        ['hide'] = "Hide",
        ['show'] = "Show"
    },
    shop = {
        ['buy_a_stash'] = "Buy a Bag or Suitcase",
        ['header'] = "Koop Stash",
        ['select'] = "Select Stash",
        ['wallet'] = "A Wallet",
        ['smallbag'] = "A small bag",
        ['mediumbag'] = "A medium bag",
        ['largebag'] = "A large bag",
        ['cash'] = "Cash Suitcase",
        ['drugs'] = "Drugs Suitcase",
        ['weapon'] = "Wapen Suitcase"
    },
    mission = {
        ['notify'] = {
            ['title'] = "The big boss says",
            ['no_job'] = "I don't have a job for you at the moment, fuck off..",
            ['start'] = "Go get my suitcase af fast as you can!",
            ['stop'] = "Thanks for this suitcase delivery!",
            ['take_the_suitcase'] = "Take the suitcase",
            ['failed'] = "You're going to die, my hunters will find you.",
        }
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
