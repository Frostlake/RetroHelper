RetroHelper_EventHandler = CreateFrame("FRAME")
RetroHelper_EventHandler:RegisterEvent("ADDON_LOADED")
RetroHelper_EventHandler:RegisterEvent("PLAYER_LOGIN")

RetroHelper_OnUpdateHandler = CreateFrame("FRAME")

CreateFrame("GameTooltip", "RH_Scan", nil, "GameTooltipTemplate")
RH_Scan:SetOwner(RH_Scan, "ANCHOR_NONE")

CreateFrame("GameTooltip", "RH_ScanBuff", nil, "GameTooltipTemplate")
RH_ScanBuff:SetOwner(RH_ScanBuff, "ANCHOR_NONE")

CreateFrame("GameTooltip", "RetroHelperBuffTooltip", nil, "GameTooltipTemplate")
RetroHelperBuffTooltip:SetOwner(RetroHelperBuffTooltip, "ANCHOR_NONE")

RetroHelper_IsFirstTime = true

local RetroHelper_Shop = {}

RetroHelper_CFG = {
    -- World Quests
    [1] = {
        [1] = {
            "WORLD_QUEST_AUTO_REPEAT_OGRES",
            "RH_CheckboxWQ01",
            "Ogres! [110 Gold]",
            true
        },
        [2] = {
            "WORLD_QUEST_AUTO_REPEAT_DEWS",
            "RH_CheckboxWQ02",
            "Dews! [30 Gold]",
            false
        },
        [3] = {
            "WORLD_QUEST_AUTO_REPEAT_ELITE_DEWS",
            "RH_CheckboxWQ03",
            "Elite Dews! [100 Gold]",
            false
        },
        [4] = {
            "WORLD_QUEST_AUTO_REPEAT_PVE_TOKENS",
            "RH_CheckboxWQ04",
            "PvE Tokens [100 Gold]",
            false
        },
        [5] = {
            "WORLD_QUEST_AUTO_REPEAT_DEMONS",
            "RH_CheckboxWQ05",
            "Demons! [50 Gold]",
            false
        },
        [6] = {
            "WORLD_QUEST_AUTO_REPEAT_MOLTEN_GIANTS",
            "RH_CheckboxWQ06",
            "Molten Giants! [50 Gold]",
            false
        },
        [7] = {
            "WORLD_QUEST_AUTO_REPEAT_QIRAJI_SENTINELS",
            "RH_CheckboxWQ07",
            "Qiraji Sentinels! [70 Gold]",
            false
        },
        [8] = {
            "WORLD_QUEST_AUTO_REPEAT_QIRAJI_ERADICATORS",
            "RH_CheckboxWQ08",
            "Qiraji Eradicators! [50 Gold]",
            false
        },
        [9] = {
            "WORLD_QUEST_AUTO_REPEAT_CORE_HOUNDS",
            "RH_CheckboxWQ09",
            "Core Hounds! [Group][170 Gold]",
            false
        },
        [10] = {
            "WORLD_QUEST_AUTO_REPEAT_THE_GURUBASHI_HUNT",
            "RH_CheckboxWQ10",
            "The Gurubashi Hunt [Group][250 Gold]",
            false
        },
        [11] = {
            "WORLD_QUEST_AUTO_REPEAT_ELITE_TOKENS",
            "RH_CheckboxWQ11",
            "Elite Tokens [150 Gold]",
            false
        },
        [12] = {
            "WORLD_QUEST_AUTO_REPEAT_HIGHLORDS_AND_DOOMGUARDS",
            "RH_CheckboxWQ12",
            "Highlords and Doomguards [100 Gold]",
            false
        },
        [13] = {
            "WORLD_QUEST_AUTO_REPEAT_SHARDTOOTH_AND_THE_YETI",
            "RH_CheckboxWQ13",
            "Shardtooth and the Yeti [110 Gold]",
            false
        },
        [14] = {
            "WORLD_QUEST_AUTO_REPEAT_BOSS_TOKENS",
            "RH_CheckboxWQ14",
            "Boss Tokens [250 Gold]",
            false
        },
        [15] = {
            "WORLD_QUEST_AUTO_REPEAT_CURSED_ISLAND",
            "RH_CheckboxWQ15",
            "Cursed Island [Group] [700 Gold]",
            false
        },
        [16] = {
            "WORLD_QUEST_AUTO_REPEAT_EASTERN_KINGDOMS_WORLD_BOSSES",
            "RH_CheckboxWQ16",
            "Eastern Kingdoms: World Bosses [300 Gold]",
            false
        },
        [17] = {
            "WORLD_QUEST_AUTO_REPEAT_KALIMDOR_WORLD_BOSSES",
            "RH_CheckboxWQ17",
            "Kalimdor: World Bosses [300 Gold]",
            false
        }
    },
    -- Ragefire Quests
    [2] = {
        [1] = {
            "RFC_QUEST_AUTO_REPEAT_EARTHBORERS_AND_TROGGS",
            "RH_CheckboxRS01",
            "Earthborers and Troggs [300 Gold]",
            false
        },
        [2] = {
            "RFC_QUEST_AUTO_REPEAT_ELEMENTALS_AND_ENFORCERS",
            "RH_CheckboxRS02",
            "Elementals and Enforcers [300 Gold]",
            false
        },
        [3] = {
            "RFC_QUEST_AUTO_REPEAT_RAGEFIRE_NIGHTMARES",
            "RH_CheckboxRS03",
            "Ragefire Nightmares [200 Gold]",
            false
        },
        [4] = {
            "RFC_QUEST_AUTO_REPEAT_FLASK_RESISTANCE",
            "RH_CheckboxRS04",
            "Ragefire Tokens: Flask of Chromatic Resistance",
            false
        },
        [5] = {
            "RFC_QUEST_AUTO_REPEAT_FLASK_TITANS",
            "RH_CheckboxRS05",
            "Ragefire Tokens: Flask of the Titans",
            false
        },
        [6] = {
            "RFC_QUEST_AUTO_REPEAT_FLASK_WISDOM",
            "RH_CheckboxRS06",
            "Ragefire Tokens: Flask of Distilled Wisdom",
            false
        },
        [7] = {
            "RFC_QUEST_AUTO_REPEAT_FLASK_POWER",
            "RH_CheckboxRS07",
            "Ragefire Tokens: Flask of Supreme Power",
            false
        }
    },
    -- PvP Quests
    [3] = {
        [1] = {
            "PVP_QUEST_AUTO_REPEAT_WARSONG_GULCH",
            "RH_CheckboxPQ01",
            "PvP: Warsong Gulch Mark of Honor",
            false
        },
        [2] = {
            "PVP_QUEST_AUTO_REPEAT_ARATHI_BASIN",
            "RH_CheckboxPQ02",
            "PvP: Arathi Basin Mark of Honor",
            false
        },
        [3] = {
            "PVP_QUEST_AUTO_REPEAT_ALTERAC_VALLEY",
            "RH_CheckboxPQ03",
            "PvP: Alterac Valley Mark of Honor",
            false
        },
        [4] = {
            "PVP_QUEST_AUTO_REPEAT_PVP_TOKEN",
            "RH_CheckboxPQ04",
            "PvP Tokens [200 Gold]",
            false
        },
        [5] = {
            "PVP_QUEST_AUTO_REPEAT_MAJOR_HEALING_POTION",
            "RH_CheckboxPQ05",
            "Major Healing Potion [5x]",
            false
        },
        [6] = {
            "PVP_QUEST_AUTO_REPEAT_MAJOR_MANA_POTION",
            "RH_CheckboxPQ06",
            "Major Mana Potion [5x]",
            false
        }
    },
    -- Quest Broadcast
    [4] = {
        [1] = {
            "QUEST_BROADCAST_AUTO",
            "RH_CheckboxQB01",
            "Auto",
            false
        },
        [2] = {
            "QUEST_BROADCAST_UI_ONLY",
            "RH_CheckboxQB02",
            "UI Message Only",
            true
        },
        [3] = {
            "QUEST_BROADCAST_PARTY_ONLY",
            "RH_CheckboxQB03",
            "Party Message Only",
            false
        },
        [4] = {
            "QUEST_BROADCAST_OFF",
            "RH_CheckboxQB04",
            "Off",
            false
        }
    },
    -- Autoloot & Need Roll
    [5] = {
        [1] = {
            "AUTO_LOOT_PVE_TOKEN",
            "RH_CheckboxAL01",
            "PvE Token",
            true
        },
        [2] = {
            "AUTO_LOOT_ELITE_TOKEN",
            "RH_CheckboxAL02",
            "Elite Token",
            true
        },
        [3] = {
            "AUTO_LOOT_BOSS_TOKEN",
            "RH_CheckboxAL03",
            "Boss Token",
            true
        },
        [4] = {
            "AUTO_LOOT_ZULGURUB_BIJOU",
            "RH_CheckboxAL04",
            "Zul'Gurub Bijou",
            false
        },
        [5] = {
            "AUTO_LOOT_ZULGURUB_IDOL",
            "RH_CheckboxAL05",
            "Zul'Gurub Idol",
            false
        },
        [6] = {
            "AUTO_LOOT_AHNQIRAJ_IDOL",
            "RH_CheckboxAL06",
            "Ahn'Qiraj Idol",
            false
        },
        [7] = {
            "AUTO_LOOT_AHNQIRAJ_SCARAB",
            "RH_CheckboxAL07",
            "Ahn'Qiraj Scarab",
            false
        }
    },
    -- BG Queue
    [6] = {
        [1] = {
            "BG_QUEUE_OFF",
            "RH_CheckboxBG01",
            "Auto BG Queue OFF",
            true
        },
        [2] = {
            "BG_QUEUE_WARSONG_GULCH",
            "RH_CheckboxBG02",
            "Warsong Gulch",
            false
        },
        [3] = {
            "BG_QUEUE_ARATHI_BUSIN",
            "RH_CheckboxBG03",
            "Arathi Basin",
            false
        },
        [4] = {
            "BG_QUEUE_ALTERAC_VALLEY",
            "RH_CheckboxBG04",
            "Alterac Valley",
            false
        }
    },
    -- ETC Config
    [7] = {
        [1] = {
            "CFG_AUTO_GROUP",
            "RH_CheckboxEC01",
            "Auto Group for Quest",
            true
        },
        [2] = {
            "CFG_AUTO_GREETINGS",
            "RH_CheckboxEC02",
            "Auto Greetings",
            true
        },
        [3] = {
            "CFG_FAST_BG",
            "RH_CheckboxEC03",
            "Fast BG Queue & Leave",
            true
        },
        [4] = {
            "CFG_DUEL_HELPER",
            "RH_CheckboxEC04",
            "Fix Duel Target",
            false
        },
        [5] = {
            "CFG_TARGET_BG",
            "RH_CheckboxEC05",
            "Smart Targeting in BG",
            false
        },
        [6] = {
            "CFG_ENEMY_SPELL",
            "RH_CheckboxEC06",
            "Enemy Spell Casting Alert",
            true
        },
        [7] = {
            "CFG_AUTO_SHOPPING",
            "RH_CheckboxEC07",
            "Auto Buy consumable",
            true
        },
        [8] = {
            "CFG_DEBUFF_NOTICE",
            "RH_CheckboxEC08",
            "Player Debuff Notice",
            true
        },
        [9] = {
            "CFG_DESPELL_PLEASE",
            "RH_CheckboxEC09",
            "Debuff Dispell Request",
            true
        }
    }
}

