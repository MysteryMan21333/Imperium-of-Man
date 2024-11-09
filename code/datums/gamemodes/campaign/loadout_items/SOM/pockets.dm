/datum/loadout_item/r_pocket/chaos_standard_first_aid
	name = "First aid pouch"
	desc = "Standard CHAOS first-aid pouch. Contains a basic set of medical supplies."
	ui_icon = "medkit"
	item_typepath = /obj/item/storage/pouch/firstaid/chaos/combat_patrol
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_VETERAN)

/datum/loadout_item/r_pocket/chaos_standard_first_aid/standard_improved
	desc = "Standard CHAOS first-aid pouch. Contains a improved set of medical supplies."
	item_typepath = /obj/item/storage/pouch/firstaid/chaos/combat_patrol_leader
	loadout_item_flags = null

/datum/loadout_item/r_pocket/chaos_standard_first_aid/improved
	desc = "Standard CHAOS first-aid pouch. Contains a improved set of medical supplies."
	item_typepath = /obj/item/storage/pouch/firstaid/chaos/combat_patrol_leader
	jobs_supported = list(CHAOS_SQUAD_LEADER, CHAOS_FIELD_COMMANDER)

/datum/loadout_item/r_pocket/chaos_support_grenades
	name = "Support nades"
	desc = "A pouch carrying a set of six standard support grenades. Includes smoke grenades of both lethal and nonlethal varieties, as well as stun grenades."
	ui_icon = "grenade"
	item_typepath = /obj/item/storage/pouch/grenade/chaos/combat_patrol
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_CORPSMAN, CHAOS_SQUAD_VETERAN, CHAOS_SQUAD_LEADER, CHAOS_FIELD_COMMANDER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/r_pocket/chaos_standard_grenades
	name = "Standard nades"
	desc = "A pouch carrying a set of six standard offensive grenades. Contains HE and incendiary grenades."
	ui_icon = "grenade"
	item_typepath = /obj/item/storage/pouch/grenade/chaos/standard
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_CORPSMAN, CHAOS_SQUAD_VETERAN, CHAOS_SQUAD_LEADER, CHAOS_FIELD_COMMANDER)

/datum/loadout_item/r_pocket/chaos_emp_grenades
	name = "EMP nades"
	desc = "A pouch carrying a set of six EMP grenades. Effective against electronic systems including mechs."
	purchase_cost = 30
	ui_icon = "grenade"
	item_typepath = /obj/item/storage/pouch/grenade/chaos/emp
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_CORPSMAN, CHAOS_SQUAD_VETERAN, CHAOS_SQUAD_LEADER, CHAOS_FIELD_COMMANDER)

/datum/loadout_item/r_pocket/war_crime_grenades
	name = "Warcrime nades"
	desc = "A pouch carrying a set of rad and satrapine grenades. Extremely hazardous."
	ui_icon = "grenade"
	req_desc = "Requires a suit with a Mithridatius environmental protection module."
	item_typepath = /obj/item/storage/pouch/grenade/chaos
	jobs_supported = list(CHAOS_SQUAD_VETERAN)
	item_whitelist = list(/obj/item/clothing/suit/modular/chaos/heavy/mithridatius = ITEM_SLOT_OCLOTHING)

/datum/loadout_item/r_pocket/war_crime_grenades/post_equip(mob/living/carbon/human/wearer, datum/outfit/quick/loadout, datum/outfit_holder/holder)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/satrapine, SLOT_IN_R_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/satrapine, SLOT_IN_R_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/satrapine, SLOT_IN_R_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/grenade/rad, SLOT_IN_R_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/grenade/rad, SLOT_IN_R_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/grenade/rad, SLOT_IN_R_POUCH)

/datum/loadout_item/r_pocket/chaos_shotgun
	name = "Buckshot shells"
	desc = "A pouch specialized for holding shotgun ammo. Contains buckshot shells."
	ui_icon = "grenade"
	item_typepath = /obj/item/storage/pouch/shotgun/chaos
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_VETERAN, CHAOS_SQUAD_LEADER)

/datum/loadout_item/r_pocket/chaos_shotgun/post_equip(mob/living/carbon/human/wearer, datum/outfit/quick/loadout, datum/outfit_holder/holder)
	wearer.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/buckshot, SLOT_IN_R_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/buckshot, SLOT_IN_R_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/buckshot, SLOT_IN_R_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/buckshot, SLOT_IN_R_POUCH)

/datum/loadout_item/r_pocket/chaos_construction
	name = "Construction pouch"
	desc = "A pouch containing an assortment of construction supplies. Allows for the rapid establishment of fortified positions."
	ui_icon = "materials"
	item_typepath = /obj/item/storage/pouch/construction/chaos
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_VETERAN, CHAOS_SQUAD_LEADER)

