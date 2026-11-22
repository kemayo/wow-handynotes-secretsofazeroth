local myname, ns = ...

local ANNIVERSARY = ns.conditions.CalendarEventStartTexture(6238552)

-- https://www.wowhead.com/guide/world-events/20th-anniversary-guest-relations-secrets

-- You have to complete A Whiff of Help before any of the Guest Relations quests appear
-- 83831 hidden quest alongside Whiff might be the real trigger
local GUEST = ns.conditions.All(ns.conditions.QuestComplete(84868), ANNIVERSARY)

-- Assistant to the Assistant Guest Relations Manager
-- https://warcraft.wiki.gg/wiki/Assistant_to_the_Assistant_Guest_Relations_Manager
-- Every story starts with Alyx; the step points only show while on their quest.
ns.RegisterPoints(71, { -- Tanaris
    [63025024] = { -- nudged off the Six of Frost card at 63005020
        label="Alyx",
        achievement=40871, criteria=true,
        note="Gives a new story quest each day of the event",
        atlas="questnormal",
        minimap=true,
    },
}, {
    group="Anniversary",
    requires=GUEST,
})

-- Assistant to the Assistant Guest Relations Manager

-- A list of quests shows the points while on any of them. The list is also
-- the completion check, so faction variants need any=true.
local function RegisterStep(mapID, quest, points, defaults)
    local onquest
    if type(quest) == "table" then
        local made = {}
        for i, q in ipairs(quest) do made[i] = ns.conditions.OnQuest(q) end
        onquest = ns.conditions.Any(unpack(made))
    else
        onquest = ns.conditions.OnQuest(quest)
    end
    for _, point in pairs(points) do
        point.quest = quest
        point.requires = onquest
    end
    ns.RegisterPoints(mapID, points, ns.merge({
        group="Anniversary",
        requires=ANNIVERSARY,
        minimap=true,
        atlas="VignetteLoot",
    }, defaults))
end

-- Deck Dismay: https://warcraft.wiki.gg/wiki/Deck_Dismay
ns.RegisterPoints(71, { -- Tanaris
    [63875238] = {label="{npc:230838:Alphonse Constant}", atlas="questnormal", note="Talk to him once you have one of the cards."},
    [63204930] = {label="{item:229199}", loot={229199}, inbag=229199, note="On the Fashion Frenzy platform"}, -- Two of Air
    [61205090] = {label="{item:229225}", loot={229225}, inbag=229225, note="By Meerah, Dolly, and Dot"}, -- Four of Earth
    [64005150] = {label="{item:229207}", loot={229207}, inbag=229207, note="Under a bench at the Story Time stage, far left, second from back"}, -- Two of Fire
    [62104930] = {label="{item:229208}", loot={229208}, inbag=229208, note="Behind the outhouse near the portals"}, -- Three of Fire
    [63805190] = {label="{item:229210}", loot={229210}, inbag=229210, note="Between two barrels at the Story Time stage"}, -- Five of Fire
    [63305230] = {label="{item:229211}", loot={229211}, inbag=229211, note="By Leeroy Jenkins"}, -- Six of Fire
    [63404900] = {label="{item:229212}", loot={229212}, inbag=229212, note="Under the Fashion Frenzy platform, by the Black Market Auction House"}, -- Seven of Fire
    [61905160] = {label="{item:229213}", loot={229213}, inbag=229213, note="By Brivelthwerp, the ice cream vendor"}, -- Eight of Fire
    [63605100] = {label="{item:229216}", loot={229216}, inbag=229216, note="On the stairs near the Story Time stage"}, -- Three of Frost
    [63005020] = {label="{item:229219}", loot={229219}, inbag=229219, note="Behind the crate by Alyx"}, -- Six of Frost
}, {
    achievement=40871, criteria=70452, -- The Case of Misfortune
    quest=84882, -- Deck Dismay
    group="Anniversary",
    requires=GUEST,
    minimap=true,
})

-- Restoring A Grand Tale
-- Pages 6 and 11 drop from the world bosses, 25 and 27 from Sand Devils in the Caverns of Time.
RegisterStep(71, 83825, { -- Tanaris
    [61874981] = {label="Green Hills of Stranglethorn - Page 16", note="By the bowl next to the doghouse in the Pet Corner"},
    [64525181] = {label="Green Hills of Stranglethorn - Page 18", note="Between three rocks to the right of the Hearthstone board, behind the Story Time stage"},
    [63534778] = {label="Green Hills of Stranglethorn - Page 21", note="Next to the outhouse behind the Fashion Frenzy stage"},
    [63604870] = {npc=227816, note="Sells a new copy of the book for 100g, if you want to skip the pages", atlas="banker"}, -- Cravitz Lorent
}, {
    achievement=40871, criteria=69850, -- The Case of a Good Book
    requires=GUEST,
})

-- The Case of the Fur-Getting Wikket
local loud = {
    achievement=40871, criteria=69853, -- The Loud and Smelly Case
    requires=GUEST,
}
RegisterStep(71, 84595, { -- Tanaris
    [62354992] = {npc=229811, atlas="questobjective", note="Choose \"Dead\" then \"Raccoon\""}, -- Breanni
    [63034943] = {npc=229775, atlas="questobjective", note="Under the Fashion Frenzy stage. Search the nearby Trash Pile first."}, -- Sully "The Pickle" McLeary
}, loud)
RegisterStep(371, 84595, { -- The Jade Forest
    [42136036] = {label="Stone bridge", parent=true, note="Reset your Tricked-Out Thinking Cap to (0, 0) here, then go to (10, -40)", atlas="questobjective"},
    [43366882] = {label="Raccoon grave", note="Use the Torch of Pyrreth on the graves. Approach Gizmo slowly when he runs."},
}, loud)

