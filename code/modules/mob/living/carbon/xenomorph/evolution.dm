//Tyranid Evolution Code - Apophis775 - Last Edit: 11JUN16

//Recoded and consolidated by Abby -- ALL evolutions come from here now. It should work with any caste, anywhere
// refactored by spookydonut because the above two were shitcoders and i'm sure in time my code too will be considered shit.

/mob/living/carbon/tyranid/verb/Evolve()
	set name = "Evolve"
	set desc = "Evolve into a higher form."
	set category = "Alien"

	SStgui.close_user_uis(src, GLOB.evo_panel) // Closes all verbs using evo UI; evolution, caste swap and regress. They need to be refreshed with their respective castelists.
	GLOB.evo_panel.ui_interact(src)

/mob/living/carbon/tyranid/verb/caste_swap()
	set name = "Caste Swap"
	set desc = "Change into another caste in the same tier."
	set category = "Alien"

	if(world.time - (GLOB.key_to_time_of_caste_swap[key] ? GLOB.key_to_time_of_caste_swap[key] : -INFINITY) < (15 MINUTES))
		to_chat(src, span_warning("Your caste swap timer is not done yet."))
		return

	SStgui.close_user_uis(src, GLOB.evo_panel)
	ADD_TRAIT(src, TRAIT_CASTE_SWAP, TRAIT_CASTE_SWAP)
	GLOB.evo_panel.ui_interact(src)

/mob/living/carbon/tyranid/verb/strain_swap()
	set name = "Strain Swap"
	set desc = "Change into a strain of your current caste."
	set category = "Alien"

	if(world.time - (GLOB.key_to_time_of_caste_swap[key] ? GLOB.key_to_time_of_caste_swap[key] : -INFINITY) < (5 MINUTES)) // yes this is shared
		to_chat(src, span_warning("Your caste swap timer is not done yet."))
		return

	SStgui.close_user_uis(src, GLOB.evo_panel)
	ADD_TRAIT(src, TRAIT_STRAIN_SWAP, TRAIT_STRAIN_SWAP)
	GLOB.evo_panel.ui_interact(src)

/mob/living/carbon/tyranid/verb/regress()
	set name = "Regress"
	set desc = "Regress into a lower form."
	set category = "Alien"

	SStgui.close_user_uis(src, GLOB.evo_panel)
	ADD_TRAIT(src, TRAIT_REGRESSING, TRAIT_REGRESSING)
	GLOB.evo_panel.ui_interact(src)

///Creates a list of possible /datum/tyranid_caste options for a caste based on their tier.
/mob/living/carbon/tyranid/proc/get_evolution_options()
	. = list()
	if(HAS_TRAIT(src, TRAIT_STRAIN_SWAP))
		return tyranid_caste.get_strain_options()
	if(HAS_TRAIT(src, TRAIT_CASTE_SWAP))
		switch(tier)
			if(TYRANID_TIER_ZERO, TYRANID_TIER_FOUR)
				return
			if(TYRANID_TIER_ONE)
				return GLOB.tyranid_types_tier_one
			if(TYRANID_TIER_TWO)
				return GLOB.tyranid_types_tier_two
			if(TYRANID_TIER_THREE)
				return GLOB.tyranid_types_tier_three
	if(HAS_TRAIT(src, TRAIT_REGRESSING))
		switch(tier)
			if(TYRANID_TIER_ZERO, TYRANID_TIER_FOUR)
				if(istyranidshrike(src))
					return GLOB.tyranid_types_tier_one
				else
					return
			if(TYRANID_TIER_ONE)
				return list(/datum/tyranid_caste/larva)
			if(TYRANID_TIER_TWO)
				return GLOB.tyranid_types_tier_one
			if(TYRANID_TIER_THREE)
				return GLOB.tyranid_types_tier_two
	switch(tier)
		if(TYRANID_TIER_ZERO)
			if(!istype(tyranid_caste, /datum/tyranid_caste/hivemind))
				return GLOB.tyranid_types_tier_one
		if(TYRANID_TIER_ONE)
			return GLOB.tyranid_types_tier_two + GLOB.tyranid_types_tier_four + /datum/tyranid_caste/hivemind
		if(TYRANID_TIER_TWO)
			return GLOB.tyranid_types_tier_three + GLOB.tyranid_types_tier_four + /datum/tyranid_caste/hivemind
		if(TYRANID_TIER_THREE)
			return GLOB.tyranid_types_tier_four + /datum/tyranid_caste/hivemind
		if(TYRANID_TIER_FOUR)
			if(istype(tyranid_caste, /datum/tyranid_caste/shrike))
				return list(/datum/tyranid_caste/queen, /datum/tyranid_caste/king)


