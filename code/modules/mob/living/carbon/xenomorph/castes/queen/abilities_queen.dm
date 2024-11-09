// ***************************************
// *********** Hive message
// ***************************************
/datum/action/ability/tyranid_action/hive_message
	name = "Hive Message" // Also known as Word of Queen.
	action_icon_state = "queen_order"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/leader.dmi'
	desc = "Announces a message to the hive."
	ability_cost = 50
	cooldown_duration = 10 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_QUEEN_HIVE_MESSAGE,
	)
	use_state_flags = ABILITY_USE_LYING

/datum/action/ability/tyranid_action/hive_message/action_activate()
	var/mob/living/carbon/tyranid/queen/Q = owner

	//Preferring the use of multiline input as the message box is larger and easier to quickly proofread before sending to hive.
	var/input = stripped_multiline_input(Q, "Maximum message length: [MAX_BROADCAST_LEN]", "Hive Message", "", MAX_BROADCAST_LEN, TRUE)
	//Newlines are of course stripped and replaced with a space.
	input = capitalize(trim(replacetext(input, "\n", " ")))
	if(!input)
		return
	var/filter_result = is_ic_filtered(input)
	if(filter_result)
		to_chat(Q, span_warning("That announcement contained a word prohibited in IC chat! Consider reviewing the server rules.\n<span replaceRegex='show_filtered_ic_chat'>\"[input]\"</span>"))
		SSblackbox.record_feedback(FEEDBACK_TALLY, "ic_blocked_words", 1, lowertext(config.ic_filter_regex.match))
		REPORT_CHAT_FILTER_TO_USER(src, filter_result)
		log_filter("IC", input, filter_result)
		return FALSE
	if(NON_ASCII_CHECK(input))
		to_chat(Q, span_warning("That announcement contained characters prohibited in IC chat! Consider reviewing the server rules."))
		return FALSE

	log_game("[key_name(Q)] has messaged the hive with: \"[input]\"")
	deadchat_broadcast(" has messaged the hive: \"[input]\"", Q, Q)
	var/queens_word = "<span class='maptext' style=font-size:18pt;text-align:center valign='top'><u>HIVE MESSAGE:</u><br></span>" + input

	var/sound/queen_sound = sound(get_sfx(SFX_QUEEN), channel = CHANNEL_ANNOUNCEMENTS)
	var/sound/king_sound = sound('modular_imperium/master_files/sound/voice/alien/xenos_roaring.ogg', channel = CHANNEL_ANNOUNCEMENTS)
	for(var/mob/living/carbon/tyranid/X AS in Q.hive.get_all_tyranids())
		to_chat(X, assemble_alert(
			title = "Hive Announcement",
			subtitle = "From [Q.name]",
			message = input,
			color_override = "purple"
		))
		switch(Q.caste_base_type) // TODO MAKE DYING SOUND A CASTE VAR????
			if(/datum/tyranid_caste/queen, /datum/tyranid_caste/shrike)
				SEND_SOUND(X, queen_sound)
			if(/datum/tyranid_caste/king)
				SEND_SOUND(X, king_sound)
		//Display the ruler's hive message at the top of the game screen.
		X.play_screen_text(queens_word, /atom/movable/screen/text/screen_text/queen_order)

	succeed_activate()
	add_cooldown()


// ***************************************
// *********** Screech
// ***************************************
/datum/action/ability/activable/tyranid/screech
	name = "Screech"
	action_icon_state = "screech"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/queen.dmi'
	desc = "A large area knockdown that causes pain and screen-shake."
	ability_cost = 250
	cooldown_duration = 100 SECONDS
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_SCREECH,
		KEYBINDING_ALTERNATE = COMSIG_TYRANIDABILITY_SCREECH_SWITCH,
	)
	// The type of screech that this ability will be doing.
	var/selected_screech = "screech"

/datum/action/ability/activable/tyranid/screech/on_cooldown_finish()
	to_chat(owner, span_warning("We feel our throat muscles vibrate. We are ready to screech again."))
	return ..()