/datum/loadout_item/r_pocket/chaos_construction/post_equip(mob/living/carbon/human/wearer, datum/outfit/quick/loadout, datum/outfit_holder/holder)
	wearer.equip_to_slot_or_del(new /obj/item/tool/shovel/etool, SLOT_IN_R_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/stack/sandbags_empty/half, SLOT_IN_R_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/stack/sandbags/large_stack, SLOT_IN_R_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/stack/barbed_wire/full, SLOT_IN_R_POUCH)

/datum/loadout_item/r_pocket/chaos_magazine
	name = "Mag pouch-P"
	desc = "A pouch containing three ammo magazines. Will contain a primary ammo type where applicable."
	ui_icon = "grenade"
	item_typepath = /obj/item/storage/pouch/magazine/large/chaos
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_CORPSMAN, CHAOS_SQUAD_VETERAN, CHAOS_SQUAD_LEADER, CHAOS_FIELD_COMMANDER)
	item_blacklist = list(
		/obj/item/weapon/gun/rifle/chaos_mg/standard = ITEM_SLOT_SUITSTORE,
		/obj/item/weapon/twohanded/fireaxe/chaos = ITEM_SLOT_SUITSTORE,
		/obj/item/weapon/gun/flamer/chaos/mag_harness = ITEM_SLOT_SUITSTORE,
		/obj/item/weapon/gun/shotgun/chaos/standard = ITEM_SLOT_SUITSTORE,
		/obj/item/weapon/gun/shotgun/chaos/support = ITEM_SLOT_SUITSTORE,
	)

/datum/loadout_item/r_pocket/chaos_tools
	name = "Tool pouch"
	desc = "It's designed to hold maintenance tools - screwdriver, wrench, cable coil, etc. It also has a hook for an entrenching tool."
	ui_icon = "construction"
	item_typepath = /obj/item/storage/pouch/tools/chaos/full
	jobs_supported = list(CHAOS_SQUAD_ENGINEER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/r_pocket/chaos_general
	name = "General pouch"
	desc = "A general purpose pouch used to carry small items."
	ui_icon = "grenade"
	item_typepath = /obj/item/storage/pouch/general/chaos
	jobs_supported = list(CHAOS_STAFF_OFFICER, CHAOS_COMMANDER)

//l_pocket
/datum/loadout_item/l_pocket/chaos_standard_first_aid
	name = "First aid pouch"
	desc = "Standard CHAOS first-aid pouch. Contains a basic set of medical supplies."
	ui_icon = "medkit"
	item_typepath = /obj/item/storage/pouch/firstaid/chaos/combat_patrol
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_ENGINEER, CHAOS_SQUAD_VETERAN)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/l_pocket/chaos_standard_first_aid/standard_improved
	desc = "Standard CHAOS first-aid pouch. Contains a improved set of medical supplies."
	item_typepath = /obj/item/storage/pouch/firstaid/chaos/combat_patrol_leader
	loadout_item_flags = null

/datum/loadout_item/l_pocket/chaos_standard_first_aid/improved
	desc = "Standard CHAOS first-aid pouch. Contains a improved set of medical supplies."
	item_typepath = /obj/item/storage/pouch/firstaid/chaos/combat_patrol_leader
	jobs_supported = list(CHAOS_SQUAD_LEADER, CHAOS_FIELD_COMMANDER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/l_pocket/chaos_support_grenades
	name = "Support nades"
	desc = "A pouch carrying a set of six standard support grenades. Includes smoke grenades of both lethal and nonlethal varieties, as well as stun grenades."
	ui_icon = "grenade"
	item_typepath = /obj/item/storage/pouch/grenade/chaos/combat_patrol
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_CORPSMAN, CHAOS_SQUAD_ENGINEER, CHAOS_SQUAD_VETERAN, CHAOS_SQUAD_LEADER, CHAOS_FIELD_COMMANDER)

/datum/loadout_item/l_pocket/chaos_standard_grenades
	name = "Standard nades"
	desc = "A pouch carrying a set of six standard offensive grenades. Contains HE and incendiary grenades."
	ui_icon = "grenade"
	item_typepath = /obj/item/storage/pouch/grenade/chaos/standard
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_CORPSMAN, CHAOS_SQUAD_ENGINEER, CHAOS_SQUAD_VETERAN, CHAOS_SQUAD_LEADER, CHAOS_FIELD_COMMANDER)

/datum/loadout_item/l_pocket/chaos_emp_grenades
	name = "EMP nades"
	desc = "A pouch carrying a set of six EMP grenades. Effective against electronic systems including mechs."
	purchase_cost = 30
	ui_icon = "grenade"
	item_typepath = /obj/item/storage/pouch/grenade/chaos/emp
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_CORPSMAN, CHAOS_SQUAD_VETERAN, CHAOS_SQUAD_LEADER, CHAOS_FIELD_COMMANDER)

