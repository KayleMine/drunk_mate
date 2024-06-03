local addonName, _A = ...
local buffed = false
local ui = function(key)
    return _A.DSL:Get("ui")(_, key)
end
local toggle = function(key)
    return _A.DSL:Get("toggle")(_, key)
end
local keybind = function(key)
    return _A.DSL:Get("keybind")(_, key)
end
local Unit, Object = _A.Unit, _A.Object

local colorClass = "|cffF48CBA"
local colorOrange = "|cffFFBB00"
local colorGreen = "|cff4DDB1D"
local colorWhite = "|cffffffff"

local Icons = {
    Blacksmithing = { icon = select(3, GetSpellInfo(390037)) },
    AutoAttack = { icon = select(3, GetSpellInfo(6603)) },
}

local spells = {
    Rebuke = { id = 96231, name = GetSpellInfo(96231), icon = select(3, GetSpellInfo(96231)) },
    BladeOfJustice = { id = 184575, name = GetSpellInfo(184575), icon = select(3, GetSpellInfo(184575)) },
    Judgment = { id = 20271, name = GetSpellInfo(20271), icon = select(3, GetSpellInfo(20271)) },
    AvengingWrath = { id = 384376, name = GetSpellInfo(384376), icon = select(3, GetSpellInfo(384376)) },
    HammerOfWrath = { id = 24275, name = GetSpellInfo(24275), icon = select(3, GetSpellInfo(24275)) },
    FinalReckoning = { id = 343721, name = GetSpellInfo(343721), icon = select(3, GetSpellInfo(343721)) },
    FinalVerdict = { id = 383328, name = GetSpellInfo(383328), icon = select(3, GetSpellInfo(383328)) },
    WakeOfAshes = { id = 255937, name = GetSpellInfo(255937), icon = select(3, GetSpellInfo(255937)) },
    DivineToll = { id = 375576, name = GetSpellInfo(375576), icon = select(3, GetSpellInfo(375576)) },
    BlessingOfFreedom = { id = 1044, name = GetSpellInfo(1044), icon = select(3, GetSpellInfo(1044)) },
    BlessingOfSacrifice = { id = 6940, name = GetSpellInfo(6940), icon = select(3, GetSpellInfo(6940)) },
    BlessingOfProtection = { id = 1022, name = GetSpellInfo(1022), icon = select(3, GetSpellInfo(1022)) },
    DivineShield = { id = 642, name = GetSpellInfo(642), icon = select(3, GetSpellInfo(642)) },
    ShieldOfVengeance = { id = 184662, name = GetSpellInfo(184662), icon = select(3, GetSpellInfo(184662)) },
    DivineProtection = { id = 403876, name = GetSpellInfo(403876), icon = select(3, GetSpellInfo(403876)) },
    LayOnHands = { id = 633, name = GetSpellInfo(633), icon = select(3, GetSpellInfo(633)) },
    FlashOfLight = { id = 19750, name = GetSpellInfo(19750), icon = select(3, GetSpellInfo(19750)) },
    WordOfGlory = { id = 85673, name = GetSpellInfo(85673), icon = select(3, GetSpellInfo(85673)) },
    Forbearance = { id = 25771, name = GetSpellInfo(25771), icon = select(3, GetSpellInfo(25771)) },
    TemplarStrike = { id = 407480, name = GetSpellInfo(407480), icon = select(3, GetSpellInfo(407480)) },
    TemplarSlash = { id = 406647, name = GetSpellInfo(406647), icon = select(3, GetSpellInfo(406647)) },
    DivineStorm = { id = 53385, name = GetSpellInfo(53385), icon = select(3, GetSpellInfo(53385)) },
    HammerOfJustice = { id = 853, name = GetSpellInfo(853), icon = select(3, GetSpellInfo(853)) },
    DivineSteed = { id = 190784, name = GetSpellInfo(190784), icon = select(3, GetSpellInfo(190784)) },
    ExecutionSentence = { id = 343527, name = GetSpellInfo(343527), icon = select(3, GetSpellInfo(343527)) },
    CrusaderStrike = { id = 35395, name = GetSpellInfo(35395), icon = select(3, GetSpellInfo(35395)) },
    BlindingLight = { id = 115750, name = GetSpellInfo(115750), icon = select(3, GetSpellInfo(115750)) },
    CleanseToxins = { id = 213644, name = GetSpellInfo(213644), icon = select(3, GetSpellInfo(213644)) },
    Intercession = { id = 391054, name = GetSpellInfo(391054), icon = select(3, GetSpellInfo(391054)) },
    RetributionAura = { id = 183435, name = GetSpellInfo(183435), icon = select(3, GetSpellInfo(183435)) },
    CrusaderAura = { id = 32223, name = GetSpellInfo(32223), icon = select(3, GetSpellInfo(32223)) },
    CookingFire = { id = 818, name = GetSpellInfo(818), icon = select(3, GetSpellInfo(818)) },
}

local function FlexIcon(SpellID, width, height, bool)
    local var = " \124T" .. (select(3, GetSpellInfo(SpellID)) or select(3, GetSpellInfo(24720))) .. ":" .. (height or 25) .. ":" .. (width or 25) .. "\124t ";
    if bool then
        ico = var .. GetSpellInfo(SpellID)
    else
        ico = var
    end
    return ico
end