/datum/action/ability/activable/tyranid/screech/use_ability(atom/A)
	var/mob/living/carbon/tyranid/queen/tyranid_owner = owner

	switch(selected_screech)
		if("screech")
			// Screech is so powerful it kills huggers in our hands.
			for(var/obj/item/clothing/mask/facehugger/hugger in tyranid_owner.get_held_items())
				hugger.kill_hugger()
				tyranid_owner.dropItemToGround(hugger)

			succeed_activate()
			add_cooldown()

			playsound(tyranid_owner.loc, 'sound/voice/alien/queen_screech.ogg', 75, 0)
			tyranid_owner.visible_message(span_tyranidhighdanger("\The [tyranid_owner] emits an ear-splitting guttural roar!"))
			GLOB.round_statistics.queen_screech++
			SSblackbox.record_feedback("tally", "round_statistics", 1, "queen_screech")
			tyranid_owner.create_shriekwave() // Adds the visual effect. Wom wom wom.

			for(var/obj/vehicle/sealed/armored/tank AS in GLOB.tank_list)
				if(get_dist(tank, tyranid_owner) > WORLD_VIEW_NUM)
					continue
				if(tank.z != owner.z)
					continue
				for(var/mob/living/living_victim AS in tank.occupants)
					living_victim.screech_act(tyranid_owner, WORLD_VIEW_NUM) // Todo: The effects of screech are weird due to relying on get_dist for a mob on a diff z-level.

			var/list/nearby_living = list() // If you're a hearer, you get effected more severely.
			for(var/mob/living/living_victim in hearers(WORLD_VIEW, tyranid_owner))
				nearby_living.Add(living_victim)
			for(var/mob/living/living_victim AS in cheap_get_living_near(tyranid_owner, WORLD_VIEW_NUM))
				living_victim.screech_act(tyranid_owner, WORLD_VIEW_NUM, living_victim in nearby_living)
		if("heal_screech")
			succeed_activate()
			add_cooldown(30 SECONDS)

			for(var/mob/living/carbon/tyranid/affected_tyranid in cheap_get_tyranids_near(tyranid_owner, 5))
				if(!tyranid_owner.issametyranidhive(affected_tyranid))
					continue
				// Gives the benefit of Hivelord's Healing Infusion but it is halved in power (lower duration and less ticks of healing).
				affected_tyranid.apply_status_effect(/datum/status_effect/healing_infusion, HIVELORD_HEALING_INFUSION_DURATION / 2, HIVELORD_HEALING_INFUSION_TICKS / 2)

			playsound(tyranid_owner.loc, 'sound/voice/alien/queen_heal_screech.ogg', 75, 0)
			tyranid_owner.visible_message(span_tyranidhighdanger("\The [tyranid_owner] emits an ear-splitting guttural roar!"))
		if("plasma_screech")
			succeed_activate()
			add_cooldown(30 SECONDS)

			for(var/mob/living/carbon/tyranid/affected_tyranid in cheap_get_tyranids_near(tyranid_owner, 5))
				if(!tyranid_owner.issametyranidhive(affected_tyranid) || !(affected_tyranid.tyranid_caste.can_flags & CASTE_CAN_BE_GIVEN_PLASMA))
					continue
				// Gives the benefit of eatting powerfruit, but everything is halved (less plasma immediately restored, less plasma regen given, shorter duration).
				affected_tyranid.apply_status_effect(/datum/status_effect/plasma_surge, affected_tyranid.tyranid_caste.plasma_max / 2, 0.5, 30 SECONDS)

			playsound(tyranid_owner.loc, 'sound/voice/alien/queen_plasma_screech.ogg', 75, 0)
			tyranid_owner.visible_message(span_tyranidhighdanger("\The [tyranid_owner] emits an ear-splitting guttural roar!"))
		if("frenzy_screech")
			succeed_activate()
			add_cooldown(30 SECONDS)

			for(var/mob/living/carbon/tyranid/affected_tyranid in cheap_get_tyranids_near(tyranid_owner, 5))
				if(!tyranid_owner.issametyranidhive(affected_tyranid))
					continue
				// 30 seconds of 10% increase of melee damage.
				affected_tyranid.apply_status_effect(/datum/status_effect/frenzy_screech)

			playsound(tyranid_owner.loc, 'sound/voice/alien/queen_frenzy_screech.ogg', 75, 0)
			tyranid_owner.visible_message(span_tyranidhighdanger("\The [tyranid_owner] emits an ear-splitting guttural roar!"))

