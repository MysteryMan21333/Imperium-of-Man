/obj/structure/lattice
	desc = "A lightweight support lattice."
	name = "lattice"
	icon = 'modular_imperium/master_files/icons/obj/structures/structures.dmi'
	icon_state = "latticefull"
	density = FALSE
	anchored = TRUE
	layer = LATTICE_LAYER
	plane = FLOOR_PLANE
	//	flags = CONDUCT

/obj/structure/lattice/Initialize(mapload)
	. = ..()
	for(var/obj/structure/lattice/LAT in src.loc)
		if(LAT != src)
			qdel(LAT)
	icon = 'modular_imperium/master_files/icons/obj/smoothlattice.dmi'
	icon_state = "latticeblank"
	updateOverlays()
	for (var/dir in GLOB.cardinals)
		var/obj/structure/lattice/L
		if(locate(/obj/structure/lattice, get_step(src, dir)))
			L = locate(/obj/structure/lattice, get_step(src, dir))
			L.updateOverlays()

/obj/structure/lattice/Destroy()
	for (var/dir in GLOB.cardinals)
		var/obj/structure/lattice/L
		if(locate(/obj/structure/lattice, get_step(src, dir)))
			L = locate(/obj/structure/lattice, get_step(src, dir))
			L.updateOverlays(src.loc)
	return ..()

/obj/structure/lattice/ex_act(severity)
	switch(severity)
		if(EXPLODE_DEVASTATE, EXPLODE_HEAVY)
			qdel(src)


/obj/structure/lattice/attackby(obj/item/C as obj, mob/user as mob)

	if (istype(C, /obj/item/stack/tile/plasteel))
		var/turf/T = get_turf(src)
		T.attackby(C, user) //BubbleWrap - hand this off to the underlying turf instead
		return
	if (iswelder(C))
		var/obj/item/tool/weldingtool/WT = C
		if(WT.remove_fuel(0, user))
			to_chat(user, span_notice("Slicing lattice joints ..."))
		new /obj/item/stack/rods(src.loc)
		qdel(src)

/obj/structure/lattice/proc/updateOverlays()
	//if(!isspaceturf(loc))
	//	qdel(src)
	spawn(1)
		overlays = list()

		var/dir_sum = 0

		for (var/direction in GLOB.cardinals)
			if(locate(/obj/structure/lattice, get_step(src, direction)))
				dir_sum += direction
			else
				if(!isspaceturf(get_step(src, direction)))
					dir_sum += direction

		icon_state = "lattice[dir_sum]"
		return

/obj/structure/lattice/autosmooth
	icon = 'modular_imperium/master_files/icons/obj/smooth_objects/lattice.dmi'
	icon_state = "lattice-0"
	layer = ABOVE_ALL_MOB_LAYER
	plane = GAME_PLANE
	base_icon_state = "lattice"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_LATTICE_ABOVE)
	canSmoothWith = list(SMOOTH_GROUP_LATTICE_ABOVE)
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/structure/catwalk
	icon = 'modular_imperium/master_files/icons/obj/smooth_objects/catwalk.dmi'
	icon_state = "catwalk-icon"
	base_icon_state = "catwalk"
	plane = FLOOR_PLANE
	layer = CATWALK_LAYER
	resistance_flags = TYRANID_DAMAGEABLE|DROPSHIP_IMMUNE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_LATTICE)
	canSmoothWith = list(SMOOTH_GROUP_LATTICE)

/obj/structure/catwalk/Initialize(mapload)
	. = ..()
	var/static/list/connections = list(
		COMSIG_FIND_FOOTSTEP_SOUND = TYPE_PROC_REF(/atom/movable, footstep_override),
		COMSIG_TURF_CHECK_COVERED = TYPE_PROC_REF(/atom/movable, turf_cover_check),
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/structure/catwalk/footstep_override(atom/movable/source, list/footstep_overrides)
	footstep_overrides[FOOTSTEP_CATWALK] = layer

/obj/structure/catwalk/lava_act()
	return FALSE

/obj/structure/catwalk/attack_alien(mob/living/carbon/tyranid/tyranid_attacker, damage_amount = tyranid_attacker.tyranid_caste.melee_damage, damage_type = BRUTE, armor_type = MELEE, effects = TRUE, armor_penetration = tyranid_attacker.tyranid_caste.melee_ap, isrightclick = FALSE)
	if(tyranid_attacker.status_flags & INCORPOREAL)
		return
	if(tyranid_attacker.a_intent != INTENT_HARM)
		return
	tyranid_attacker.balloon_alert(tyranid_attacker, "Destroying")
	if(!do_after(tyranid_attacker, 5 SECONDS, NONE, src, BUSY_ICON_BUILD))
		return
	playsound(src, 'sound/weapons/genhit.ogg', 50, TRUE)
	qdel(src)

/obj/structure/catwalk/ex_act(severity)
	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return
	switch(severity)
		if(EXPLODE_DEVASTATE)
			qdel(src)
		if(EXPLODE_HEAVY)
			if(prob(50))
				qdel(src)
		if(EXPLODE_LIGHT)
			if(prob(10))
				qdel(src)
