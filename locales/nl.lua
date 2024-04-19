--[[ ===================================================== ]] --
--[[              MH Stashes Script by MaDHouSe            ]] --
--[[ ===================================================== ]] --
local Translations = {
    notify = {
        ['purchased_a_stash'] = "Je hebt een stash item gekocht voor €%{price}",
        ['noy_enough_cash'] = "Je hebt niet genoeg contant geld.",
        ['you_have_a_stash'] = "Je hebt dit item al in je inventory!",
        ['stash_not_exsist'] = "De stash die u probeert te pakken bestaat niet!",
        ['stash_is_dropped'] = "De stash die je probeert neer te zetten, staat al op de grond!",
        ['no_stash'] = "Je hebt geen stash om neer te zetten!",
        ['stash_deleted'] = "De stash is verwijderd!",
        ['max_carry_item'] = "Je kunt slechts één van dit item tegelijk meenemen!",
        ['allowed_items_error'] = "Je kunt dit item niet deze stash doen!",
        ['pickup_a_stash'] = "Je hebt een %{item} stash opgepakt",
        ['not_allowed_to_loot'] = "Je kunt deze stash niet leeg halen!"
    },
    target = {
        ["pickup"] = "Pak",
        ["open"] = "Open",
        ["delete"] = "Verwijder"
    },
    menu = {
        ['title'] = 'Mijn Stash',
        ['hide'] = "Verbergen",
        ['show'] = "Zichtbaar"
    },
    shop = {
        ['buy_a_stash'] = "Koop een Tas of Koffer",
        ['header'] = "Koop Koffer",
        ['select'] = "Selecteer Koffer",
        ['wallet'] = "Een portemonnee",
        ['smallbag'] = "Een kleine tas",
        ['mediumbag'] = "Een medium tas",
        ['largebag'] = "Een grote tas",
        ['cash'] = "Geld Koffer",
        ['drugs'] = "Drugs Koffer",
        ['weapon'] = "Wapen Koffer"
    },
    mission = {
        ['notify'] = {
            ['title'] = "De Grote baas zegt",
            ['no_job'] = "Ik heb nu geen werk voor je, fuck off..",
            ['start'] = "Ga zo snel als je kunt mijn koffer halen!",
            ['stop'] = "Bedankt voor het terug brengen van mijn koffer!",
            ['take_the_suitcase'] = "Pak de koffer",
            ['failed'] = "Je gaat dood, mijn jagers zullen je vinden.",
        }
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
