/datum/emergency_call/tyranids_zeta
	name = "Tyranids (Zeta Hive)"
	base_probability = 0
	auto_shuttle_launch = TRUE
	spawn_type = null


/datum/emergency_call/tyranids_zeta/print_backstory(mob/living/carbon/tyranid/X)
	to_chat(X, "<B>We are a Tyranid from the Zeta hive.</b>")
	to_chat(X, "<B>We've been cruising in space for years until a new Queen reached out to us and took over the control of our shuttle.</b>") // Admin-only ERT, so queens only.
	to_chat(X, "<B>Expand our hive and destroy any who dare to oppose our influence especially other hives. For the Zeta Hive!</b>")


/datum/emergency_call/tyranids_zeta/spawn_items()
	var/turf/drop_spawn = get_spawn_point(TRUE)
	if(istype(drop_spawn))
		new /obj/alien/weeds/node(drop_spawn) //Drop some weeds for tyranid plasma regen.


/datum/emergency_call/tyranids_zeta/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return

	var/mob/original = M.current
	var/turf/spawn_loc = .

	if(!leader)
		. = new /mob/living/carbon/tyranid/ravager/Zeta(spawn_loc, TRUE) //TRUE for the can_spawn_in_centcom, so they don't get sent to a different hive.
		leader = .
		M.transfer_to(., TRUE)
		print_backstory(.)
		return

	if(prob(35))
		. = new /mob/living/carbon/tyranid/drone/Zeta(spawn_loc, TRUE)
		M.transfer_to(., TRUE)
		print_backstory(.)
		return

	if(prob(35))
		. = new /mob/living/carbon/tyranid/spitter/Zeta(spawn_loc, TRUE)
		M.transfer_to(., TRUE)
		print_backstory(.)
		return

	. = new /mob/living/carbon/tyranid/hunter/Zeta(spawn_loc, TRUE)
	M.transfer_to(., TRUE)
	print_backstory(.)

	if(original)
		qdel(original)