local RetroHelper_QuestObjects = {
    ["Ogres! [110 Gold]"] = {
        ["Plate Ogre slain"] = 10,
        ["Red Ogre Puncher slain"] = 10
    },
    ["Dews! [30 Gold]"] = {
        ["Dew slain"] = 15
    },
    ["Elite Dews! [100 Gold]"] = {
        ["Dew Elite slain"] = 15
    },
    ["PvE Tokens [100 Gold]"] = {
        ["PvE Token"] = 50
    },
    ["Demons! [50 Gold]"] = {
        ["Demon slain"] = 15
    },
    ["Molten Giants! [50 Gold]"] = {
        ["Molten slain"] = 15
    },
    ["Qiraji Sentinels! [70 Gold]"] = {
        ["Qiraj Sentinel slain"] = 15
    },
    ["Qiraji Eradicators! [50 Gold]"] = {
        ["Qiraj Eradicator slain"] = 15
    },
    ["Core Hounds! [Group][170 Gold]"] = {
        ["Core Hound slain"] = 10
    },
    ["The Gurubashi Hunt [Group][250 Gold]"] = {
        ["Gurubashi Guard slain"] = 10,
        ["Gurubashi Servant slain"] = 10,
        ["Gurubashi Soidier slain"] = 10,
        ["Jaguero slain"] = 1
    },
    ["Elite Tokens [150 Gold]"] = {
        ["Elite Token"] = 20
    },
    ["Highlords and Doomguards [100 Gold]"] = {
        ["Doomguards slain"] = 10,
        ["Highlords slain"] = 10
    },
    ["Shardtooth and the Yeti [110 Gold]"] = {
        ["Shardtooth slain"] = 10,
        ["Yeti slain"] = 10
    },
    ["Boss Tokens [250 Gold]"] = {
        ["Boss Token"] = 10
    },
    ["Cursed Island [Group] [700 Gold]"] = {
        ["Patchwerk Junior slain"] = 10,
        ["Kazzak Junior slain"] = 10,
        ["Flamelord slain"] = 10,
        ["Golem slain"] = 10
    },
    ["Eastern Kingdoms: World Bosses [300 Gold]"] = {
        ["Lord Kazzak slain"] = 1,
        ["Lethon slain"] = 1,
        ["Taerar slain"] = 1
    },
    ["Kalimdor: World Bosses [300 Gold]"] = {
        ["Azuregos slain"] = 1,
        ["Emeriss slain"] = 1,
        ["Ysondre slain"] = 1
    },
    ["Earthborers and Troggs [300 Gold]"] = {
        ["Earthborer slain"] = 10,
        ["Ragefire Trogg slain"] = 15
    },
    ["Elementals and Enforcers [300 Gold]"] = {
        ["Molten Elemental slain"] = 10,
        ["Searing Blade Enforcer slain"] = 15
    },
    ["Ragefire Nightmares [200 Gold]"] = {
        ["Oggleflint slain"] = 1,
        ["Taragaman the Hungerer slain"] = 1,
        ["Bazzalan slain"] = 1,
        ["Jergosh the Invoker slain"] = 1
    },
    ["Ragefire Tokens: Flask of Chromatic Resistance"] = {
        ["Ragefire Token"] = 20
    },
    ["Ragefire Tokens: Flask of the Titans"] = {
        ["Ragefire Token"] = 20
    },
    ["Ragefire Tokens: Flask of Distilled Wisdom"] = {
        ["Ragefire Token"] = 20
    },
    ["Ragefire Tokens: Flask of Supreme Power"] = {
        ["Ragefire Token"] = 20
    },
    ["Zul'Gurub: Elites [200 Gold]"] = {
        ["Gurubashi Berserker slain"] = 5,
        ["Gurubashi Champion slain"] = 10,
        ["Razzashi Broodwidow slain"] = 5,
        ["Gurubashi Bat Rider slain"] = 5
    },
    ["Molten Core: Elites [300 Gold]"] = {
        ["Molten Giant slain"] = 5,
        ["Ancient Core Hound slain"] = 10,
        ["Lava Surger slain"] = 5,
        ["Firelord slain"] = 10
    },
    ["Ruins of Ahn'Qiraj: Elites [300 Gold]"] = {
        ["Qiraji Gladiator slain"] = 5,
        ["Hive'Zara Stinger slain"] = 10,
        ["Anubisath Guardian slain"] = 5,
        ["Obsidian Destroyer slain"] = 5
    },
    ["Temple of Ahn'Qiraj: Elites [400 Gold]"] = {
        ["Obsidian Eradicator slain"] = 3,
        ["Qiraji Brainwasher slain"] = 5,
        ["Vekniss Guardian slain"] = 10,
        ["Vekniss Soldier slain"] = 5
    },
    ["Naxxramas: Elites  [600 Gold]"] = {
        ["Bile Retcher slain"] = 5,
        ["Crypt Reaver slain"] = 5,
        ["Deathknight Vindicator slain"] = 5,
        ["Deathknight Cavalier slain"] = 8
    },
    ["Mark of Honor Attunement"] = {
        ["PvP Token"] = 100
    },
    ["PVP Tokens [200 Gold]"] = {
        ["PvP Tokens [200 Gold]"] = 50
    },
    ["Major Healing Potion [5x]"] = {
        ["PvP Token"] = 75
    },
    ["Major Mana Potion [5x]"] = {
        ["PvP Token"] = 75
    }
}

RetroHelper_Variables = {
    playerName = "",
    currentQuest = "",
    latestAcceptQuest = "",
    questAcceptTime = nil,
    currentProgressingQuest = "RetroWoW Game Master slain [1B Gold]",
    currentProgressingQuestTime = nil,
    isPlayerAFK = false,
    worldChannelID = nil,
    latestYellTime = GetTime(),
    inv_guild = "",
    inv_say = "",
    inv_whisper = "",
    inv_yell = "",
    duel_state = false,
    duel_target = "",
    isShop = false,
    shopOpenTime = GetTime(),
    isTrainer = false,
    trainerOpenTime = GetTime(),
    onUpdateTime = GetTime(),
    lastMessage = "",
    lastMessage2 = "",
    battlegroundQueueReady = false,
    lastchatCommand = "",
    lastchatCommandTime = GetTime(),
    isCurrentCasting = false,
    pvpKillCount = 0,
    killingBlowCount = 0,
    honorPoint = 0
}

local RetroHelper_RecentInvList = {}
local RetroHelper_RecentWhisperList = {}

local RetroHelper_Events = {
    "CHAT_MSG_CHANNEL",
    "CHAT_MSG_WHISPER",
    "CHAT_MSG_GUILD",
    "CHAT_MSG_SAY",
    "CHAT_MSG_YELL",
    "CHAT_MSG_SYSTEM",
    "CHAT_MSG_COMBAT_HONOR_GAIN",
    "UI_INFO_MESSAGE",
    "UI_ERROR_MESSAGE",
    "LOOT_BIND_CONFIRM",
    "START_LOOT_ROLL",
    "QUEST_PROGRESS",
    "QUEST_COMPLETE",
    "QUEST_DETAIL",
    "GOSSIP_SHOW",
    "QUEST_GREETING",
    "PARTY_INVITE_REQUEST",
    "PLAYER_TARGET_CHANGED",
    "DUEL_REQUESTED",
    "DUEL_FINISHED",
    "MERCHANT_SHOW",
    "MERCHANT_CLOSED",
    "TRAINER_SHOW",
    "TRAINER_CLOSED",
    "BATTLEFIELDS_SHOW",
    "PLAYER_UNGHOST",
    "UPDATE_INVENTORY_ALERTS",
    "PLAYER_AURAS_CHANGED",
    "PLAYER_PVP_KILLS_CHANGED",
    "CHAT_MSG_COMBAT_HOSTILE_DEATH",
    "SPELLCAST_START",
    "SPELLCAST_STOP",
    "SPELLCAST_FAILED",
    "SPELLCAST_INTERRUPTED",
    "SPELLCAST_CHANNEL_START",
    "SPELLCAST_CHANNEL_STOP",
    "MINIMAP_ZONE_CHANGED",
    "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE",
    "CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS"
}

local function RetroHelper_MenuHandler(available, active, accept, complete)
    --    RetroHelper_MenuHandler(available, active, name, SelectAvailableQuest, SelectActiveQuest)
    local function SetupBackground(b)
        b:SetAllPoints(b:GetParent())
        b:SetDrawLayer("BACKGROUND", -1)
        b:SetTexture(1, 1, 1)
        b:SetGradientAlpha("HORIZONTAL", 0, 0.45, 1, 0.5, 0, 0.45, 1, 0)
    end
    for i = 1, 32 do
        local f = getglobal("QuestTitleButton" .. i)
        if f.RH == nil then
            f.RH = {background = f:CreateTexture(), oldScript = f:GetScript("OnClick")}
            SetupBackground(f.RH.background)
            local function OnClick(...)
                local title = f:GetText()
                f.RH.oldScript(unpack(arg))
            end
            f:SetScript("OnClick", OnClick)
        end
        if (RetroHelper_GetCfg(f:GetText(), 2)) then
            f.RH.background:Show()
        else
            f.RH.background:Hide()
        end
    end
    ---------------------
    if (RetroHelper_IsQuestNPC() and (not IsShiftKeyDown())) then
        local logCompleted = {}
        for k = 1, GetNumQuestLogEntries() do
            local title, _, _, _, _, completed = GetQuestLogTitle(k)
            if (completed) and (RetroHelper_GetCfg(title, 2)) then
                logCompleted[title] = true
            end
        end
        for k, v in active do
            if logCompleted[v] then
                RetroHelper_Variables.currentQuest = v
                complete(k)
                return
            end
        end

        for k, v in available do
            if RetroHelper_GetCfg(v, 2) then
                RetroHelper_Variables.currentQuest = v
                accept(k)
                return
            end
        end

        for k, v in active do
            if RetroHelper_GetCfg(v, 2) then
                RetroHelper_Variables.currentQuest = v
                complete(k)
                return
            end
        end

        if next(available) then
            if (RetroHelper_GetCfg(available[1], 2)) then
                RetroHelper_Variables.currentQuest = available[1]
                accept(1)
                return
            end
        end
        if next(active) then
            if (RetroHelper_GetCfg(active[1], 2)) then
                RetroHelper_Variables.currentQuest = active[1]
                complete(1)
                return
            end
        end
    end