-- Nola's Last Wish
local wish = {
    achievement=40871, criteria=69852, -- The Case of an Old Soul
    parent=true,
    requires=GUEST,
}
RegisterStep(864, 84435, { -- Vol'dun
    [64022607] = {label="Nola's Last Wish", note="Use the Idol of Ohn'ahra near the dead Tortaka Tribesmen"},
    [61602050] = {npc=123063, note="In Tortaka Refuge", atlas="questobjective"}, -- Elder Kuppaka
}, wish)
RegisterStep(862, 84435, { -- Zuldazar
    [24404450] = {label="Tortollan wedding", note="Use Nola's Last Wish here. Or reset your Tricked-Out Thinking Cap to (0, 0) at the scroll location, then go to (-132, -429)", atlas="questobjective"},
}, wish)

-- From Ashes to Wisdom
local whistle = {
    achievement=40871, criteria=70454, -- The Case of Great Aspirations
    note="Use the Whelpling Whistle here; you have to visit the points in order",
    atlas="questobjective",
    requires=GUEST,
    parent=true,
}
RegisterStep(36, 84933, { -- Burning Steppes
    [61142953] = {label="Voidfire #1: Ruins of Thaurissan"},
}, whistle)
RegisterStep(15, 84933, { -- Badlands
    [31074870] = {label="Voidfire #2: Scar of the Worldbreaker"},
}, whistle)
RegisterStep(241, 84933, { -- Twilight Highlands
    [38434919] = {label="Voidfire #3: Twilight Breach"},
}, whistle)
RegisterStep(205, 84933, { -- Shimmering Expanse
    [39076748] = {label="Voidfire #4: Ruins of Vashj'ir", translate={[13]=true}},
}, whistle)

-- A Bird's Tail
local bird = {
    achievement=40871, criteria=70455, -- The Case of a Feathered Friend
    requires=GUEST,
    parent=true,
}
RegisterStep(542, 84924, { -- Spires of Arak
    [45765360] = {loot={229408}, inbag=229408, note="By a bonfire on a sundial, at the top of the Windswept Terrace"}, -- Burnt Feather
}, bird)
RegisterStep(535, 84924, { -- Talador
    [29552954] = {loot={229409}, inbag=229409, note="On a rock by the lake, west of Shattrath City"}, -- Plucked Feather
}, bird)
RegisterStep(550, 84924, { -- Nagrand
    [83841940] = {loot={229410}, inbag=229410, note="At the top of the mountain above the Elemental Plateau. Tricked-Out Thinking Cap: (-48, 93)"}, -- Frozen Feather
}, bird)
RegisterStep(525, 84924, { -- Frostfire Ridge
    [42076749] = {loot={229411}, inbag=229411, note="By the Frostwall shipyard. Horde characters with a built shipyard could be out of phase; use party sync with someone who has not built one."}, -- Normal Feather
}, bird)

-- Lost and... Found?
-- Take the items from the box next to Alyx. Marin Noggenfogger (Potion Bottle) patrols, so has no point.
RegisterStep(71, 85477, { -- Tanaris
    [63105202] = {npc=228262, note="Give the Well-Worn Almanac. By the fences near the Mount Mania stage."}, -- Farmer Yoon
    [62264984] = {npc=228247, note="Give the Tiny Mechanical Mouse. Patrols by the toy stall."}, -- Oglethorpe Obnoticus
    [63495215] = {npc=228249, note="Give the Crude Ivory Locket. In line at the bar to the right of the Story Time stage."}, -- Mankrik
    [63395181] = {npc=228251, note="Give the Jade Amulet. By the fences near the Mount Mania stage."}, -- John J. Keeshan
}, {
    achievement=40871, criteria=70453, -- The Case of Missing Mementos
    atlas="questobjective",
    requires=GUEST,
})

-- Battle Pet Bingo
local bingo = {achievement=40871, criteria=69851, parent=true, requires=GUEST} -- The Case of Pet Games
RegisterStep(371, 84469, { -- The Jade Forest
    [64068076] = {label="Jumping Spider", note="By some bamboo east of Pearlfin Village"},
}, bingo)
RegisterStep(379, 84469, { -- Kun-Lai Summit
    [44435251] = {label="Summit Kid", note="At the top of Mount Neverest"},
}, bingo)

-- The Show Must Go On
-- Don't carry a Torch of Pyrreth or use the Idol of Ohn'ahra in the theater.
RegisterStep(1565, 84912, { -- Ardenweald
    [41244280] = {loot={229383}, inbag=229383, note="Backstage, on a table with a pink lamp and a cup"}, -- Play Script
    [42224671] = {loot={229384}, inbag=229384, note="In the audience, under the Winter Queen's throne"}, -- Prop Sword
    [41174373] = {loot={229385}, inbag=229385, note="Behind the main stage, to the right of a pink lamp"}, -- Mask of the Trickster
    [43294646] = {loot={229386}, inbag=229386, note="Behind the audience, on the floor next to the drum"}, -- Conductor's Baton
}, {
    achievement=40871, criteria=70456, -- The Case of Staged Disaster
    requires=GUEST,
})
})
