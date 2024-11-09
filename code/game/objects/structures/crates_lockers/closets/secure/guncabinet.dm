/obj/structure/closet/secure_closet/guncabinet
	name = "gun cabinet"
	icon = 'modular_imperium/master_files/icons/obj/structures/misc.dmi'
	icon_state = "base"
	icon_off ="base"
	icon_broken ="base"
	icon_locked ="base"
	icon_closed ="base"
	icon_opened = "base"

/obj/structure/closet/secure_closet/guncabinet/Initialize(mapload)
	. = ..()
	update_icon()

/obj/structure/closet/secure_closet/guncabinet/toggle()
	..()
	update_icon()

/obj/structure/closet/secure_closet/guncabinet/update_overlays()
	. = ..()
	if(opened)
		. += image(icon,"door_open")
		return
	. += image(icon,"door")
	if(broken)
		. += image(icon,"broken")
	else if (locked)
		. += image(icon,"locked")
	else
		. += image(icon,"open")


/obj/structure/closet/secure_closet/guncabinet/canterbury
	req_access = list(ACCESS_GUARDSMAN_BRIDGE)


/obj/structure/closet/secure_closet/guncabinet/canterbury/PopulateContents()
	new /obj/item/weapon/gun/shotgun/combat/standardguardsman(src)
	new /obj/item/weapon/gun/rifle/m412(src)
	new /obj/item/weapon/gun/flamer/big_flamer/guardsmanstandard(src)
	new /obj/item/ammo_magazine/flamer_tank/large(src)
	new /obj/item/weapon/gun/smg/m25(src)
	new /obj/item/weapon/gun/revolver/mateba(src)

	var/list/to_spawn = list(
		/obj/item/ammo_magazine/shotgun/incendiary = 2, // Incendiaries are quite rare, soo...
		/obj/item/ammo_magazine/rifle = 3,
		/obj/item/ammo_magazine/smg/m25 = 3,
		/obj/item/clothing/suit/armor/bulletproof = 2, // Synths might make use of it.
		/obj/item/ammo_magazine/revolver/mateba = 2,
	)
	for(var/typepath in to_spawn)
		for(var/i in 1 to to_spawn[typepath])
			new typepath(src)


/obj/structure/closet/secure_closet/guncabinet/nt_lab/PopulateContents()
	new /obj/item/weapon/gun/smg/m25/elite(src)


/obj/structure/closet/secure_closet/guncabinet/pmc_m39/PopulateContents()
	new /obj/item/storage/pouch/magazine/large/pmc_m25(src)
	new /obj/item/weapon/gun/smg/m25/elite(src)


/obj/structure/closet/secure_closet/guncabinet/lmg/PopulateContents()
	new /obj/item/weapon/gun/rifle/standard_lmg(src)
	new /obj/item/ammo_magazine/standard_lmg(src)
	new /obj/item/weapon/gun/rifle/standard_lmg(src)
	new /obj/item/ammo_magazine/standard_lmg(src)


/obj/structure/closet/secure_closet/guncabinet/m57a4/PopulateContents()
	new /obj/item/weapon/gun/launcher/rocket/m57a4(src)
	new /obj/item/ammo_magazine/rocket/m57a4(src)
	new /obj/item/weapon/gun/launcher/rocket/m57a4(src)
	new /obj/item/ammo_magazine/rocket/m57a4(src)


/obj/structure/closet/secure_closet/guncabinet/explosives/PopulateContents()
	new /obj/item/storage/box/visual/grenade/incendiary(src)
	new /obj/item/storage/box/visual/grenade/M15(src)
	new /obj/item/storage/box/visual/grenade/impact(src)
	new /obj/item/storage/box/explosive_mines(src)

/obj/structure/closet/secure_closet/guncabinet/highpower/PopulateContents()
	new /obj/item/weapon/gun/pistol/highpower(src)
	new /obj/item/ammo_magazine/pistol/highpower(src)

/obj/structure/closet/secure_closet/guncabinet/incendiary
	req_access = list(ACCESS_GUARDSMAN_RESEARCH)

/obj/structure/closet/secure_closet/guncabinet/incendiary/PopulateContents()
	new /obj/item/weapon/gun/flamer/big_flamer(src)
	new /obj/item/explosive/grenade/incendiary(src)


