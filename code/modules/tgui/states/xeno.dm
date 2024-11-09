/**
 * tgui state: tyranid_state
 *
 * Checks that the user is a tyranid, ezpz.
 **/

GLOBAL_DATUM_INIT(tyranid_state, /datum/ui_state/tyranid_state, new)

/datum/ui_state/tyranid_state/can_use_topic(src_object, mob/user)
	if(!istyranid(user))
		return UI_CLOSE
	if(user.stat == DEAD)
		return UI_DISABLED
	if(user.stat == UNCONSCIOUS || user.incapacitated())
		return UI_UPDATE
	return UI_INTERACTIVE

/**
 * tgui state: hive_ui_state
 *
 * Givens the UI state of hive status page.
 **/

GLOBAL_DATUM_INIT(hive_ui_state, /datum/ui_state/hive_ui_state, new)

/datum/ui_state/hive_ui_state/can_use_topic(src_object, mob/user)
	if(!istyranid(user) && !isobserver(user))
		// Guardsmans respawning should not be able to see the UI anymore.
		return UI_CLOSE
	return UI_INTERACTIVE
