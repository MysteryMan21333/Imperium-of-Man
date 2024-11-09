/obj/item/loot_box
	name = "Blackmarket loot box"
	desc = "A box of loot, what could be inside?"
	icon = 'modular_imperium/master_files/icons/obj/items/items.dmi'
	icon_state = "lootbox"
	worn_icon_state = "lootbox"
	///list of the lowest probability drops
	var/list/legendary_list
	///list of rare propability drops
	var/list/rare_list
	///list of uncommon drops
	var/list/uncommon_list
	///list of common drops
	var/list/common_list
	///the odds of each loot category being picked
	var/list/weight_list = list(legendary_list = 10, rare_list = 20, uncommon_list = 30, common_list = 40)
	///The number of rolls on the table this box has
	var/rolls = 1

/obj/item/loot_box/ex_act()
	qdel(src)

/obj/item/loot_box/attack_self(mob/user)
	var/obj/loot_pick
	while(rolls)
		switch(pickweight(weight_list))
			if("legendary_list")
				loot_pick = pick(legendary_list)
			if("rare_list")
				loot_pick = pick(rare_list)
			if("uncommon_list")
				loot_pick = pick(uncommon_list)
			if("common_list")
				loot_pick = pick(common_list)
		loot_pick = new loot_pick(get_turf(user))
		if(isitem(loot_pick))
			user.put_in_hands(loot_pick)
		if(!iseffect(loot_pick))
			user.visible_message("[user] pulled a [loot_pick.name] out of the [src]!")
		rolls --
	qdel(src)

/obj/item/loot_box/guardsman
	legendary_list = list(
		/obj/item/weapon/karambit,
		/obj/item/weapon/karambit/fade,
		/obj/item/weapon/karambit/case_hardened,
		/obj/item/storage/briefcase/standard_magnum/gold,
		/obj/item/storage/briefcase/standard_magnum/silver,
		/obj/item/storage/briefcase/standard_magnum/nickle,
	)
	rare_list = list(
		/obj/vehicle/unmanned,
		/obj/item/weapon/gun/rifle/sniper/antimaterial,
		/obj/item/weapon/gun/rifle/tx8,
		/obj/item/weapon/gun/minigun,
		/obj/item/weapon/gun/launcher/rocket/sadar,
		/obj/item/weapon/gun/rifle/railgun,
		/obj/item/weapon/gun/rifle/standard_autosniper,
		/obj/item/weapon/gun/shotgun/zx76,
		/obj/item/storage/belt/champion,
	)
	uncommon_list = list(
		/obj/item/weapon/gun/revolver/mateba,
		/obj/item/storage/fancy/crayons,
		/obj/item/weapon/sword,
		/obj/vehicle/ridden/motorbike,
		/obj/item/weapon/gun/launcher/rocket/oneuse,
		/obj/item/weapon/gun/rifle/m412l1_hpr,
		/obj/item/weapon/gun/shotgun/chaos,
		/obj/item/loot_box/guardsman, //reroll time
	)
	common_list = list(
		/obj/item/clothing/head/strawhat,
		/obj/item/storage/bag/trash,
		/obj/item/toy/bikehorn,
		/obj/item/clothing/tie/horrible,
		/obj/item/toy/spinningtoy,
		/obj/item/toy/katana,
		/obj/item/weapon/banhammer,
	)

//Supply drop boxes
/obj/item/loot_box/supply_drop
	name = "supply drop"
	desc = "A TGMC-marked box full of valuable military tactical equipment."
	icon = 'modular_imperium/master_files/icons/obj/items/items.dmi'
	w_class = WEIGHT_CLASS_GIGANTIC
	slowdown = 1 //You won't be running off with this
	rolls = 4
	weight_list = list(rare_list = 20, uncommon_list = 30, common_list = 40)

	rare_list = list(
		/obj/effect/supply_drop/heavy_armor,
		/obj/effect/supply_drop/grenadier,
		/obj/effect/supply_drop/minigun,
		/obj/effect/supply_drop/zx_shotgun,
	)
	uncommon_list = list(
		/obj/effect/supply_drop/guardsman_sentry,
		/obj/effect/supply_drop/recoilless_rifle,
		/obj/effect/supply_drop/scout,
		/obj/effect/supply_drop/oicw,
		/obj/item/storage/belt/lifesaver/quick,
		/obj/item/storage/belt/rig/medical,
		/obj/effect/supply_drop/mmg,
	)
	common_list = list(
		/obj/effect/supply_drop/armor_upgrades,
		/obj/effect/supply_drop/medical_basic,
		/obj/item/storage/pouch/firstaid/combat_patrol,
		/obj/item/storage/pouch/medical_injectors/firstaid,
		/obj/item/storage/pouch/medical_injectors/medic,
		/obj/effect/supply_drop/standard_carbine,
		/obj/effect/supply_drop/standard_rifle,
		/obj/effect/supply_drop/combat_rifle,
		/obj/effect/supply_drop/laser_rifle,
		/obj/effect/supply_drop/standard_shotgun,
	)