end

function RetroHelper_EventHandler.MINIMAP_ZONE_CHANGED()
    local bgQueueStats = nil
    local bStats, mapName = nil, nil
    for i = 1, MAX_BATTLEFIELD_QUEUES do
        bStats, mapName = GetBattlefieldStatus(i)
        if (bStats == "queued" or bStats == "confirm") then
            bgQueueStats = true
        end
    end

    RetroHelper_Variables.battlegroundQueueReady = false
    if (GetNumBattlefieldStats() == 0) then
        if (GetBattlefieldEstimatedWaitTime(1) == 0) then
            if (not bgQueueStats) then
                RetroHelper_Variables.battlegroundQueueReady = true
                RetroHelper_Queue()
            end
        end
    end

    if (GetNumBattlefieldStats() == 0) then
        if (GetBattlefieldEstimatedWaitTime(1) == 0) then
            RetroHelper_Variables.pvpKillCount = 0
            RetroHelper_Variables.honorPoint = 0
            RetroHelper_Variables.killingBlowCount = 0
        --_print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. "Auto Battlefield Queue !!")
        end
    end

    -- Battle Map
    if (BattlefieldMinimap) then
    -- RetroHelper_ShowBGMap()
    end
end

function RetroHelper_EventHandler.PLAYER_PVP_KILLS_CHANGED()
    RetroHelper_Variables.pvpKillCount = RetroHelper_Variables.pvpKillCount + 1
    _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. "Your Honorable Kills : " .. "|cffFF007F" .. RetroHelper_Variables.pvpKillCount .. "|cffFFFFFF" .. " !!")
end

function RetroHelper_EventHandler.PLAYER_UNGHOST()
    RetroHelper_Repair()
end

function RetroHelper_EventHandler.UPDATE_INVENTORY_ALERTS()
    RetroHelper_Repair()
end

function RetroHelper_EventHandler.SPELLCAST_START()
    RetroHelper_Variables.isCurrentCasting = true
end

function RetroHelper_EventHandler.SPELLCAST_CHANNEL_START()
    RetroHelper_Variables.isCurrentCasting = true
end

function RetroHelper_EventHandler.SPELLCAST_STOP()
    RetroHelper_Variables.isCurrentCasting = false
end

function RetroHelper_EventHandler.SPELLCAST_CHANNEL_STOP()
    RetroHelper_Variables.isCurrentCasting = false
end

function RetroHelper_EventHandler.SPELLCAST_FAILED()
    RetroHelper_Variables.isCurrentCasting = false
end

function RetroHelper_EventHandler.SPELLCAST_INTERRUPTED()
    RetroHelper_Variables.isCurrentCasting = false
end

function RetroHelper_EventHandler.PLAYER_AURAS_CHANGED()
    -- Feared .
    -- Fleeing in terror
    -- Charmed.
    -- Cannot attack or cast spells.  Increased regeneration. (poly)
    -- Incapacitated. (sap)
    -- Stunned. (cheapshot)
    -- Disoriented. (Blind)
    -- Frozen. (freezing trap)
    -- Silenced.
    -- Horrified. (warlock's instant fear spell)

    -- Speaking Demonic increasing casting time by (curse of tongues)

    local isFeared = ""
    local isFlee = ""
    local isCharm = ""
    local isPoly = ""
    local isSap = ""
    local isStun = ""
    local isBlind = ""
    local isFrozen = ""
    local isSilence = ""
    local isHorrifed = ""
    local isNeedWarning = false

    local isCOT = ""

    local num = 0

    while GetPlayerBuff(num) >= 0 do
        local index, untilCancelled = GetPlayerBuff(num)
        RH_ScanBuff:SetPlayerBuff(index)
        local txt = RH_ScanBuffTextLeft2:GetText()
        if txt then
            if (string.find(strlower(txt), "fear")) and ((not string.find(strlower(txt), strlower("warded"))) and (not string.find(strlower(txt), strlower("Immune")))) then
                isFeared = "Fear, "
                isNeedWarning = true
            elseif (string.find(strlower(txt), "flee")) and (not string.find(strlower(txt), strlower("Immune"))) then
                isFlee = "Fleeing, "
                isNeedWarning = true
            elseif (string.find(strlower(txt), "charm")) and (not string.find(strlower(txt), strlower("Immune"))) then
                isCharm = "Charmed, "
                isNeedWarning = true
            elseif
                (string.find(strlower(txt), strlower("Cannot attack or cast spells"))) and (string.find(strlower(txt), strlower("Increased regeneration"))) and
                    (not string.find(strlower(txt), strlower("Immune")))
             then
                isPoly = "polymorph, "
                isNeedWarning = true
            elseif (string.find(strlower(txt), "incapacitated")) and (not string.find(strlower(txt), strlower("Immune"))) then
                isSap = "Sap / Gouge, "
                isNeedWarning = true
            elseif (string.find(strlower(txt), "stun")) and (not string.find(strlower(txt), strlower("Immune"))) then
                isStun = "Stun, "
                isNeedWarning = true
            elseif (string.find(strlower(txt), "disoriented")) and (not string.find(strlower(txt), strlower("Immune"))) then
                isBlind = "Blind, "
                isNeedWarning = true
            elseif (string.find(strlower(txt), "horrified.")) and (not string.find(strlower(txt), strlower("Immune"))) then
                isHorrifed = "Horrified, "
                isNeedWarning = true
            elseif (string.find(strlower(txt), "frozen")) and (not string.find(strlower(txt), strlower("in place."))) and (not string.find(strlower(txt), strlower("Immune"))) then
                isFrozen = "Freezing Trap / Frost Nova, "
                isNeedWarning = true
            elseif (string.find(strlower(txt), "silence")) and (not string.find(strlower(txt), strlower("Immune"))) then
                isSilence = "Silence, "
                isNeedWarning = true
            elseif (string.find(strlower(txt), strlower("Speaking Demonic increasing casting time"))) then
                isCOT = "TRUE"
            end
        end
        num = num + 1
    end
    if (RetroHelper_GetCfg("CFG_DEBUFF_NOTICE", 1) == true) then
        if (isNeedWarning) then
            --_sayx("[RetroHelper]: Player Lost Control - " .. isFeared .. isFlee .. isCharm .. isPoly .. isSap .. isStun .. isBlind .. isFrozen .. isSilence .. "!!")
            _sayx("[RetroHelper]: Player Control Lost or Silenced !!")
        else
            _sayx("[RetroHelper]: Player Control Gained !!")
        end
    end

    if (RetroHelper_GetCfg("CFG_DESPELL_PLEASE", 1) == true) then
        if (GetNumRaidMembers() > 0) then
            for i = 1, GetNumRaidMembers() do
                if (CheckInteractDistance("raid" .. i, 4)) and (not UnitIsDeadOrGhost("raid" .. i)) and (not UnitIsUnit("raid" .. i, "player")) then
                    local uClass = UnitClass("raid" .. i)
                    local uName = UnitName("raid" .. i)
                    if
                        ((isFeared ~= "") and (not (RetroHelper_Debuffed("Psychic Scream", "player") or RetroHelper_Debuffed("Intimidating Shout", "player")))) or (isCharm ~= "") or (isPoly ~= "") or
                            (isFrozen ~= "") or
                            (isSilence ~= "")
                     then
                        if (uClass == "Paladin") or (uClass == "Priest") then
                            _whisperx("[RetroHelper]: Dispell My Debuff Please !!", uName)
                        end
                    elseif (isBlind ~= "") then
                        if (uClass == "Paladin") or (uClass == "Druid") or (uClass == "Shaman") then
                            _whisperx("[RetroHelper]: Dispell [Blind] Please !!", uName)
                        end
                    elseif (isCOT ~= "") then
                        local pClass = UnitClass("player")
                        if (pClass == "Paladin" or pClass == "Priest" or pClass == "Warlock" or pClass == "Shaman" )and (uClass == "Mage" or uClass == "Druid") then
                            _whisperx("[RetroHelper]: Dispell [Curse of Tongues] Please !!", uName)
                        end
                    end
                end
            end
        elseif (GetNumPartyMembers() > 0) then
            for i = 1, GetNumPartyMembers() do
                if (CheckInteractDistance("party" .. i, 4)) and (not UnitIsDeadOrGhost("party" .. i)) and (not UnitIsUnit("party" .. i, "player")) then
                    local uClass = UnitClass("party" .. i)
                    local uName = UnitName("party" .. i)
                    if (isFeared ~= "") or (isCharm ~= "") or (isPoly ~= "") or (isFrozen ~= "") or (isSilence ~= "") then
                        if (uClass == "Paladin") or (uClass == "Priest") then
                            _whisperx("[RetroHelper]: Dispell My Debuff Please !!", uName)
                        end
                    elseif (isBlind ~= "") then
                        if (uClass == "Paladin") or (uClass == "Druid") or (uClass == "Shaman") then
                            _whisperx("[RetroHelper]: Dispell Blind Please !!", uName)
                        end
                    elseif (isCOT ~= "") then
                        if (uClass == "Mage") or (uClass == "Druid") then
                            _whisperx("[RetroHelper]: Dispell My Debuff Please !!", uName)
                        end
                    end
                end
            end
        end
    end
end

function RetroHelper_EventHandler.ADDON_LOADED()
    -- retro helper
    SLASH_RETROHELPER1 = "/rh"
    SLASH_RETROHELPER2 = "/retrohelper"
    SlashCmdList["RETROHELPER"] = RetroHelper_Option

    SLASH_RHINVSAY1 = "/invs"
    SLASH_RHINVSAY2 = "/invS"
    SlashCmdList["RHINVSAY"] = RetroHelper_InvSay
    SLASH_RHINVGUILD1 = "/invg"
    SLASH_RHINVGUILD2 = "/invG"
    SlashCmdList["INVGUILD"] = RetroHelper_InvGuild
    SLASH_RHINVYELL1 = "/invy"
    SLASH_RHINVYELL2 = "/invY"
    SlashCmdList["RHINVYELL"] = RetroHelper_InvYell
    SLASH_RHINVWHISPER1 = "/invw"
    SLASH_RHINVWHISPER2 = "/invW"
    SlashCmdList["RHINVWHISPER"] = RetroHelper_InvWhisper
    SLASH_RHINVTARGET1 = "/invt"
    SLASH_RHINVTARGET2 = "/invT"
    SlashCmdList["RHINVTARGET"] = RetroHelper_InvTarget
    RetroHelper_RegisterEvents()
    RetroHelper_EventHandler:UnregisterEvent("ADDON_LOADED")
    if (GetRealmName() == "RetroWoW") then
        --_print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. "Invite the latest [WHISPER CHANNEL] player to party. " .. "|cffFFE400" .. "/invW")
        --_print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. "Invite the latest [SAY CHANNEL] player to party. " .. "|cffFFE400" .. "/invS")
        --_print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. "Invite the latest [GUILD CHANNEL] player to party. " .. "|cffFFE400" .. "/invG")
        --_print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. "Invite the latest [YELL CHANNEL] player to party. " .. "|cffFFE400" .. "/invY")
        --_print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. "Invite the current target to party. " .. "|cffFFE400" .. "/invT")
        local RETROHELPER_TITLE = GetAddOnMetadata("RetroHelper", "Title")
        local RETROHELPER_VERSION = GetAddOnMetadata("RetroHelper", "Version")
        local RETROHELPER_AUTHOR = GetAddOnMetadata("RetroHelper", "Author")
        local RETROHELPER_NOTE = GetAddOnMetadata("RetroHelper", "Notes")
        _print(RETROHELPER_TITLE .. " " .. "|cffFFFFFF" .. " #Author : " .. "|cffFF007F" .. RETROHELPER_AUTHOR .. "|cffFFFFFF" .. " #Note : " .. "|cff00D8FF" .. RETROHELPER_NOTE)
    else
        _print("|cffFF007F" .. "Realm is not RetroWoW - " .. "|cff00D8FF" .. "Retro helper OFF [author : nslookup79@gmail.com]")
    end
