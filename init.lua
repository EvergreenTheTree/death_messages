-----------------------------------------------------------------------------------------------
local title	= "Death Messages"
local version = "0.1"
local mname	= "death_messages"
-----------------------------------------------------------------------------------------------

minetest.register_on_dieplayer(function(player)
	-- Death by lava
	if minetest.get_node(player:getpos(name)).name == "default:lava_source" or minetest.get_node(player:getpos(name)).name == "default:lava_flowing" then
		minetest.chat_send_all(player:get_player_name().." melted into a ball of fire.")
	-- Death by drowning
	elseif minetest.get_node(player:getpos(name)).name == "default:water_source" or minetest.get_node(player:getpos(name)).name == "default:water_flowing" then
		minetest.chat_send_all(player:get_player_name().." ran out of air.")
	--Death by fire
	elseif minetest.get_node(player:getpos(name)).name == "fire:basic_flame" then
		minetest.chat_send_all(player:get_player_name().." burned up.")
	--Death by something else
	else
		minetest.chat_send_all(player:get_player_name().." died.")
	end
end)

-----------------------------------------------------------------------------------------------
print("[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...")
-----------------------------------------------------------------------------------------------
