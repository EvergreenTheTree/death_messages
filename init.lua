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

-----------------------------------------------------------------------------------------------
local title = "Death Messages"
local version = "0.1.2"
local mname = "death_messages"
-----------------------------------------------------------------------------------------------
dofile(minetest.get_modpath("death_messages").."/settings.txt")
-----------------------------------------------------------------------------------------------

-- A table of quips for death messages.  The first item in each sub table is the
-- default message used when RANDOM_MESSAGES is disabled.
local messages = {}

-- Lava death messages
messages.lava = {
	" melted into a ball of fire.",
	" thought lava was cool.",
	" couldn't resist that warm glow of lava.",
	" dug straight down.",
	" didn't know lava was hot.",
	" dived into a pool of lava and hit their head.",
	"'s goose was cooked.",
	" is now being fed to the Devil!",
	" didn't bring a potion of fire resistance...",
	"! Only $3.99 at Kentucky Fried Miners!",
	", lava was not meant to be swam in."
}

-- Drowning death messages
messages.water = {
	" drowned.",
	" ran out of air.",
	" failed at swimming lessons.",
	" tried to impersonate an anchor.",
	" forgot he wasn't a fish.",
	" blew one too many bubbles.",
	" is sleeping with the fishes.",
	" regrets skipping the swimming lessons.",
	" tried to swim in cement shoes.",
	" took \"our ancestors were fish\" the wrong way.",
	" forgot to wear a life jacket.",
	" went to Davy Jones's locker.",
	" is now soggy.",
	" didn't bring a potion of underwater breathing...",
	" was never a sea creature."
}

-- Burning death messages
messages.fire = {
	" burned to a crisp.",
	" got a little too warm.",
	" got too close to the camp fire.",
	" just got roasted, hotdog style.",
	" gout burned up. More light that way.",
	" spontaneously combusted.",
	"'s goose was cooked.",
	" found out they were highly flammable.",
	" may need some ice for that burn.",
	" tried to make love to a campfire.",
	" walked on hot coals.",
	" was fired.",
	"'s fire eating performance took a turn for the worse.",
	" is now being fed to the Devil!",
	" didn't bring a potion of fire resistance...",
	"! Only $3.99 at Kentucky Fried Miners!"
}

-- Other death messages
messages.other = {
	" died.",
	" did something fatal.",
	" gave up on life.",
	" is somewhat dead now.",
	" passed out -permanently.",
	" got to test the theory of the eternal soul.",
	" wanted to see if reincarnation was true.",
	" is now a candidate for the Darwin Awards.",
	" removed themselves from the gene pool.",
	" bit the dust.",
	" came to a sticky end.",
	" is now dead as a dodo.",
	" kicked the bucket.",
	" was too good for this world.",
	" cashed in their chips.",
	" got rekt m80s",
	' had to say: "Goodbye, cruel world."',
	" isn't gonna be around anymore...",
	"'s body had been knocked out.",
	", YOU DIED, YOU DIED, YOU DIED, YOU DIED, YOU DIED!!",
	" will become featured as a fossil in a natural history museum.",
	" did not survive.",
	" is going to have their funeral.",
	" wasn't prepared for double trouble.",
	" never was worthy.",
	" got too trippy, so they died.",
	" had a bad time.",
	" will be remembered...",
	" let themselves down...",
	" became deceased."
	" went to pieces!",
	" goooooooooooooooooooooooooooooooot dunked on!"
}

function get_message(mtype)
	if RANDOM_MESSAGES then
		return messages[mtype][math.random(1, #messages[mtype])]
	else
		return messages[1] -- 1 is the index for the non-random message
	end
end

minetest.register_on_dieplayer(function(player)
	local player_name = player:get_player_name()
	local node = minetest.registered_nodes[minetest.get_node(player:getpos()).name]
	if minetest.is_singleplayer() then
		player_name = "The player"
	end
	-- Death by lava
	if node.groups.lava ~= nil then
		minetest.chat_send_all(player_name .. get_message("lava"))
	-- Death by drowning
	elseif player:get_breath() == 0 then
		minetest.chat_send_all(player_name .. get_message("water"))
	-- Death by fire
	elseif node.name == "fire:basic_flame" then
		minetest.chat_send_all(player_name .. get_message("fire"))
	-- Death by something else
	else
		minetest.chat_send_all(player_name .. get_message("other"))
	end

end)

-----------------------------------------------------------------------------------------------
print("[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...")
-----------------------------------------------------------------------------------------------
