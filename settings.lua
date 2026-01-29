data.extend({
    {
        type = "bool-setting",
        name = "balanced-seeds-mode",
        localised_name = "Balanced Cultivation",
        localised_description = "Cultivator outputs are cut to 30% of their original value such that it is harder to replenish the seeds without a full productivity bonus.",
        setting_type = "startup",
        default_value = true
    },
    {
        type = "bool-setting",
        name = "cultivators-anywhere",
        localised_name = "Freeplace Cultivators",
        localised_description = "Too many harvestable plants can lead to too many collision masks for cultivator placement. Turn this on before adding those extra mods to save on collision layers. Or if you want to place cultivators anywhere!",
        setting_type = "startup",
        default_value = false
    },
    {
        type = "bool-setting",
        name = "default-all-plants-cultivation",
        localised_name = "Create cultivators for every plant",
        localised_description = "If enabled, mod will create cultivators for every plant. Disable this to avoid compatibility issues with other mods.",
        setting_type = "startup",
        default_value = false
    }
})