end

function RH_GetVer()
    _print("[RetroHelper]: Current Version is : " .. GetAddOnMetadata("RetroHelper", "Version"))
end

function RetroHelper_EventHandler.PLAYER_LOGIN()
    RetroHelper_PopupMenuFrame = RetroHelper_CreateOptionsFrame()
    RetroHelper_Variables.playerName = UnitName("player")
    RetroHelper_EventHandler:UnregisterEvent("PLAYER_LOGIN")
    if (RetroHelper_IsFirstTime == true) then
        RetroHelper_IsFirstTime = false
        RetroHelper_Option()
    end
end

function RetroHelper_EventHandler.MERCHANT_SHOW()
    RetroHelper_Variables.isShop = true
    RetroHelper_Variables.shopOpenTime = GetTime()
end

function RetroHelper_EventHandler.MERCHANT_CLOSED()
    RetroHelper_Variables.isShop = false
end

function RetroHelper_EventHandler.TRAINER_SHOW()
    RetroHelper_Variables.isTrainer = true
    RetroHelper_Variables.trainerOpenTime = GetTime()
end

function RetroHelper_EventHandler.TRAINER_CLOSED()
    RetroHelper_Variables.isShop = false
    _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFE400" .. "Auto learns Trainer Skills!!")
end

function RetroHelper_EventHandler.CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE()
    if (RetroHelper_GetCfg("CFG_ENEMY_SPELL", 1) == true) then
        local eName, spell, eTarget
        for eName, spell in string.gfind(arg1, "(.+) begins to cast (.+).") do
            if
                (spell == "Lightning Bolt") or (spell == "Chain Lightning") or (spell == "Firebolt") or (spell == "Pyroblast") or (spell == "Shadow Bolt") or (spell == "Polymorph") or
                    (spell == "Frostbolt") or
                    (spell == "Starfire") or
                    (spell == "Fear") or
                    (spell == "Soul Fire")
             then
                TargetByName(eName, 1)
                eTarget = GetUnitName("targettarget")
                if (CheckInteractDistance("target", 4)) then
                    inDistance = "Close"
                else
                    inDistance = "Far"
                end
                if (eTarget == nil) then
                    eTarget = "None"
                end
                TargetLastTarget()

                if (eTarget == GetUnitName("player")) then
                    PlaySoundFile("Sound\\Doodad\\g_hornofecheyakee.wav")
                    _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cff5CD1E5" .. "Enemy Cast Start - " .. "|cffFFFFFF" .. "Spell : " .. spell .. "  Name : " .. eName .. "  Distance : " .. inDistance)
                end
            end
        end
    end
end

function RetroHelper_EventHandler.BATTLEFIELDS_SHOW()
    if (not IsShiftKeyDown()) then
        if (RetroHelper_GetCfg("CFG_FAST_BG", 1)) then
            for i = 1, MAX_BATTLEFIELD_QUEUES do
                local status = GetBattlefieldStatus(i)
                if (status == "queued" or status == "confirm") then
                    AcceptBattlefieldPort(i, nil)
                end
            end
            if (GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0) and IsPartyLeader() then
                JoinBattlefield(0, 1)
            else
                JoinBattlefield(0)
            end
            ClearTarget()
            BattlefieldFrameCancelButton:Click()
        end
    end
end

RetroHelper_EventHandler:SetScript(
    "OnEvent",
    function(...)
        if RetroHelper_EventHandler[event] then
            RetroHelper_EventHandler[event]()
        end
    end
)

RetroHelper_OnUpdateHandler:SetScript(
    "OnUpdate",
    function(...)
        if (RetroHelper_GetCfg("CFG_DUEL_HELPER", 1)) then
            if (RetroHelper_Variables.duel_state == true) then
                TargetByName(RetroHelper_Variables.duel_target, 1)
            end
        end
        ----- add cfg
        if (GetTime() - RetroHelper_Variables.onUpdateTime >= 0.2) then
            RetroHelper_Variables.onUpdateTime = GetTime() + 0.2
            local isDeserter = nil
            for i = 1, 16 do
                local dBuff = UnitDebuff("player", i)
                if (dBuff) then
                    if (string.find(dBuff, "Ability_Druid_Cower")) then
                        isDeserter = true
                    end
                end
            end
            if (GetNumBattlefieldStats() == 0) then
                if (GetBattlefieldEstimatedWaitTime(1) == 0) then
                    if (not isDeserter) then
                        if (GetMinimapZoneText() ~= nil) then
                            if (GetNumPartyMembers() == 0) and (GetNumRaidMembers() == 0) then
                                if (RetroHelper_Variables.battlegroundQueueReady) then
                                --  RetroHelper_Queue()
                                end
                            end
                        end
                    end
                --_print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. "Auto Battlefield Queue !!")
                end
            end
        -- Do Something
        end
        -----
        if (RetroHelper_Variables.isShop) and (GetTime() - RetroHelper_Variables.shopOpenTime >= 0.8) and (not CursorHasItem()) then
            RetroHelper_Variables.shopOpenTime = GetTime() + 0.8
            RetroHelper_ShopRepair()
        end
        if (RetroHelper_Variables.isTrainer) and (GetTime() - RetroHelper_Variables.trainerOpenTime >= 0.25) then
            RetroHelper_Variables.trainerOpenTime = GetTime() + 0.25
            RetroHelper_LearnSkills()
        end
        if (RetroHelper_GetCfg("CFG_FAST_BG", 1)) then
            local bg_winner = GetBattlefieldWinner()
            local winner_name = "Alliance"
            local player_faction = UnitFactionGroup("player")
            local result = nil
            if bg_winner ~= nil then
                if bg_winner == 0 then
                    winner_name = "Horde"
                end
                --    UIErrorsFrame:Clear()
                --  UIErrorsFrame:AddMessage("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. "Winner is " .. "|cffFFE400" .. winner_name)
                if (winner_name == player_faction) then
                    result = "You Win !!"
                else
                    result = "You Lose !!"
                end

                _printx(
                    "|cff00D8FF" ..
                        "[RetroHelper]: " ..
                            "|cffFFFFFF" ..
                                "Battlefield Result - " ..
                                    "|cffFFE400" ..
                                        result ..
                                            " (" ..
                                                "|cffFFFFFF" ..
                                                    winner_name ..
                                                        "|cffFFE400" ..
                                                            ") " ..
                                                                "|cffFFFFFF" ..
                                                                    " Killing Blows : " ..
                                                                        "|cffFFE400" ..
                                                                            RetroHelper_Variables.killingBlowCount ..
                                                                                "|cffFFFFFF" ..
                                                                                    " Honorable kills : " ..
                                                                                        "|cffFFE400" ..
                                                                                            RetroHelper_Variables.pvpKillCount ..
                                                                                                "|cffFFFFFF" .. ", Total Honor Points : " .. "|cffFFE400" .. RetroHelper_Variables.honorPoint
                )
                LeaveBattlefield()
            end
        end
    end
)

function RetroHelper_RegisterEvents()
    for _, i in RetroHelper_Events do
        RetroHelper_EventHandler:RegisterEvent(i)
    end
end

function RetroHelper_UnregisterEvents()
    for _, i in RetroHelper_Events do
        RetroHelper_EventHandler:UnregisterEvent(i)
    end
end

function RetroHelper_EventHandler.CHAT_MSG_COMBAT_HOSTILE_DEATH(...)
    for name in string.gfind(arg1, "You have slain (.+)!") do
        local tName = UnitName("target")
        local tChanged = false
        if (not tName) or (tName ~= name) then
            tChanged = true
            TargetByName(name, 1)
        end

        if (not RetroHelper_IsPet()) and (UnitIsPlayer("target")) then
            local level = "|cffFFFFFFNice !"
            if (RetroHelper_Variables.killingBlowCount >= 5) then
                level = "|cffABF200Good Job !"
            end
            if (RetroHelper_Variables.killingBlowCount >= 10) then
                level = "|cffA566FFGreat !"
            end
            if (RetroHelper_Variables.killingBlowCount >= 15) then
                level = "|cffFFBB00Excellent !"
            end
            if (RetroHelper_Variables.killingBlowCount >= 20) then
                level = "|cffFAED7DAmazing !!"
            end
            if (RetroHelper_Variables.killingBlowCount >= 25) then
                level = "|cffF361DCIncredible !!!"
            end
            if (RetroHelper_Variables.killingBlowCount >= 35) then
                level = "|cff86E57FKilling Spree !!!"
            end
            if (RetroHelper_Variables.killingBlowCount >= 40) then
                level = "|cff0054FFGOD OF WAR !!!"
            end

            RetroHelper_Variables.killingBlowCount = RetroHelper_Variables.killingBlowCount + 1
            _print(
                "|cff00D8FF" ..
                    "[RetroHelper]: " ..
                        level .. "|cffFFFFFF" .. " - You have slain [" .. "|cffFFE400" .. name .. "|cffFFFFFF" .. "], Killing Blows : " .. "|cff5CD1E5" .. RetroHelper_Variables.killingBlowCount
            )
            PlaySoundFile("Sound\\Interface\\ReadyCheck.wav")
        end
        if (tChanged) then
            TargetLastTarget()
        end
    end