/datum/action/ability/activable/tyranid/screech/alternate_action_activate()
	var/mob/living/carbon/tyranid/queen/tyranid_owner = owner
	if(tyranid_owner.upgrade != TYRANID_UPGRADE_PRIMO)
		return
	INVOKE_ASYNC(src, PROC_REF(switch_screech))
	return COMSIG_KB_ACTIVATED

/// Shows a radical menu that lets the owner choose which type of screech they want to use.
/datum/action/ability/activable/tyranid/screech/proc/switch_screech()
	var/screech_images_list = list(
		"Screech" = image('modular_imperium/master_files/icons/tyranid/actions/queen.dmi', icon_state = "screech"),
		"Healing Screech" = image('modular_imperium/master_files/icons/tyranid/actions/queen.dmi', icon_state = "heal_screech"),
		"Plasma Screech" = image('modular_imperium/master_files/icons/tyranid/actions/queen.dmi', icon_state = "plasma_screech"),
		"Frenzy Screech" = image('modular_imperium/master_files/icons/tyranid/actions/queen.dmi', icon_state = "frenzy_screech")
	)
	var/screech_choice = show_radial_menu(owner, owner, screech_images_list, radius = 35)
	if(!screech_choice)
		return
	switch(screech_choice)
		if("Screech")
			selected_screech = "screech"
			name = "Screech ([ability_cost])"
			desc = "A large area knockdown that causes pain and screen-shake."
			to_chat(owner, span_tyranidnotice("Our screech will stun and deaf nearby enemies."))
		if("Healing Screech")
			selected_screech = "heal_screech"
			name = "Healing Screech ([ability_cost])"
			desc = "A beneficial screech that grants health and sunder regeneration to you and nearby allies."
			to_chat(owner, span_tyranidnotice("Our screech will heal nearby allies."))
		if("Plasma Screech")
			selected_screech = "plasma_screech"
			name = "Plasma Screech ([ability_cost])"
			desc = "A beneficial screech that grants plasma regeneration to you and nearby allies."
			to_chat(owner, span_tyranidnotice("Our screech will restore plasma of nearby allies."))
		if("Frenzy Screech")
			selected_screech = "frenzy_screech"
			name = "Frenzy Screech ([ability_cost])"
			desc = "A beneficial screech that grants an increase of 10% melee damage to you and nearby allies."
			to_chat(owner, span_tyranidnotice("Our screech will bolster the damage of nearby allies."))
	update_button_icon()

/datum/action/ability/activable/tyranid/screech/update_button_icon()
	action_icon_state = selected_screech
	return ..()

/datum/action/ability/activable/tyranid/screech/ai_should_start_consider()
	return TRUE

/datum/action/ability/activable/tyranid/screech/ai_should_use(atom/target)
	if(!iscarbon(target))
		return FALSE
	if(get_dist(target, owner) > 4)
		return FALSE
	if(!can_use_ability(target, override_flags = ABILITY_IGNORE_SELECTED_ABILITY))
		return FALSE
	if(target.get_tyranid_hivenumber() == owner.get_tyranid_hivenumber())
		return FALSE
	return TRUE

// ***************************************
// *********** Overwatch
// ***************************************
/datum/action/ability/tyranid_action/watch_tyranid
	name = "Watch Tyranid"
	action_icon_state = "watch_tyranid"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/queen.dmi'
	desc = "See from the target Tyranids vision. Click again the ability to stop observing"
	ability_cost = 0
	use_state_flags = ABILITY_USE_LYING
	hidden = TRUE
	var/overwatch_active = FALSE

