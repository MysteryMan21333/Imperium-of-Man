#define TIME_TO_TRANSFORM 1 SECONDS

/mob/living/carbon/tyranid/hivemind
	caste_base_type =/datum/tyranid_caste/hivemind
	name = "Hivemind"
	real_name = "Hivemind"
	desc = "A glorious singular entity."

	icon_state = "hivemind_marker"
	bubble_icon = "alienroyal"
	icon = 'modular_imperium/master_files/icons/tyranid/castes/hivemind.dmi'
	status_flags = GODMODE | INCORPOREAL
	resistance_flags = RESIST_ALL|BANISH_IMMUNE
	pass_flags = PASS_LOW_STRUCTURE|PASSABLE|PASS_FIRE //to prevent hivemind eye to catch fire when crossing lava
	density = FALSE

	a_intent = INTENT_HELP

	health = 1000
	maxHealth = 1000
	plasma_stored = 5
	tier = TYRANID_TIER_ZERO
	upgrade = TYRANID_UPGRADE_BASETYPE

	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	see_invisible = SEE_INVISIBLE_LIVING
	invisibility = INVISIBILITY_MAXIMUM
	sight = SEE_MOBS|SEE_TURFS|SEE_OBJS
	see_in_dark = 8
	move_on_shuttle = TRUE

	hud_type = /datum/hud/hivemind
	hud_possible = list(PLASMA_HUD, HEALTH_HUD_TYRANID, PHEROMONE_HUD, TYRANID_RANK_HUD, QUEEN_OVERWATCH_HUD, TYRANID_BLESSING_HUD, TYRANID_EVASION_HUD)
	///The core of our hivemind
	var/datum/weakref/core
	///The minimum health we can have
	var/minimum_health = -300

/mob/living/carbon/tyranid/hivemind/Initialize(mapload)
	var/obj/structure/tyranid/hivemindcore/new_core = new /obj/structure/tyranid/hivemindcore(loc, hivenumber)
	core = WEAKREF(new_core)
	. = ..()
	new_core.parent = WEAKREF(src)
	RegisterSignal(src, COMSIG_TYRANID_CORE_RETURN, PROC_REF(return_to_core))
	RegisterSignal(src, COMSIG_TYRANID_HIVEMIND_CHANGE_FORM, PROC_REF(change_form))
	update_action_buttons()

/mob/living/carbon/tyranid/hivemind/upgrade_possible()
	return FALSE

/mob/living/carbon/tyranid/hivemind/upgrade_tyranid(newlevel, silent = FALSE)
	newlevel = TYRANID_UPGRADE_BASETYPE
	return ..()

/mob/living/carbon/tyranid/hivemind/updatehealth()
	if(on_fire)
		ExtinguishMob()
	health = maxHealth - getFireLoss() - getBruteLoss() //Tyranids can only take brute and fire damage.
	if(health <= 0 && !(status_flags & INCORPOREAL))
		setBruteLoss(0)
		setFireLoss(-minimum_health)
		change_form()
		remove_status_effect(/datum/status_effect/spacefreeze)
	health = maxHealth - getFireLoss() - getBruteLoss()
	med_hud_set_health()
	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		return
	update_wounds()

/mob/living/carbon/tyranid/hivemind/handle_living_health_updates()
	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		return
	var/turf/T = loc
	if(!istype(T))
		return
	// If manifested and off weeds, lets deal some damage.
	if(!(status_flags & INCORPOREAL) && !loc_weeds_type)
		adjustBruteLoss(20 * TYRANID_RESTING_HEAL, TRUE)
		return
	// If not manifested
	if(health < minimum_health + maxHealth)
		setBruteLoss(0)
		setFireLoss(-minimum_health)
	if(health >= maxHealth) //can't regenerate.
		updatehealth() //Update health-related stats, like health itself (using brute and fireloss), health HUD and status.
		return
	heal_wounds(TYRANID_RESTING_HEAL)
	updatehealth()

/mob/living/carbon/tyranid/hivemind/Destroy()
	var/obj/structure/tyranid/hivemindcore/hive_core = get_core()
	if(hive_core)
		qdel(hive_core)
	return ..()


/mob/living/carbon/tyranid/hivemind/on_death()
	var/obj/structure/tyranid/hivemindcore/hive_core = get_core()
	if(!QDELETED(hive_core))
		qdel(hive_core)
	return ..()

/mob/living/carbon/tyranid/hivemind/gib()
	return_to_core()

/mob/living/carbon/tyranid/hivemind/set_resting()
	return