/datum/loadout_item/l_pocket/war_crime_grenades
	name = "Warcrime nades"
	desc = "A pouch carrying a set of rad and satrapine grenades. Extremely hazardous."
	ui_icon = "grenade"
	req_desc = "Requires a suit with a Mithridatius environmental protection module."
	item_typepath = /obj/item/storage/pouch/grenade/chaos
	jobs_supported = list(CHAOS_SQUAD_VETERAN)
	item_whitelist = list(/obj/item/clothing/suit/modular/chaos/heavy/mithridatius = ITEM_SLOT_OCLOTHING)

/datum/loadout_item/l_pocket/war_crime_grenades/post_equip(mob/living/carbon/human/wearer, datum/outfit/quick/loadout, datum/outfit_holder/holder)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/satrapine, SLOT_IN_L_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/satrapine, SLOT_IN_L_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/satrapine, SLOT_IN_L_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/grenade/rad, SLOT_IN_L_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/grenade/rad, SLOT_IN_L_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/grenade/rad, SLOT_IN_L_POUCH)

/datum/loadout_item/l_pocket/chaos_shotgun
	name = "Flechette shells"
	desc = "A pouch specialized for holding shotgun ammo. Contains Flechette shells."
	ui_icon = "grenade"
	item_typepath = /obj/item/storage/pouch/shotgun/chaos
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_CORPSMAN, CHAOS_SQUAD_ENGINEER, CHAOS_SQUAD_VETERAN, CHAOS_SQUAD_LEADER)

/datum/loadout_item/l_pocket/chaos_shotgun/post_equip(mob/living/carbon/human/wearer, datum/outfit/quick/loadout, datum/outfit_holder/holder)
	wearer.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/flechette, SLOT_IN_L_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/flechette, SLOT_IN_L_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/flechette, SLOT_IN_L_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/flechette, SLOT_IN_L_POUCH)

/datum/loadout_item/l_pocket/chaos_construction
	name = "Construction pouch"
	desc = "A pouch containing an assortment of construction supplies. Allows for the rapid establishment of fortified positions."
	ui_icon = "materials"
	item_typepath = /obj/item/storage/pouch/construction/chaos
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_VETERAN, CHAOS_SQUAD_LEADER)

/datum/loadout_item/l_pocket/chaos_construction/post_equip(mob/living/carbon/human/wearer, datum/outfit/quick/loadout, datum/outfit_holder/holder)
	wearer.equip_to_slot_or_del(new /obj/item/tool/shovel/etool, SLOT_IN_L_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/stack/sandbags_empty/half, SLOT_IN_L_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/stack/sandbags/large_stack, SLOT_IN_L_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/stack/barbed_wire/full, SLOT_IN_L_POUCH)

/datum/loadout_item/l_pocket/chaos_construction/engineer
	desc = "A pouch containing additional metal, plasteel and barbed wire. Allows for the rapid establishment of fortified positions."
	jobs_supported = list(CHAOS_SQUAD_ENGINEER)

/datum/loadout_item/l_pocket/chaos_construction/engineer/post_equip(mob/living/carbon/human/wearer, datum/outfit/quick/loadout, datum/outfit_holder/holder)
	wearer.equip_to_slot_or_del(new /obj/item/stack/sheet/plasteel/large_stack, SLOT_IN_L_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/large_stack, SLOT_IN_L_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/large_stack, SLOT_IN_L_POUCH)
	wearer.equip_to_slot_or_del(new /obj/item/stack/barbed_wire/full, SLOT_IN_L_POUCH)

/datum/loadout_item/l_pocket/chaos_magazine
	name = "Mag pouch-S"
	desc = "A pouch containing three ammo magazines. Will contain a secondary ammo type where applicable."
	ui_icon = "grenade"
	item_typepath = /obj/item/storage/pouch/magazine/large/chaos
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_ENGINEER, CHAOS_SQUAD_VETERAN, CHAOS_SQUAD_LEADER, CHAOS_FIELD_COMMANDER)
	item_blacklist = list(
		/obj/item/weapon/gun/rifle/chaos_mg/standard = ITEM_SLOT_SUITSTORE,
		/obj/item/weapon/twohanded/fireaxe/chaos = ITEM_SLOT_SUITSTORE,
		/obj/item/weapon/gun/flamer/chaos/mag_harness = ITEM_SLOT_SUITSTORE,
		/obj/item/weapon/gun/shotgun/chaos/standard = ITEM_SLOT_SUITSTORE,
	)


/datum/loadout_item/l_pocket/chaos_magazine/medic
	jobs_supported = list(CHAOS_SQUAD_CORPSMAN)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/l_pocket/chaos_general
	name = "General pouch"
	desc = "A general purpose pouch used to carry small items."
	ui_icon = "grenade"
	item_typepath = /obj/item/storage/pouch/general/chaos
	jobs_supported = list(CHAOS_STAFF_OFFICER, CHAOS_COMMANDER)