/datum/action/ability/tyranid_action/watch_tyranid/give_action(mob/living/L)
	. = ..()
	RegisterSignal(L, COMSIG_MOB_DEATH, PROC_REF(on_owner_death))
	RegisterSignal(L, COMSIG_TYRANID_WATCHTYRANID, PROC_REF(on_list_tyranid_selection))

/datum/action/ability/tyranid_action/watch_tyranid/remove_action(mob/living/L)
	if(overwatch_active)
		stop_overwatch()
	UnregisterSignal(L, list(COMSIG_MOB_DEATH, COMSIG_TYRANID_WATCHTYRANID))
	return ..()

/datum/action/ability/tyranid_action/watch_tyranid/proc/start_overwatch(mob/living/carbon/tyranid/target)
	if(!can_use_action()) // Check for action now done here as action_activate pipeline has been bypassed with signal activation.
		return

	var/mob/living/carbon/tyranid/watcher = owner
	var/mob/living/carbon/tyranid/old_tyranid = watcher.observed_tyranid
	if(old_tyranid == target)
		stop_overwatch(TRUE)
		return
	if(old_tyranid)
		stop_overwatch(FALSE)
	watcher.observed_tyranid = target
	if(istyranidqueen(watcher)) // Only queen needs the eye shown.
		target.hud_set_queen_overwatch()
	watcher.reset_perspective()
	RegisterSignal(target, COMSIG_HIVE_TYRANID_DEATH, PROC_REF(on_tyranid_death))
	RegisterSignals(target, list(COMSIG_TYRANID_EVOLVED, COMSIG_TYRANID_DEEVOLVED), PROC_REF(on_tyranid_evolution))
	RegisterSignal(watcher, COMSIG_MOVABLE_MOVED, PROC_REF(on_movement))
	RegisterSignal(watcher, COMSIG_TYRANID_TAKING_DAMAGE, PROC_REF(on_damage_taken))
	overwatch_active = TRUE
	set_toggle(TRUE)

/datum/action/ability/tyranid_action/watch_tyranid/proc/stop_overwatch(do_reset_perspective = TRUE)
	var/mob/living/carbon/tyranid/watcher = owner
	var/mob/living/carbon/tyranid/observed = watcher.observed_tyranid
	watcher.observed_tyranid = null
	if(!QDELETED(observed))
		UnregisterSignal(observed, list(COMSIG_HIVE_TYRANID_DEATH, COMSIG_TYRANID_EVOLVED, COMSIG_TYRANID_DEEVOLVED))
		if(istyranidqueen(watcher)) // Only queen has to reset the eye overlay.
			observed.hud_set_queen_overwatch()
	if(do_reset_perspective)
		watcher.reset_perspective()
	UnregisterSignal(watcher, list(COMSIG_MOVABLE_MOVED, COMSIG_TYRANID_TAKING_DAMAGE))
	overwatch_active = FALSE
	set_toggle(FALSE)

/datum/action/ability/tyranid_action/watch_tyranid/proc/on_list_tyranid_selection(datum/source, mob/living/carbon/tyranid/selected_tyranid)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(start_overwatch), selected_tyranid)

/datum/action/ability/tyranid_action/watch_tyranid/proc/on_tyranid_evolution(datum/source, mob/living/carbon/tyranid/new_tyranid)
	SIGNAL_HANDLER
	start_overwatch(new_tyranid)

/datum/action/ability/tyranid_action/watch_tyranid/proc/on_tyranid_death(datum/source, mob/living/carbon/tyranid/dead_tyranid)
	SIGNAL_HANDLER
	if(overwatch_active)
		stop_overwatch()

/datum/action/ability/tyranid_action/watch_tyranid/proc/on_owner_death(mob/source, gibbing)
	SIGNAL_HANDLER
	if(overwatch_active)
		stop_overwatch()

/datum/action/ability/tyranid_action/watch_tyranid/proc/on_movement(datum/source, atom/oldloc, direction, Forced)
	SIGNAL_HANDLER
	if(overwatch_active)
		stop_overwatch()

/datum/action/ability/tyranid_action/watch_tyranid/proc/on_damage_taken(datum/source, damage)
	SIGNAL_HANDLER
	if(overwatch_active)
		stop_overwatch()


