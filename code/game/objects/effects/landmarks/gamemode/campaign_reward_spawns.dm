//When various rewards are spawned, they are sent to an available spawn location
/obj/effect/landmark/reward_spawn_location
	name = "TGMC Reward spawn location"
	desc = "THIS SHOULDN'T BE VISIBLE"
	icon = 'modular_imperium/master_files/icons/obj/structures/campaign_structures.dmi'
	icon_state = "tgmc_reward_spawn"
	///Faction associated with this location
	var/faction = FACTION_IMPERIUM

/obj/effect/landmark/reward_spawn_location/Initialize(mapload)
	. = ..()
	LAZYADDASSOC(GLOB.campaign_reward_spawners, faction, src)
	icon_state = null

/obj/effect/landmark/reward_spawn_location/Destroy()
	LAZYREMOVEASSOC(GLOB.campaign_reward_spawners, faction, src)
	return ..()

/obj/effect/landmark/reward_spawn_location/chaos
	name = "CHAOS Reward spawn location"
	icon_state = "chaos_reward_spawn"
	faction = FACTION_CHAOS
