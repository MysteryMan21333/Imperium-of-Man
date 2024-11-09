/datum/loadout_item/uniform
	item_slot = ITEM_SLOT_ICLOTHING

/datum/loadout_item/uniform/empty
	name = "no uniform"
	desc = ""
	ui_icon = "empty"
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE
	jobs_supported = list(
		SQUAD_GUARDSMAN,
		SQUAD_CORPSMAN,
		SQUAD_ENGINEER,
		SQUAD_SMARTGUNNER,
		SQUAD_LEADER,
		FIELD_COMMANDER,
		STAFF_OFFICER,
		CAPTAIN,
		CHAOS_SQUAD_GUARDSMAN,
		CHAOS_SQUAD_CORPSMAN,
		CHAOS_SQUAD_ENGINEER,
		CHAOS_SQUAD_VETERAN,
		CHAOS_SQUAD_LEADER,
		CHAOS_FIELD_COMMANDER,
		CHAOS_STAFF_OFFICER,
		CHAOS_COMMANDER,
	)


/datum/loadout_item/uniform/guardsman_standard
	name = "TDF uniform"
	desc = "A standard-issue, kevlar-weaved, hazmat-tested, EMF-augmented guardsman uniform. You suspect it's not as robust-proof as advertised."
	item_typepath = /obj/item/clothing/under/tdf/black_vest
	jobs_supported = list(SQUAD_GUARDSMAN, SQUAD_SMARTGUNNER, SQUAD_LEADER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/uniform/white_dress
	name = "white dress uniform"
	desc = "A standard-issue Imperium Guardsman Corps white dress uniform. \
	The starch in the fabric chafes a small amount but it pales in comparison to the pride you feel when you first put it on during graduation from boot camp. Doesn't seem to fit perfectly around the waist though."
	item_typepath = /obj/item/clothing/under/guardsman/whites
	jobs_supported = list(SQUAD_GUARDSMAN, SQUAD_CORPSMAN, SQUAD_ENGINEER, SQUAD_SMARTGUNNER, SQUAD_LEADER, FIELD_COMMANDER, STAFF_OFFICER, CAPTAIN)

//corpsman
/datum/loadout_item/uniform/guardsman_corpsman
	name = "corpsman fatigues"
	desc = "A standard-issue, kevlar-weaved, hazmat-tested, EMF-augmented combat corpsman fatigues. You suspect it's not as robust-proof as advertised."
	item_typepath = /obj/item/clothing/under/tdf/medic/corpman_vest
	jobs_supported = list(SQUAD_CORPSMAN)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/uniform/guardsman_corpsman/role_post_equip(mob/living/carbon/human/wearer, datum/outfit/quick/loadout, datum/outfit_holder/holder)
	wearer.equip_to_slot_or_del(new /obj/item/bodybag/cryobag, SLOT_IN_ACCESSORY)
	wearer.equip_to_slot_or_del(new /obj/item/roller, SLOT_IN_ACCESSORY)
	wearer.equip_to_slot_or_del(new /obj/item/tweezers_advanced, SLOT_IN_ACCESSORY)
	wearer.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/advanced/nanoblood, SLOT_IN_ACCESSORY)
	wearer.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/advanced/big/combatmix, SLOT_IN_ACCESSORY)
	wearer.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/advanced/combat_advanced, SLOT_IN_ACCESSORY)

//engineer
/datum/loadout_item/uniform/guardsman_engineer
	name = "Engineer fatigues"
	desc = "A standard-issue, kevlar-weaved, hazmat-tested, EMF-augmented combat engineer fatigues. You suspect it's not as robust-proof as advertised."
	req_desc = "Requires a tool pouch. You ARE an engineer, right?"
	item_typepath = /obj/item/clothing/under/tdf/black_vest
	jobs_supported = list(SQUAD_ENGINEER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

//FC
/datum/loadout_item/uniform/field_commander
	name = "FC uniform"
	desc = "A special-issue, kevlar-weaved, hazmat-tested, EMF-augmented worn by a field-grade officer of the TGMC. You suspect it's not as robust-proof as advertised."
	item_typepath = /obj/item/clothing/under/tdf/black_vest
	jobs_supported = list(FIELD_COMMANDER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

//Staff officer
/datum/loadout_item/uniform/staff_officer
	name = "SO uniform"
	desc = "A standard-issue, kevlar-weaved, hazmat-tested, EMF-augmented staff officer uniform. Do the navy proud."
	item_typepath = /obj/item/clothing/under/guardsman/officer/bridge
	jobs_supported = list(STAFF_OFFICER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

//Captain
/datum/loadout_item/uniform/captain_officer
	name = "Captain uniform"
	desc = "A special-issue, well-ironed, kevlar-weaved, hazmat-tested, EMF-augmented uniform worth of a Imperium Naval Captain. Even looking at it the wrong way could result in being court-martialed."
	item_typepath = /obj/item/clothing/under/guardsman/officer/command
	jobs_supported = list(CAPTAIN)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE
