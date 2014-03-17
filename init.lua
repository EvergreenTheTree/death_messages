-----------------------------------------------------------------------------------------------
local title	= "Death Messages"
local version = "0.1"
local mname	= "death_messages"
-----------------------------------------------------------------------------------------------

minetest.register_on_dieplayer(function(player)
	local player_name = player:get_player_name()
	if minetest.is_singleplayer() then
		player_name = "You"
	end
	-- Death by lava
	local nodename = minetest.get_node(player:getpos()).name
	if nodename == "default:lava_source" or nodename == "default:lava_flowing" then
		minetest.chat_send_all(player_name .. " melted into a ball of fire.")
	-- Death by drowning
	elseif nodename == "default:water_source" or nodename == "default:water_flowing" then
		minetest.chat_send_all(player_name .. " ran out of air.")
	--Death by fire
	elseif nodename == "fire:basic_flame" then
		minetest.chat_send_all(player_name .. " burned up.")
	--Death by something else
	else
		minetest.chat_send_all(player_name .. " died.")
	end

end)

-----------------------------------------------------------------------------------------------
print("[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...")
-----------------------------------------------------------------------------------------------