local header_tsize = 18
local checkbox_tsize = 15
local input_tsize = 15
local info_tsize = 15
local button_tsize = 15
local spacer_size = 2
local talent_row1 = 'BYEAAAAAAAAAAAAAAAAAAAAAAAAAAQAAiWp0KJtSjoFJplEAAAAAAQEkkQgEEpEhkQKplQkICJiCaBAA'
local talent_row2 = 'BYEAAAAAAAAAAAAAAAAAAAAAAAAAAQAgIalSrk0KNJKSSKSCAAAAAAkGkkQgkQkSEkQkWiGJCEiSjGAA'

local kb_t = [[
|cFFffd000Hard-coded Keybinds:|r
ALT - Pause
SHIFT -  Uses Divine Steed on keyhold
CTRL -  Uses Hammer of Justice on target
]]

local GUI = {
    { type = "spacer", size = spacer_size },
    { type = "header", size = header_tsize, text = "|cFFffd000Info|r", align = "center" },
    { type = "spacer", size = spacer_size },
    { type = 'text', size = info_tsize, text = 'Spotted lua errors?' },
    { type = 'text', size = info_tsize, text = 'Send screenshots to me at discord! \nDiscord: @ _2related' },
    { type = "spacer", size = spacer_size },

    { type = 'text', size = info_tsize, text = 'Retribution Paladin Raid Build: ' },
    { type = "spacer", size = 12 }, -- apofis buttons fucked somehow...
    { type = "button", size = button_tsize, text = "Click to copy!", width = 300, height = "20", callback = function()
        _A.CopyToClipboard(talent_row1)
    end, align = 'CENTER' },
    { type = "spacer", size = 4 }, -- button....
    { type = "spacer", size = spacer_size },

    { type = "spacer", size = spacer_size },

    { type = 'text', size = info_tsize, text = 'Retribution Paladin M+ Build: ' },
    { type = "spacer", size = 12 }, -- apofis buttons fucked somehow...
    { type = "button", size = button_tsize, text = "Click to copy!", width = 300, height = "20", callback = function()
        _A.CopyToClipboard(talent_row2)
    end, align = 'CENTER' },
    { type = "spacer", size = 4 }, -- button....
    { type = "spacer", size = spacer_size },

    { type = "spacer", size = spacer_size },
    { type = "header", size = header_tsize, text = "|cFFffd000Support|r", align = "center" },
    { type = "spacer", size = spacer_size },
    { key = "sac", type = "checkspin", size = checkbox_tsize, text = FlexIcon(6940, 15, 15, true) .. " :: TANK", check = true, spin = 35, width = 100, step = 1, max = 100, min = 1 },
    { key = "hop", type = "checkspin", size = checkbox_tsize, text = FlexIcon(1022, 15, 15, true) .. " :: HEALER", check = true, spin = 45, width = 100, step = 1, max = 100, min = 1 },
    { key = "freedom", type = "checkbox", size = checkbox_tsize, text = FlexIcon(1044, 15, 15, true), default = true },

    { type = "spacer", size = spacer_size },
    { type = "header", size = header_tsize, text = "|cFFffd000Heals|r", align = "center" },
    { type = "spacer", size = spacer_size },
    { key = "loh", type = "checkspin", size = checkbox_tsize, text = FlexIcon(633, 15, 15, true) .. " :: TANK", check = true, spin = 17, width = 100, step = 1, max = 100, min = 1 },
    { key = "wog", type = "checkspin", size = checkbox_tsize, text = FlexIcon(85673, 15, 15, true), check = true, spin = 70, width = 100, step = 1, max = 100, min = 1 },
    { key = "flash", type = "checkspin", size = checkbox_tsize, text = FlexIcon(19750, 15, 15, true), check = true, spin = 20, width = 100, step = 1, max = 100, min = 1 },

    { type = "spacer", size = spacer_size },
    { type = "header", size = header_tsize, text = "|cFFffd000Protection|r", align = "center" },
    { type = "spacer", size = spacer_size },
    { key = "divine", type = "checkspin", size = checkbox_tsize, text = FlexIcon(403876, 15, 15, true), check = true, spin = 45, width = 100, step = 1, max = 100, min = 1 },
    { key = "shield", type = "checkspin", size = checkbox_tsize, text = FlexIcon(642, 15, 15, true), check = true, spin = 20, width = 100, step = 1, max = 100, min = 1 },
    { key = "vengeance", type = "checkspin", size = checkbox_tsize, text = FlexIcon(184662, 15, 15, true), check = true, spin = 35, width = 100, step = 1, max = 100, min = 1 },


    { type = "spacer", size = spacer_size },
    { type = "header", size = header_tsize, text = "|cFFffd000Offtarget stuff|r", align = "center" },
    { type = "spacer", size = spacer_size },
    { type = "checkbox", size = checkbox_tsize, text = "AutoTargeting", key = "AutoTargeting", default = true },

    { type = "spacer", size = spacer_size },

    { type = "spacer", size = spacer_size },
    { type = "header", size = header_tsize, text = "|cFFffd000Misc. stuff|r", align = "center" },
    { type = "spacer", size = spacer_size },
    { type = 'checkbox', size = checkbox_tsize, text = 'Auto Loot', key = 'auto_loot', default = true },
    { key = 'fire_placer', type = 'checkbox', size = checkbox_tsize, text = "XP Fire placer", default = false },
    { key = 'battleRezz', type = 'checkbox', size = checkbox_tsize, text = "auto bRezz tank > heal > dps", default = true },
    { type = 'checkbox', size = checkbox_tsize, text = 'Auto Loot', key = 'auto_loot', default = true },

    { type = "spacer", size = spacer_size },
    { type = "header", size = header_tsize, text = "|cFFffd000Keybinds|r", align = "center" },
    { type = "spacer", size = spacer_size },
    { type = 'text', size = info_tsize, text = kb_t },
    { type = "spacer", size = spacer_size },
    { type = 'text', size = info_tsize, text = '© .zoddel & Revolver & Related' },
}

