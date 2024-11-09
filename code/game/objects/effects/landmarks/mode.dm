/obj/effect/landmark/lv624


/obj/effect/landmark/lv624/fog_blocker
	name = "fog blocker"
	icon_state = "fog_spawn"


/obj/effect/landmark/lv624/fog_blocker/Initialize(mapload)
	. = ..()
	store_location()
	atom_flags |= INITIALIZED
	return INITIALIZE_HINT_QDEL

/obj/effect/landmark/lv624/fog_blocker/proc/store_location()
	GLOB.fog_blocker_locations += loc

/obj/effect/landmark/lv624/fog_blocker/tyranid_spawn
	name = "tyranid spawn protection"

/obj/effect/landmark/lv624/fog_blocker/tyranid_spawn/store_location()
	GLOB.tyranid_spawn_protection_locations += loc
