script.on_event(defines.events.on_entity_died, function(event)
	local entity = event.entity
	if entity and entity.fluidbox then
		-- Iterate through the fluidbox slots to find the water fluid
		for i = 1, #entity.fluidbox do
			local fluid = entity.fluidbox[i]
			if fluid and fluid.name == "spores" then
				-- Determine the amount of Gleba-specific pollution based on the water amount
				local pollution_amount = fluid.amount / 100
				-- Create pollution at the entity's position using the Gleba pollutant
				entity.surface.pollute(entity.position, pollution_amount)
				break
			end
		end
	end
end)

script.on_event(defines.events.on_player_mined_entity, function(event)
	local entity = event.entity
	if entity and entity.fluidbox then
		-- Iterate through the fluidbox slots to find the water fluid
		for i = 1, #entity.fluidbox do
			local fluid = entity.fluidbox[i]
			if fluid and fluid.name == "spores" then
				-- Determine the amount of Gleba-specific pollution based on the water amount
				local pollution_amount = fluid.amount / 100
				-- Create pollution at the entity's position using the Gleba pollutant
				entity.surface.pollute(entity.position, pollution_amount)
				break
			end
		end
	end
end)

script.on_event(defines.events.on_robot_mined_entity, function(event)
	local entity = event.entity
	if entity and entity.fluidbox then
		-- Iterate through the fluidbox slots to find the water fluid
		for i = 1, #entity.fluidbox do
			local fluid = entity.fluidbox[i]
			if fluid and fluid.name == "spores" then
				-- Determine the amount of Gleba-specific pollution based on the water amount
				local pollution_amount = fluid.amount / 100
				-- Create pollution at the entity's position using the Gleba pollutant
				entity.surface.pollute(entity.position, pollution_amount)
				break
			end
		end
	end
end)

local function check_cultivator_placement(event)
	local entity = event.entity
	if not entity or not entity.valid then return end

	-- Derive plant name
	local entity_name = entity.name
	if entity_name == "entity-ghost" then
		entity_name = entity.ghost_name
	end
	
	local plant_name = string.gsub(entity_name, "%-greenhouse$", "")

	-- Find plant prototype
	local plant_proto = prototypes.entity[plant_name]
	if not plant_proto then
		return
	end

	-- Check tile restrictions
	local autoplace = plant_proto.autoplace_specification
	if not autoplace then
		return
	end

	local tile_restriction = autoplace.tile_restriction
	if not tile_restriction then
		return
	end

	local tile_restriction_map = {}
	for _, tile_name in ipairs(tile_restriction) do
		tile_restriction_map[tile_name.first] = true
		if tile_name.second then
			tile_restriction_map[tile_name.second] = true
		end
	end

	local surface = entity.surface
	-- Check tiles under the entity
	local tiles = surface.find_tiles_filtered { area = entity.bounding_box }

	local valid_placement = true
	for _, tile in pairs(tiles) do
		if not tile_restriction_map[tile.name] then
			valid_placement = false
			break
		end
	end

	if not valid_placement then
		local is_ghost = entity.name == "entity-ghost"
		if event.player_index then
			local player = game.get_player(event.player_index)
			if player then
				player.create_local_flying_text {
					text = { "quality-seeds-error-message.invalid-soil-for-plant", { "entity-name." .. plant_name } },
					create_at_cursor = true,
					color = { r = 1, g = 0, b = 0 },
				}
				if not is_ghost then
					-- Try to return item to cursor or inventory
					local items_to_place = entity.prototype.items_to_place_this
					local item_name = (items_to_place and items_to_place[1] and items_to_place[1].name) or entity.name

					if player.cursor_stack.valid_for_read and player.cursor_stack.name == item_name then
						player.cursor_stack.count = player.cursor_stack.count + 1
					else
						player.insert({ name = item_name, count = 1 })
					end
				end
			end
		elseif not is_ghost then
			-- Robot built
			local items_to_place = entity.prototype.items_to_place_this
			local item_name = (items_to_place and items_to_place[1] and items_to_place[1].name) or entity.name
			surface.spill_item_stack { position = entity.position, stack = { name = item_name, count = 1 }, enable_looted = true, force = entity.force, allow_belts = false }
		end

		entity.destroy()
	end
end

-- Generate filters for cultivators
local build_filters = {}
for name, _ in pairs(prototypes.entity) do
	if string.find(name, "%-greenhouse$") then
		table.insert(build_filters, { filter = "name", name = name })
		table.insert(build_filters, { filter = "ghost_name", name = name })
	end
end

if #build_filters > 0 then
	script.on_event(defines.events.on_built_entity, check_cultivator_placement, build_filters)
	script.on_event(defines.events.on_robot_built_entity, check_cultivator_placement, build_filters)
end
