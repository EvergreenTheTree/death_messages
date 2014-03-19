-----------------------------------------------------------------------------------------------
local title	= "Death Messages"
local version = "0.1.1"
local mname	= "death_messages"
-----------------------------------------------------------------------------------------------


-- A table of quips for death messages

local messages = {}

-- Lava death messages
messages.lava = {
	" thought lava was cool.",
	" melted into a ball of fire.",
	" couldn't resist that warm glow of lava."
}

-- Drowning death messages
messages.water = {
	" ran out of air.",
	" failed at swimming lessons.",
	" tried to impersonate an anchor."
}

-- Burning death messages
messages.fire = {
	" burned to a crisp.",
	" got a little too warm.",
	" got too close to the camp fire."
}

-- Other death messages
messages.other = {
	" did something fatal.",
	" died.",
	" gave up on life."
}


minetest.register_on_dieplayer(function(player)
	local player_name = player:get_player_name()
	if minetest.is_singleplayer() then
		player_name = "You"
	end
	-- Death by lava
	local nodename = minetest.get_node(player:getpos()).name
	if nodename == "default:lava_source" or nodename == "default:lava_flowing" then
		minetest.chat_send_all(player_name ..  messages.lava[math.random(1,#messages.lava)] )
	-- Death by drowning
	elseif nodename == "default:water_source" or nodename == "default:water_flowing" then
		minetest.chat_send_all(player_name ..  messages.water[math.random(1,#messages.water)] )
	--Death by fire
	elseif nodename == "fire:basic_flame" then
		minetest.chat_send_all(player_name ..  messages.fire[math.random(1,#messages.fire)] )
	--Death by something else
	else
		minetest.chat_send_all(player_name ..  messages.other[math.random(1,#messages.other)] )
	end

end)

-----------------------------------------------------------------------------------------------
print("[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...")
-----------------------------------------------------------------------------------------------
