--[[
death_messages - A Minetest mod which sends a chat message when a player dies.
Copyright (C) 2016  EvergreenTree

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
--]]

--------------------------------------------------------------------------------
local title = "Death Messages"
local version = "0.1.4"
local mname = "death_messages"
local S = minetest.get_translator("death_messages")
--------------------------------------------------------------------------------
dofile(minetest.get_modpath("death_messages").."/settings.txt")
--------------------------------------------------------------------------------

-- A table of quips for death messages.  The first item in each sub table is the
-- default message used when RANDOM_MESSAGES is disabled.
local messages = {}

-- Lava death messages
messages.lava = {
    S("%s melted into a ball of fire."),
    S("%s thought lava was cool."),
    S("%s melted into a ball of fire."),
    S("%s couldn't resist that warm glow of lava."),
    S("%s dug straight down."),
    S("%s didn't know lava was hot.")
}

-- Drowning death messages
messages.water = {
    S("%s drowned."),
    S("%s ran out of air."),
    S("%s failed at swimming lessons."),
    S("%s tried to impersonate an anchor."),
    S("%s forgot they aren't a fish."),
    S("%s blew one too many bubbles.")
}

-- Burning death messages
messages.fire = {
    S("%s burned to a crisp."),
    S("%s got a little too warm."),
    S("%s got too close to the camp fire."),
    S("%s just got roasted, hotdog style."),
    S("%s got burned up. More light that way.")
}

-- Other death messages
messages.other = {
    S("%s died."),
    S("%s did something fatal."),
    S("%s gave up on life."),
    S("%s is somewhat dead now."),
    S("%s passed out -permanently.")
}

function get_message(mtype)
    if RANDOM_MESSAGES then
        return messages[mtype][math.random(1, #messages[mtype])]
    else
        return messages[1] -- 1 is the index for the non-random message
    end
end

minetest.register_on_dieplayer(function(player)
    local cadaver_name = player:get_player_name()
    local node = minetest.registered_nodes[
        minetest.get_node(player:getpos()).name
    ]
    if minetest.is_singleplayer() then
        cadaver_name = S("You")
    end

 -- Death by something else
    local msg = get_message("other")
    -- Death by lava
    if node.groups.lava ~= nil then
        msg = get_message("lava")
    -- Death by drowning
    elseif player:get_breath() == 0 then
        msg = get_message("water")
    -- Death by fire
    elseif node.name == "fire:basic_flame" then
        msg = get_message("fire")
    end

    for _, player in ipairs(minetest.get_connected_players()) do
        local ricevee_name = player:get_player_name()
        local info = minetest.get_player_information(ricevee_name)
        local lang = (info and info.lang_code) or "en"
        local translated_msg = minetest.get_translated_string(lang, msg)

        if ricevee_name then
            minetest.chat_send_player(ricevee_name, translated_msg:gsub("%%s", cadaver_name))
        end
    end
end)

--------------------------------------------------------------------------------
print("[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...")
--------------------------------------------------------------------------------