/obj/structure/closet/secure_closet/guncabinet/m41aMK1/PopulateContents()
	new /obj/item/weapon/gun/rifle/standard_assaultrifle(src)
	new /obj/item/ammo_magazine/rifle/standard_assaultrifle(src)
	new /obj/item/ammo_magazine/rifle/standard_assaultrifle(src)
	new /obj/item/weapon/gun/rifle/standard_assaultrifle(src)
	new /obj/item/ammo_magazine/rifle/standard_assaultrifle(src)
	new /obj/item/ammo_magazine/rifle/standard_assaultrifle(src)


/obj/structure/closet/secure_closet/guncabinet/mp_armory
	req_access = list(ACCESS_GUARDSMAN_BRIG)

/obj/structure/closet/secure_closet/guncabinet/mp_armory/PopulateContents()
	new /obj/item/weapon/gun/shotgun/combat(src)
	new /obj/item/weapon/gun/shotgun/combat(src)
	new /obj/item/weapon/gun/shotgun/combat(src)
	new /obj/item/ammo_magazine/shotgun(src)
	new /obj/item/ammo_magazine/shotgun/buckshot(src)
	new /obj/item/ammo_magazine/shotgun/buckshot(src)
	new /obj/item/ammo_magazine/shotgun/buckshot(src)

/obj/structure/closet/secure_closet/guncabinet/mp_armory/engineering
	req_access = list(ACCESS_GUARDSMAN_ENGINEERING, ACCESS_GUARDSMAN_LOGISTICS, ACCESS_GUARDSMAN_BRIDGE)

/obj/structure/closet/secure_closet/guncabinet/riot_control
	name = "riot control equipment closet"
	req_access = list(ACCESS_GUARDSMAN_BRIG)
	storage_capacity = 55 //lots of stuff to fit in

/obj/structure/closet/secure_closet/guncabinet/riot_control/PopulateContents()
	new /obj/item/weapon/gun/shotgun/pump(src, TRUE)
	new /obj/item/weapon/gun/shotgun/pump(src, TRUE)
	new /obj/item/weapon/gun/shotgun/pump(src, TRUE)
	new /obj/item/weapon/shield/riot(src)
	new /obj/item/weapon/shield/riot(src)
	new /obj/item/weapon/shield/riot(src)
	new /obj/item/weapon/shield/riot(src)
	new /obj/item/ammo_magazine/shotgun/beanbag(src)
	new /obj/item/ammo_magazine/shotgun/beanbag(src)
	new /obj/item/ammo_magazine/shotgun/beanbag(src)
	new /obj/item/ammo_magazine/shotgun/beanbag(src)
	new /obj/item/weapon/gun/grenade_launcher/single_shot/riot(src, TRUE)
	new /obj/item/storage/box/visual/grenade/teargas(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/clothing/head/helmet/riot(src)
	new /obj/item/clothing/head/helmet/riot(src)
	new /obj/item/clothing/head/helmet/riot(src)
	new /obj/item/clothing/suit/armor/riot(src)
	new /obj/item/clothing/suit/armor/riot(src)
	new /obj/item/clothing/suit/armor/riot(src)
	new /obj/item/storage/box/flashbangs(src)

/obj/structure/closet/secure_closet/guncabinet/emergency_combat_gear
	name = "\improper emergency combat gear"
	desc = "Kept in cases of extreme emergency. Tends to feature surplus, second rate gear. Not for regular TGMC squad guardsmans."
	req_access = null

/obj/structure/closet/secure_closet/guncabinet/emergency_combat_gear/PopulateContents()
	new /obj/item/clothing/head/helmet/guardsman
	new /obj/item/clothing/head/helmet/guardsman
	new /obj/item/clothing/shoes/guardsman/brown
	new /obj/item/clothing/shoes/guardsman/brown
	new /obj/item/clothing/under/guardsman/camo
	new /obj/item/clothing/under/guardsman/camo
	new /obj/item/storage/backpack/guardsman/satchel/green
	new /obj/item/storage/backpack/guardsman/satchel/green
	new /obj/item/storage/belt/guardsman/standard_skirmishrifle
	new /obj/item/storage/belt/guardsman/standard_skirmishrifle
	new /obj/item/weapon/gun/rifle/standard_skirmishrifle/standard
	new /obj/item/weapon/gun/rifle/standard_skirmishrifle/standard
	new /obj/item/storage/box/visual/magazine/compact/standard_skirmishrifle
	new /obj/item/clothing/suit/modular/xenonauten
	new /obj/item/clothing/suit/modular/xenonauten


