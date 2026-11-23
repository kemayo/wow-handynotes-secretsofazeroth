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
        npc="{npc:226683}", -- Alyx
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
    end
    ns.RegisterPoints(mapID, points, ns.merge({
        group="Anniversary",
        requires=ns.conditions.All(onquest, ANNIVERSARY),
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
    [63604870] = {label="{npc:227816}", note="Sells a new copy of the book for 100g, if you want to skip the pages", atlas="banker"}, -- Cravitz Lorent
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
    [62354992] = {label="{npc:229811}", atlas="questobjective", note="Choose \"Dead\" then \"Raccoon\""}, -- Breanni
    [63034943] = {label="{npc:229775}", atlas="questobjective", note="Under the Fashion Frenzy stage. Search the nearby Trash Pile first."}, -- Sully "The Pickle" McLeary
}, loud)
RegisterStep(371, 84595, { -- The Jade Forest
    [43366882] = {label="Raccoon grave", parent=true, note="Use the Torch of Pyrreth on the graves. Approach Gizmo slowly when he runs.", path=42136036},
}, loud)

-- Nola's Last Wish
local wish = {
    achievement=40871, criteria=69852, -- The Case of an Old Soul
    parent=true,
    requires=GUEST,
}
RegisterStep(864, 84435, { -- Vol'dun
    [64022607] = {label="Nola's Last Wish", note="Use the Idol of Ohn'ahra near the dead Tortaka Tribesmen"},
    [61602050] = {label="{npc:123063}", note="In Tortaka Refuge", atlas="questobjective"}, -- Elder Kuppaka
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
    [62264984] = {label="{npc:228247}", requires=ns.conditions.Item(231762), note="Give the {item:231762:Tiny Mechanical Mouse}. Patrols by the toy stall."}, -- Oglethorpe Obnoticus
    [63525036] = {label="{npc:228248}", requires=ns.conditions.Item(231763), note="Give the {item:231763:Potion Bottle}. Wanders."}, -- Marin Noggenfogger
    [63495215] = {label="{npc:228249}", requires=ns.conditions.Item(231761), note="Give the {item:231761:Crude Ivory Locket}. In line at the bar to the right of the Story Time stage."}, -- Mankrik
    [63395181] = {label="{npc:228251}", requires=ns.conditions.Item(231764), note="Give the {item:231764:Jade Amulet}. By the fences near the Mount Mania stage."}, -- John J. Keeshan
    [63105202] = {label="{npc:228262}", requires=ns.conditions.Item(231765), note="Give the {item:231765:Well-Worn Almanac}. By the fences near the Mount Mania stage."}, -- Farmer Yoon
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

-- I Saved the Party and All I Got Were These Lousy Hats (40872)

local npc = {atlas="questobjective"}

-- Chapter 1
RegisterStep(71, 84144, { -- Tanaris: Tat Big Meanie
    [62105170] = {label="Red Hair", note="Between the World Boss and Infirmary tents"},
    [62005150] = {label="Historic Tales", note="On the right post of the Infirmary tent"},
    [64005170] = {label="Ratts", note="On a bench by the Story Time stage"},
    [63604790] = {label="Strange Torch", note="Next to the outhouse behind the Fashion Frenzy stage"},
})
RegisterStep(71, {84393, 84363}, { -- Tanaris: Da Stick of Revealing, Tweasure Hunt
    [42107190] = {loot={227790}, note="Use the Amber to spawn a Tanaris Sandworm, which drops it"}, -- Cool Guts
    [40807050] = {loot={227785}, note="The left eye of the giant statue head, north of the Southmoon Ruins"}, -- Jeweled Eye
    [45006450] = {loot={227775}, note="By a half-buried chest, west of the Eastmoon Ruins"}, -- Golden Chalice
    [52204520] = {loot={227777}, note="By the broken pillar, behind Marvon Rivetseeker. Respawns in 30 seconds."}, -- Fragment of an Ancient Statue
})
RegisterStep(71, 84521, { -- Tanaris: Thoughtful Pursuits
    [64205000] = {label="Crystal Ocular Lenses", note="By Isaandrae, the balloon vendor"},
    [63604860] = {label="Thought Calculating Apparatus", note="By the barber shop behind the Fashion Frenzy stage"},
    [61404980] = {label="Downy Helmet Liner", note="Behind Taivan in the Pet Corner"},
})
RegisterStep(71, 84237, { -- Tanaris: The "Great" Detective
    [63905170] = {label="{npc:226796}", note="On a bench by the Story Time stage", atlas="questobjective"}, -- Detective Athelton Jones
    [63805110] = {label="Team Solid", note="Use the Idol of Ohn'ahra, then talk to all three until they have nothing more to say", atlas="questobjective"},
    [65905950] = {label="Abandoned Chair", note="On the beach south of the Caverns of Time"},
    [65904040] = {label="Wavestrider Beach", note="Talk to all the NPCs and use the Torch of Pyrreth on the sand piles. At 96% progress, accuse someone to Jones."},
}, {
    atlas="questobjective"
})
RegisterStep(71, 84278, { -- Tanaris: Tracking Quest
    [68004080] = {label="Goblin Vessel", note="Use the Tricked-Out Thinking Cap by Alyx, then go to (36, 44)", atlas="questobjective"},
})
RegisterStep(114, 84278, { -- Borean Tundra
    [78805360] = {label="Unu'pe Docks", note="Reset your Tricked-Out Thinking Cap here", atlas="questobjective"},
    [77304610] = {label="{npc:226952}", atlas="questobjective"}, -- Rexxar
})
RegisterStep(114, 84296, { -- Borean Tundra: The Trail's Gone Cold
    [85903400] = {label="Fishing Hut", note="One note inside the hut, and one to the left that the Torch of Pyrreth uncovers. Ignore the wisps."},
    [88003460] = {label="Bush", note="The third note"},
})
RegisterStep(119, 84296, { -- Sholazar Basin
    [49703600] = {label="Telescope", note="On top of the Glimmering Pillar"},
})
RegisterStep(118, 84296, { -- Icecrown
    [16005880] = {label="Scrapes's Corpse", note="In Balagarde Fortress. Use the Idol of Ohn'ahra to find it, then the Spirit's Whistle to summon Rexxar."},
})
RegisterStep(71, 84336, { -- Tanaris: Spot the Difference
    [63385230] = {label="{npc:158192}", note="Witness"}, -- Leeroy Jenkins
    [63455167] = {label="{npc:227731}", note="Witness"}, -- Addie Fizzlebog
    [62475194] = {label="{npc:228250}", note="Witness"}, -- Hemet Nesingwary Sr.
    [59946247] = {label="{npc:228663}", note="Southeast of the Bootlegger Outpost flight path. Kill it, then return to Alyx."}, -- Y'lliya Xennin
}, npc)

-- Chapter 2
local toyRescue = {84588, 85025, any=true} -- Operation Toy Rescue
RegisterStep(2024, toyRescue, { -- The Azure Span
    [13424892] = {label="{npc:229847}", note="In Iskaara", atlas="questobjective"}, -- Yennu
})
RegisterStep(2022, toyRescue, { -- The Waking Shores
    [47038352] = {label="Missing Note", note="Inside a cart in the Dragonscale Basecamp"},
})
RegisterStep(2023, toyRescue, { -- Ohn'ahran Plains
    [62003750] = {label="Yennu's Ball", note="In a dirt pile near Maruukai"},
})
RegisterStep(1161, toyRescue, { -- Boralus
    [53977276] = {label="{npc:142044}", note="In Catty Cathy's House in Upton Borough", atlas="questobjective"}, -- Kenshi
    [42037505] = {label="Ball of Yarn", note="By a fenced tree next to the hedge maze in Proudmoore Keep"},
}, {faction="Alliance"})
RegisterStep(1165, toyRescue, { -- Dazar'alor
    [56243168] = {label="{npc:54227}", note="In the Hall of Beasts", atlas="questobjective"}, -- Nuts
    [56222102] = {label="Plush Toy", note="By a tree above a waterfall"},
}, {faction="Horde"})
local toyThief = {84756, 85043, any=true} -- The Toy Thief
RegisterStep(1161, toyThief, { -- Boralus
    [54227281] = {label="{npc:137191}", note="Kenshi's owner"}, -- Catherine Morgan
    [43337248] = {label="{npc:142178}", note="Use the Idol of Ohn'ahra by the tree with the Ball of Yarn to find him. He gives you the Bakar Sketch."}, -- Urban Planner Volrath
}, {faction="Alliance", atlas="questobjective"})
RegisterStep(1165, toyThief, { -- Dazar'alor
    [56203180] = {label="{npc:132103}", note="Next to Nuts", atlas="questobjective"}, -- Matan
    [56992223] = {label="Bakar Sketch", note="Use the Idol of Ohn'ahra by the tree with the Plush Toy"},
}, {faction="Horde"})
RegisterStep(2023, toyThief, { -- Ohn'ahran Plains
    [62794068] = {label="{npc:191269}", atlas="questobjective"}, -- Hearthkeeper Berulan
    [58583965] = {label="{npc:196300}", note="By the western entrance of Maruukai", atlas="questobjective"}, -- Getseng
    [57833173] = {label="Chew Toy", note="Next to some bones by the statue of Ohn'ahra"},
    [39665828] = {label="Toy Box", note="Put the Chew Toy in the box, then hide in the bush. Follow the Bakar Pup."},
    [38275596] = {label="Maru's Toy", note="In the Bakar Pup's hoard, in the cave"},
})

-- Chapter 3
RegisterStep(71, {85047, 85060, 85208, 85503}, { -- Tanaris
    [60894487] = {label="{npc:231413}", note="At the pirate camp north of the celebration"}, -- Bonenose
}, npc)
RegisterStep(210, 85060, { -- Cape of Stranglethorn: Pirate Foods and Superstitions
    [42816897] = {label="{npc:2664}", note="In the Old Port Authority. If Kelsey is dead, talk to Mrs. Gant.", atlas="questobjective"}, -- Kelsey Yance
    [42887283] = {label="Boonful Banquet", note="Under the bunk bed on the bottom level. Then find Scowling Rosa, who patrols the docks."},
})
RegisterStep(170, 85208, { -- Hrothgar's Landing: A Pirate Missive
    [58421417] = {label="The Lone Watcher", note="Reset your Tricked-Out Thinking Cap here, then go to (-12, 10)", atlas="questobjective"},
    [55491063] = {label="Secret Ingredient", note="Ice crystals with a Deep Sea Monsterbelly. You can also buy one from the auction house."},
})

-- Chapter 4
RegisterStep(71, 85476, { -- Tanaris: Buried Tweasure
    [37608412] = {label="Ancient Treasure Map", note="To the right of the chest at the end of the Ruins of Uldum. Use the Idol of Ohn'ahra to find the two ancient toys.", path=37758028},
    [47515649] = {label="Ancient Treasure Note #1", note="Reset your Tricked-Out Thinking Cap by the chest in the Ruins of Uldum, then go to (70, 132)"},
    [38852211] = {label="Ancient Treasure Note #2", note="Behind the Summoning Stone at Zul'Farrak. Uncover it with the Torch of Pyrreth."},
    [52702687] = {label="{npc:232863}", note="In the Gadgetzan inn", atlas="questobjective"}, -- Yennu
})
RegisterStep(71, 85503, { -- Tanaris: A Surprising Investigation
    [63044925] = {label="Impostor: {npc:233007:Reshad}", note="By the Fashion Frenzy stage"},
    [63034986] = {label="Impostor: {npc:233000:Big Kinook}", note="By the Mole Machine next to the Fashion Frenzy stage"},
    [61665105] = {label="Impostor: {npc:233002:Lorewalker Cho}", note="By the ice rink"},
    [61904990] = {label="Impostor: {npc:233006:Maru}", note="By the Pet Corner"},
    [63805176] = {label="Impostor: {npc:233042:Jepetto Joybuzz}", note="By the barrels next to the Story Time seats"},
    [65814176] = {label="Beach Party", note="After the letters and Bonenose"},
}, npc)

-- Celebration Crates: these stay up after the event ends.
-- Crate Insurance Agent (40873) is any six; No Crate Left Behind (40979) is all of them.
local crate = {
    achievement=40979,
    group="Anniversary",
    texture=ns.atlas_texture("VignetteLoot", {r=1, g=1, b=0}),
    minimap=true, parent=true, world=true,
}
ns.RegisterPoints(862, { -- Zuldazar
    [54205420] = {quest=83794, loot={226200}, inbag=226200, note="Buy a Clam Digger from Master Talekeep Nikto, lower in the Dive Bar, and give it to Gerald the conch on the upper level"}, -- Soggy Celebration Crate
}, crate)
ns.RegisterPoints(66, { -- Desolace
    [54005810] = {quest=85574, loot={232263}, inbag=232263, note="Only visible while you're dead"}, -- Hazy Celebration Crate
}, crate)
ns.RegisterPoints(42, { -- Deadwind Pass
    [22438374] = {
        quest=84470, loot={228322}, inbag=228322, note="Deep in the Karazhan Crypts. Go down the spiral tunnel, then swim to the other side.",
        path={22678363, 25788172, 30598114, 34557571, 35597512, 36007455, 36267384, 36337300, 35797157, 34917054, 34277055, 34827025, 35106980, 35746915, 36346989, 36407049, 35587373, 36097388, 38697233, 39227210, 39777212, 39847363}
    }, -- Dirt-Caked Celebration Crate
}, crate)
ns.RegisterPoints(64, { -- Thousand Needles
    [64908440] = {quest=84624, loot={228767, 228768}, inbag=228768, note="In the back of a silithid cave at the Rustmaul Dig Site. Take it to Vashti the Wandering Merchant, who patrols the eastern road in Azsuna; he sells the Sandy Celebration Crate.", path=66308620}, -- Water-Resistant Receipt, Sandy Celebration Crate
}, crate)
ns.RegisterPoints(117, { -- Howling Fjord
    [29400636] = {quest=83931, loot={226375}, inbag=226375, note="In a cave on the border with Grizzly Hills"}, -- Battered Celebration Crate
}, crate)
ns.RegisterPoints(71, { -- Tanaris
    [69186860] = {quest=84426, loot={228212}, inbag=228212, note="Underwater, on the second floor of the larger gnomish building"}, -- Waterlogged Celebration Crate
}, crate)
ns.RegisterPoints(198, { -- Mount Hyjal
    [13603350] = {quest=84767, loot={228976}, inbag=228976, note="Under the trampoline"}, -- Charred Celebration Crate
}, crate)
ns.RegisterPoints(63, { -- Ashenvale
    [47903840] = {quest=85523, label="{spell:463368:Potion of Truth}", note="At the top of Thunder Peak, behind Lord Magmathar. You need its 30-minute buff to see the Mildewed Celebration Crate in Feralas. Fly there yourself; changing continents or taking a flight path removes it."},
}, crate)
ns.RegisterPoints(69, { -- Feralas
    [60423540] = {quest=85523, loot={231886}, inbag=231886, note="In the corridors to Dire Maul. Only visible with the Potion of Truth buff from Ashenvale."}, -- Mildewed Celebration Crate
}, crate)
ns.RegisterPoints(107, { -- Nagrand (Outland)
    [35277473] = {quest=84773, loot={228983}, inbag=228983, note="Inside Oshu'gun, in the middle room of the draenei section", path=35856720}, -- Crystallized Celebration Crate
}, crate)
ns.RegisterPoints(12, { -- Kalimdor; the Ahn'Qiraj: The Fallen Kingdom map coordinates are unreliable
    [40719283] = {quest=84625, loot={228772}, inbag=228772, note="In a cave on the southwest coast of Ahn'Qiraj: The Fallen Kingdom, behind the sleeping dragon. Summon a dog battle pet to dig up the bones.", path=40439312}, -- Mysterious Bones
}, crate)
ns.RegisterPoints(634, { -- Stormheim
    [37394764] = {quest=84625, loot={228770}, inbag=228770, note="At the grave on the cliff above the wrecked warship at the Weeping Bluffs. Use the Mysterious Bones."}, -- Surprisingly Pristine Celebration Crate
}, crate)
ns.RegisterPoints(1536, { -- Maldraxxus
    [49997381] = {quest=84909, loot={229367}, inbag=229367, note="On the top level of the Seat of the Primus, next to the portal"}, -- Ghostly Celebration Crate
}, crate)