/mob/living/carbon/tyranid/hivemind/change_form()
	if(status_flags & INCORPOREAL && health != maxHealth)
		to_chat(src, span_tyranidwarning("You do not have the strength to manifest yet!"))
		return
	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		return
	wound_overlay.icon_state = "none"
	TIMER_COOLDOWN_START(src, COOLDOWN_HIVEMIND_MANIFESTATION, TIME_TO_TRANSFORM)
	invisibility = 0
	flick(status_flags & INCORPOREAL ? "Hivemind_[initial(loc_weeds_type.color_variant)]_materialisation" : "Hivemind_[initial(loc_weeds_type.color_variant)]_materialisation_reverse", src)
	setDir(SOUTH)
	addtimer(CALLBACK(src, PROC_REF(do_change_form)), TIME_TO_TRANSFORM)

/mob/living/carbon/tyranid/hivemind/set_jump_component(duration = 0.5 SECONDS, cooldown = 2 SECONDS, cost = 0, height = 16, sound = null, flags = JUMP_SHADOW, jump_pass_flags = PASS_LOW_STRUCTURE|PASS_FIRE|PASS_TANK)
	return //no jumping, bad hivemind

///Finish the form changing of the hivemind and give the needed stats
/mob/living/carbon/tyranid/hivemind/proc/do_change_form()
	LAZYCLEARLIST(movespeed_modification)
	update_movespeed()
	if(status_flags & INCORPOREAL)
		status_flags = NONE
		resistance_flags = BANISH_IMMUNE
		pass_flags = PASS_LOW_STRUCTURE|PASS_MOB|PASS_TYRANID
		density = TRUE
		hive.tyranids_by_upgrade[upgrade] -= src
		upgrade = TYRANID_UPGRADE_MANIFESTATION
		set_datum(FALSE)
		hive.tyranids_by_upgrade[upgrade] += src
		update_wounds()
		update_icon()
		update_action_buttons()
		return
	status_flags = initial(status_flags)
	resistance_flags = initial(resistance_flags)
	pass_flags = initial(pass_flags)
	density = FALSE
	hive.tyranids_by_upgrade[upgrade] -= src
	upgrade = TYRANID_UPGRADE_BASETYPE
	set_datum(FALSE)
	hive.tyranids_by_upgrade[upgrade] += src
	setDir(SOUTH)
	update_wounds()
	update_icon()
	update_action_buttons()
	handle_weeds_adjacent_removed()

/mob/living/carbon/tyranid/hivemind/fire_act(burn_level)
	return_to_core()
	to_chat(src, span_tyranidnotice("We were on top of fire, we got moved to our core."))

/mob/living/carbon/tyranid/hivemind/proc/check_weeds(turf/T, strict_turf_check = FALSE)
	SHOULD_BE_PURE(TRUE)
	if(isnull(T))
		return FALSE
	. = TRUE
	if(locate(/obj/fire/flamer) in T)
		return FALSE
	for(var/obj/alien/weeds/W in range(strict_turf_check ? 0 : 1, T ? T : get_turf(src)))
		if(QDESTROYING(W))
			continue
		return
	return FALSE

/mob/living/carbon/tyranid/hivemind/handle_weeds_adjacent_removed()
	if(loc_weeds_type || check_weeds(get_turf(src)))
		return
	return_to_core()
	to_chat(src, span_tyranidnotice("We had no weeds nearby, we got moved to our core."))
	return

