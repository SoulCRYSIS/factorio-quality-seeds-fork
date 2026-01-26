require ("util")
require ("prototypes.liquid-spores")
require("prototypes.spaceplants")
--Unlock Sciences:
data:extend({
  {
      type = "technology",
      name = "fruit-cultivation",
      icon = "__quality-seeds__/graphics/technology/cultivars.png", -- Path to your tech icon
      icon_size = 256, -- Adjust to match your icon's size
      prerequisites = {"agricultural-science-pack"}, -- Add appropriate prerequisite techs
      unit = {
        count = 2000,
        ingredients =
        {
          {"automation-science-pack",   1},
          {"logistic-science-pack",     1},
          {"chemical-science-pack",     1},
          {"space-science-pack",        1},
          {"agricultural-science-pack", 1}
        },
        time = 60
      },
      effects = {
        {type = "unlock-recipe", recipe = "spore-tower"}
          -- Add more recipes and structures as needed
      },
  },
  {
    type = "technology",
    name = "space-cultivation",
    icon = "__quality-seeds__/graphics/technology/space-cultivars.png", -- Path to your tech icon
    icon_size = 256, -- Adjust to match your icon's size
    prerequisites = {"fruit-cultivation"}, -- Add appropriate prerequisite techs
    unit = {
      count_formula = "4000",
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1},
        {"metallurgic-science-pack", 1},
        {"electromagnetic-science-pack", 1},
        {"agricultural-science-pack", 1},
        {"cryogenic-science-pack", 1},
        {"promethium-science-pack", 1}
      },
      time = 120
    },
    effects = {
      {type = "unlock-recipe", recipe = "space-cultivator"}
        -- Add more recipes and structures as needed
    },
  },
  {
    type = "recipe-category",
    name = "space-cultivation"
  }
})

data.raw["recipe"]["pentapod-egg"].hide_from_signal_gui = false

-- Define the global ignore list if not already defined
quality_seeds = quality_seeds or {}
quality_seeds.ignore_plants = quality_seeds.ignore_plants or {}


if mods["zen-garden"] then
  table.insert(quality_seeds.ignore_plants, "tree-plant-acacia")
  table.insert(quality_seeds.ignore_plants, "tree-plant-willow")
  table.insert(quality_seeds.ignore_plants, "tree-plant-pine")
  table.insert(quality_seeds.ignore_plants, "tree-plant-birch")
  table.insert(quality_seeds.ignore_plants, "tree-plant-elm")
  table.insert(quality_seeds.ignore_plants, "tree-plant-maple")
  table.insert(quality_seeds.ignore_plants, "tree-plant-oak")
  table.insert(quality_seeds.ignore_plants, "tree-plant-juniper")
  table.insert(quality_seeds.ignore_plants, "tree-plant-redwood")
end