// ***************************************
// *********** Queen zoom
// ***************************************
/datum/action/ability/tyranid_action/toggle_queen_zoom
	name = "Toggle Queen Zoom"
	action_icon_state = "toggle_queen_zoom"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/queen.dmi'
	desc = "Zoom out for a larger view around wherever you are looking."
	ability_cost = 0
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_TOGGLE_QUEEN_ZOOM,
	)
	use_state_flags = ABILITY_USE_LYING


/datum/action/ability/tyranid_action/toggle_queen_zoom/action_activate()
	var/mob/living/carbon/tyranid/queen/tyranid = owner
	if(tyranid.do_actions)
		return
	if(tyranid.tyranid_flags & TYRANID_ZOOMED)
		zoom_tyranid_out(tyranid.observed_tyranid ? FALSE : TRUE)
		return
	if(!do_after(tyranid, 1 SECONDS, IGNORE_HELD_ITEM, null, BUSY_ICON_GENERIC) || (tyranid.tyranid_flags & TYRANID_ZOOMED))
		return
	zoom_tyranid_in(tyranid.observed_tyranid ? FALSE : TRUE) //No need for feedback message if our eye is elsewhere.


/datum/action/ability/tyranid_action/toggle_queen_zoom/proc/zoom_tyranid_in(message = TRUE)
	var/mob/living/carbon/tyranid/tyranid = owner
	RegisterSignal(tyranid, COMSIG_MOVABLE_MOVED, PROC_REF(on_movement))
	if(message)
		tyranid.visible_message(span_notice("[tyranid] emits a broad and weak psychic aura."),
		span_notice("We start focusing our psychic energy to expand the reach of our senses."), null, 5)
	tyranid.zoom_in(0, 12)


/datum/action/ability/tyranid_action/toggle_queen_zoom/proc/zoom_tyranid_out(message = TRUE)
	var/mob/living/carbon/tyranid/tyranid = owner
	UnregisterSignal(tyranid, COMSIG_MOVABLE_MOVED)
	if(message)
		tyranid.visible_message(span_notice("[tyranid] stops emitting its broad and weak psychic aura."),
		span_notice("We stop the effort of expanding our senses."), null, 5)
	tyranid.zoom_out()


/datum/action/ability/tyranid_action/toggle_queen_zoom/proc/on_movement(datum/source, atom/oldloc, direction, Forced)
	zoom_tyranid_out()


// ***************************************
// *********** Set leader
// ***************************************
/datum/action/ability/tyranid_action/set_tyranid_lead
	name = "Choose/Follow Tyranid Leaders"
	action_icon_state = "tyranid_lead"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/queen.dmi'
	desc = "Make a target Tyranid a leader."
	ability_cost = 200
	use_state_flags = ABILITY_USE_LYING
	hidden = TRUE

/datum/action/ability/tyranid_action/set_tyranid_lead/give_action(mob/living/L)
	. = ..()
	RegisterSignal(L, COMSIG_TYRANID_LEADERSHIP, PROC_REF(try_use_action))

/datum/action/ability/tyranid_action/set_tyranid_lead/remove_action(mob/living/L)
	. = ..()
	UnregisterSignal(L, COMSIG_TYRANID_LEADERSHIP)

/// Signal handler for the set_tyranid_lead action that checks can_use
/datum/action/ability/tyranid_action/set_tyranid_lead/proc/try_use_action(datum/source, mob/living/carbon/tyranid/target)
	SIGNAL_HANDLER
	if(!can_use_action())
		return
	INVOKE_ASYNC(src, PROC_REF(select_tyranid_leader), target)

/// Check if there is an empty slot and promote the passed tyranid to a hive leader
/datum/action/ability/tyranid_action/set_tyranid_lead/proc/select_tyranid_leader(mob/living/carbon/tyranid/selected_tyranid)
	var/mob/living/carbon/tyranid/queen/tyranid_ruler = owner

	if(selected_tyranid.tyranid_flags & TYRANID_LEADER)
		unset_tyranid_leader(selected_tyranid)
		return

	if(tyranid_ruler.tyranid_caste.queen_leader_limit <= length(tyranid_ruler.hive.tyranid_leader_list))
		tyranid_ruler.balloon_alert(tyranid_ruler, "No more leadership slots")
		return

	set_tyranid_leader(selected_tyranid)

