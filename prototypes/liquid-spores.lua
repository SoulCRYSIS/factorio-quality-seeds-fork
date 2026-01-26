
local spore_tower = table.deepcopy(data.raw["assembling-machine"]["biochamber"])
spore_tower.name = "spore-tower"
spore_tower.type = "furnace"
spore_tower.icon = "__quality-seeds__/graphics/icons/spore-tower.png"
spore_tower.minable.result = "spore-tower"
spore_tower.energy_usage = "1kW"
spore_tower.ingredient_count = 1
spore_tower.result_inventory_size = 0
spore_tower.source_inventory_size = 0
spore_tower.cant_insert_at_source_message_key = "That is not spores."
spore_tower.effect_receiver = {} -- Remove the added productivity of the biochamber.
spore_tower.forced_symmetry = "horizontal"
spore_tower.graphics_set = {
  animation =
  {
    layers =
    {
      util.sprite_load("__quality-seeds__/graphics/entity/spore-tower",
      {
        animation_speed = animation_speed,
        frame_count = 1,
        repeat_count = 64,
        scale = 0.5,
      }),
      util.sprite_load("__space-age__/graphics/entity/biochamber/biochamber-animation",
      {
        animation_speed = animation_speed,
        frame_count = 64,
        scale = 0.5,
      }),
      util.sprite_load("__space-age__/graphics/entity/biochamber/biochamber-shadow",
      {
        draw_as_shadow = true,
        animation_speed = animation_speed,
        frame_count = 1,
        repeat_count = 64,
        scale = 0.5,
      })
    }
  },
  frozen_patch = util.sprite_load("__space-age__/graphics/entity/biochamber/biochamber-frozen", {scale = 0.5}),
  working_visualisations =
  {
    {
      animation = util.sprite_load("__space-age__/graphics/entity/biochamber/biochamber-status-lamp",
        {
          priority = "extra-high",
          frame_count = 1,
          repeat_count = 64,
          animation_speed = animation_speed,
          blend_mode = "additive",
          draw_as_glow = true,
          scale = 0.5
        }
      )
    },
    {
      fadeout = true,
      apply_recipe_tint = "secondary",
      effect = "flicker",
      animation = util.sprite_load("__space-age__/graphics/entity/biochamber/biochamber-glow-2",
        {
          priority = "extra-high",
          frame_count = 64,
          animation_speed = animation_speed,
          blend_mode = "additive",
          draw_as_glow = true,
          scale = 0.5
        }
      )
    },
    {
      effect = "flicker",
      fadeout = true,
      apply_recipe_tint = "primary",
      light = {intensity = 0.5, size = 17, shift = {-0.5, 0}, color = {r = 1, g = 1, b = 1}}
    }
  }
}
spore_tower.crafting_speed = 1
spore_tower.crafting_categories = {"spore-releasing"}
--spore_tower.fluid_usage_per_tick = 50.0 -- 0.05 * 60 * 60 = 180 / minute.
spore_tower.energy_source = {
    type = "electric",
    usage_priority = "secondary-input",
    emissions_per_minute = { spores = 60 },
    light_flicker = require("__space-age__.prototypes.entity.biochamber-pictures").light_flicker,
    smoke =
    {
      {
        name = "smoke",
        frequency = 10,
        position = {0.7, -1.2},
        starting_vertical_speed = 0.08,
        starting_frame_deviation = 60
      }
    }
}

local pipe_pictures_1 = table.deepcopy(require("__space-age__.prototypes.entity.biochamber-pictures").pipe_pictures_1)
pipe_pictures_1.north.layers[1] = util.sprite_load("__quality-seeds__/graphics/entity/biochamber-pipes-north-1",
{
  scale = 0.5,
  shift = {1,2},
})

spore_tower.fluid_boxes =
{
  {
    production_type = "input",
    pipe_picture =  pipe_pictures_1,
    mirrored_pipe_picture = require("__space-age__.prototypes.entity.biochamber-pictures").pipe_pictures_2,
    mirrored_pipe_picture_frozen = require("__space-age__.prototypes.entity.biochamber-pictures").pipe_pictures_2_frozen,
    pipe_picture_frozen = require("__space-age__.prototypes.entity.biochamber-pictures").pipe_pictures_1_frozen,
    pipe_covers = pipecoverspictures(),
    volume = 1000,
    filter="spores",
    pipe_connections =
    {
      {
        flow_direction="input",
        direction = defines.direction.south,
        position = {1, 1}
      }
    }
  }
}

local spore_tower_item = table.deepcopy(data.raw["item"]["biochamber"])
spore_tower_item.name = spore_tower.name
spore_tower_item.place_result = spore_tower.name
spore_tower_item.icon = "__quality-seeds__/graphics/icons/spore-tower.png"
spore_tower_item.order = "a[agricultural-tower]-b[spore-vent]"

local spore_recipe = {
    type = "recipe",
    name = "spore-release",
    category = "spore-releasing",
    enabled = true,
    hidden = true,
    energy_required = 1,
    ingredients =
    {
      {type="fluid", name="spores", amount=100}
    },
    results = {},
    icon = "__quality-seeds__/graphics/icons/spores.png",
    subgroup = "fluid-recipes",
    order = "z[incineration]"
  }

-- Recipe for Spore Tower:
local spore_tower_recipe = {
    type = "recipe",
    name = spore_tower.name,
    energy_required = 20,
    ingredients =
    {
      {type = "item", name = "biochamber", amount = 1},
      {type = "item", name = "heating-tower", amount = 1},
      {type = "item", name = "concrete", amount = 20},
      {type = "item", name = "landfill", amount = 8}
    },
    results = {{type="item", name=spore_tower.name, amount=1}},
    enabled = false,
    icon = "__quality-seeds__/graphics/icons/spore-tower.png"
  }

local spore_fluid = {
    type = "fluid",
    name = "spores",
    localised_name = "Spores",
    localised_description = "These spores created from agricultural processes attract Pentapods if released!",
    subgroup = "fluid",
    default_temperature = 15,
    max_temperature = 100,
    heat_capacity = "2kJ",
    base_color = {0.48, 0.39, 0.14},
    flow_color = {0.77, 0.63, 0.24},
    icon = "__quality-seeds__/graphics/icons/spores.png",
    order = "a[fluid]-b[agriculture]-a[spores]",
    auto_barrel = false
}

data.extend({
    spore_tower,
    spore_tower_item,
    spore_fluid,
    spore_tower_recipe,
    spore_recipe,
    {
        type = "recipe-category",
        name = "spore-releasing"
    },
})