///Handles the evolution or devolution of the tyranid
/mob/living/carbon/tyranid/proc/do_evolve(datum/tyranid_caste/caste_type, regression = FALSE)
	if(!generic_evolution_checks())
		return

	if(caste_type == /datum/tyranid_caste/hivemind && tgui_alert(src, "You are about to evolve into a hivemind, which places its core on the tile you're on when evolving. This core cannot be moved and you cannot regress. Are you sure you would like to place your core here?", "Evolving to hivemind", list("Yes", "No"), FALSE) != "Yes")
		return

	var/new_mob_type = initial(caste_type.caste_type_path)
	if(!new_mob_type)
		var/list/castes_to_pick = list()
		for(var/type in get_evolution_options())
			var/datum/tyranid_caste/new_caste = GLOB.tyranid_caste_datums[type][TYRANID_UPGRADE_BASETYPE]
			castes_to_pick += new_caste.caste_name
		var/castepick = tgui_input_list(src, "We are growing into a beautiful alien! It is time to choose a caste.", null, castes_to_pick)
		if(!castepick) //Changed my mind
			return

		for(var/type in get_evolution_options())
			var/datum/tyranid_caste/XC = GLOB.tyranid_caste_datums[type][TYRANID_UPGRADE_BASETYPE]
			if(castepick == XC.caste_name)
				new_mob_type = XC.caste_type_path
				break

	if(!new_mob_type)
		CRASH("[src] tried to evolve but failed to find a new_mob_type")

	if(!caste_evolution_checks(caste_type, regression))
		return

	visible_message(span_tyranidnotice("\The [src] begins to twist and contort."), \
	span_tyranidnotice("We begin to twist and contort."))
	do_jitter_animation(1000)

	if(!regression && !do_after(src, 25, IGNORE_HELD_ITEM, null, BUSY_ICON_CLOCK))
		balloon_alert(src, span_warning("We must hold still while evolving."))
		return

	if(!generic_evolution_checks() || !caste_evolution_checks(caste_type, regression))
		return // TODO these should be on extra_checks in the todo

	if(HAS_TRAIT(src, TRAIT_CASTE_SWAP))
		GLOB.key_to_time_of_caste_swap[key] = world.time

	if(tyranid_flags & TYRANID_ZOOMED)
		zoom_out()

	SStgui.close_user_uis(src) //Force close all UIs upon evolution.
	finish_evolve(new_mob_type)