/// Remove the passed tyranid's leadership
/datum/action/ability/tyranid_action/set_tyranid_lead/proc/unset_tyranid_leader(mob/living/carbon/tyranid/selected_tyranid)
	var/mob/living/carbon/tyranid/tyranid_ruler = owner
	tyranid_ruler.balloon_alert(tyranid_ruler, "Tyranid demoted")
	selected_tyranid.balloon_alert(selected_tyranid, "Leadership removed")
	selected_tyranid.hive.remove_leader(selected_tyranid)
	selected_tyranid.hud_set_queen_overwatch()
	selected_tyranid.handle_tyranid_leader_pheromones(tyranid_ruler)

	selected_tyranid.update_leader_icon(FALSE)

/// Promote the passed tyranid to a hive leader, should not be called direct
/datum/action/ability/tyranid_action/set_tyranid_lead/proc/set_tyranid_leader(mob/living/carbon/tyranid/selected_tyranid)
	var/mob/living/carbon/tyranid/tyranid_ruler = owner
	if(!(selected_tyranid.tyranid_caste.can_flags & CASTE_CAN_BE_LEADER))
		tyranid_ruler.balloon_alert(tyranid_ruler, "Tyranid cannot lead")
		return
	tyranid_ruler.balloon_alert(tyranid_ruler, "Tyranid promoted")
	selected_tyranid.balloon_alert(selected_tyranid, "Promoted to leader")
	to_chat(selected_tyranid, span_tyranidannounce("[tyranid_ruler] has selected us as a Hive Leader. The other Tyranids must listen to us. We will also act as a beacon for the Queen's pheromones."))

	tyranid_ruler.hive.add_leader(selected_tyranid)
	selected_tyranid.hud_set_queen_overwatch()
	selected_tyranid.handle_tyranid_leader_pheromones(tyranid_ruler)
	notify_ghosts("\ [tyranid_ruler] has designated [selected_tyranid] as a Hive Leader", source = selected_tyranid, action = NOTIFY_ORBIT)

	selected_tyranid.update_leader_icon(TRUE)

// ***************************************
// *********** Queen Acidic Salve
// ***************************************
/datum/action/ability/activable/tyranid/psychic_cure/queen_give_heal
	name = "Heal"
	action_icon_state = "heal_tyranid"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/drone.dmi'
	desc = "Apply a minor heal to the target."
	cooldown_duration = 5 SECONDS
	ability_cost = 150
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_QUEEN_HEAL,
	)
	heal_range = HIVELORD_HEAL_RANGE
	target_flags = ABILITY_MOB_TARGET
	/// Should this ability be usable on moving targets and use an alternative flavortext?
	var/hivemind_heal = FALSE

/datum/action/ability/activable/tyranid/psychic_cure/queen_give_heal/use_ability(atom/target)
	if(owner.do_actions)
		return FALSE
	if(!do_after(owner, 1 SECONDS, hivemind_heal ? IGNORE_TARGET_LOC_CHANGE : NONE, target, BUSY_ICON_FRIENDLY, BUSY_ICON_MEDICAL))
		return FALSE
	if(!can_use_ability(target, TRUE))
		return FALSE

	if(!hivemind_heal)
		target.visible_message(span_tyranidwarning("\the [owner] vomits acid over [target], mending their wounds!"))
	else
		owner.visible_message(span_tyranidwarning("A faint psychic aura is suddenly emitted from \the [owner]!"), \
		span_tyranidwarning("We cure [target] with the power of our mind!"))
		target.visible_message(span_tyranidwarning("[target] lightly shimmers in a chill light."), \
		span_tyranidwarning("We feel a soothing chill."))

	playsound(target, SFX_ALIEN_DROOL, 25)
	new /obj/effect/temp_visual/telekinesis(get_turf(target))
	var/mob/living/carbon/tyranid/patient = target
	patient.salve_healing()
	owner.changeNext_move(CLICK_CD_RANGE)
	succeed_activate()
	add_cooldown()
	if(owner.client)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[owner.ckey]
		personal_statistics.heals++