end

function RetroHelper_EventHandler.CHAT_MSG_CHANNEL(...)
    if (arg1 == nil) or (arg2 == RetroHelper_Variables.playerName) then
        return
    end
    if (string.find(arg1, RetroHelper_Variables.currentProgressingQuest, nil, true)) then
        if (GetTime() - RetroHelper_Variables.currentProgressingQuestTime < 300) then
            if (RetroHelper_IsPlayerCanInvite() ~= false) then
                RetroHelper_InviteToParty(arg2)
            end
        end
    end
    -- for world buffs
    if
        ((string.find(strlower(arg1), strlower("buff")))or (string.find(strlower(arg1), strlower("ony")))or (string.find(strlower(arg1), strlower("zg")))or (string.find(strlower(arg1), strlower("nef")))) and
            ((string.find(strlower(arg1), strlower("inc")))or (string.find(strlower(arg1), strlower("in"))) or (string.find(strlower(arg1), strlower("work"))) or (string.find(strlower(arg1), strlower("min"))) or
                (string.find(strlower(arg1), strlower("com"))))
     then
        PlaySoundFile("Sound\\INTERFACE\\LevelUp2.wav")
        _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. "World Buff Incoming Notify - MSG : [" .. "|cffFFE400" .. arg2 .. "|cffFFFFFF" .. "]: " .. "|cff5CD1E5" .. arg1)
    end
end

function RetroHelper_EventHandler.CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS(...)
    if (arg1 == nil) then
        return
    end
    if (RetroHelper_GetCfg("CFG_AUTO_GROUP", 1) == true) then
        for enemy, unit in string.gfind(arg1, "(.+) hits.(.+) for ") do
            for k1, v1 in pairs(RetroHelper_QuestObjects) do
                for k2, v2 in pairs(RetroHelper_QuestObjects[k1]) do
                    if (string.find(k2, enemy, nil, 1)) then
                        if (k1 == RetroHelper_Variables.currentProgressingQuest) then
                            if (RetroHelper_IsPlayerCanInvite() == false) then
                                return
                            else
                                if (UnitIsPartyLeader("player") and (GetNumPartyMembers() <= 3)) then
                                    for i = 1, GetNumPartyMembers() do
                                        if (GetUnitName("party" .. i .. "") == unit) then
                                            return
                                        end
                                    end
                                    RetroHelper_InviteToParty(unit)
                                elseif ((GetNumPartyMembers() == 0) and (GetNumRaidMembers() == 0)) then
                                    RetroHelper_InviteToParty(unit)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function _print(txt)
    DEFAULT_CHAT_FRAME:AddMessage(txt)
end

function RetroHelper_EventHandler.CHAT_MSG_GUILD(...)
    if (arg1 == nil) or (arg2 == GetUnitName("player")) then
        return
    else
        RetroHelper_Variables.inv_guild = arg2
    end
end
function RetroHelper_EventHandler.CHAT_MSG_SAY(...)
    if (arg1 == nil) or (arg2 == GetUnitName("player")) then
        return
    else
        RetroHelper_Variables.inv_say = arg2
    end
end
function RetroHelper_EventHandler.CHAT_MSG_YELL(...)
    if (arg1 == nil) or (arg2 == GetUnitName("player")) then
        return
    else
        RetroHelper_Variables.inv_yell = arg2
    end
end
function RetroHelper_EventHandler.CHAT_MSG_WHISPER(...)
    if (arg1 == nil) or (arg2 == GetUnitName("player")) then
        return
    else
        RetroHelper_Variables.inv_whisper = arg2
        local isInvRequest = false
        if (string.find(arg1, "inv")) then
            isInvRequest = true
        end
        if ((isInvRequest) or (GetTime() - RetroHelper_Variables.latestYellTime < 60)) then
            if (string.find(arg1, "RetroHelper")) then
                return
            elseif (RetroHelper_IsPlayerCanInvite() ~= false) then
                RetroHelper_InviteToParty(arg2)
            end
        end
    end
end

function RetroHelper_InviteToParty(name)
    if (RetroHelper_GetCfg("CFG_AUTO_GROUP", 1) == true) then
        local inv = RetroHelper_RecentInvList[name]
        if (inv == nil) or (GetTime() - inv > 300) then
            RetroHelper_RecentInvList[name] = GetTime()
            SendChatMessage("[RetroHelper] Invite [" .. name .. "] to " .. RetroHelper_Variables.currentProgressingQuest .. " Quest Group !!", "WHISPER", nil, name)
            InviteByName(name)
        end
    end
end

function RetroHelper_IsPlayerCanInvite()
    if (UnitIsPartyLeader("player") and (GetNumPartyMembers() <= 3)) then
        return true
    elseif (GetNumPartyMembers() ~= 0) then
        return false
    elseif ((GetNumPartyMembers() == 0) and (GetNumRaidMembers() == 0)) then
        return true
    else
        return false
    end
end

function RetroHelper_IsBGNPC()
    local name = GetUnitName("target")
    if (name == "Deze Snowbane") or (name == "Elfarran") or (name == "Thelman Slatefist") then
        return true
    end
    return false
end

function RetroHelper_IsQuestNPC()
    local name = GetUnitName("target")
    if (name == "World Quests") or (name == "Ragefire Spy") or (name == "PvP Quest Master") then
        return true
    end
    return false
end

function RetroHelper_IsPet()
    UnitType = UnitCreatureType("Target")
    if (UnitType ~= nill and ((string.find(UnitType, "Beast") and (UnitClass("target") ~= "Druid")) or string.find(UnitType, "Demon") or string.find(UnitType, "Not specified"))) then
        return true
    else
        return false
    end
end

function RetroHelper_EventHandler.PLAYER_TARGET_CHANGED(...)
    if (RetroHelper_IsQuestNPC()) then
        _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. "While the " .. "|cffFFE400" .. "[Shift Key]" .. "|cffFFFFFF" .. " pressed, the quest will not be processed automatically.")
    elseif (RetroHelper_IsBGNPC()) then
        _print(
            "|cff00D8FF" ..
                "[RetroHelper]: " .. "|cffFFFFFF" .. "While the " .. "|cffFFE400" .. "[Shift Key]" .. "|cffFFFFFF" .. " pressed, the battleground queue will not be processed automatically."
        )
    end

    -- BG Smart Targeting
    if (RetroHelper_GetCfg("CFG_TARGET_BG", 1)) then
        if (GetNumBattlefieldStats() ~= 0) then
            local name = GetUnitName("target")
            if (name ~= nil) then
                if
                    (((not UnitIsPlayer("target")) and ((UnitLevel("target") <= 55) and (not UnitAffectingCombat("target")))) or
                        (UnitIsPlayer("target") and (UnitIsDead("target") and (not UnitClass("target") == "Hunter"))) or
                        (RetroHelper_IsPet()))
                 then
                    ClearTarget()
                end
            end
        end
    end

    if (RetroHelper_Variables.worldChannelID == nil) then
        for i = 1, 10 do
            local frame = getglobal("ChatFrame" .. i)
            if (frame) then
                local cID, cName = GetChannelName(i)
                if (cName == "World") then
                    RetroHelper_Variables.worldChannelID = cID
                end
            end
        end
    end
end

function RetroHelper_EventHandler.CHAT_MSG_COMBAT_HONOR_GAIN(...)
    for point in string.gfind(arg1, "(%d+)") do
        RetroHelper_Variables.honorPoint = RetroHelper_Variables.honorPoint + tonumber(point)
    end
end

function RetroHelper_EventHandler.CHAT_MSG_SYSTEM(...)
    local function IsGuildMate(name)
        if IsInGuild() then
            local ngm = GetNumGuildMembers()
            for i = 1, ngm do
                n, rank, rankIndex, level, class, zone, note, officernote, online, status, classFileName = GetGuildRosterInfo(i)
                if strlower(n) == strlower(name) then
                    return true
                end
            end
        end
        return nil
    end

    if (arg1 ~= nil) then
        if (arg1 == "You are now AFK: Away from Keyboard") then
            RetroHelper_Variables.isPlayerAFK = true
            SendChatMessage("[RetroHelper] Player is AFK now !!", "GUILD")
        elseif (arg1 == "You are no longer AFK.") then
            RetroHelper_Variables.isPlayerAFK = false
        elseif (string.find(arg1, "joins the party.")) and (RetroHelper_GetCfg("CFG_AUTO_GREETINGS", 1) == true) then
            for name, _ in string.gfind(arg1, "(.+) joins the party.") do
                SendChatMessage("[RetroHelper] " .. name .. ", Welcome to party !!", "PARTY")
            end
        elseif (string.find(arg1, "has come online.")) and (RetroHelper_GetCfg("CFG_AUTO_GREETINGS", 1) == true) then
            if (RetroHelper_Variables.isPlayerAFK == true) then
                local _, _, name = string.find(arg1, "^.*%[(.*)%].*$")
                if (IsGuildMate(name)) then
                    SendChatMessage("[RetroHelper] " .. name .. ", Welcome !! [AFK MSG]", "GUILD")
                end
            end
        elseif (arg1 == "You have requested a duel.") and (RetroHelper_GetCfg("CFG_DUEL_HELPER", 1)) then
            RetroHelper_DuelStart()
        end
    end
end

function RetroHelper_EventHandler.LOOT_BIND_CONFIRM(...)
    StaticPopup1Button1:Click()
end

function RetroHelper_EventHandler.START_LOOT_ROLL(...)
    local _, name, _, quality = GetLootRollItemInfo(arg1)
    local loot = false
    if (RetroHelper_GetCfg("AUTO_LOOT_PVE_TOKEN", 1) == true) and (string.find(name, "PvE Token")) then
        loot = true
    elseif (RetroHelper_GetCfg("AUTO_LOOT_ELITE_TOKEN", 1) == true) and (string.find(name, "Elite Token")) then
        loot = true
    elseif (RetroHelper_GetCfg("AUTO_LOOT_BOSS_TOKEN", 1) == true) and (string.find(name, "Boss Token")) then
        loot = true
    elseif (RetroHelper_GetCfg("AUTO_LOOT_ZULGURUB_BIJOU", 1) == true) and ((string.find(name, "Coin")) or (string.find(name, "Bijou"))) then
        loot = true
    elseif (RetroHelper_GetCfg("AUTO_LOOT_ZULGURUB_IDOL", 1) == true) and (string.find(name, "Idol")) then
        loot = true
    elseif (RetroHelper_GetCfg("AUTO_LOOT_AHNQIRAJ_IDOL", 1) == true) and (string.find(name, "Idol")) then
        loot = true
    elseif (RetroHelper_GetCfg("AUTO_LOOT_AHNQIRAJ_SCARAB", 1) == true) and (string.find(name, "Scarab")) then
        loot = true
    end
    if (loot) then
        RollOnLoot(arg1, 1)
        StaticPopup1Button1:Click()
        local _, _, _, item = GetItemQualityColor(quality)
        _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. "Need Roll : " .. item .. " " .. GetLootRollItemLink(arg1))
        return
    end
