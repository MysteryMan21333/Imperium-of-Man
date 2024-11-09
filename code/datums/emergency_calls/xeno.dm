/datum/emergency_call/tyranids
	name = "Tyranids"
	base_probability = 11
	auto_shuttle_launch = TRUE
	spawn_type = null
	alignement_factor = 4


/datum/emergency_call/tyranids/print_backstory(mob/living/carbon/tyranid/X)
	to_chat(X, "<B>We are a Tyranid from a distant hive.</b>")
	to_chat(X, "<B>We've been cruising in space for years until a new leader reached out to us and took over the control of our shuttle.</b>") // It may be a shrike or a queen.
	to_chat(X, "<B>Help our leader take over this sector. For the new Hive!</b>")


/datum/emergency_call/tyranids/spawn_items()
	var/turf/drop_spawn = get_spawn_point(TRUE)
	if(istype(drop_spawn))
		new /obj/alien/weeds/node(drop_spawn) //Drop some weeds for tyranid plasma regen.

/datum/emergency_call/tyranids/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return

	var/mob/original = M.current
	var/turf/spawn_loc = .

	if(!leader)
		. = new /mob/living/carbon/tyranid/ravager(spawn_loc)
		leader = .
		M.transfer_to(., TRUE)
		print_backstory(.)
		return

	if(prob(35))
		. = new /mob/living/carbon/tyranid/drone(spawn_loc)
		M.transfer_to(., TRUE)
		print_backstory(.)
		return

	if(prob(35))
		. = new /mob/living/carbon/tyranid/spitter(spawn_loc)
		M.transfer_to(., TRUE)
		print_backstory(.)
		return

	. = new /mob/living/carbon/tyranid/hunter(spawn_loc)
	M.transfer_to(., TRUE)
	print_backstory(.)

	if(original)
		qdel(original)
