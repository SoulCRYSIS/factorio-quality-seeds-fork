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