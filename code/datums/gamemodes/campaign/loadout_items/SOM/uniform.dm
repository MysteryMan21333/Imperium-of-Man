/datum/loadout_item/uniform/chaos_standard
	name = "CHAOS uniform"
	desc = "The standard uniform of CHAOS military personnel. Its design shows a clear lineage from mining uniforms used in the old mining colonies."
	item_typepath = /obj/item/clothing/under/chaos/webbing
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/uniform/chaos_veteran
	name = "CHAOS veteran uniform"
	desc = "The standard uniform of CHAOS military personnel. Its design shows a clear lineage from mining uniforms used in the old mining colonies. This one has markings indicating specialist status."
	item_typepath = /obj/item/clothing/under/chaos/veteran/webbing
	jobs_supported = list(CHAOS_SQUAD_VETERAN)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/uniform/chaos_leader
	name = "CHAOS leader uniform"
	desc = "The standard uniform of CHAOS military personnel. Its design shows a clear lineage from mining uniforms used in the old mining colonies. This one has leadership markings."
	item_typepath = /obj/item/clothing/under/chaos/leader/webbing
	jobs_supported = list(CHAOS_SQUAD_LEADER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

//corpsman
/datum/loadout_item/uniform/chaos_medic
	name = "CHAOS medical uniform"
	desc = "The standard uniform of CHAOS military personnel. Its design shows a clear lineage from mining uniforms used in the old mining colonies. This one has medical markings."
	item_typepath = /obj/item/clothing/under/chaos/medic/vest
	jobs_supported = list(CHAOS_SQUAD_CORPSMAN)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/uniform/chaos_medic/role_post_equip(mob/living/carbon/human/wearer, datum/outfit/quick/loadout, datum/outfit_holder/holder)
	wearer.equip_to_slot_or_del(new /obj/item/bodybag/cryobag, SLOT_IN_ACCESSORY)
	wearer.equip_to_slot_or_del(new /obj/item/roller, SLOT_IN_ACCESSORY)
	wearer.equip_to_slot_or_del(new /obj/item/tweezers_advanced, SLOT_IN_ACCESSORY)
	wearer.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/advanced/nanoblood, SLOT_IN_ACCESSORY)
	wearer.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/advanced/big/combatmix, SLOT_IN_ACCESSORY)
	wearer.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/advanced/combat_advanced, SLOT_IN_ACCESSORY)

//engineer
/datum/loadout_item/uniform/chaos_engineer
	name = "CHAOS uniform"
	desc = "The standard uniform of CHAOS military personnel. Its design shows a clear lineage from mining uniforms used in the old mining colonies."
	req_desc = "Requires a tool pouch. You ARE an engineer, right?"
	item_typepath = /obj/item/clothing/under/chaos/webbing
	jobs_supported = list(CHAOS_SQUAD_ENGINEER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/uniform/chaos_field_commander
	name = "Officer uniform"
	desc = "The distinct black uniform befitting a CHAOS field officer."
	item_typepath = /obj/item/clothing/under/chaos/officer/webbing
	jobs_supported = list(CHAOS_FIELD_COMMANDER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/uniform/chaos_officer
	name = "Officer uniform"
	desc = "The distinct black uniform of a CHAOS officer. Usually worn by junior officers."
	item_typepath = /obj/item/clothing/under/chaos/officer
	jobs_supported = list(CHAOS_STAFF_OFFICER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/uniform/chaos_senior_officer
	name = "Officer uniform"
	desc = "The distinct jacketed black uniform of a CHAOS officer. Usually worn by senior officers."
	item_typepath = /obj/item/clothing/under/chaos/officer/senior
	jobs_supported = list(CHAOS_COMMANDER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

