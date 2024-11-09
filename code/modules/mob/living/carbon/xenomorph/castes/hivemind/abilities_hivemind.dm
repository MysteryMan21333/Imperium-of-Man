/datum/action/ability/tyranid_action/return_to_core
	name = "Return to Core"
	action_icon_state = "lay_hivemind"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/hivemind.dmi'
	desc = "Teleport back to your core."
	use_state_flags = ABILITY_USE_SOLIDOBJECT

/datum/action/ability/tyranid_action/return_to_core/action_activate()
	SEND_SIGNAL(owner, COMSIG_TYRANID_CORE_RETURN)
	return ..()

/datum/action/ability/activable/tyranid/secrete_resin/hivemind/can_use_action(silent = FALSE, override_flags, selecting = FALSE)
	if (owner.status_flags & INCORPOREAL)
		return FALSE
	return ..()

/datum/action/ability/activable/tyranid/secrete_special_resin/hivemind/can_use_action(silent = FALSE, override_flags, selecting = FALSE)
	if (owner.status_flags & INCORPOREAL)
		return FALSE
	return ..()

/datum/action/ability/tyranid_action/change_form
	name = "Change form"
	action_icon_state = "manifest"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/hivemind.dmi'
	desc = "Change from your incorporeal form to your physical on and vice-versa."
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANID_HIVEMIND_CHANGE_FORM,
	)
	use_state_flags = ABILITY_USE_SOLIDOBJECT

/datum/action/ability/tyranid_action/change_form/action_activate()
	var/mob/living/carbon/tyranid/tyranid_owner = owner
	tyranid_owner.change_form()

/datum/action/ability/activable/tyranid/command_minions
	name = "Command minions"
	action_icon_state = "minion_agressive"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/leader.dmi'
	desc = "Command all minions, ordering them to converge on this location. Rightclick to change minion behaviour."
	ability_cost = 100
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_RALLY_MINION,
		KEYBINDING_ALTERNATE = COMSIG_TYRANIDABILITY_MINION_BEHAVIOUR,
	)
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	cooldown_duration = 60 SECONDS
	use_state_flags = ABILITY_USE_LYING|ABILITY_USE_BUCKLED
	///If minions should be agressive
	var/minions_agressive = TRUE

/datum/action/ability/activable/tyranid/command_minions/update_button_icon()
	action_icon_state = minions_agressive ? "minion_agressive" : "minion_passive"
	return ..()

/datum/action/ability/activable/tyranid/command_minions/use_ability(atom/target)
	var/turf_targeted = get_turf(target)
	if(!turf_targeted)
		return
	new /obj/effect/ai_node/goal(turf_targeted, owner)
	succeed_activate()
	add_cooldown()

/datum/action/ability/activable/tyranid/command_minions/alternate_action_activate()
	minions_agressive = !minions_agressive
	SEND_SIGNAL(owner, COMSIG_ESCORTING_ATOM_BEHAVIOUR_CHANGED, minions_agressive)
	update_button_icon()

/datum/action/ability/activable/tyranid/psychic_cure/queen_give_heal/hivemind
	hivemind_heal = TRUE

/datum/action/ability/activable/tyranid/psychic_cure/queen_give_heal/hivemind/can_use_action(silent = FALSE, override_flags, selecting = FALSE)
	if (owner.status_flags & INCORPOREAL)
		return FALSE
	return ..()

/datum/action/ability/activable/tyranid/transfer_plasma/hivemind
	plasma_transfer_amount = PLASMA_TRANSFER_AMOUNT * 2

/datum/action/ability/activable/tyranid/transfer_plasma/hivemind/can_use_action(silent = FALSE, override_flags, selecting = FALSE)
	if (owner.status_flags & INCORPOREAL)
		return FALSE
	return ..()

/datum/action/ability/tyranid_action/pheromones/hivemind/can_use_action(silent = FALSE, override_flags)
	if (owner.status_flags & INCORPOREAL)
		return FALSE
	return ..()

/datum/action/ability/tyranid_action/watch_tyranid/hivemind/can_use_action(silent = FALSE, override_flags)
	if(TIMER_COOLDOWN_CHECK(owner, COOLDOWN_HIVEMIND_MANIFESTATION))
		return FALSE
	return ..()

/datum/action/ability/tyranid_action/watch_tyranid/hivemind/on_list_tyranid_selection(datum/source, mob/living/carbon/tyranid/selected_tyranid)
	if(!can_use_action())
		return
	var/mob/living/carbon/tyranid/hivemind/hivemind = source
	hivemind.jump(selected_tyranid)

/datum/action/ability/tyranid_action/teleport
	name = "Teleport"
	action_icon_state = "resync" // TODO: i think i missed an icon
	desc = "Pick a location on the map and instantly manifest there if possible."
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMISG_TYRANID_HIVEMIND_TELEPORT,
	)
	use_state_flags = ABILITY_USE_SOLIDOBJECT
	///Is the map being shown to the player right now?
	var/showing_map = FALSE

/datum/action/ability/tyranid_action/teleport/action_activate()
	var/atom/movable/screen/minimap/shown_map = SSminimaps.fetch_minimap_object(owner.z, MINIMAP_FLAG_TYRANID)

	if(showing_map) // The map is open on their screen, close it
		owner.client?.screen -= shown_map
		shown_map.UnregisterSignal(owner, COMSIG_MOB_CLICKON)
		showing_map = FALSE
		return

	owner.client?.screen += shown_map
	showing_map = TRUE
	var/list/polled_coords = shown_map.get_coords_from_click(owner)
	owner.client?.screen -= shown_map
	showing_map = FALSE
	if(!polled_coords)
		shown_map.UnregisterSignal(owner, COMSIG_MOB_CLICKON)
		return
	var/turf/turf_to_teleport_to = locate(polled_coords[1], polled_coords[2], owner.z)
	if(!turf_to_teleport_to)
		return

	var/mob/living/carbon/tyranid/hivemind/hivemind_owner = owner
	if(!hivemind_owner.check_weeds(turf_to_teleport_to, TRUE))
		owner.balloon_alert(owner, "No weeds in selected location")
		return
	if(!(hivemind_owner.status_flags & INCORPOREAL))
		hivemind_owner.start_teleport(turf_to_teleport_to)
		return
	hivemind_owner.abstract_move(turf_to_teleport_to)