local buffs
local debuffs
local talents
local items
local ignoreByBuff
local ignoreById
local DungeonDispelInstant
local DungeonDispelInstantPlayer
local DungeonDispelStack

local function debuffAnyList(UNIT, tbl)
    for _, id in pairs(tbl) do
        if UNIT:debuffAny(id) then
            return true
        end
    end
end

local function buffAnyList(UNIT, tbl)
    for _, id in pairs(tbl) do
        if UNIT:buffAny(id) then
            return true
        end
    end
end

local function ignoreIdList(UNIT, tbl)
    for _, id in pairs(tbl) do
        if UNIT.id == id then
            return true
        end
    end
end

local exeOnLoad = function()
    _A.Interface:ShowToggle("cooldowns", false)
    _A.Interface:ShowToggle("interrupts", false)
    _A.Interface:ShowToggle("aoe", false)

    --_A.Interface:AddToggle({
    --    key = 'forceDps',
    --    name = 'Force DPS Group/Raid',
    --    text = 'Enabling this will focus on dps while lowest health is above 60%.',
    --    icon = 'Interface\\Icons\\Ability_creature_cursed_04.png'
    --})
    --_A.Interface:AddToggle({
    --    key = 'autoDispel',
    --    name = 'AUTO DISPEL DEBUFFS IN PARTY/RAID',
    --    text = 'dispel specific magic/disease debuffs in dragonflight dungeons/raids',
    --    icon = 'Interface\\Icons\\Spell_holy_dispelmagic.png'
    --})
    --_A.Interface:AddToggle({
    --    key = 'autoDispel2',
    --    name = 'AUTO DISPEL ENEMY MAGIC BUFFS IN PARTY/RAID',
    --    text = 'dispel specific enemy magic buffs in dragonflight dungeons/raids',
    --    icon = 'Interface\\Icons\\Spell_nature_nullifydisease.png'
    --})
    _A.Interface:AddToggle({
        key = 'autoDisease',
        name = 'AUTO DISPEL DISEASE/TOXIN IN PARTY',
        text = 'dispel specific diseases/toxins in dragonflight dungeons',
        icon = 'Interface\\Icons\\Spell_holy_renew.png'
    })
    _A.Interface:AddToggle({
        key = 'potions',
        name = 'auto potions',
        text = 'auto use healthstone, hp potion',
        icon = 'Interface\\Icons\\Inv_stone_04.png'
    })
    _A.Interface:AddToggle({
        key = 'autoTarget',
        name = 'auto target',
        text = 'auto target enemy in melee range',
        icon = 'Interface\\Icons\\Ability_hunter_snipershot.png'
    })
    _A.Interface:AddToggle({
        key = 'enemyTable',
        name = 'enemy table',
        text = 'on = Enemy / off = EnemyCombat',
        icon = 'Interface\\Icons\\Ability_marksmanship.png'
    })

    -- start of lists
    -----------------

    talents = {
        Searing_Light = { id = 404540, name = GetSpellInfo(404540) }
    }

    buffs = {
        AvengingWrath = 31884,
        Crusade = 231895,
        Inquisition = 84963,
        DivinePurpose = 223819,
        FinalReckoning = 343721,
        FinalVerdict = 383328,
        WakeOfAshes = 255937,
        DivineToll = 375576,
        BlessingOfFreedom = 1044,
        BlessingOfSacrifice = 6940,
        BlessingOfProtection = 1022,
        DivineShield = 642,
        ShieldOfVengeance = 184662,
        DivineProtection = 498,
        LayOnHands = 633,
        Forbearance = 25771,
        Expurgation = 383344,
        TemplarStrike = 407480,
        TemplarSlash = 406647,
        EchoesOfWrath = 423590,
        DivineStorm = 53385,
        HammerOfJustice = 853,
        DivineSteed = 190784,
        EmpyreanLegacy = 387178,
        DivineArbiter = 406975,
    }

    debuffs = {
        Initiative = 337332,
    }

    items = {
        healthStone = GetItemInfo(5512),
        healthPotion = GetItemInfo(191380),
    }

    DungeonDispelInstant = {
        -- diseases
        Withering = 368081, -- disease / dmg stack 30sec high prio
        Withering_Contagion = 382808, -- disease / dmg 10sec high prio
        Infectious_Spit = 377864, -- disease / nature dmg dot + movement slow
        Necrotic_Burst = 156718, -- disease / nature dot + 25% reduced healing received 5 sec / stacks (Shadowmoon Burial Grounds trash)
        Plague_Spit = 153524, -- disease / nature dot + 50% reduced movement speed. 12sec (Shadowmoon Burial Grounds trash)
        Infected_Wound = 258323, -- disease / reduce healing taken 20% (freehold)
        Plague_Step = 257775, -- disease / nature dmg + reduce healing taken 25% (freehold BFA)
        Decaying_Mind = 278961, -- disease / stun + absorb heal (underrot)
        Diseased_Bite = 369818, -- disease / slow 30% (uldaman LoT)
    }

    DungeonDispelInstantPlayer = {
        -- disease
        Withering = 368081, -- disease / dmg stack 30sec high prio
        Withering_Contagion = 382808, -- disease / dmg 10sec high prio
        Infectious_Spit = 377864, -- disease / nature dmg dot + movement slow
        Necrotic_Burst = 156718, -- disease / nature dot + 25% reduced healing received 5 sec / stacks (Shadowmoon Burial Grounds trash)
        Plague_Spit = 153524, -- disease / nature dot + 50% reduced movement speed. 12sec (Shadowmoon Burial Grounds trash)
        Infected_Wound = 258323, -- disease / reduce healing taken 20% (freehold)
        Plague_Step = 257775, -- disease / nature dmg + reduce healing taken 25% (freehold BFA)
        Decaying_Mind = 278961, -- disease / stun + absorb heal (underrot)
        Diseased_Bite = 369818, -- disease / slow 30% (uldaman LoT)
    }

    DungeonDispelStack = {
        -- disease
        Creeping_Mold = 391613, -- disease / nature dot stacks
        Decaying_Spores = 273266, -- disease / plague dmg (underrot)

    }

    ignoreByBuff = {
        sacred_barrier = 369031, -- sacred barrier Emberon boss uldaman tyr
        ablative_barrier = 383840, -- ablative barrier watcher irideus HoI
        --376780, -- magma shield warlord sargha neltharus
        --123456, -- balakar khan intermission phase shield nokhud offensive
        --123456, -- azureblade intermission phase shield azure vault
        glacial_shield = 388084, -- telash greywing intermission glacial shield azure vault

    }

    interrupts = {

    }
    ignoreById = {
        204560, -- incorporeal affix mob
        129758, -- grenadier add last boss freehold

    }

    -- end of lists
    ---------------
