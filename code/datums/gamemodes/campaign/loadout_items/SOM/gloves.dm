/datum/loadout_item/gloves/chaos_gloves
	name = "CHAOS gloves"
	desc = "Gloves with origins dating back to the old mining colonies, they look pretty tough."
	item_typepath = /obj/item/clothing/gloves/guardsman/chaos
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_CORPSMAN)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/gloves/chaos_veteran_gloves
	name = "Veteran gloves"
	desc = "Gloves with origins dating back to the old mining colonies. These ones seem tougher than normal."
	item_typepath = /obj/item/clothing/gloves/guardsman/chaos/veteran
	jobs_supported = list(CHAOS_SQUAD_VETERAN, CHAOS_SQUAD_LEADER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/gloves/chaos_insulated
	name = "Insulated gloves"
	desc = "Gloves with origins dating back to the old mining colonies. These ones appear to have an electrically insulating layer built into them."
	item_typepath = /obj/item/clothing/gloves/guardsman/chaos/insulated
	jobs_supported = list(CHAOS_SQUAD_ENGINEER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/gloves/chaos_officer_gloves
	name = "Officer gloves"
	desc = "Black gloves commonly worn by CHAOS officers."
	item_typepath = /obj/item/clothing/gloves/guardsman/chaos/officer
	jobs_supported = list(CHAOS_FIELD_COMMANDER, CHAOS_STAFF_OFFICER, CHAOS_COMMANDER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

