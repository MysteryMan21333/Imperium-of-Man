/datum/loadout_item/ears/chaos_standard
	name = "Standard headset"
	desc = "A headset, allowing for communication with your team and access to the tactical minimap. You're in for a bad time if you don't use this."
	item_typepath = /obj/item/radio/headset/mainship/chaos
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_CORPSMAN, CHAOS_SQUAD_ENGINEER, CHAOS_SQUAD_VETERAN, CHAOS_SQUAD_LEADER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/ears/chaos_command
	name = "Command headset"
	desc = "A command headset, allowing for communication with all squads and access to the tactical minimap. You're in for a bad time if you don't use this."
	item_typepath = /obj/item/radio/headset/mainship/chaos/command
	jobs_supported = list(CHAOS_FIELD_COMMANDER, CHAOS_STAFF_OFFICER, CHAOS_COMMANDER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE
