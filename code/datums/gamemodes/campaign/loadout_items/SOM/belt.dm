/datum/loadout_item/belt/chaos
	item_blacklist = list(
		/obj/item/weapon/gun/shotgun/double/sawn = ITEM_SLOT_SECONDARY,
		/obj/item/weapon/energy/sword/chaos = ITEM_SLOT_SECONDARY,
	)


/datum/loadout_item/belt/chaos/ammo_belt
	name = "Ammo belt"
	desc = "A belt with origins traced to the M276 ammo belt and some old colony security. Holds 6 normal sized magazines."
	item_typepath = /obj/item/storage/belt/guardsman/chaos
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_ENGINEER, CHAOS_SQUAD_VETERAN, CHAOS_SQUAD_LEADER, CHAOS_FIELD_COMMANDER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE
	item_blacklist = list(
		/obj/item/weapon/gun/rifle/chaos_mg/standard = ITEM_SLOT_SUITSTORE,
		/obj/item/weapon/twohanded/fireaxe/chaos = ITEM_SLOT_SUITSTORE,
		/obj/item/weapon/gun/flamer/chaos/mag_harness = ITEM_SLOT_SUITSTORE,
		/obj/item/weapon/gun/shotgun/chaos/standard = ITEM_SLOT_SUITSTORE,
		/obj/item/weapon/gun/shotgun/chaos/support = ITEM_SLOT_SUITSTORE,
		/obj/item/weapon/gun/shotgun/double/sawn = ITEM_SLOT_SECONDARY,
		/obj/item/weapon/energy/sword/chaos = ITEM_SLOT_SECONDARY,
	)

/datum/loadout_item/belt/chaos/sparepouch
	name = "Utility pouch"
	desc = "A small, lightweight pouch that can be clipped onto armor or your belt to provide additional storage for miscellaneous gear or box and drum magazines. Made from genuine CHAOS leather."
	item_typepath = /obj/item/storage/belt/sparepouch/chaos
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN)

/datum/loadout_item/belt/chaos/shotgun_mixed
	name = "Shotgun shell rig"
	desc = "An ammunition belt designed to hold shotgun shells or individual bullets. Made with traditional CHAOS leather. Loaded full of buckshot and flechette shells."
	item_typepath = /obj/item/storage/belt/shotgun/chaos/mixed
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN)

/datum/loadout_item/belt/chaos/shotgun_flechette
	name = "Shotgun shell rig"
	desc = "An ammunition belt designed to hold shotgun shells or individual bullets. Made with traditional CHAOS leather. Loaded full of flechette shells."
	item_typepath = /obj/item/storage/belt/shotgun/chaos/flechette
	jobs_supported = list(CHAOS_SQUAD_ENGINEER)

/datum/loadout_item/belt/chaos/grenades
	name = "Grenade rig"
	desc = "A simple harness system available in many configurations. This version is designed to carry bulk quantities of grenades."
	ui_icon = "grenade"
	item_typepath = /obj/item/storage/belt/grenade/chaos
	jobs_supported = list(CHAOS_SQUAD_VETERAN)
	purchase_cost = 80
	quantity = 2

/datum/loadout_item/belt/chaos/grenades/post_equip(mob/living/carbon/human/wearer, datum/outfit/quick/loadout, datum/outfit_holder/holder)
	. = ..()
	wearer.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/chaos, SLOT_IN_BELT)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/chaos, SLOT_IN_BELT)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/satrapine, SLOT_IN_BELT)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/satrapine, SLOT_IN_BELT)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/grenade/flashbang/stun, SLOT_IN_BELT)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/grenade/flashbang/stun, SLOT_IN_BELT)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/grenade/chaos, SLOT_IN_BELT)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/grenade/chaos, SLOT_IN_BELT)
	wearer.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/chaos, SLOT_IN_BELT)

/datum/loadout_item/belt/chaos/pistol_holster
	name = "Pistol holster"
	desc = "A belt with origins dating back to old colony security holster rigs. Holds any pistol secondary, and plenty of ammo."
	ui_icon = "v11"
	item_typepath = /obj/item/storage/holster/belt/pistol/m4a3/chaos
	jobs_supported = list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_CORPSMAN, CHAOS_SQUAD_ENGINEER, CHAOS_SQUAD_VETERAN, CHAOS_SQUAD_LEADER)
	item_whitelist = list(
		/obj/item/weapon/gun/pistol/chaos/standard = ITEM_SLOT_SECONDARY,
		/obj/item/weapon/gun/pistol/chaos/burst = ITEM_SLOT_SECONDARY,
		/obj/item/weapon/gun/pistol/highpower/standard = ITEM_SLOT_SECONDARY,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/serpenta = ITEM_SLOT_SECONDARY,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/serpenta/custom = ITEM_SLOT_SECONDARY,
		/obj/item/storage/backpack/guardsman/engineerpack/chaos = ITEM_SLOT_SECONDARY,
	)
	req_desc = "Requires a pistol secondary."

/datum/loadout_item/belt/chaos/pistol_holster/default
	jobs_supported = list(CHAOS_STAFF_OFFICER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE
/datum/loadout_item/belt/chaos/pistol_holster/officer
	desc = "A quality pistol belt of a style typically seen worn by CHAOS officers. It looks old, but well looked after. Holds any pistol secondary, and plenty of ammo."
	ui_icon = "vx12"
	item_typepath = /obj/item/storage/holster/belt/pistol/m4a3/chaos/fancy
	jobs_supported = list(CHAOS_FIELD_COMMANDER, CHAOS_COMMANDER)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE

/datum/loadout_item/belt/chaos/lifesaver
	name = "S17 lifesaver bag"
	desc = "A belt with heavy origins from the belt used by paramedics and doctors in the old mining colonies."
	ui_icon = "medkit"
	item_typepath = /obj/item/storage/belt/lifesaver/chaos/quick
	jobs_supported = list(CHAOS_SQUAD_CORPSMAN)
	loadout_item_flags = LOADOUT_ITEM_ROUNDSTART_OPTION|LOADOUT_ITEM_DEFAULT_CHOICE
