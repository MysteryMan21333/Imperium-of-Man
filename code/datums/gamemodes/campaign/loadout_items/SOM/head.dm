/datum/loadout_item/helmet/chaos_standard
	name = "Infantry helmet"
	desc = "The standard combat helmet worn by CHAOS combat troops. Made using advanced polymers to provide very effective protection without compromising visibility."
	item_typepath = /obj/item/clothing/head/modular/chaos
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/helmet/chaos_standard/medic
	jobs_supported = list(CHAOS_SQUAD_CORPSMAN)

/datum/loadout_item/helmet/chaos_standard/medic/post_equip(mob/living/carbon/human/wearer, datum/outfit/quick/loadout, datum/outfit_holder/holder)
	wearer.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/russian_red, SLOT_IN_HEAD)
	wearer.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/russian_red, SLOT_IN_HEAD)

/datum/loadout_item/helmet/chaos_veteran
	name = "Veteran helmet"
	desc = "The standard combat helmet worn by CHAOS combat specialists. State of the art materials provides more protection for more valuable brains."
	item_typepath = /obj/item/clothing/head/modular/chaos/veteran
	jobs_supported = list(CHAOS_SQUAD_VETERAN)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/helmet/gorgon
	name = "Gorgon helmet"
	desc = "Made for use with Gorgon pattern assault armor, providing superior protection. Typically seen on CHAOS leaders or their most elite combat units."
	item_typepath = /obj/item/clothing/head/modular/chaos/leader
	jobs_supported = list(CHAOS_SQUAD_LEADER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/helmet/gorgon/fc
	name = "Gorgon helmet"
	desc = "Made for use with Gorgon pattern assault armor, providing superior protection. This one has gold markings indicating it belongs to a high ranking field officer."
	item_typepath = /obj/item/clothing/head/modular/chaos/leader/officer
	jobs_supported = list(CHAOS_FIELD_COMMANDER)

/datum/loadout_item/helmet/chaos_surt
	name = "Hades Helmet"
	desc = "A standard combat helmet with a Hades fireproof module."
	req_desc = "Requires a suit with a Hades module."
	item_typepath = /obj/item/clothing/head/modular/chaos/hades
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN)
	item_whitelist = list(/obj/item/clothing/suit/modular/chaos/heavy/pyro = ITEM_SLOT_OCLOTHING)

/datum/loadout_item/helmet/chaos_tyr
	name = "Lorica Helmet"
	desc = "A bulky helmet paired with the 'Lorica' armor module, designed for outstanding protection at the cost of significant weight and reduced flexibility. \
	Substantial additional armor improves protection against all damage."
	req_desc = "Requires a suit with a Lorica module."
	ui_icon = "lorica"
	item_typepath = /obj/item/clothing/head/modular/chaos/lorica
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_VETERAN)
	item_whitelist = list(
		/obj/item/clothing/suit/modular/chaos/heavy/lorica = ITEM_SLOT_OCLOTHING,
		/obj/item/clothing/suit/modular/chaos/heavy/lorica/medic = ITEM_SLOT_OCLOTHING,
		/obj/item/clothing/suit/modular/chaos/heavy/lorica/engineer = ITEM_SLOT_OCLOTHING,
	)

/datum/loadout_item/helmet/chaos_tyr/medic
	jobs_supported = list(CHAOS_SQUAD_CORPSMAN)
	loadout_item_flags = NONE

/datum/loadout_item/helmet/chaos_tyr/medic/post_equip(mob/living/carbon/human/wearer, datum/outfit/quick/loadout, datum/outfit_holder/holder)
	wearer.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/russian_red, SLOT_IN_HEAD)
	wearer.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/russian_red, SLOT_IN_HEAD)

/datum/loadout_item/helmet/chaos_tyr/engineer
	jobs_supported = list(CHAOS_SQUAD_ENGINEER)
	loadout_item_flags = NONE

/datum/loadout_item/helmet/chaos_tyr/engineer/post_equip(mob/living/carbon/human/wearer, datum/outfit/quick/loadout, datum/outfit_holder/holder)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_HEAD)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_HEAD)

/datum/loadout_item/helmet/chaos_tyr/universal
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_CORPSMAN, CHAOS_SQUAD_ENGINEER, CHAOS_SQUAD_VETERAN, CHAOS_SQUAD_LEADER, CHAOS_FIELD_COMMANDER)
	loadout_item_flags = NONE

/datum/loadout_item/helmet/chaos_mimir
	name = "Biohazard helmet"
	desc = "A standard combat helmet with a Mithridatius 'Mith' environmental protection module."
	req_desc = "Requires a suit with a Mithridatius environmental protection module."
	item_typepath = /obj/item/clothing/head/modular/chaos/bio
	jobs_supported = list(CHAOS_SQUAD_VETERAN)
	item_whitelist = list(/obj/item/clothing/suit/modular/chaos/heavy/mithridatius = ITEM_SLOT_OCLOTHING)

/datum/loadout_item/helmet/chaos_engineer
	name = "Engineer helmet"
	desc = "A specialised helmet designed for use by combat engineers. Its main feature being an integrated welding mask."
	item_typepath = /obj/item/clothing/head/modular/chaos/engineer
	jobs_supported = list(CHAOS_SQUAD_ENGINEER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/helmet/chaos_engineer/post_equip(mob/living/carbon/human/wearer, datum/outfit/quick/loadout, datum/outfit_holder/holder)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_HEAD)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_HEAD)