end

function RetroHelper_EventHandler.UI_INFO_MESSAGE(...)
    local function GetQuestName(object)
        for k1, v1 in pairs(RetroHelper_QuestObjects) do
            for k2, v2 in pairs(RetroHelper_QuestObjects[k1]) do
                if (string.find(object, k2)) then
                    return k1
                end
            end
        end
        return nil
    end

    if (arg1 ~= nil) then
        local qName = GetQuestName(arg1)
        local numA, numB
        if (qName ~= nil) then
            if (not (string.find(qName, "Tokens") or string.find(qName, "PvP") or string.find(qName, "Potion"))) then
                RetroHelper_Variables.currentProgressingQuest = qName
                RetroHelper_Variables.currentProgressingQuestTime = GetTime()

                if (RetroHelper_GetCfg("QUEST_BROADCAST_OFF", 1) == false) then
                    for n1, n2 in string.gfind(arg1, " slain: (.+)/(.+)") do
                        if (n1 == n2) then
                            PlaySoundFile("Sound\\Doodad\\g_hornofecheyakee.wav")
                            SendChatMessage("[RetroHelper]: " .. RetroHelper_Variables.currentProgressingQuest .. " " .. arg1 .. " - [DONE!!] ", "YELL")
                        end
                    end
                    if (RetroHelper_GetCfg("QUEST_BROADCAST_AUTO", 1)) then
                        if (GetNumPartyMembers() ~= 0) then
                            SendChatMessage("[RetroHelper]: " .. RetroHelper_Variables.currentProgressingQuest .. " " .. arg1, "PARTY")
                        else
                            _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFE400" .. RetroHelper_Variables.currentProgressingQuest .. " " .. "|cffFFFFFF" .. arg1)
                        end
                    elseif (RetroHelper_GetCfg("QUEST_BROADCAST_PARTY_ONLY", 1)) then
                        if (GetNumPartyMembers() ~= 0) then
                            SendChatMessage("[RetroHelper]: " .. RetroHelper_Variables.currentProgressingQuest .. " " .. arg1, "PARTY")
                        end
                    elseif (RetroHelper_GetCfg("QUEST_BROADCAST_UI_ONLY", 1)) then
                        _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFE400" .. RetroHelper_Variables.currentProgressingQuest .. " " .. "|cffFFFFFF" .. arg1)
                    end
                end
            end
        end
    end
end

function RetroHelper_EventHandler.UI_ERROR_MESSAGE(...)
    if (string.find(arg1, "mounted") or string.find(arg1, "while silenced")) then
        UIErrorsFrame:Clear()
        RetroHelper_CancleBuff("Increases speed by (.+)%%")
    end
    if (arg1 == "You are in shapeshift form") then
        UIErrorsFrame:Clear()
        RetroHelper_CancleBuff("stopped breathing")
    end
    if (string.find(arg1, "standing")) then
    end
end

function RetroHelper_EventHandler.QUEST_GREETING()
    local available = {}
    local active = {}
    for k = 1, GetNumAvailableQuests() do
        table.insert(available, GetAvailableTitle(k))
    end
    for k = 1, GetNumActiveQuests() do
        table.insert(active, GetActiveTitle(k))
    end
    RetroHelper_MenuHandler(available, active, SelectAvailableQuest, SelectActiveQuest)
end

function RetroHelper_EventHandler.QUEST_PROGRESS(...)
    local qName = GetTitleText()
    if (RetroHelper_GetCfg(qName, 2)) then
        if (not IsShiftKeyDown()) then
            if ((RetroHelper_Variables.currentQuest == qName) and IsQuestCompletable()) then
                RetroHelper_Variables.currentQuest = qName
                CompleteQuest()
            else
                RetroHelper_Variables.currentQuest = ""
                _print(
                    "|cff00D8FF" ..
                        "[RetroHelper]: " ..
                            "|cffFFFFFF" ..
                                "None of the quests selected for automatic repetition are currently completed.  Select the quest that will be repeated automatically from the [RetroWoW Option]. try " ..
                                    "|cffFFE400" .. "/rh" .. "|cffFFFFFF" .. " or " .. "|cffFFE400" .. "/retrohelper"
                )
                CloseQuest()
            end
        end
    end
end

function RetroHelper_EventHandler.QUEST_DETAIL()
    local qName = GetTitleText()
    if ((RetroHelper_GetCfg(qName, 2)) == true) then
        if (not IsShiftKeyDown()) then
            if ((RetroHelper_Variables.currentQuest == qName) and (RetroHelper_GetCfg(qName, 2))) then
                if (not (string.find(qName, "Tokens") or string.find(qName, "PvP") or string.find(qName, "Potion"))) then
                    if (RetroHelper_Variables.worldChannelID ~= nil) then
                        if (RetroHelper_IsPlayerCanInvite()) then
                            local headTxt = ""
                            if (UnitIsPartyLeader("player") and (GetNumPartyMembers() <= 3)) then
                                headTxt = "LFM"
                            elseif ((GetNumPartyMembers() == 0) and (GetNumRaidMembers() == 0)) then
                                headTxt = "LFG/LFM"
                            end
                            if (((groupType ~= false) and (groupType ~= "party")) and (RetroHelper_GetCfg("CFG_AUTO_GROUP", 1) == true)) then
                                SendChatMessage("[RetroHelper] " .. headTxt .. " [" .. qName .. "] ", "CHANNEL", nil, RetroHelper_Variables.worldChannelID)
                                RetroHelper_Variables.latestYellTime = GetTime()
                            end
                        end
                    end
                end
                RetroHelper_Variables.questAcceptTime = GetTime()
                RetroHelper_Variables.latestAcceptQuest = qName
                AcceptQuest()
            else
                RetroHelper_Variables.currentQuest = ""
            end
        end
    end
end

function RetroHelper_EventHandler.QUEST_COMPLETE()
    local qName = GetTitleText()
    if (not IsShiftKeyDown()) then
        if ((RetroHelper_Variables.currentQuest == qName) and (RetroHelper_GetCfg(qName, 2)) and GetNumQuestChoices() == 0) then
            GetQuestReward()
        end
        RetroHelper_Variables.currentQuest = ""
    end
end

function RetroHelper_EventHandler.GOSSIP_SHOW()
    if (GetUnitName("target") ~= "Rin'wosho the Trader") then
        local GossipType = {}
        local gossipnr = nil
        local gossipbreak = nil
        _, GossipType[1], _, GossipType[2], _, GossipType[3], _, GossipType[4], _, GossipType[5] = GetGossipOptions()

        for i = 1, getn(GossipType) do
            if (GossipType[i] == "binder") then
                local bind = GetBindLocation()
                if bind ~= GetSubZoneText() then
                    gossipbreak = true
                end
            elseif gossipnr then
                gossipbreak = true
            elseif (GossipType[i] == "trainer" or GossipType[i] == "vendor" or GossipType[i] == "battlemaster" or GossipType[i] == "gossip") then
                --  elseif (GossipType[i] == "trainer" or GossipType[i] == "vendor" or GossipType[i] == "battlemaster" or GossipType[i] == "gossip") then
                gossipnr = i
            elseif GossipType[i] == "taxi" then
                gossipnr = i
                RetroHelper_CancleBuff("Increases speed by (.+)%%")
            end
        end

        if not gossipbreak and gossipnr then
            SelectGossipOption(gossipnr)
        end
    end
end

function RetroHelper_EventHandler.DUEL_REQUESTED()
    if (RetroHelper_GetCfg("CFG_DUEL_HELPER", 1)) then
        TargetByName(arg1, 1)
        _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. " Duel request!! The target is fixed to the current target until the duel is finished. - Opponent : " .. "|cffFFE400" .. arg1)
        RetroHelper_Variables.duel_state = true
        RetroHelper_Variables.duel_target = arg1
    end
end

function RetroHelper_DuelStart()
    if (RetroHelper_GetCfg("CFG_DUEL_HELPER", 1)) then
        local name = GetUnitName("target")
        _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. " Duel start!! The target is fixed to the current target until the duel is finished. - Target : " .. "|cffFFE400" .. name)
        RetroHelper_Variables.duel_state = true
        RetroHelper_Variables.duel_target = name
    end
end

function RetroHelper_EventHandler.DUEL_FINISHED()
    if (RetroHelper_GetCfg("CFG_DUEL_HELPER", 1)) then
        _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. " Duel finished!! The target is released.")
        RetroHelper_Variables.duel_state = false
        RetroHelper_Variables.duel_target = ""
    end
end

function RetroHelper_EventHandler.PARTY_INVITE_REQUEST(...)
    local function IsGuildMate(name)
        if IsInGuild() then
            local ngm = GetNumGuildMembers()
            for i = 1, ngm do
                n, rank, rankIndex, level, class, zone, note, officernote, online, status, classFileName = GetGuildRosterInfo(i)
                if strlower(n) == strlower(name) then
                    return true
                end
            end
        end
        return nil
    end
    local function IsFriend(name)
        for i = 1, GetNumFriends() do
            if GetFriendInfo(i) == name then
                return true
            end
        end
        return nil
    end
    if ((IsGuildMate(arg1)) or (IsFriend(arg1)) or (GetTime() - RetroHelper_Variables.latestYellTime < 60)) then
        AcceptGroup()
        StaticPopup_Hide("PARTY_INVITE")
        PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav")
        _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFF007F" .. "Invitation has accepted automatically.")
    end
end

function RetroHelper_GetCfg(value, option)
    local CONSTANT = 1 -- constant to bool, description, cbName
    local DESCRIPTION = 2 -- description to bool, constant, cbName

    for k1, v1 in ipairs(RetroHelper_CFG) do
        for k1, v1 in ipairs(RetroHelper_CFG[k1]) do
            if (option == CONSTANT) then
                if (v1[1] == value) then
                    return v1[4], v1[3], v1[2]
                end
            elseif (option == DESCRIPTION) then
                -- if (v1[3] == value) then
                if (value) then
                    if (v1[3] == value) or (string.find(value, v1[3])) then
                        return v1[4], v1[1], v1[2]
                    end
                end
            end
        end
    end
end

function RetroHelper_CancleBuff(bName)
    local counter = 0
    while GetPlayerBuff(counter) >= 0 do
        local index, untilCancelled = GetPlayerBuff(counter)
        RetroHelperBuffTooltip:SetPlayerBuff(index)
        local desc = RetroHelperBuffTooltipTextLeft2:GetText()
        if desc then
            if (string.find(desc, bName)) then
                CancelPlayerBuff(counter)
                return
            end
        --[[
            _, _, msg = string.find(desc, bName)
            if msg then
                CancelPlayerBuff(counter)
                return
            end
            ]]
        end
        counter = counter + 1
    end