end

local exeOnUnload = function()

end

local inCombat = function()
    local player = Object('player')
    if not player then
        return
    end
    local target = Object('lowest_enemy')
    local lowest = Object('lowest')

    if player:toggle("enemyTable") then
        enemySwitch = 'Enemy'
    else
        enemySwitch = 'EnemyCombat'
    end
    -- pause
    if keybind('lalt') then
        return
    end

    if keybind("lshift") and player:SpellReady(spells.DivineSteed.name) and not player:Buff(spells.DivineSteed.name) then
        return player:Cast(spells.DivineSteed.name)
    end

    if player:SpellReady(spells.CrusaderAura.name) and player:mounted() and not player:buff(spells.CrusaderAura.name) then
        return player:Cast(spells.CrusaderAura.name)
    end

    if player:SpellReady(spells.RetributionAura.name) and not player:mounted() and not player:buff(spells.RetributionAura.name) then
        return player:Cast(spells.RetributionAura.name)
    end

    if target and keybind("lcontrol") then
        if player:SpellReady(spells.BlindingLight.name) and player:AreaEnemies(10) >= 3 then
            return target:Cast(spells.BlindingLight.name)
        end
        if player:SpellReady(spells.HammerOfJustice.name) and IsSpellInRange(spells.HammerOfJustice.name, target) == 1 and (not player:areaEnemies(10) <= 3 or not player:SpellReady(spells.BlindingLight.name)) then
            return target:Cast(spells.HammerOfJustice.name)
        end
    end

    if player:SpellReady(spells.BlessingOfFreedom.name) and ui("freedom") then
        for _, Obj in pairs(_A.OM:Get('Roster')) do
            if Obj:isPlayer() and Obj:SpellRange(spells.BlessingOfFreedom.name) and Obj:State("snare || root") and not Obj:BuffAny(spells.BlessingOfFreedom.name) then
                return Obj:Cast(spells.BlessingOfFreedom.name)
            end
        end
    end

    if player:SpellReady(spells.BlessingOfSacrifice.name) and ui("sac_check") then
        for _, Obj in pairs(_A.OM:Get('Roster')) do
            if Obj:Role() == "TANK" and Obj:SpellRange(spells.BlessingOfSacrifice.name) and Obj:Health() <= ui("sac_spin") and not Obj:BuffAny(spells.BlessingOfSacrifice.name) then
                return Obj:Cast(spells.BlessingOfSacrifice.name)
            end
        end
    end

    if player:SpellReady(spells.BlessingOfProtection.name) and ui("hop_check") then
        for _, Obj in pairs(_A.OM:Get('Roster')) do
            if Obj:Role() == "HEALER" and Obj:SpellRange(spells.BlessingOfProtection.name) and Obj:Health() <= ui("hop_spin") and not Obj:BuffAny(spells.BlessingOfProtection.name) then
                return Obj:Cast(spells.BlessingOfProtection.name)
            end
        end
    end

    if ui("shield_check") and player:Combat() and player:SpellReady(spells.DivineShield.name) and player:Health() <= ui("shield_spin") and not player:DebuffAny(spells.Forbearance.name) then
        return player:Cast(spells.DivineShield.name)
    end

    if player and ui("divine_check") and player:Combat() and player:SpellReady(spells.ShieldOfVengeance.name) and player:health() <= ui("divine_spin") then
        return player:Cast(spells.ShieldOfVengeance.name)
    end

    if ui("vengeance_check") and player:SpellReady(spells.ShieldOfVengeance.name) and player:health() <= ui("vengeance_spin") then
        return player:Cast(spells.ShieldOfVengeance.name)
    end

    if ui("loh_check") and player:SpellReady(spells.LayOnHands.name) then
        for _, Obj in pairs(_A.OM:Get('Roster')) do
            if Obj:Los() and Obj:Role() == "TANK" and ui("loh_spin") >= Obj:Health() and not Obj:DebuffAny(spells.Forbearance.name) and Obj:SpellRange(spells.LayOnHands.name) then
                return Obj:Cast(spells.LayOnHands.name)
            end
        end
    end

    if ui("flash_check") then
        if ui("flash_spin") >= player:health() then
            if player:SpellReady(spells.FlashOfLight.name) then
                return player:Cast(spells.FlashOfLight.name)
            end
        end
    end

    if ui("wog_check") then
        if player:holyPower() >= 3
                and player:SpellReady(spells.WordOfGlory.name)
                and ui("wog_spin") >= player:Health() then
            return player:Cast(spells.WordOfGlory.name)
        end
    end

    if debuffAnyList(player, DungeonDispelInstantPlayer) then
        return player:Cast(spells.Purify)
    end
    -- cancel protection
    if player:IscastingAnySpell() or player:Dead() or player:Mounted() or player:LostControl() then
        return
    end

    if target and ignoreIdList(target, ignoreById) then
        return
    end

    if target and buffAnyList(target, ignoreByBuff) then
        return
    end

    if IsSpellInRange(spells.Rebuke.name, target) == 1
            and not player:AutoAttack() then
        _A.AttackTarget()
    end

    -- auto targeting
    if player:toggle("autoTarget") then

        if target
        then
            if target:Dead()
                    or target:Friend()
                    or buffAnyList(target, ignoreByBuff)
                    or debuffAnyList(target, ignoreByBuff)
                    or ignoreIdList(target, ignoreById)
                    --or enemy:range() < target:range()
                    or not target:Infront()
                    or not target:los()
            then
                _A.ClearTarget()
                return
            end

            for _, enemy in pairs(_A.OM:Get(enemySwitch)) do
                if enemy:los()
                        and enemy:Alive()
                        and enemy:combat()
                        and enemy:Infront()
                        --and enemy:Range() < 8
                        --and enemy:SpellRange(spells.Hammer_Justice) -- rangecheck 10
                        and IsSpellInRange(spells.HammerOfJustice.name, enemy.key) == 1
                        and not buffAnyList(enemy, ignoreByBuff)
                        and not debuffAnyList(enemy, ignoreByBuff)
                        and not ignoreIdList(enemy, ignoreById)
                then
                    --if enemy:distance() < target:distance()
                    --if enemy:range() < target:range()
                    --if enemy:SpellRange(spells.Rebuke)
                    if IsSpellInRange(spells.Rebuke.name, enemy.key) == 1
                            --and not target:SpellRange(spells.Rebuke)
                            and IsSpellInRange(spells.Rebuke.name, target) == 0
                    then
                        _A.TargetUnit(enemy.key)
                        return
                    end
                end
            end
        end

        if not target then
            for _, enemy in pairs(_A.OM:Get(enemySwitch)) do
                if enemy:los()
                        and enemy:alive()
                        and enemy:combat()
                        and enemy:infront()
                        and not buffAnyList(enemy, ignoreByBuff)
                        and not debuffAnyList(enemy, ignoreByBuff)
                        and not ignoreIdList(enemy, ignoreById)
                then
                    --[[
                    if enemy:range() < 2 then
                        _A.TargetUnit(enemy.key)
                        return
                    end
                    --]]

                    --if enemy:SpellRange(spells.Rebuke) then  -- rangecheck 5
                    if IsSpellInRange(spells.Rebuke.name, enemy.key) == 1 then
                        _A.TargetUnit(enemy.key)
                        return
                    end

                    --if enemy:SpellRange(spells.Hammer_Justice) then -- rangecheck 10
                    if IsSpellInRange(spells.HammerOfJustice.name, enemy.key) == 1 then
                        _A.TargetUnit(enemy.key)
                        return
                    end

                end
            end
        end

    end

    -- interrupt
    if target
            and player:CanCast(spells.Rebuke.name)
            and target:enemy()
            --and target:range() < 8
            --and target:SpellRange(spells.Disrupt.name)
            and IsSpellInRange(spells.Rebuke.name, target) == 1
            and target:los()
            and target:combat()
            and target:alive()
            and target:infront()
            and target:interruptAt(40) then
        return target:Cast(spells.Rebuke.name)
    end

    -- interrupt offtarget
    if player:spellCooldown(spells.Rebuke.name) == 0 then
        for _, enemy in pairs(_A.OM:Get(enemySwitch)) do
            --if enemy:range() < 8
            --if enemy:SpellRange(spells.Rebuke)
            if IsSpellInRange(spells.Rebuke.name, enemy.key) == 1
                    and enemy:los()
                    and enemy:combat()
                    and enemy:alive()
                    and enemy:infront()
                    and enemy:interruptAt(40) then
                return enemy:Cast(spells.Rebuke.name)
            end
        end
    end

    ---- Explosive Orb Cleaner ----
    if player:CanCast(spells.Judgement) then
        for _, critter in pairs(_A.OM:Get('Critters')) do
            if critter.id == 120651 then
                if IsSpellInRange(spells.Judgment.name, critter.key) == 1
                        and critter:los()
                        and critter:infront()
                        and critter:alive() then
                    return critter:Cast(spells.Judgement.name)
                end
            end
        end
    end

    -- potions
    if player:toggle('potions')
            and player:health() < 60
            and player:castingPercent() == 0
            and player:channelingPercent() == 0
    then
        if player:itemUsable(5512)
                and player:itemCount(5512) > 0
                and player:itemCooldown(5512) == 0
        then
            player:UseItem(5512)
        end

        if player:itemUsable(191380)
                and player:itemCount(191380) > 0
                and player:itemCooldown(191380) == 0
        then
            player:UseItem(191380)
        end
    end

    -- dungeon dispel start
    if IsInGroup() and IsInInstance() then
        if player:toggle('autoDisease') and player:CanCast(spells.CleanseToxins.name) then
            -- dispel afflicted soul affix
            for _, friend in pairs(_A.OM:Get('Friendly')) do
                if friend.id == 204773
                        and friend:alive()
                        --and friend:distance() < 35
                        and IsSpellInRange(spells.FlashOfLight.name, friend.key) == 1
                        and friend:los()
                then
                    print('dispel afflicted soul affix')
                    return friend:Cast(spells.CleanseToxins.name)
                end
            end


            --player
            if debuffAnyList(player, DungeonDispelInstantPlayer) then
                print('dispel player debuffAnyList')
                return player:Cast(spells.CleanseToxins.name)
            end

            if player:debuffCountAny(DungeonDispelStack.Creeping_Mold) > 2       -- disease / nature dot stacks
                    or player:debuffCountAny(DungeonDispelStack.Decaying_Spores) > 2 -- disease / plague dmg (underrot)
            then
                print('dispel player stack debuff')
                return player:Cast(spells.CleanseToxins.name)
            end


            --lowest
            --if lowest
            if lowest:los()
                    --and lowest:distance() < 35
                    and IsSpellInRange(spells.FlashOfLight.name, lowest.key) == 1
            then
                if debuffAnyList(lowest, DungeonDispelInstant) then
                    print('dispel lowest debuffAnyList')
                    return lowest:Cast(spells.CleanseToxins.name)
                end

                if lowest:debuffCountAny(DungeonDispelStack.Creeping_Mold) > 2       -- disease / nature dot stacks
                        or lowest:debuffCountAny(DungeonDispelStack.Decaying_Spores) > 2 -- disease / plague dmg (underrot)
                then
                    print('dispel lowest debuff')
                    return lowest:Cast(spells.CleanseToxins.name)
                end
            end


            --anyone else in party
            for _, roster in pairs(_A.OM:Get('Roster')) do
                if roster:los()
                        --and roster:distance() < 35
                        and IsSpellInRange(spells.FlashOfLight.name, roster.key) == 1
                then
                    if debuffAnyList(roster, DungeonDispelInstant) then
                        print('dispel anybody debuffAnyList')
                        return roster:Cast(spells.CleanseToxins.name)
                    end

                    if roster:debuffCountAny(DungeonDispelStack.Creeping_Mold) > 2       -- disease / nature dot stacks
                            or roster:debuffCountAny(DungeonDispelStack.Decaying_Spores) > 2 -- disease / plague dmg (underrot)
                    then
                        print('dispel anybody debuff')
                        return roster:Cast(spells.CleanseToxins.name)
                    end
                end
            end
        end
    end
    -- dungeon dispel end

    -- intercession battle ressurection
    if player:ui('battleRezz') and IsInInstance() and not player:moving() then
        if player:CanCast(spells.Intercession.name)
                and player:holypower() >= 3 then
            for _, deadmember in pairs(_A.OM:Get('Dead')) do
                if deadmember:range() < 35
                        and deadmember:los()
                        and UnitIsPlayer(deadmember.key) -- wow api
                        --and deadmember:Isplayer()  -- apep
                        and deadmember:Ingroup()
                then
                    if IsInRaid() then
                        if deadmember:role() == "TANK"
                        then
                            print('revive', GetUnitName(deadmember.key))
                            return deadmember:Cast(spells.Intercession.name)
                        end

                        if deadmember:role() == "HEALER"
                        then
                            print('revive', GetUnitName(deadmember.key))
                            return deadmember:Cast(spells.Intercession.name)
                        end
                    end

                    if IsInGroup() and not IsInRaid() then
                        if deadmember:role() == "HEALER"
                        then
                            print('revive', GetUnitName(deadmember.key))
                            return deadmember:Cast(spells.Intercession.name)
                        end

                        if deadmember:role() == "DAMAGER"
                        then
                            print('revive', GetUnitName(deadmember.key))
                            return deadmember:Cast(spells.Intercession.name)
                        end
                    end
                end
            end
        end
    end
    -- intercession battle ressurection end

    if player:talent(talents.Searing_Light.name) and target and target:AreaEnemies(10) < 3 then
        -- MultiTarget Build ST
        if player:SpellReady(spells.AvengingWrath.name) and target:inmelee() then
            return player:Cast(spells.AvengingWrath.name)
        end

        if player:SpellReady(spells.FinalReckoning.name) and target:Los() and target:Range() <= 30 and player:HolyPower() >= 4 then
            return target:CastGround(spells.FinalReckoning.name)
        end

        if player:SpellReady(spells.FinalVerdict.name) and target:Los() and target:infront() and target:Range() <= 20 and (player:HolyPower() == 5 or player:Buff(buffs.EchoesOfWrath)) then
            return target:Cast(spells.FinalVerdict.name)
        end

        if player:SpellReady(spells.WakeOfAshes.name) and target:Los() and target:InConeOf(player, 145) and target:SpellRange(spells.WakeOfAshes.name) and player:HolyPower() <= 2 then
            return target:Cast(spells.WakeOfAshes.name)
        end

        if player:SpellReady(spells.BladeOfJustice.name) and target:Los() and target:Range() <= 20 and not target:Debuff(buffs.Expurgation) then
            return target:Cast(spells.BladeOfJustice.name)
        end

        if player:SpellReady(spells.DivineToll.name) and target:Los() and target:Range() <= 30 and player:HolyPower() <= 1 then
            return target:Cast(spells.DivineToll.name)
        end

        if player:SpellReady(spells.Judgment.name) and target:Los() and target:infront() and target:SpellRange(spells.Judgment.name) then
            return target:Cast(spells.Judgment.name)
        end

        if player:SpellReady(spells.HammerOfWrath.name) and target:Los() and target:Range() <= 30 and (player:HolyPower() <= 3 or target:Health() > 20) then
            return target:Cast(spells.HammerOfWrath.name)
        end

        if player:SpellReady(spells.TemplarStrike.name) and target:Los() and target:Infront() and target:Range() <= 8 then
            return target:Cast(spells.TemplarStrike.name)
        end

        if player:SpellReady(spells.BladeOfJustice.name) and target:Los() and target:Range() <= 20 and player:holyPower() <= 3 then
            return target:Cast(spells.BladeOfJustice.name)
        end

        if player:SpellReady(spells.FinalVerdict.name) and target:Los() and target:infront() and target:Range() <= 20 and player:HolyPower() == 4 then
            return target:Cast(spells.FinalVerdict.name)
        end

        if player:SpellReady(spells.TemplarStrike.name) and target:Los() and target:Infront() and target:Range() <= 8 then
            return target:Cast(spells.TemplarStrike.name)
        end
    end

    if player:talent(talents.Searing_Light.name) and target and target:AreaEnemies(10) >= 3 then
        -- MultiTarget Build AOE
        if player:SpellReady(spells.AvengingWrath.name) and target:inmelee() then
            return player:Cast(spells.AvengingWrath.name)
        end

        if player:SpellReady(spells.FinalReckoning.name) and target:Los() and target:Range() <= 30 and player:HolyPower() >= 4 then
            return target:CastGround(spells.FinalReckoning.name)
        end

        if player:SpellReady(spells.DivineStorm.name) and target:Los() and target:infront() and target:Range() <= 10 and (player:HolyPower() == 5 or player:Buff(buffs.EchoesOfWrath)) then
            return target:Cast(spells.DivineStorm.name)
        end

        if player:SpellReady(spells.WakeOfAshes.name) and target:Los() and target:InConeOf(player, 145) and target:SpellRange(spells.WakeOfAshes.name) and player:HolyPower() <= 2 then
            return target:Cast(spells.WakeOfAshes.name)
        end

        if player:SpellReady(spells.BladeOfJustice.name) and target:Los() and target:Range() <= 20 and not target:Debuff(buffs.Expurgation) then
            return target:Cast(spells.BladeOfJustice.name)
        end

        if player:SpellReady(spells.DivineToll.name) and target:Los() and target:Range() <= 30 and player:HolyPower() <= 1 then
            return target:Cast(spells.DivineToll.name)
        end

        if player:SpellReady(spells.Judgment.name) and target:Los() and target:infront() and target:SpellRange(spells.Judgment.name) then
            return target:Cast(spells.Judgment.name)
        end

        if player:SpellReady(spells.HammerOfWrath.name) and target:Los() and target:Range() <= 30 and (player:HolyPower() <= 3 or target:Health() > 20) then
            return target:Cast(spells.HammerOfWrath.name)
        end

        if player:SpellReady(spells.TemplarStrike.name) and target:Los() and target:Infront() and target:Range() <= 8 then
            return target:Cast(spells.TemplarStrike.name)
        end

        if player:SpellReady(spells.BladeOfJustice.name) and target:Los() and target:Range() <= 20 and player:holyPower() <= 3 then
            return target:Cast(spells.BladeOfJustice.name)
        end

        if player:SpellReady(spells.DivineStorm.name) and target:Los() and target:infront() and target:Range() <= 10 and player:HolyPower() == 4 then
            return target:Cast(spells.DivineStorm.name)
        end

        if player:SpellReady(spells.TemplarStrike.name) and target:Los() and target:Infront() and target:Range() <= 8 then
            return target:Cast(spells.TemplarStrike.name)
        end
    end

    if not player:talent(talents.Searing_Light.name) and target and target:AreaEnemies(10) <= 3 then
        -- ST Build ST
        if player:SpellReady(spells.AvengingWrath.name) and target:inmelee() then
            return player:Cast(spells.AvengingWrath.name)
        end

        if player:SpellReady(spells.ExecutionSentence.name) and target:Los() and target:SpellRange(spells.ExecutionSentence.name) then
            return target:Cast(spells.ExecutionSentence.name)
        end

        if player:SpellReady(spells.FinalVerdict.name) and target:Los() and target:infront() and target:range(2) <= 20 and (player:HolyPower() == 5 or player:Buff(buffs.EchoesOfWrath)) then
            return target:Cast(spells.FinalVerdict.name)
        end

        if player:SpellReady(spells.WakeOfAshes.name) and target:Los() and target:InConeOf(player, 145) and target:SpellRange(spells.WakeOfAshes.name) and player:HolyPower() <= 2 then
            return target:Cast(spells.WakeOfAshes.name)
        end

        if player:SpellReady(spells.DivineToll.name) and target:Los() and target:SpellRange(spells.Judgment.name) and player:HolyPower() <= 3 then
            return target:Cast(spells.DivineToll.name)
        end

        if player:SpellReady(spells.HammerOfWrath.name) and target:Los() and target:SpellRange(spells.HammerOfWrath.name) and (player:HolyPower() <= 3 or target:Health() > 20) then
            return target:Cast(spells.HammerOfWrath.name)
        end

        if player:SpellReady(spells.Judgment.name) and target:Los() and target:infront() and target:SpellRange(spells.Judgment.name) and player:HolyPower() <= 3 then
            return target:Cast(spells.Judgment.name)
        end

        if player:SpellReady(spells.BladeOfJustice.name) and target:Los() and target:SpellRange(spells.BladeOfJustice.name) and player:HolyPower() <= 3 then
            return target:Cast(spells.BladeOfJustice.name)
        end

        if player:SpellReady(spells.CrusaderStrike.name) and target:Los() and target:SpellRange(spells.CrusaderStrike.name) and player:SpellCharges(spells.CrusaderStrike.name) == 2 then
            return target:Cast(spells.CrusaderStrike.name)
        end

        if player:SpellReady(spells.FinalVerdict.name) and target:Los() and target:infront() and target:range(2) <= 20 and player:HolyPower() == 4 then
            return target:Cast(spells.FinalVerdict.name)
        end

        if player:SpellReady(spells.CrusaderStrike.name) and target:Los() and target:SpellRange(spells.CrusaderStrike.name) then
            return target:Cast(spells.CrusaderStrike.name)
        end
    end

    if not player:talent(talents.Searing_Light.name) and target and target:AreaEnemies(10) >= 3 then
        -- ST Build AOE
        if player:SpellReady(spells.AvengingWrath.name) and target:inmelee() then
            return player:Cast(spells.AvengingWrath.name)
        end

        if player:SpellReady(spells.ExecutionSentence.name) and target:Los() and target:SpellRange(spells.ExecutionSentence.name) then
            return target:Cast(spells.ExecutionSentence.name)
        end

        if player:SpellReady(spells.FinalVerdict.name) and target:Los() and target:infront() and target:range(2) <= 20 and (player:BuffStack(buffs.DivineArbiter) >= 25 or player:Buff(buffs.EmpyreanLegacy)) and player:HolyPower() == 5 then
            return target:Cast(spells.FinalVerdict.name)
        end

        if player:SpellReady(spells.DivineStorm.name) and target:Los() and target:infront() and target:Range() <= 10 and (player:HolyPower() == 5 or player:Buff(buffs.EchoesOfWrath)) then
            return target:Cast(spells.DivineStorm.name)
        end

        if player:SpellReady(spells.WakeOfAshes.name) and target:Los() and target:InConeOf(player, 145) and target:SpellRange(spells.WakeOfAshes.name) and player:HolyPower() <= 2 then
            return target:Cast(spells.WakeOfAshes.name)
        end

        if player:SpellReady(spells.DivineToll.name) and target:Los() and target:Range() <= 30 and player:HolyPower() <= 1 then
            return target:Cast(spells.DivineToll.name)
        end

        if player:SpellReady(spells.BladeOfJustice.name) and target:Los() and target:range(2) <= 20 and player:HolyPower() <= 3 and player:AreaEnemies(20) >= 4 then
            return target:Cast(spells.BladeOfJustice.name)
        end

        if player:SpellReady(spells.Judgment.name) and target:Los() and target:infront() and target:SpellRange(spells.Judgment.name) and player:HolyPower() <= 3 then
            return target:Cast(spells.Judgment.name)
        end

        if player:SpellReady(spells.CrusaderStrike.name) and target:Los() and target:SpellRange(spells.CrusaderStrike.name) and player:SpellCharges(spells.CrusaderStrike.name) == 2 then
            return target:Cast(spells.CrusaderStrike.name)
        end

        if player:SpellReady(spells.FinalVerdict.name) and target:Los() and target:infront() and target:range(2) <= 20 and (player:BuffStack(buffs.DivineArbiter) >= 25 or player:Buff(buffs.EmpyreanLegacy)) and player:HolyPower() == 4 then
            return target:Cast(spells.FinalVerdict.name)
        end

        if player:SpellReady(spells.DivineStorm.name) and target:Los() and target:infront() and target:Range() <= 10 and player:HolyPower() == 4 then
            return target:Cast(spells.DivineStorm.name)
        end

        if player:SpellReady(spells.CrusaderStrike.name) and target:Los() and target:SpellRange(spells.CrusaderStrike.name) then
            return target:Cast(spells.CrusaderStrike.name)
        end
    end