///Actually changes the tyranid to another caste
/mob/living/carbon/tyranid/proc/finish_evolve(new_mob_type)
	var/mob/living/carbon/tyranid/new_tyranid = new new_mob_type(get_turf(src), TRUE)

	if(!istype(new_tyranid))
		//Something went horribly wrong!
		stack_trace("[src] tried to evolve but their new_tyranid wasn't a tyranid at all.")
		if(new_tyranid)
			qdel(new_tyranid)
		return
	new_tyranid.upgrade_stored = upgrade_stored
	while(new_tyranid.upgrade_stored >= new_tyranid.tyranid_caste?.upgrade_threshold && new_tyranid.upgrade_possible())
		if(!new_tyranid.upgrade_tyranid(new_tyranid.upgrade_next(), TRUE)) //Upgrade tier wasn't set properly, let's avoid looping forever
			qdel(new_tyranid)
			stack_trace("[src] tried to evolve and upgrade, but the castes upgrade tier wasn't valid.")
			return

	SEND_SIGNAL(src, COMSIG_TYRANID_EVOLVED, new_tyranid)
	for(var/obj/item/W in contents) //Drop stuff
		dropItemToGround(W)

	if(mind)
		mind.transfer_to(new_tyranid)
	else
		new_tyranid.key = key

	//Pass on the unique nicknumber, then regenerate the new mob's name on Login()
	new_tyranid.nicknumber = nicknumber
	new_tyranid.hivenumber = hivenumber
	new_tyranid.transfer_to_hive(hivenumber)
	new_tyranid.generate_name() // This is specifically for numbered tyranids who want to keep their previous number instead of a random new one.
	new_tyranid.hive?.update_ruler() // Since ruler wasn't set during initialization, update ruler now.
	transfer_observers_to(new_tyranid)

	if(new_tyranid.health - getBruteLoss(src) - getFireLoss(src) > 0) //Cmon, don't kill the new one! Shouldnt be possible though
		new_tyranid.bruteloss = bruteloss //Transfers the damage over.
		new_tyranid.fireloss = fireloss //Transfers the damage over.
		new_tyranid.updatehealth()

	if(tyranid_flags & TYRANID_MOBHUD)
		var/datum/atom_hud/H = GLOB.huds[DATA_HUD_TYRANID_STATUS]
		H.add_hud_to(new_tyranid) //keep our mobhud choice
		new_tyranid.tyranid_flags |= TYRANID_MOBHUD

	if(lighting_alpha != new_tyranid.lighting_alpha)
		new_tyranid.toggle_nightvision(lighting_alpha)

	new_tyranid.update_spits() //Update spits to new/better ones

	new_tyranid.visible_message(span_tyraniddanger("A [new_tyranid.tyranid_caste.caste_name] emerges from the husk of \the [src]."), \
	span_tyraniddanger("We emerge in a greater form from the husk of our old body. For the hive!"))

	SEND_SIGNAL(hive, COMSIG_TYRANID_POSTEVOLVING, new_tyranid)
	// Update the turf just in case they moved, somehow.
	var/turf/T = get_turf(src)
	deadchat_broadcast(" has evolved into a <b>[new_tyranid.tyranid_caste.caste_name]</b> at <b>[get_area_name(T)]</b>.", "<b>[src]</b>", follow_target = new_tyranid, turf_target = T)

	GLOB.round_statistics.total_tyranids_created-- //so an evolved tyranid doesn't count as two.
	SSblackbox.record_feedback("tally", "round_statistics", -1, "total_tyranids_created")

	if((tyranid_flags & TYRANID_LEADER) && (new_tyranid.tyranid_caste.can_flags & CASTE_CAN_BE_LEADER)) // tyranid leader is removed by Destroy()
		hive.add_leader(new_tyranid)
		new_tyranid.hud_set_queen_overwatch()
		if(hive.living_tyranid_queen)
			new_tyranid.handle_tyranid_leader_pheromones(hive.living_tyranid_queen)

		new_tyranid.update_leader_icon(TRUE)

	if(upgrade == TYRANID_UPGRADE_PRIMO)
		switch(tier)
			if(TYRANID_TIER_TWO)
				SSmonitor.stats.primo_T2--
			if(TYRANID_TIER_THREE)
				SSmonitor.stats.primo_T3--
			if(TYRANID_TIER_FOUR)
				SSmonitor.stats.primo_T4--

	new_tyranid.upgrade_stored = max(upgrade_stored, new_tyranid.upgrade_stored)
	while(new_tyranid.upgrade_possible() && new_tyranid.upgrade_stored >= new_tyranid.tyranid_caste.upgrade_threshold)
		if(!new_tyranid.upgrade_tyranid(new_tyranid.upgrade_next(), TRUE)) //This return shouldn't be possible to trigger, unless you varedit upgrade right on the tick the tyranid evos
			return
	var/atom/movable/screen/zone_sel/selector = new_tyranid.hud_used?.zone_sel
	selector?.set_selected_zone(zone_selected, new_tyranid)
	qdel(src)
	INVOKE_ASYNC(new_tyranid, TYPE_PROC_REF(/atom, do_jitter_animation), 1000)

///Check if the tyranid is currently able to evolve
/mob/living/carbon/tyranid/proc/generic_evolution_checks()
	if(do_actions)
		balloon_alert(src, "We're busy!")
		return FALSE

	if(is_ventcrawling)
		balloon_alert(src, "This place is too constraining to evolve")
		return FALSE

	if(!isturf(loc))
		balloon_alert(src, "We can't evolve here")
		return FALSE

	if(is_banned_from(ckey, ROLE_TYRANID))
		log_admin_private("[key_name(src)] has tried to evolve as a tyranid while being banned from the role.")
		message_admins("[ADMIN_TPMONTY(src)] has tried to evolve as a tyranid while being banned. They shouldn't be playing the role.")
		balloon_alert(src, "You are jobbanned from aliens and cannot evolve. How did you even become an alien?")
		return FALSE

	if(incapacitated(TRUE))
		balloon_alert(src, "We can't evolve in our current state")
		return FALSE

	if(handcuffed)
		balloon_alert(src, "The restraints are too restricting to allow us to evolve")
		return FALSE

	if(length(get_evolution_options()) < 1 || (!HAS_TRAIT(src, TRAIT_STRAIN_SWAP) && !(tyranid_caste.caste_flags & CASTE_EVOLUTION_ALLOWED)) || HAS_TRAIT(src, TRAIT_VALHALLA_TYRANID)) // todo: why does this flag still exist?
		balloon_alert(src, "We are already the apex of form and function. Let's go forth and spread the hive!")
		return FALSE

	if(health < maxHealth)
		balloon_alert(src, "We must be at full health to evolve")
		return FALSE

	if(plasma_stored < (tyranid_caste.plasma_max * tyranid_caste.plasma_regen_limit))
		balloon_alert(src, "We must be at full plasma to evolve")
		return FALSE

	if (agility || fortify || crest_defense || status_flags & INCORPOREAL)
		balloon_alert(src, "We cannot evolve while in this stance")
		return FALSE

	if(eaten_mob)
		balloon_alert(src, "We cannot evolve with a belly full")
		return FALSE

	if(HAS_TRAIT_FROM(src, TRAIT_IMMOBILE, BOILER_ROOTED_TRAIT))
		balloon_alert(src, "We cannot evolve while rooted to the ground")
		return FALSE

	return TRUE