/// Heals the target.
/mob/living/carbon/tyranid/proc/salve_healing()
	var/amount = 50
	if(recovery_aura)
		amount += recovery_aura * maxHealth * 0.01
	var/remainder = max(0, amount - getBruteLoss())
	adjustBruteLoss(-amount)
	adjustFireLoss(-remainder, updating_health = TRUE)
	adjust_sunder(-amount/10)

// ***************************************
// *********** Queen plasma
// ***************************************
/datum/action/ability/activable/tyranid/queen_give_plasma
	name = "Give Plasma"
	action_icon_state = "queen_give_plasma"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/queen.dmi'
	desc = "Give plasma to a target Tyranid (you must be overwatching them.)"
	ability_cost = 150
	cooldown_duration = 8 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_QUEEN_GIVE_PLASMA,
	)
	use_state_flags = ABILITY_USE_LYING
	target_flags = ABILITY_MOB_TARGET

/datum/action/ability/activable/tyranid/queen_give_plasma/can_use_ability(atom/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE
	if(!istyranid(target))
		return FALSE
	var/mob/living/carbon/tyranid/receiver = target
	if(!CHECK_BITFIELD(use_state_flags|override_flags, ABILITY_IGNORE_DEAD_TARGET) && receiver.stat == DEAD)
		if(!silent)
			receiver.balloon_alert(owner, "Cannot give plasma, dead")
		return FALSE
	if(!CHECK_BITFIELD(receiver.tyranid_caste.can_flags, CASTE_CAN_BE_GIVEN_PLASMA))
		if(!silent)
			receiver.balloon_alert(owner, "Cannot give plasma")
			return FALSE
	var/mob/living/carbon/tyranid/giver = owner
	if(giver.z != receiver.z)
		if(!silent)
			receiver.balloon_alert(owner, "Cannot give plasma, too far")
		return FALSE
	if(receiver.plasma_stored >= receiver.tyranid_caste.plasma_max)
		if(!silent)
			receiver.balloon_alert(owner, "Cannot give plasma, full")
		return FALSE


/datum/action/ability/activable/tyranid/queen_give_plasma/give_action(mob/living/L)
	. = ..()
	RegisterSignal(L, COMSIG_TYRANID_QUEEN_PLASMA, PROC_REF(try_use_ability))

/datum/action/ability/activable/tyranid/queen_give_plasma/remove_action(mob/living/L)
	. = ..()
	UnregisterSignal(L, COMSIG_TYRANID_QUEEN_PLASMA)

/// Signal handler for the queen_give_plasma action that checks can_use
/datum/action/ability/activable/tyranid/queen_give_plasma/proc/try_use_ability(datum/source, mob/living/carbon/tyranid/target)
	SIGNAL_HANDLER
	if(!can_use_ability(target, FALSE, ABILITY_IGNORE_SELECTED_ABILITY))
		return
	use_ability(target)

/datum/action/ability/activable/tyranid/queen_give_plasma/use_ability(atom/target)
	var/mob/living/carbon/tyranid/receiver = target
	add_cooldown()
	receiver.gain_plasma(300)
	succeed_activate()
	receiver.balloon_alert_to_viewers("Queen plasma", ignored_mobs = GLOB.alive_human_list)
	if (get_dist(owner, receiver) > 7)
		// Out of screen transfer.
		owner.balloon_alert(owner, "Transferred plasma")


#define BULWARK_LOOP_TIME 1 SECONDS
#define BULWARK_RADIUS 4
#define BULWARK_ARMOR_MULTIPLIER 0.25

/datum/action/ability/tyranid_action/bulwark
	name = "Royal Bulwark"
	action_icon_state = "bulwark"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/queen.dmi'
	desc = "Creates a field of defensive energy, filling gaps in the armor of nearby sisters, making them more resilient."
	ability_cost = 100
	cooldown_duration = 20 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_QUEEN_BULWARK,
	)
	/// assoc list tyranid = armor_diff
	var/list/armor_mod_keys = list()