end

function RetroHelper_EE()
    local function GetBuffDiscription(dis)
        local num = 0
        while GetPlayerBuff(num) >= 0 do
            local index, untilCancelled = GetPlayerBuff(num)
            RH_ScanBuff:SetPlayerBuff(index)
            local txt = RH_ScanBuffTextLeft2:GetText()
            if txt then
                --  _print(txt)
                if (string.find(strlower(txt), strlower(dis))) then
                    return true
                end
            end
            num = num + 1
        end
        return false
    end

    local function GetFeatherTime()
        for i = 0, 30 do
            local temp = GetPlayerBuffTexture(i)
            if (temp and strfind(temp, "FeatherFall")) then
                return GetPlayerBuffTimeLeft(i)
            end
        end
        return 0
    end

    -- Use Potions
    if (true) then
        if (UnitAffectingCombat("player")) then
            local uClass = UnitClass("player")
            if (RH_UnitHP("player") <= 40) and (not RetroHelper_UseItem("Healing Draught")) and RetroHelper_UseItem("Healthstone") then
                -- to do anything ...
            elseif (RH_UnitMP("player") <= 15) and (not (uClass == "Rogue" or uClass == "Warrior" or uClass == "Druid")) then
                RetroHelper_UseItem("Mana Draught")
            end
        end
    end

    -- Buff Items
    local tName = UnitName("target")
    if (not tName) or (tName and (UnitIsEnemy("target", "player")) and (not CheckInteractDistance("target", 3))) then
        if (not (GetBuffDiscription("feel smaller")) or (not GetBuffDiscription("feel light"))) or (GetFeatherTime() <= 30) then
            if (not GetBuffDiscription("Magical resistances increased by 100")) then
                if (not GetBuffDiscription("Increases speed by (.+)%%")) then
                    RetroHelper_UseItem("Noggenfogger Elixir")
                end
            end
        elseif
            (not RetroHelper_Buffed("Rumsey Rum", "player")) and (not RetroHelper_Buffed("Graccu", "player")) and (not UnitAffectingCombat("player")) and (not RetroHelper_Variables.isCurrentCasting)
         then
            RetroHelper_UseItem("Rumsey Rum")
        end
    end
end

function RetroHelper_UseItem(name)
    local link = nil
    local bagslots = nil
    for bag = 0, NUM_BAG_FRAMES do
        bagslots = GetContainerNumSlots(bag)
        if bagslots and bagslots > 0 then
            for slot = 1, bagslots do
                link = GetContainerItemLink(bag, slot)
                if (link) and (string.find(link, name)) and (GetContainerItemCooldown(bag, slot) == 0) then
                    UseContainerItem(bag, slot)
                    return true
                end
            end
        end
    end
    return false
end

function RetroHelper_GetDurability(slotNum)
    local tooltip = RH_Scan
    local textleft1 = getglobal(tooltip:GetName() .. "TextLeft1")

    tooltip:SetOwner(UIParent, "ANCHOR_NONE")
    tooltip:SetInventoryItem("player", slotNum)
    for i = 1, 23 do
        local text = getglobal("RH_ScanTextLeft" .. i):GetText()
        if (not text) then
            break
        elseif (strfind(strlower(text), "durability")) then
            tooltip:Hide()
            for curDura, maxDura in string.gfind(text, "Durability (.+) / (.+)") do
                return curDura / maxDura * 100
            end
        end
    end
    tooltip:Hide()
    return 100
end

function RetroHelper_ShopRepair()
    local function IsSelling(iName)
        for i = 1, GetMerchantNumItems() do
            local link, tex, price, quantity, numAvailable, isUsable = GetMerchantItemInfo(i)
            if (link) then
                link = strlower(link)
                iName = strlower(iName)
                if (string.find(link, iName)) then
                    return true
                end
            end
        end
        return false
    end
    local function bagHandler(find)
        local link = nil
        local bagslots = nil
        for bag = 0, NUM_BAG_FRAMES do
            bagslots = GetContainerNumSlots(bag)
            if bagslots and bagslots > 0 then
                for slot = 1, bagslots do
                    link = GetContainerItemLink(bag, slot)
                    if not find and not link or find and link and string.find(link, find) then
                        return bag, slot
                    end
                end
            end
        end
        return nil
    end

    local bag, slot = bagHandler("ff9d9d9d")
    if bag and slot then
        local _, _, locked = GetContainerItemInfo(bag, slot)
        if bag and slot and not locked then
            UseContainerItem(bag, slot)
            if not (RetroHelper_Shop.bag == bag and RetroHelper_Shop.slot == slot) then
                _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. " Sold " .. GetContainerItemLink(bag, slot))
                RetroHelper_Shop.bag = bag
                RetroHelper_Shop.slot = slot
            end
        end
    --[[ elseif CanMerchantRepair() then
        local rcost = GetRepairAllCost()
        if rcost and rcost ~= 0 then
            if rcost > GetMoney() then
                _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. " Not enough gold to repair.")
                return
            end
            RetroHelper_Shop.repair = rcost
            RepairAllItems()
        elseif RetroHelper_Shop.repair and rcost == 0 then
            local gold = floor(abs(RetroHelper_Shop.repair / 10000))
            local silver = floor(abs(mod(RetroHelper_Shop.repair / 100, 100)))
            local copper = floor(abs(mod(RetroHelper_Shop.repair, 100)))
            local COLOR_COPPER = "|cffeda55f"
            local COLOR_SILVER = "|cffc7c7cf"
            local COLOR_GOLD = "|cffffd700"

            _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. "Repaired all the items " .. COLOR_GOLD .. gold .. "g " .. COLOR_SILVER .. silver .. "s " .. COLOR_COPPER .. copper .. "c")
            RetroHelper_Shop.repair = nil
        end ]]
    end
    if (true) then
        local function getCount(x, y)
            local _, itemCount = GetContainerItemInfo(x, y)
            return itemCount
        end
        -- stack is how much item stack can buy onece to merchant : ex cake is 200
        local function buyItem(iName, cNum, maxNum, stack)
            for i = 1, GetMerchantNumItems() do
                local link, tex, price, quantity, numAvailable, isUsable = GetMerchantItemInfo(i)
                if (link) then
                    link = strlower(link)
                    iName = strlower(iName)
                    if (string.find(link, iName)) then
                        if (price <= GetMoney()) then
                            if (stack > 1) then
                                local bCount
                                if (stack >= maxNum - cNum) then
                                    bCount = maxNum - cNum
                                elseif (stack < maxNum - cNum) then
                                    bCount = stack
                                end
                                BuyMerchantItem(i, bCount)
                                _print(
                                    "|cff00D8FF" ..
                                        "[RetroHelper]: " ..
                                            "|cffFFFFFF" .. "Buying " .. GetMerchantItemLink(i) .. " " .. "|cffFFE400" .. " (" .. cNum .. "/" .. maxNum .. ")" .. "|cffFF007F" .. " + " .. bCount
                                )
                            else
                                BuyMerchantItem(i)
                                _print(
                                    "|cff00D8FF" ..
                                        "[RetroHelper]: " ..
                                            "|cffFFFFFF" .. "Buying " .. GetMerchantItemLink(i) .. " " .. "|cffFFE400" .. " (" .. cNum .. "/" .. maxNum .. ")" .. "|cffFF007F" .. " + " .. stack
                                )
                            end
                        else
                            _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. "You don't have enough money to buy " .. GetMerchantItemLink(i))
                        end
                    end
                end
            end
        end
        local class = UnitClass("player")
        local isRich = false
        if (GetMoney() >= 10000) then
            isRich = true
        end

        ---- if auto buy on
        if (RetroHelper_GetCfg("CFG_AUTO_SHOPPING", 1) == true) then
            --free
            local nFood = 0
            local nArrow = 0
            --warlock
            local nShard = 0
            local nInfernalStone = 0
            local nDemonicFigurine = 0
            -- faid
            local nBGHpPotion = 0
            local nBGMpPotion = 0            
            local nNoggen = 0
            local nFeather = 0

            -- priest
            local nCandle = 0
            -- Druid
            local nWildThornroot = 0
            local nIronwoodSeed = 0
            local nWildBerries = 0
            -- Mage
            local nPotalRune = 0
            local nArcanePowder = 0
            -- Shaman
            local nAnkh = 0
            -- Paladin            
            local nKings = 0
            -- Rogue
            local nFlashPowder = 0
            local nBlindingPowder = 0

            for i = 0, 4 do
                for j = 1, 18 do
                    local link = GetContainerItemLink(i, j)
                    if (link ~= nil) then
                        if (string.find(link, "Graccu")) then
                            nFood = nFood + getCount(i, j)
                        end
                        if (string.find(link, "Doomshot")) then
                            nArrow = nArrow + getCount(i, j)
                        end
                        if (string.find(link, "Soul Shard")) then
                            nShard = nShard + getCount(i, j)
                        end
                        if (string.find(link, "Healing Draught")) then
                            nBGHpPotion = nBGHpPotion + getCount(i, j)
                        end
                        if (string.find(link, "Mana Draught")) then
                            nBGMpPotion = nBGMpPotion + getCount(i, j)
                        end                        
                        if (string.find(link, "Noggenfogger")) then
                            nNoggen = nNoggen + getCount(i, j)
                        end
                        if (string.find(link, "Sacred Candle")) then
                            nCandle = nCandle + getCount(i, j)
                        end
                        if (string.find(link, "Wild Thornroot")) then
                            nWildThornroot = nWildThornroot + getCount(i, j)
                        end
                        if (string.find(link, "Ironwood Seed")) then
                            nIronwoodSeed = nIronwoodSeed + getCount(i, j)
                        end
                        if (string.find(link, "Wild Berries")) then
                            nWildBerries = nWildBerries + getCount(i, j)
                        end
                        if (string.find(link, "Rune of Portals")) then
                            nPotalRune = nPotalRune + getCount(i, j)
                        end
                        if (string.find(link, "Arcane Powder")) then
                            nArcanePowder = nArcanePowder + getCount(i, j)
                        end
                        if (string.find(link, "Light Feather")) then
                            nFeather = nFeather + getCount(i, j)
                        end
                        if (string.find(link, "Ankh")) then
                            nAnkh = nAnkh + getCount(i, j)
                        end
                      
                        if (string.find(link, "Symbol of Kings")) then
                            nKings = nKings + getCount(i, j)
                        end
                        if (string.find(link, "Infernal Stone")) then
                            nInfernalStone = nInfernalStone + getCount(i, j)
                        end
                        if (string.find(link, "Demonic Figurine")) then
                            nDemonicFigurine = nDemonicFigurine + getCount(i, j)
                        end
                        if (string.find(link, "Flash Powder")) then
                            nFlashPowder = nFlashPowder + getCount(i, j)
                        end
                        if (string.find(link, "Blinding Powder")) then
                            nBlindingPowder = nBlindingPowder + getCount(i, j)
                        end
                    end
                end
            end

            if (nFood < 200) and (IsSelling("Graccu")) then
                buyItem("Graccu", nFood, 200, 200)
            elseif (nArrow < 200) and (class == "Warrior" or class == "Rogue") and (IsSelling("Doomshot")) then
                buyItem("Doomshot", nArrow, 200, 1)
            elseif (nArrow < 3000) and (class == "Hunter") and (IsSelling("Doomshot")) then
                buyItem("Doomshot", nArrow, 3000, 1)
            elseif (nBGHpPotion < 10) and (isRich) and (IsSelling("Healing Draught")) then
                buyItem("Healing Draught", nBGHpPotion, 10, 10)
            elseif (nBGMpPotion < 10) and (not (class == "Warrior" or class == "Rogue")) and (isRich) and (IsSelling("Mana Draught")) then
                buyItem("Mana Draught", nBGMpPotion, 10, 10)            
            elseif (nNoggen < 200) and (isRich) and (IsSelling("Noggenfogger")) then
                buyItem("Noggenfogger", nNoggen, 200, 200)
            elseif (nCandle < 200) and (class == "Priest") and (isRich) and (IsSelling("Sacred Candle")) then
                buyItem("Sacred Candle", nCandle, 200, 20)
            elseif (nWildThornroot < 200) and (class == "Druid") and (isRich) and (IsSelling("Wild Thornroot")) then
                buyItem("Wild Thornroot", nWildThornroot, 200, 20)
            elseif (nIronwoodSeed < 200) and (class == "Druid") and (isRich) and (IsSelling("Ironwood Seed")) then
                buyItem("Ironwood Seed", nIronwoodSeed, 200, 20)
            elseif (nWildBerries < 20) and (class == "Druid") and (isRich) and (IsSelling("Wild Berries")) then
                buyItem("Wild Berries", nWildBerries, 20, 20)
            elseif (nPotalRune < 200) and (class == "Mage") and (isRich) and (IsSelling("Rune of Portals")) then
                buyItem("Rune of Portals", nPotalRune, 200, 20)
            elseif (nArcanePowder < 200) and (class == "Mage") and (isRich) and (IsSelling("Arcane Powder")) then
                buyItem("Arcane Powder", nArcanePowder, 200, 20)
            elseif (nFeather < 200) and (class == "Mage" or class == "Priest") and (isRich) and (IsSelling("Light Feather")) then
                buyItem("Light Feather", nFeather, 200, 20)
            elseif (nAnkh < 200) and (class == "Shaman") and (isRich) and (IsSelling("Ankh")) then
                buyItem("Ankh", nAnkh, 200, 5)           
            elseif (nKings < 400) and (class == "Paladin") and (isRich) and (IsSelling("Symbol of Kings")) then
                --elseif (nShard < 200) and (class == "Warlock") and (IsSelling("Soul Shard")) then
                --  buyItem("Soul Shard", nShard, 200, 1)
                buyItem("Symbol of Kings", nKings, 400, 200)
            elseif (nShard < 200) and (class == "Warlock") and (IsSelling("Soul Shard")) then
                buyItem("Soul Shard", nShard, 200, 200)
            elseif (nInfernalStone < 5) and (class == "Warlock") and (isRich) and (IsSelling("Infernal Stone")) then
                buyItem("Infernal Stone", nInfernalStone, 5, 1)
            elseif (nDemonicFigurine < 5) and (class == "Warlock") and (isRich) and (IsSelling("Demonic Figurine")) then
                buyItem("Demonic Figurine", nDemonicFigurine, 5, 1)
            elseif (nFlashPowder < 200) and (class == "Rogue") and (isRich) and (IsSelling("Flash Powder")) then
                buyItem("Flash Powder", nFlashPowder, 200, 20)
            elseif (nBlindingPowder < 200) and (class == "Rogue") and (isRich) and (IsSelling("Blinding Powder")) then
                buyItem("Blinding Powder", nBlindingPowder, 200, 20)
            end
        end
    end