/mob/living/carbon/tyranid/hivemind/proc/return_to_core()
	if(!(status_flags & INCORPOREAL) && !TIMER_COOLDOWN_CHECK(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		do_change_form()
	for(var/obj/item/explosive/grenade/sticky/sticky_bomb in contents)
		sticky_bomb.clean_refs()
		sticky_bomb.forceMove(loc)
	forceMove(get_turf(get_core()))

///Start the teleportation process to send the hivemind manifestation to the selected turf
/mob/living/carbon/tyranid/hivemind/proc/start_teleport(turf/T)
	if(!isopenturf(T))
		balloon_alert(src, "Can't teleport into a wall")
		return
	TIMER_COOLDOWN_START(src, COOLDOWN_HIVEMIND_MANIFESTATION, TIME_TO_TRANSFORM * 2)
	flick("Hivemind_[initial(loc_weeds_type.color_variant)]_materialisation_reverse", src)
	setDir(SOUTH)
	addtimer(CALLBACK(src, PROC_REF(end_teleport), T), TIME_TO_TRANSFORM)

///Finish the teleportation process to send the hivemind manifestation to the selected turf
/mob/living/carbon/tyranid/hivemind/proc/end_teleport(turf/T)
	if(!check_weeds(T, TRUE))
		balloon_alert(src, "No weeds in destination")
		return
	forceMove(T)
	flick("Hivemind_[initial(loc_weeds_type.color_variant)]_materialisation", src)
	setDir(SOUTH)

/mob/living/carbon/tyranid/hivemind/Move(atom/newloc, direction, glide_size_override)
	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		return
	if(!(status_flags & INCORPOREAL))
		return ..()
	if(!check_weeds(newloc))
		return FALSE

	// FIXME: Port canpass refactor from tg
	// Don't allow them over the timed_late doors
	var/obj/machinery/door/poddoor/timed_late/door = locate() in newloc
	if(door && !door.CanPass(src, newloc))
		return FALSE

	abstract_move(newloc)

/mob/living/carbon/tyranid/hivemind/receive_hivemind_message(mob/living/carbon/tyranid/speaker, message)
	var/track = "<a href='?src=[REF(src)];hivemind_jump=[REF(speaker)]'>(F)</a>"
	show_message("[track] [speaker.hivemind_start()] [span_message("hisses, '[message]'")][speaker.hivemind_end()]", 2)

/mob/living/carbon/tyranid/hivemind/Topic(href, href_list)
	. = ..()
	if(.)
		return
	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		return
	if(href_list["hivemind_jump"])
		var/mob/living/carbon/tyranid/tyranid = locate(href_list["hivemind_jump"])
		if(!istype(tyranid))
			return
		jump(tyranid)

/// Jump hivemind's camera to the passed tyranid, if they are on/near weeds
/mob/living/carbon/tyranid/hivemind/proc/jump(mob/living/carbon/tyranid/tyranid)
	if(!check_weeds(get_turf(tyranid), TRUE))
		balloon_alert(src, "No nearby weeds")
		return
	if(!(status_flags & INCORPOREAL))
		start_teleport(get_turf(tyranid))
		return
	abstract_move(get_turf(tyranid))

/// handles hivemind updating with their respective weedtype
/mob/living/carbon/tyranid/hivemind/update_icon_state()
	. = ..()
	if(status_flags & INCORPOREAL)
		icon_state = "hivemind_marker"
		return
	icon_state = "Hivemind_[initial(loc_weeds_type.color_variant)]"

/mob/living/carbon/tyranid/hivemind/update_icons()
	return

/mob/living/carbon/tyranid/hivemind/med_hud_set_health()
	var/image/holder = hud_list[HEALTH_HUD_TYRANID]
	if(!holder)
		return

	if(status_flags & INCORPOREAL)
		holder.icon_state = ""

	var/amount = round(health * 100 / maxHealth, 10)
	if(!amount)
		amount = 1 //don't want the 'zero health' icon when we still have 4% of our health
	holder.icon_state = "health[amount]"

/mob/living/carbon/tyranid/hivemind/DblClickOn(atom/A, params)
	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		return
	var/list/modifiers = params2list(params)
	if(modifiers["right"])
		return
	var/turf/target_turf = get_turf(A)
	if(!check_weeds(target_turf, TRUE))
		return
	if(!(status_flags & INCORPOREAL))
		start_teleport(target_turf)
		return
	setDir(SOUTH)
	abstract_move(target_turf)

/mob/living/carbon/tyranid/hivemind/CtrlClick(mob/user)
	if(!(status_flags & INCORPOREAL))
		return ..()
	return FALSE

/mob/living/carbon/tyranid/hivemind/CtrlShiftClickOn(atom/A)
	if(!(status_flags & INCORPOREAL))
		return ..()
	return FALSE

/mob/living/carbon/tyranid/hivemind/a_intent_change()
	return //Unable to change intent, forced help intent

/// Hiveminds specifically have no status hud element
/mob/living/carbon/tyranid/hivemind/med_hud_set_status()
	return

/mob/living/carbon/tyranid/hivemind/update_progression()
	return

/obj/fire/flamer/CanAllowThrough(atom/movable/mover, turf/target)
	if(istyranidhivemind(mover))
		return FALSE
	return ..()

/// Getter proc for the weakref'd core
/mob/living/carbon/tyranid/hivemind/proc/get_core()
	return core?.resolve()

// =================
// hivemind core
/obj/structure/tyranid/hivemindcore
	name = "hivemind core"
	desc = "A very weird, pulsating node. This looks almost alive."
	max_integrity = 600
	icon = 'modular_imperium/master_files/icons/tyranid/1x1building.dmi'
	icon_state = "hivemind_core"
	tyranid_structure_flags = CRITICAL_STRUCTURE|DEPART_DESTRUCTION_IMMUNE
	///The cooldown of the alert hivemind gets when a hostile is near it's core
	COOLDOWN_DECLARE(hivemind_proxy_alert_cooldown)
	///The weakref to the parent hivemind mob that we're attached to
	var/datum/weakref/parent

/obj/structure/tyranid/hivemindcore/Initialize(mapload)
	. = ..()
	GLOB.hive_datums[hivenumber].hivemindcores += src
	new /obj/alien/weeds/node(loc)
	set_light(7, 5, LIGHT_COLOR_PURPLE)
	for(var/turfs in RANGE_TURFS(TYRANID_HIVEMIND_DETECTION_RANGE, src))
		RegisterSignal(turfs, COMSIG_ATOM_ENTERED, PROC_REF(hivemind_proxy_alert))

/obj/structure/tyranid/hivemindcore/Destroy()
	GLOB.hive_datums[hivenumber].hivemindcores -= src
	var/mob/living/carbon/tyranid/hivemind/our_parent = get_parent()
	if(isnull(our_parent))
		return ..()
	our_parent.playsound_local(our_parent, SFX_ALIEN_HELP, 30, TRUE)
	to_chat(our_parent, span_tyranidhighdanger("Your core has been destroyed!"))
	tyranid_message("A sudden tremor ripples through the hive... \the [our_parent] has been slain!", "tyranidannounce", 5, our_parent.hivenumber)
	GLOB.key_to_time_of_role_death[our_parent.key] = world.time
	GLOB.key_to_time_of_death[our_parent.key] = world.time
	our_parent.ghostize()
	if(!QDELETED(our_parent))
		qdel(our_parent)
	return ..()

//hivemind cores

/obj/structure/tyranid/hivemindcore/attack_alien(mob/living/carbon/tyranid/tyranid_attacker, damage_amount = tyranid_attacker.tyranid_caste.melee_damage, damage_type = BRUTE, armor_type = MELEE, effects = TRUE, armor_penetration = tyranid_attacker.tyranid_caste.melee_ap, isrightclick = FALSE)
	if(istyranidqueen(tyranid_attacker))
		var/choice = tgui_alert(tyranid_attacker, "Are you sure you want to destroy the hivemind?", "Destroy hivemind", list("Yes", "Cancel"))
		if(choice == "Yes")
			deconstruct(FALSE)
			return

	tyranid_attacker.visible_message(span_danger("[tyranid_attacker] nudges its head against [src]."), \
	span_danger("You nudge your head against [src]."))

/obj/structure/tyranid/hivemindcore/take_damage(damage_amount, damage_type = BRUTE, armor_type = null, effects = TRUE, attack_dir, armour_penetration = 0, mob/living/blame_mob)
	. = ..()
	var/mob/living/carbon/tyranid/hivemind/our_parent = get_parent()
	if(isnull(our_parent))
		return
	var/health_percent = round((max_integrity / obj_integrity) * 100)
	switch(health_percent)
		if(-INFINITY to 25)
			to_chat(our_parent, span_tyranidhighdanger("Your core is under attack, and dangerous low on health!"))
		if(26 to 75)
			to_chat(our_parent, span_tyraniddanger("Your core is under attack, and low on health!"))
		if(76 to INFINITY)
			to_chat(our_parent, span_tyraniddanger("Your core is under attack!"))

/**
 * Proc checks if we should alert the hivemind, and if it can, it does so.
 * datum/source - the atom (in this case it should be a turf) sending the crossed signal
 * atom/movable/hostile - the atom that triggered the crossed signal, in this case we're looking for a mob
 */
/obj/structure/tyranid/hivemindcore/proc/hivemind_proxy_alert(datum/source, atom/movable/hostile)
	SIGNAL_HANDLER
	if(!COOLDOWN_CHECK(src, hivemind_proxy_alert_cooldown)) //Proxy alert triggered too recently; abort
		return

	if(!isliving(hostile))
		return

	var/mob/living/living_triggerer = hostile
	if(living_triggerer.stat == DEAD) //We don't care about the dead
		return

	if(istyranid(hostile))
		var/mob/living/carbon/tyranid/X = hostile
		if(X.hivenumber == hivenumber) //Trigger proxy alert only for hostile tyranids
			return

	to_chat(get_parent(), span_tyranidannounce("Our [src.name] has detected a nearby hostile [hostile] at [get_area(hostile)] (X: [hostile.x], Y: [hostile.y])."))
	SEND_SOUND(get_parent(), 'sound/voice/alien/help1.ogg')
	COOLDOWN_START(src, hivemind_proxy_alert_cooldown, TYRANID_HIVEMIND_DETECTION_COOLDOWN) //set the cooldown.

/// Getter for the parent of this hive core
/obj/structure/tyranid/hivemindcore/proc/get_parent()
	return parent?.resolve()
