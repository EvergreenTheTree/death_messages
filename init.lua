-----------------------------------------------------------------------------------------------
local title	= "Death Messages"
local version = "0.1.2"
local mname	= "death_messages"
-----------------------------------------------------------------------------------------------
dofile(minetest.get_modpath("death_messages").."/settings.txt")
-----------------------------------------------------------------------------------------------

-- A table of quips for death messages

local messages = {}

-- Lava death messages
messages.lava = {
	" thought lava was cool.",
	" melted into a ball of fire.",
	" couldn't resist that warm glow of lava.",
	" dug straight down.",
	" didn't know lava was hot."
}

-- Drowning death messages
messages.water = {
	" ran out of air.",
	" failed at swimming lessons.",
	" tried to impersonate an anchor.",
	" forgot he wasn't a fish.",
	" blew one too many bubbles."
}

-- Burning death messages
messages.fire = {
	" burned to a crisp.",
	" got a little too warm.",
	" got too close to the camp fire.",
	" just got roasted , hotdog style.",
	" was set aflame. More light that way."
}

-- Other death messages
messages.other = {
	" did something fatal.",
	" died.",
	" gave up on life.",
	" is somewhat dead now.",
	" passed out -permanently."
}

if RANDOM_MESSAGES == true then
	minetest.register_on_dieplayer(function(player)
		local player_name = player:get_player_name()
		local node = minetest.registered_nodes[minetest.get_node(player:getpos()).name]
		if minetest.is_singleplayer() then
			player_name = "You"
		end
		-- Death by lava
		if node.groups.lava ~= nil then
			minetest.chat_send_all(player_name ..  messages.lava[math.random(1,#messages.lava)] )
		-- Death by drowning
		elseif player:get_breath() == 0 then
			minetest.chat_send_all(player_name ..  messages.water[math.random(1,#messages.water)] )
		-- Death by fire
		elseif node.name == "fire:basic_flame" then
			minetest.chat_send_all(player_name ..  messages.fire[math.random(1,#messages.fire)] )
		-- Death by something else
		else
			minetest.chat_send_all(player_name ..  messages.other[math.random(1,#messages.other)] )
		end

	end)

else
	minetest.register_on_dieplayer(function(player)
		local player_name = player:get_player_name()
		local node = minetest.registered_nodes[minetest.get_node(player:getpos()).name]
		if minetest.is_singleplayer() then
			player_name = "You"
		end
		-- Death by lava
		if node.groups.lava ~= nil then
			minetest.chat_send_all(player_name .. " melted into a ball of fire")
		-- Death by drowning
		elseif player:get_breath() == 0 then
			minetest.chat_send_all(player_name .. " ran out of air.")
		-- Death by fire
		elseif node.name == "fire:basic_flame" then
			minetest.chat_send_all(player_name .. " burned to a crisp.")
		-- Death by something else
		else
			minetest.chat_send_all(player_name .. " died.")
		end

	end)
end

-----------------------------------------------------------------------------------------------
print("[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...")
-----------------------------------------------------------------------------------------------