/obj/item/loot_box/supply_drop/chaos
	name = "supply drop"
	desc = "A rugged box composed of valuable CHAOS military materiel."
	icon = 'modular_imperium/master_files/icons/obj/items/items.dmi'
	w_class = WEIGHT_CLASS_GIGANTIC
	rolls = 4

	rare_list = list(
		/obj/effect/supply_drop/culverin,
		/obj/effect/supply_drop/caliver,
		/obj/effect/supply_drop/chaos_shotgun_burst,
		/obj/effect/supply_drop/blink_kit,
	)
	uncommon_list = list(
		/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/cope,
		/obj/effect/supply_drop/chaos_rifle_ap,
		/obj/effect/supply_drop/chaos_smg_ap,
		/obj/effect/supply_drop/chaos_rpg,
		/obj/effect/supply_drop/chaos_flamer,
		/obj/item/storage/belt/lifesaver/chaos/quick,
		/obj/item/storage/belt/rig/medical,
		/obj/effect/supply_drop/charger,
	)
	common_list = list(
		/obj/effect/supply_drop/chaos_armor_upgrades,
		/obj/effect/supply_drop/medical_basic,
		/obj/item/storage/pouch/firstaid/chaos/combat_patrol,
		/obj/item/storage/pouch/medical_injectors/chaos/firstaid,
		/obj/item/storage/pouch/medical_injectors/chaos/medic,
		/obj/effect/supply_drop/chaos_rifle,
		/obj/effect/supply_drop/chaos_smg,
		/obj/effect/supply_drop/chaos_shotgun,
		/obj/effect/supply_drop/chaos_mg,
	)

//Alien supply drop, how'd they get a bluespace teleporter?
/obj/effect/supply_drop/tyranid/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(spawn_larva)), 1)

/obj/effect/supply_drop/tyranid/proc/spawn_larva()
	var/mob/picked = get_alien_candidate()
	var/mob/living/carbon/tyranid/larva/new_tyranid

	new_tyranid = new(loc)

	new_tyranid.hivenumber = TYRANID_HIVE_NORMAL
	new_tyranid.update_icons()

	//If we have a candidate, transfer it over.
	if(picked)
		picked.mind.transfer_to(new_tyranid, TRUE)
		to_chat(new_tyranid, span_tyranidannounce("The Queen Mother has hurled us through Bluespace, we live for the hive!"))
		new_tyranid << sound('sound/effects/alien/new_larva.ogg')
	return INITIALIZE_HINT_QDEL

//The actual drop sets
/obj/effect/supply_drop/medical_basic/Initialize(mapload)
	. = ..()
	new /obj/item/storage/firstaid/adv(loc)
	new /obj/item/storage/firstaid/regular(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/heavy_armor/Initialize(mapload)
	. = ..()
	new /obj/item/clothing/head/helmet/guardsman/specialist(loc)
	new /obj/item/clothing/gloves/guardsman/specialist(loc)
	new /obj/item/clothing/suit/storage/guardsman/specialist(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/grenadier/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/grenade_launcher/multinade_launcher(loc)
	new /obj/item/storage/belt/grenade/b17(loc)
	new /obj/item/clothing/head/helmet/guardsman/grenadier(loc)
	new /obj/item/clothing/suit/storage/guardsman/B17(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/minigun/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/minigun/magharness(loc)
	new /obj/item/ammo_magazine/minigun_powerpack(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/zx_shotgun/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/shotgun/zx76/standard(loc)
	new /obj/item/storage/belt/shotgun/flechette(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/guardsman_sentry/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/sentry/mini/combat_patrol(loc)
	new /obj/item/weapon/gun/sentry/mini/combat_patrol(loc)
	new /obj/item/ammo_magazine/minisentry(loc)
	new /obj/item/ammo_magazine/minisentry(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/recoilless_rifle/Initialize(mapload)
	. = ..()
	new /obj/item/storage/holster/backholster/rpg/low_impact(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/oicw/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/rifle/tx55/combat_patrol(loc)
	new /obj/item/storage/belt/guardsman/oicw(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/scout/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/rifle/tx8/scout(loc)
	new /obj/item/storage/belt/guardsman/tx8(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/armor_upgrades/Initialize(mapload)
	. = ..()
	new /obj/item/clothing/suit/modular/xenonauten/heavy/tyr_two(loc)
	new /obj/item/clothing/head/modular/m10x/tyr(loc)
	new /obj/item/weapon/shield/riot/guardsman(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/mmg/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/standard_mmg/machinegunner(loc)
	new /obj/item/ammo_magazine/standard_mmg(loc)
	new /obj/item/ammo_magazine/standard_mmg(loc)
	new /obj/item/ammo_magazine/standard_mmg(loc)
	new /obj/item/stack/sandbags/large_stack(loc)
	new /obj/item/stack/barbed_wire/full(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/standard_carbine/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/rifle/standard_carbine/scout(loc)
	new /obj/item/storage/belt/guardsman/t18(loc)
	new /obj/item/explosive/grenade(loc)
	new /obj/item/explosive/grenade(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/standard_rifle/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/rifle/standard_assaultrifle/rifleman(loc)
	new /obj/item/storage/belt/guardsman/t12(loc)
	new /obj/item/explosive/grenade(loc)
	new /obj/item/explosive/grenade(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/combat_rifle/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/rifle/tx11/standard(loc)
	new /obj/item/storage/belt/guardsman/combat_rifle(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/laser_rifle/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_guardsman_rifle/rifleman(loc)
	new /obj/item/storage/belt/guardsman/te_cells(loc)
	new /obj/item/ammo_magazine/flamer_tank/mini(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/standard_shotgun/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/shotgun/pump/t35/pointman(loc)
	new /obj/item/storage/belt/shotgun/mixed(loc)
	return INITIALIZE_HINT_QDEL

//CHAOS drops
/obj/effect/supply_drop/gorgon_armor/Initialize(mapload)
	. = ..()
	new /obj/item/clothing/head/modular/chaos/leader(loc)
	new /obj/item/clothing/suit/modular/chaos/heavy/leader/valk(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/chaos_mg/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/rifle/chaos_mg/standard(loc)
	new /obj/item/ammo_magazine/chaos_mg(loc)
	new /obj/item/ammo_magazine/chaos_mg(loc)
	new /obj/item/ammo_magazine/chaos_mg(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/chaos_rifle/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/rifle/chaos/standard(loc)
	new /obj/item/storage/belt/guardsman/chaos/chaos_rifle(loc)
	new /obj/item/ammo_magazine/handful/micro_grenade(loc)
	new /obj/item/ammo_magazine/handful/micro_grenade(loc)
	new /obj/item/ammo_magazine/handful/micro_grenade/dragonbreath(loc)
	new /obj/item/ammo_magazine/handful/micro_grenade/cluster(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/chaos_rifle_ap/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/rifle/chaos/veteran(loc)
	new /obj/item/storage/belt/guardsman/chaos/chaos_rifle_ap(loc)
	new /obj/item/ammo_magazine/handful/micro_grenade(loc)
	new /obj/item/ammo_magazine/handful/micro_grenade(loc)
	new /obj/item/ammo_magazine/handful/micro_grenade/dragonbreath(loc)
	new /obj/item/ammo_magazine/handful/micro_grenade/cluster(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/mpi/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/rifle/mpi_km/black/grenadier(loc)
	new /obj/item/storage/belt/guardsman/chaos/mpi_black(loc)
	new /obj/item/explosive/grenade/chaos(loc)
	new /obj/item/explosive/grenade/chaos(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/chaos_carbine/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/rifle/chaos_carbine/black/standard(loc)
	new /obj/item/storage/belt/guardsman/chaos/carbine(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/chaos_smg/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/smg/chaos/scout(loc)
	new /obj/item/storage/belt/guardsman/chaos/chaos_smg(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/chaos_smg_ap/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/smg/chaos/veteran(loc)
	new /obj/item/storage/belt/guardsman/chaos/chaos_smg_ap(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/chaos_shotgun/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/shotgun/chaos/pointman(loc)
	new /obj/item/storage/belt/shotgun/chaos/mixed(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/chaos_shotgun_burst/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/shotgun/chaos/burst/pointman(loc)
	new /obj/item/storage/belt/shotgun/chaos/flechette(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/chaos_rpg/Initialize(mapload)
	. = ..()
	new /obj/item/storage/holster/backholster/rpg/chaos/war_crimes(loc)
	new /obj/item/clothing/head/modular/chaos/bio(loc)
	new /obj/item/clothing/suit/modular/chaos/heavy/mithridatius(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/chaos_flamer/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/flamer/chaos/mag_harness(loc)
	new /obj/item/ammo_magazine/flamer_tank/backtank(loc)
	new /obj/item/clothing/suit/modular/chaos/heavy/pyro(loc)
	new /obj/item/tool/extinguisher(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/chaos_armor_upgrades/Initialize(mapload)
	. = ..()
	new /obj/item/clothing/head/modular/chaos/lorica(loc)
	new /obj/item/clothing/suit/modular/chaos/heavy/lorica(loc)
	new /obj/item/weapon/shield/riot/guardsman/chaos(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/charger/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/charger/scout(loc)
	new /obj/item/storage/belt/guardsman/chaos/volkite(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/caliver/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/caliver/standard(loc)
	new /obj/item/storage/belt/guardsman/chaos/volkite(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/culverin/Initialize(mapload)
	. = ..()
	new /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/culverin/magharness(loc)
	new /obj/item/cell/lasgun/volkite/powerpack(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/supply_drop/blink_kit/Initialize(mapload)
	. = ..()
	new /obj/item/blink_drive(loc)
	new /obj/item/weapon/energy/sword/chaos(loc)
	return INITIALIZE_HINT_QDEL

// 150 to 200 points of value packs, spend 100 points get 150 to 200 in value, basically. Ideally, commons are variety packs, uncommons maybe shake up the round a bit, rares a bit more. Legendaries make the round go wacko. You get a crate of stuff dropped on spawn.
/obj/item/loot_box/tgmclootbox
	name = "TGMC pack box"
	desc = "A box of gear sent over by the TGMC on request, nobody knows what's in it. You just know it'll probably be good."
	icon = 'modular_imperium/master_files/icons/obj/items/items.dmi'
	icon_state = "lootbox"
	worn_icon_state = "lootbox"

	legendary_list = list(
		/obj/item/storage/box/crate/loot/operator_pack,
		/obj/item/storage/box/crate/loot/heavy_pack,
		/obj/item/storage/box/crate/loot/b18classic_pack,
		/obj/item/storage/box/crate/loot/sadarclassic_pack,
	)
	rare_list = list(
		/obj/item/storage/box/crate/loot/hsg_102_pack,
		/obj/item/storage/box/crate/loot/mortar_pack,
		/obj/structure/closet/crate/loot/howitzer_pack,
		/obj/item/storage/box/crate/loot/sentry_pack,
		/obj/item/storage/box/crate/loot/agl_pack,
	)
	uncommon_list = list(
		/obj/item/storage/box/crate/loot/materials_pack,
		/obj/item/storage/box/crate/loot/railgun_pack,
		/obj/item/storage/box/crate/loot/scoutrifle_pack,
		/obj/item/storage/box/crate/loot/recoilless_pack,
	)
	common_list = list(
		/obj/item/storage/box/crate/loot/autosniper_pack,
		/obj/item/storage/box/crate/loot/thermobaric_pack,
		/obj/item/storage/box/crate/loot/tesla_pack,
		/obj/item/storage/box/crate/loot/tx54_pack,
	)

// Boxes the lootbox uses.

/obj/item/storage/box/crate/loot
	name = "\improper generic equipment"
	desc = "A large case containing some kind of equipment. Drag this sprite into you to open it up!\nNOTE: You cannot put items back inside this case."
	icon_state = "smartgun_case"
	w_class = WEIGHT_CLASS_HUGE

/obj/item/storage/box/crate/loot/Initialize(mapload)
	. = ..()
	storage_datum.storage_slots = 100
	storage_datum.max_storage_space = 100
	storage_datum.max_w_class = 0 //1 way storage

/obj/item/storage/box/crate/loot/PopulateContents()
	new /obj/item/weapon/banhammer(src)

// Crate for lootboxes. Use for large items.

/obj/structure/closet/crate/loot
	name = "\improper generic equipment"
	desc = "A large crate containing some kind of equipment."
	icon = 'modular_imperium/master_files/icons/obj/structures/crates.dmi'
	icon_state = "closed_basic"
	icon_opened = "open_basic"
	icon_closed = "closed_basic"

/obj/structure/closet/crate/loot/PopulateContents()
	new /obj/item/weapon/banhammer(src)

// Common

/obj/item/storage/box/crate/loot/autosniper_pack
	icon_state = "sniper_case"

/obj/item/storage/box/crate/loot/autosniper_pack/PopulateContents()
	. = ..()
	new /obj/item/weapon/gun/rifle/standard_autosniper(src)
	new /obj/item/weapon/gun/rifle/standard_autosniper(src)
	new /obj/item/weapon/gun/rifle/standard_autosniper(src)
	new /obj/item/ammo_magazine/rifle/autosniper(src)
	new /obj/item/ammo_magazine/rifle/autosniper(src)
	new /obj/item/ammo_magazine/rifle/autosniper(src)
	new /obj/item/ammo_magazine/rifle/autosniper(src)
	new /obj/item/ammo_magazine/rifle/autosniper(src)
	new /obj/item/ammo_magazine/rifle/autosniper(src)
	new /obj/item/ammo_magazine/rifle/autosniper(src)
	new /obj/item/ammo_magazine/rifle/autosniper(src)
	new /obj/item/ammo_magazine/rifle/autosniper(src)
	new /obj/item/ammo_magazine/rifle/autosniper(src) //180 total and common, fine considering 3 autos is really strong.

/obj/item/storage/box/crate/loot/thermobaric_pack
	icon_state = "rocket_case"

/obj/item/storage/box/crate/loot/thermobaric_pack/PopulateContents()
	. = ..()
	new /obj/item/weapon/gun/launcher/rocket/m57a4/t57(src)
	new /obj/item/weapon/gun/launcher/rocket/m57a4/t57(src)
	new /obj/item/weapon/gun/launcher/rocket/m57a4/t57(src)
	new /obj/item/ammo_magazine/rocket/m57a4(src)
	new /obj/item/ammo_magazine/rocket/m57a4(src)
	new /obj/item/ammo_magazine/rocket/m57a4(src)
	new /obj/item/ammo_magazine/rocket/m57a4(src)
	new /obj/item/ammo_magazine/rocket/m57a4(src)
	new /obj/item/ammo_magazine/rocket/m57a4(src)
	new /obj/item/ammo_magazine/rocket/m57a4(src)
	new /obj/item/ammo_magazine/rocket/m57a4(src)
	new /obj/item/ammo_magazine/rocket/m57a4(src)
	new /obj/item/ammo_magazine/rocket/m57a4(src) // three launchers and 10 arrays. Common. 200.

/obj/item/storage/box/crate/loot/tesla_pack/PopulateContents()
	. = ..()
	new /obj/item/weapon/gun/energy/lasgun/lasrifle/tesla(src)
	new /obj/item/weapon/gun/energy/lasgun/lasrifle/tesla(src)
	new /obj/item/weapon/gun/energy/lasgun/lasrifle/tesla(src) // 180 and nothing else. Have fun.

/obj/item/storage/box/crate/loot/tx54_pack/PopulateContents()
	. = ..()
	new /obj/item/weapon/gun/rifle/tx54(src)
	new /obj/item/weapon/gun/rifle/tx54(src)
	new /obj/item/weapon/gun/rifle/tx54(src)
	new /obj/item/ammo_magazine/rifle/tx54(src)
	new /obj/item/ammo_magazine/rifle/tx54(src)
	new /obj/item/ammo_magazine/rifle/tx54(src)
	new /obj/item/ammo_magazine/rifle/tx54(src)
	new /obj/item/ammo_magazine/rifle/tx54(src)
	new /obj/item/ammo_magazine/rifle/tx54(src)
	new /obj/item/ammo_magazine/rifle/tx54/he(src)
	new /obj/item/ammo_magazine/rifle/tx54/he(src)
	new /obj/item/ammo_magazine/rifle/tx54/he(src)
	new /obj/item/ammo_magazine/rifle/tx54/he(src)
	new /obj/item/ammo_magazine/rifle/tx54/he(src)
	new /obj/item/ammo_magazine/rifle/tx54/he(src)

// Uncommon

/obj/item/storage/box/crate/loot/materials_pack/PopulateContents()
	. = ..()
	new /obj/item/stack/sheet/plasteel/large_stack(src)
	new /obj/item/stack/sheet/plasteel/large_stack(src)
	new /obj/item/stack/sheet/metal/large_stack(src)
	new /obj/item/stack/sheet/metal/large_stack(src)
	new /obj/item/stack/sheet/metal/large_stack(src)
	new /obj/item/stack/sheet/metal/large_stack(src)
	new /obj/item/stack/sandbags_empty/full(src)
	new /obj/item/stack/sandbags_empty/full(src)
	new /obj/item/stack/sandbags_empty/full(src)
	new /obj/item/stack/sandbags_empty/full(src)
	new /obj/item/tool/shovel/etool(src)
	new /obj/item/tool/shovel/etool(src)
	new /obj/item/tool/shovel/etool(src)
	new /obj/item/tool/shovel/etool(src)

/obj/item/storage/box/crate/loot/recoilless_pack
	icon_state = "rocket_case"

/obj/item/storage/box/crate/loot/recoilless_pack/PopulateContents()
	. = ..()
	new /obj/item/storage/holster/backholster/rpg/full(src)
	new /obj/item/storage/holster/backholster/rpg/full(src)
	new /obj/item/storage/holster/backholster/rpg/full(src)
	new /obj/item/ammo_magazine/rocket/recoilless/heat(src)
	new /obj/item/ammo_magazine/rocket/recoilless/heat(src)
	new /obj/item/ammo_magazine/rocket/recoilless/heat(src)
	new /obj/item/ammo_magazine/rocket/recoilless/heat(src)
	new /obj/item/ammo_magazine/rocket/recoilless/heat(src)
	new /obj/item/ammo_magazine/rocket/recoilless/heat(src)

/obj/item/storage/box/crate/loot/railgun_pack/PopulateContents()
	. = ..()
	new /obj/item/weapon/gun/rifle/railgun(src)
	new /obj/item/weapon/gun/rifle/railgun(src)
	new /obj/item/weapon/gun/rifle/railgun(src)
	new /obj/item/ammo_magazine/railgun/smart(src)
	new /obj/item/ammo_magazine/railgun/smart(src)
	new /obj/item/ammo_magazine/railgun/smart(src)
	new /obj/item/ammo_magazine/railgun/smart(src)
	new /obj/item/ammo_magazine/railgun/hvap(src)
	new /obj/item/ammo_magazine/railgun/hvap(src)
	new /obj/item/ammo_magazine/railgun/hvap(src)
	new /obj/item/ammo_magazine/railgun/hvap(src)
	new /obj/item/ammo_magazine/railgun(src)
	new /obj/item/ammo_magazine/railgun(src)
	new /obj/item/ammo_magazine/railgun(src)
	new /obj/item/ammo_magazine/railgun(src)

/obj/item/storage/box/crate/loot/scoutrifle_pack
	icon_state = "sniper_case"

/obj/item/storage/box/crate/loot/scoutrifle_pack/PopulateContents()
	. = ..()
	new /obj/item/weapon/gun/rifle/tx8(src)
	new /obj/item/weapon/gun/rifle/tx8(src)
	new /obj/item/weapon/gun/rifle/tx8(src)
	new /obj/item/ammo_magazine/packet/scout_rifle(src)
	new /obj/item/ammo_magazine/packet/scout_rifle(src)
	new /obj/item/ammo_magazine/packet/scout_rifle(src)
	new /obj/item/ammo_magazine/packet/scout_rifle(src)
	new /obj/item/ammo_magazine/rifle/tx8
	new /obj/item/ammo_magazine/rifle/tx8
	new /obj/item/ammo_magazine/rifle/tx8
	new /obj/item/ammo_magazine/rifle/tx8
	new /obj/item/ammo_magazine/rifle/tx8
	new /obj/item/ammo_magazine/rifle/tx8


// Rares

/obj/item/storage/box/crate/loot/mortar_pack/PopulateContents()
	. = ..()
	new /obj/item/mortar_kit(src)
	new /obj/item/mortar_kit(src)
	new /obj/item/mortar_kit(src)
	new /obj/item/mortar_kit(src)
	new /obj/item/mortar_kit(src)

/obj/structure/closet/crate/loot/howitzer_pack/PopulateContents()
	. = ..()
	new /obj/item/mortar_kit/howitzer(src)
	new /obj/item/mortar_kit/howitzer(src)
	new /obj/item/mortal_shell/howitzer/white_phos(src)
	new /obj/item/mortal_shell/howitzer/white_phos(src)
	new /obj/item/mortal_shell/howitzer/white_phos(src)
	new /obj/item/mortal_shell/howitzer/white_phos(src)
	new /obj/item/mortal_shell/howitzer/white_phos(src)
	new /obj/item/mortal_shell/howitzer/white_phos(src)
	new /obj/item/mortal_shell/howitzer/white_phos(src)
	new /obj/item/mortal_shell/howitzer/white_phos(src)
	new /obj/item/mortal_shell/howitzer/white_phos(src)
	new /obj/item/mortal_shell/howitzer/white_phos(src)
	new /obj/item/mortal_shell/howitzer/white_phos(src)
	new /obj/item/mortal_shell/howitzer/white_phos(src)

/obj/item/storage/box/crate/loot/hsg_102_pack/PopulateContents()
	. = ..()
	new /obj/item/storage/box/hsg_102(src)
	new /obj/item/storage/box/hsg_102(src)

/obj/item/storage/box/crate/loot/agl_pack/PopulateContents()
	. = ..()
	new /obj/item/weapon/gun/standard_agls(src)
	new /obj/item/ammo_magazine/standard_agls(src)
	new /obj/item/ammo_magazine/standard_agls(src)
	new /obj/item/ammo_magazine/standard_agls(src)
	new /obj/item/ammo_magazine/standard_agls(src)
	new /obj/item/ammo_magazine/standard_agls/fragmentation(src)
	new /obj/item/ammo_magazine/standard_agls/fragmentation(src)
	new /obj/item/ammo_magazine/standard_agls/fragmentation(src)
	new /obj/item/ammo_magazine/standard_agls/fragmentation(src)

/obj/item/storage/box/crate/loot/sentry_pack
	icon_state = "sentry_case"

/obj/item/storage/box/crate/loot/sentry_pack/PopulateContents()
	. = ..()
	new /obj/item/storage/box/crate/sentry(src)
	new /obj/item/storage/box/crate/sentry(src)
	new /obj/item/storage/box/crate/sentry(src)
	new /obj/item/storage/box/crate/minisentry(src)

// Legendaries

/obj/item/storage/box/crate/loot/operator_pack/PopulateContents()
	. = ..()
	new /obj/item/weapon/gun/rifle/m412/elite
	new /obj/item/ammo_magazine/rifle
	new /obj/item/ammo_magazine/rifle
	new /obj/item/ammo_magazine/rifle
	new /obj/item/ammo_magazine/rifle
	new /obj/item/clothing/glasses/night/tx8

/obj/item/storage/box/crate/loot/b18classic_pack/PopulateContents()
	. = ..()
	new /obj/item/clothing/suit/storage/guardsman/specialist(src)
	new /obj/item/clothing/head/helmet/guardsman/specialist(src)
	new /obj/item/clothing/gloves/guardsman/specialist(src)
	new /obj/item/weapon/gun/minigun(src)
	new /obj/item/ammo_magazine/minigun_powerpack(src)
	new /obj/item/ammo_magazine/minigun_powerpack(src)

/obj/item/storage/box/crate/loot/heavy_pack/PopulateContents()
	. = ..()
	new /obj/item/weapon/gun/minigun(src)
	new /obj/item/weapon/gun/minigun(src)
	new /obj/item/ammo_magazine/minigun_powerpack(src)
	new /obj/item/ammo_magazine/minigun_powerpack(src)
	new /obj/item/armor_module/module/tyr_extra_armor(src)
	new /obj/item/armor_module/module/tyr_extra_armor(src)

/obj/item/storage/box/crate/loot/sadarclassic_pack
	icon_state = "rocket_case"

/obj/item/storage/box/crate/loot/sadarclassic_pack/PopulateContents()
	. = ..()
	new /obj/item/weapon/gun/launcher/rocket/sadar(src)
	new /obj/item/storage/backpack/guardsman/satchel/scout_cloak(src)
	new /obj/item/ammo_magazine/rocket/sadar/ap(src)