end -- end of in combat

local outCombat = function()
    local player = Object('player')
    if not player then
        return
    end
    local target = Object('lowest_enemy')

    local custom_Fire_Placer = ui('fire_placer')

    -- pause
    if player:keybind('lalt') then
        return
    end

    if custom_Fire_Placer then
        if not player:iscasting(spells.CookingFire.name) and player:CanCast(spells.CookingFire.name) then
            return player:CastGround(spells.CookingFire.name)
        end
    end

    if keybind("lshift") and player:SpellReady(spells.DivineSteed.name) and not player:Buff(spells.DivineSteed.name) then
        return player:Cast(spells.DivineSteed.name)
    end

    if player:SpellReady(spells.CrusaderAura.name) and player:mounted() and not player:buff(spells.CrusaderAura.name) then
        return player:Cast(spells.CrusaderAura.name)
    end

    if player:SpellReady(spells.RetributionAura.name) and not player:mounted() and not player:buff(spells.RetributionAura.name) then
        return player:Cast(spells.RetributionAura.name)
    end

    -- cancel protection
    if player:IscastingAnySpell() or player:Dead() or player:Mounted() or player:LostControl() then
        return
    end

    -- autoloot
    if ui("auto_loot") then
        for _, loot in pairs(_A.OM:Get('Dead')) do
            if loot:distance() <= 5
                    and loot:hasloot()
            then
                _A.InteractUnit(loot.key)
            end
        end
    end
end

_A.CR:Add(70, {
    name = '[|cffFF9900FREE|r] Paladin | |cffFFCC00Retribution|r beta 0215',
    wow_ver = "10.1.7",
    apep_ver = "1.1",
    ic = inCombat,
    ooc = outCombat,
    use_lua_engine = true,
    gui = GUI,
    gui_st = {
        title = "Related - Retribution - Dragonflight",
        color = "F48CBA",
        width = "320",
        height = "790"
    },
    load = exeOnLoad,
    unload = exeOnUnload
})
