/datum/loadout_item/feet/chaos_boots
	name = "Combat shoes"
	desc = "Shoes with origins dating back to the old mining colonies. These were made for more than just walking."
	item_typepath = /obj/item/clothing/shoes/guardsman/chaos/knife
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_CORPSMAN, CHAOS_SQUAD_ENGINEER, CHAOS_SQUAD_VETERAN, CHAOS_SQUAD_LEADER, CHAOS_FIELD_COMMANDER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/feet/chaos_officer
	name = "officer's boots"
	desc = "A shiny pair of boots, normally seen on the feet of CHAOS officers."
	item_typepath = /obj/item/clothing/shoes/guardsmanchief/chaos
	jobs_supported = list(CHAOS_STAFF_OFFICER, CHAOS_COMMANDER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE
