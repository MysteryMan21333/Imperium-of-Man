///List of all faction_stats datums, by faction
GLOBAL_LIST_EMPTY(faction_stats_datums)

///jobs by faction, ranked by seniority
GLOBAL_LIST_INIT(ranked_jobs_by_faction, list(
	FACTION_IMPERIUM = list(CAPTAIN, FIELD_COMMANDER, STAFF_OFFICER, SQUAD_LEADER),
	FACTION_CHAOS = list(CHAOS_COMMANDER, CHAOS_FIELD_COMMANDER, CHAOS_STAFF_OFFICER, CHAOS_SQUAD_LEADER, CHAOS_SQUAD_VETERAN),
))

///All jobs used in campaign
GLOBAL_LIST_INIT(campaign_jobs, list(
	SQUAD_GUARDSMAN,
	SQUAD_ENGINEER,
	SQUAD_CORPSMAN,
	SQUAD_SMARTGUNNER,
	SQUAD_LEADER,
	FIELD_COMMANDER,
	STAFF_OFFICER,
	CAPTAIN,
	CHAOS_SQUAD_GUARDSMAN,
	CHAOS_SQUAD_ENGINEER,
	CHAOS_SQUAD_CORPSMAN,
	CHAOS_SQUAD_VETERAN,
	CHAOS_SQUAD_LEADER,
	CHAOS_FIELD_COMMANDER,
	CHAOS_STAFF_OFFICER,
	CHAOS_COMMANDER,
))

///Loot table if Guardsmans win a major victory in a campaign mission
GLOBAL_LIST_INIT(campaign_tgmc_major_loot, list(
	/obj/effect/supply_drop/medical_basic = 7,
	/obj/effect/supply_drop/guardsman_sentry = 5,
	/obj/effect/supply_drop/recoilless_rifle = 3,
	/obj/effect/supply_drop/armor_upgrades = 5,
	/obj/effect/supply_drop/mmg = 4,
	/obj/effect/supply_drop/zx_shotgun = 3,
	/obj/effect/supply_drop/minigun = 3,
	/obj/effect/supply_drop/scout = 3,
	/obj/item/implanter/sandevistan = 3,
	/obj/item/implanter/blade = 3,
	/obj/effect/supply_drop/jump_mod = 3,
))

///Loot table if Guardsmans win a minor victory in a campaign mission
GLOBAL_LIST_INIT(campaign_tgmc_minor_loot, list(
	/obj/effect/supply_drop/medical_basic = 7,
	/obj/effect/supply_drop/guardsman_sentry = 5,
	/obj/effect/supply_drop/recoilless_rifle = 3,
	/obj/effect/supply_drop/armor_upgrades = 5,
	/obj/effect/supply_drop/mmg = 4,
	/obj/item/implanter/blade = 3,
	/obj/effect/supply_drop/jump_mod = 2,
))

///Loot table if CHAOS win a major victory in a campaign mission
GLOBAL_LIST_INIT(campaign_chaos_major_loot, list(
	/obj/effect/supply_drop/medical_basic = 7,
	/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/cope = 5,
	/obj/effect/supply_drop/chaos_rpg = 3,
	/obj/effect/supply_drop/chaos_armor_upgrades = 5,
	/obj/effect/supply_drop/charger = 4,
	/obj/effect/supply_drop/culverin = 3,
	/obj/effect/supply_drop/blink_kit = 3,
	/obj/effect/supply_drop/chaos_shotgun_burst = 3,
	/obj/item/implanter/sandevistan = 3,
	/obj/item/implanter/blade = 3,
	/obj/effect/supply_drop/jump_mod = 3,
))

///Loot table if CHAOS win a minor victory in a campaign mission
GLOBAL_LIST_INIT(campaign_chaos_minor_loot, list(
	/obj/effect/supply_drop/medical_basic = 7,
	/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/cope = 5,
	/obj/effect/supply_drop/chaos_rpg = 3,
	/obj/effect/supply_drop/chaos_armor_upgrades = 5,
	/obj/effect/supply_drop/charger = 4,
	/obj/item/implanter/blade = 3,
	/obj/effect/supply_drop/jump_mod = 2,
))
