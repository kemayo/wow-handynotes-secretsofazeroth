local myname, ns = ...

ns.overlayTexture = 4419345 -- icon for Whodunnit?

ns.hiddenConfig = {}

ns.defaults.profile.groupsHidden = {
}

ns.defaults.profile.achievementsHidden = {
}

-- ns.groups["junk"] = BAG_FILTER_JUNK

--[[
Tools of the Trade: 18645
Whodunnit?: 18646
Community Rumors: 18643

--]]

-- Mimiron's Jumpjets:
ns.RegisterPoints(77, { -- Felwood
    [44202850] = {label="The Sixth Clue",},
    [49892630] = {label="Mimiron's Booster Part", quest=nil, loot={209781}}, -- Second Booster Part
})
ns.RegisterPoints(17, { -- Blasted Lands
    [55864173] = {label="Mimiron's Booster Part", quest=78100, loot={209055}}, -- Third Booster Part
})