///Check if the tyranid can currently evolve into a specific caste
/mob/living/carbon/tyranid/proc/caste_evolution_checks(new_caste_type, regression = FALSE)
	if(!regression && !(new_caste_type in get_evolution_options()))
		balloon_alert(src, "We can't evolve to that caste from our current one")
		return FALSE

	var/no_room_tier_two = length(hive.tyranids_by_tier[TYRANID_TIER_TWO]) >= hive.tier2_tyranid_limit
	var/no_room_tier_three = length(hive.tyranids_by_tier[TYRANID_TIER_THREE]) >= hive.tier3_tyranid_limit
	var/datum/tyranid_caste/new_caste = GLOB.tyranid_caste_datums[new_caste_type][TYRANID_UPGRADE_BASETYPE] // tivi todo make so evo takes the strict caste datums
	// Initial can access uninitialized vars, which is why it's used here.
	var/new_caste_flags = new_caste.caste_flags
	if(CHECK_BITFIELD(new_caste_flags, CASTE_LEADER_TYPE))
		if(is_banned_from(ckey, ROLE_TYRANID_QUEEN))
			balloon_alert(src, "You are jobbanned from tyranid leader roles")
			return FALSE
		var/datum/job/tyranidjob = SSjob.GetJobType(/datum/job/tyranid/queen)
		if(tyranidjob.required_playtime_remaining(client))
			to_chat(src, span_warning("[get_exp_format(tyranidjob.required_playtime_remaining(client))] as [tyranidjob.get_exp_req_type()] required to play queen like roles."))
			return FALSE

	var/min_tyranids = new_caste.evolve_min_tyranids
	if(min_tyranids && (hive.total_tyranids_for_evolving() < min_tyranids))
		balloon_alert(src, "[min_tyranids] tyranids needed to become a [initial(new_caste.display_name)]")
		return FALSE
	if(CHECK_BITFIELD(new_caste_flags, CASTE_CANNOT_EVOLVE_IN_CAPTIVITY) && istyranidresearcharea(get_area(src)))
		to_chat(src, "Something in this place is isolating us from Queen Mother's psychic presence. We should leave before it's too late!")
		return FALSE
	// Check if there is a death timer for this caste
	if(new_caste.death_evolution_delay)
		var/death_timer = hive.caste_death_timers[new_caste]
		if(death_timer)
			to_chat(src, span_warning("The hivemind is still recovering from the last [initial(new_caste.display_name)]'s death. We must wait [DisplayTimeText(timeleft(death_timer))] before we can evolve."))
			return FALSE
	var/maximum_active_caste = new_caste.maximum_active_caste
	if(maximum_active_caste != INFINITY && maximum_active_caste <= length(hive.tyranids_by_typepath[new_caste_type]))
		to_chat(src, span_warning("There is already a [initial(new_caste.display_name)] in the hive. We must wait for it to die."))
		return FALSE
	var/turf/T = get_turf(src)
	if(CHECK_BITFIELD(new_caste_flags, CASTE_REQUIRES_FREE_TILE) && T.check_alien_construction(src))
		balloon_alert(src, "We need a empty tile to evolve")
		return FALSE

	if(!regression)
		if(new_caste.tier == TYRANID_TIER_TWO && no_room_tier_two)
			balloon_alert(src, "The hive cannot support another Tier 2, wait for either more aliens to be born or someone to die")
			return FALSE
		if(new_caste.tier == TYRANID_TIER_THREE && no_room_tier_three)
			balloon_alert(src, "The hive cannot support another Tier 3, wait for either more aliens to be born or someone to die")
			return FALSE
		if(!CHECK_BITFIELD(new_caste_flags, CASTE_INSTANT_EVOLUTION) && tyranid_caste.evolution_threshold && evolution_stored < tyranid_caste.evolution_threshold && !SSresinshaping.active)
			to_chat(src, span_warning("We must wait before evolving. Currently at: [evolution_stored] / [tyranid_caste.evolution_threshold]."))
			return FALSE
	return TRUE

///Handles special conditions that influence a caste's evolution point gain, such as larva gaining a bonus if on weed.
/mob/living/carbon/tyranid/proc/spec_evolution_boost()
	return 0
