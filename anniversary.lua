local myname, ns = ...

local ANNIVERSARY = ns.conditions.CalendarEventStartTexture(6238552)

-- Deck Dismay: https://warcraft.wiki.gg/wiki/Deck_Dismay
ns.RegisterPoints(71, { -- Tanaris
    [63204930] = {loot={229199}, inbag=229199, note="On the Fashion Frenzy platform"}, -- Two of Air
    [61205090] = {loot={229225}, inbag=229225, note="By Meerah, Dolly, and Dot"}, -- Four of Earth
    [64005150] = {loot={229207}, inbag=229207, note="Under a bench at the Story Time stage, far left, second from back"}, -- Two of Fire
    [62104930] = {loot={229208}, inbag=229208, note="Behind the outhouse near the portals"}, -- Three of Fire
    [63805190] = {loot={229210}, inbag=229210, note="Between two barrels at the Story Time stage"}, -- Five of Fire
    [63305230] = {loot={229211}, inbag=229211, note="By Leeroy Jenkins"}, -- Six of Fire
    [63404900] = {loot={229212}, inbag=229212, note="Under the Fashion Frenzy platform, by the Black Market Auction House"}, -- Seven of Fire
    [61905160] = {loot={229213}, inbag=229213, note="By Brivelthwerp, the ice cream vendor"}, -- Eight of Fire
    [63605100] = {loot={229216}, inbag=229216, note="On the stairs near the Story Time stage"}, -- Three of Frost
    [63005020] = {loot={229219}, inbag=229219, note="Behind the crate by Alyx"}, -- Six of Frost
}, {
    quest=84882, -- Deck Dismay
    group="Anniversary",
    requires=ANNIVERSARY,
    minimap=true,
})