/datum/action/ability/tyranid_action/bulwark/action_activate()
	var/list/turf/affected_turfs = RANGE_TURFS(BULWARK_RADIUS, owner)
	add_cooldown()

	for(var/turf/target AS in affected_turfs)
		//yes I realize this adds and removes it every move but its simple
		//also we use this and not aura because we want speedy updates on entering
		RegisterSignal(target, COMSIG_ATOM_EXITED, PROC_REF(remove_buff))
		RegisterSignal(target, COMSIG_ATOM_ENTERED, PROC_REF(apply_buff))
		ADD_TRAIT(target, TRAIT_BULWARKED_TURF, TYRANID_TRAIT)
		for(var/mob/living/carbon/tyranid/tyranid in target)
			apply_buff(null, tyranid)

	var/obj/effect/abstract/particle_holder/aoe_particles = new(owner.loc, /particles/bulwark_aoe)
	aoe_particles.particles.position = generator(GEN_SQUARE, 0, 16 + (BULWARK_RADIUS-1)*32, LINEAR_RAND)
	while(do_after(owner, BULWARK_LOOP_TIME, IGNORE_HELD_ITEM, user_display = BUSY_ICON_MEDICAL, extra_checks = CALLBACK(src, TYPE_PROC_REF(/datum/action, can_use_action), FALSE, ABILITY_IGNORE_COOLDOWN|ABILITY_USE_BUSY)))
		succeed_activate()

	aoe_particles.particles.spawning = 0
	QDEL_IN(aoe_particles, 4 SECONDS)

	for(var/turf/target AS in affected_turfs)
		UnregisterSignal(target, list(COMSIG_ATOM_EXITED, COMSIG_ATOM_ENTERED))
		REMOVE_TRAIT(target, TRAIT_BULWARKED_TURF, TYRANID_TRAIT)
		for(var/mob/living/carbon/tyranid/tyranid AS in armor_mod_keys)
			remove_buff(null, tyranid)
	affected_turfs = null

///adds buff to tyranids
/datum/action/ability/tyranid_action/bulwark/proc/apply_buff(datum/source, mob/living/carbon/tyranid/tyranid, direction)
	SIGNAL_HANDLER
	if(!istyranid(tyranid) || armor_mod_keys[tyranid] || !owner.issametyranidhive(tyranid))
		return
	var/datum/armor/basearmor = getArmor(arglist(tyranid.tyranid_caste.soft_armor))
	var/datum/armor/armordiff = basearmor.scaleAllRatings(BULWARK_ARMOR_MULTIPLIER)
	tyranid.soft_armor = tyranid.soft_armor.attachArmor(armordiff)
	armor_mod_keys[tyranid] = armordiff

///removes the buff from tyranids
/datum/action/ability/tyranid_action/bulwark/proc/remove_buff(datum/source, mob/living/carbon/tyranid/tyranid, direction)
	SIGNAL_HANDLER
	if(direction) // triggered by moving signal, check if next turf is in bulwark
		var/turf/next = get_step(source, direction)
		if(HAS_TRAIT(next, TRAIT_BULWARKED_TURF))
			return
	if(armor_mod_keys[tyranid])
		tyranid.soft_armor = tyranid.soft_armor.detachArmor(armor_mod_keys[tyranid])
		armor_mod_keys -= tyranid

/particles/bulwark_aoe
	icon = 'icons/effects/particles/generic_particles.dmi'
	icon_state = list("cross" = 1, "x" = 1, "rectangle" = 1, "up_arrow" = 1, "down_arrow" = 1, "square" = 1)
	width = 500
	height = 500
	count = 2000
	spawning = 50
	gravity = list(0, 0.1)
	color = LIGHT_COLOR_PURPLE
	lifespan = 13
	fade = 5
	fadein = 5
	scale = 0.8
	friction = generator(GEN_NUM, 0.1, 0.15)
	spin = generator(GEN_NUM, -20, 20)