end

function RetroHelper_LearnSkills()
    if (GetNumTrainerServices() ~= 0) then
        BuyTrainerService(0)
    end
end

function RetroHelper_InvSay()
    if (RetroHelper_Variables.inv_say ~= "") then
        InviteByName(RetroHelper_Variables.inv_say)
        _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. " Invited the latest [SAY CHANNAL] player to party.")
    else
        _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. " Can't find target to invite.")
    end
end
function RetroHelper_InvGuild()
    if (RetroHelper_Variables.inv_guild ~= "") then
        InviteByName(RetroHelper_Variables.inv_guild)
        _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. " Invited the latest [GUILD CHANNEL] player to party.")
    else
        _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. " Can't find target to invite.")
    end
end
function RetroHelper_InvYell()
    if (RetroHelper_Variables.inv_yell ~= "") then
        InviteByName(RetroHelper_Variables.inv_yell)
        _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. " Invited the latest [YELL CHANNEL] player to party.")
    else
        _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. " Can't find target to invite.")
    end
end
function RetroHelper_InvWhisper()
    if (RetroHelper_Variables.inv_whisper ~= "") then
        InviteByName(RetroHelper_Variables.inv_whisper)
        _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. " Invited the latest [WHISPER CHANNEL] player to party.")
    else
        _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. " Can't find target to invite.")
    end
end
function RetroHelper_InvTarget()
    name = GetUnitName("target")
    if ((name) and name ~= GetUnitName("player")) then
        InviteByName(name)
        _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. " Invited the current target to party.")
    else
        _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. " Can't find target to invite.")
    end
end

function RetroHelper_ChatCommand(cmd)
    -- if (RetroHelper_Variables.lastchatCommand ~= cmd) or (GetTime() - RetroHelper_Variables.lastchatCommandTime >= 120) then
    --   RetroHelper_Variables.lastchatCommand = cmd
    -- RetroHelper_Variables.lastchatCommandTime = GetTime()
    DEFAULT_CHAT_FRAME.editBox:SetText(cmd)
    ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
    -- end
end

function RetroHelper_Queue()
    if (RetroHelper_GetCfg("BG_QUEUE_WARSONG_GULCH", 1) == true) then
        RetroHelper_ChatCommand(".go warsong")
    elseif (RetroHelper_GetCfg("BG_QUEUE_ARATHI_BUSIN", 1) == true) then
        RetroHelper_ChatCommand(".go arathi")
    elseif (RetroHelper_GetCfg("BG_QUEUE_ALTERAC_VALLEY", 1) == true) then
        RetroHelper_ChatCommand(".go alterac")
    end
end

function RetroHelper_Buffed(bName, unit)
    local buff = strlower(bName)
    local tooltip = RH_Scan
    local textleft1 = getglobal(tooltip:GetName() .. "TextLeft1")
    if (not unit) then
        unit = "player"
    end

    tooltip:SetOwner(UIParent, "ANCHOR_NONE")
    tooltip:SetTrackingSpell()
    local b = textleft1:GetText()
    if (b and strfind(strlower(b), buff)) then
        tooltip:Hide()
        return "track", b
    end
    local c = nil
    for i = 1, 16 do
        tooltip:SetOwner(UIParent, "ANCHOR_NONE")
        tooltip:SetUnitBuff(unit, i)
        b = textleft1:GetText()
        tooltip:Hide()
        if (b and strfind(strlower(b), buff)) then
            return "buff", i, b
        elseif (c == b) then
            break
        end
        --c = b;
    end
    tooltip:Hide()
end

function RetroHelper_Debuffed(bName, unit)
    local buff = strlower(bName)
    local tooltip = RH_Scan
    local textleft1 = getglobal(tooltip:GetName() .. "TextLeft1")
    if (not unit) then
        unit = "player"
    end

    tooltip:SetOwner(UIParent, "ANCHOR_NONE")
    tooltip:SetTrackingSpell()
    local b = textleft1:GetText()
    if (b and strfind(strlower(b), buff)) then
        tooltip:Hide()
        return "track", b
    end
    local c = nil
    for i = 1, 16 do
        tooltip:SetOwner(UIParent, "ANCHOR_NONE")
        tooltip:SetUnitDebuff(unit, i)
        b = textleft1:GetText()
        tooltip:Hide()
        if (b and strfind(strlower(b), buff)) then
            return "debuff", i, b
        elseif (c == b) then
            break
        end
        --c = b;
    end
    tooltip:Hide()
end

function RetroHelper_Repair()
    local function isNeedRepair()
        if (UnitIsDeadOrGhost("player")) then
            return false
        end
        for i = 1, 18 do
            if (GetInventoryItemLink("player", i)) and (RetroHelper_GetDurability(i) <= 20) then
                return true
            end
        end
        return false
    end
    if (isNeedRepair()) then
        RetroHelper_ChatCommand(".repair " .. GetUnitName("player"))
        _print("|cff00D8FF" .. "[RetroHelper]: " .. "|cffFFFFFF" .. "your equipment has been repaired.")
    end
end

function RetroHelper_ShowBGMap()
    DEFAULT_POI_ICON_SIZE = 6
    BattlefieldMinimap:SetScale(1.71)
    if (not BattlefieldMinimap:IsShown()) then
        BattlefieldMinimap:Show()
    end
    SetMapToCurrentZone()
end

function _sayx(msg)
    if (msg ~= RetroHelper_Variables.lastMessage2) then
        RetroHelper_Variables.lastMessage2 = msg
        SendChatMessage(msg, "SAY")
    end
end

function _printx(msg)
    if (msg ~= RetroHelper_Variables.lastMessage) then
        RetroHelper_Variables.lastMessage = msg
        DEFAULT_CHAT_FRAME:AddMessage(msg)
    end
end

function _whisperx(msg, name)
    local wTime = RetroHelper_RecentWhisperList[name]
    if (wTime == nil) or (GetTime() - wTime >= 5) then
        RetroHelper_RecentWhisperList[name] = GetTime()
        SendChatMessage(msg, "WHISPER", nil, name)
    end
end

function RH_UnitHP(unit)
    return (UnitHealth(unit) / UnitHealthMax(unit)) * 100
end

function RH_UnitMP(unit)
    return (UnitMana(unit) / UnitManaMax(unit)) * 100
end

function _say(msg)
    SendChatMessage(msg, "SAY")
end

function RH_A()
    local cmd = ".go alterac"
end
function RH_B()
end
