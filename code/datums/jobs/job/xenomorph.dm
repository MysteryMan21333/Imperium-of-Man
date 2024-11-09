/datum/job/tyranid
	job_category = JOB_CAT_TYRANID
	title = ROLE_TYRANID
	supervisors = "the hive ruler"
	selection_color = "#B2A3CC"
	display_order = JOB_DISPLAY_ORDER_TYRANID
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_NOHEADSET|JOB_FLAG_OVERRIDELATEJOINSPAWN|JOB_FLAG_SHOW_OPEN_POSITIONS
	jobworth = list(/datum/job/survivor/rambo = SURVIVOR_POINTS_REGULAR)
	job_points_needed = 10 //Redefined via config.
	faction = FACTION_TYRANID
	exp_type = EXP_TYPE_SPECIAL
	html_description = {"
		<b>Difficulty</b>: Variable<br /><br />
		<b>You answer to the</b> acting Hive leader<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Crash, Nuclear War<br /><br /><br />
		<b>Duty</b>: Spread the hive, obey the will of your Hive Leader and the Queen Mother. Kill or capture those who get into your way. Protect the hive whenever possible. Amass your numbers.
	"}
	/**
	 * This is the amount of "free" tyranid jobs opened at the start, even before guardsmans job contributes to the total.
	 * This is a counter to prevent adding more jobs that necessary
	 */
	var/free_tyranid_at_start = FREE_TYRANID_AT_START

/datum/job/tyranid/return_spawn_type(datum/preferences/prefs)
	return /mob/living/carbon/tyranid/larva

/datum/job/tyranid/return_spawn_turf()
	if(length(GLOB.tyranid_resin_silos_by_hive[TYRANID_HIVE_NORMAL]))
		return pick(GLOB.tyranid_resin_silos_by_hive[TYRANID_HIVE_NORMAL])
	return pick(GLOB.spawns_by_job[/datum/job/tyranid])

/datum/job/tyranid/radio_help_message(mob/M)
	. = ..()
	to_chat(M, "<b>Your job is to spread the hive and protect the Hive Leader. If there's no Hive Leader, you can become the Shrike or Queen yourself by evolving into a drone.</b><br>\
	Talk in Hivemind using <strong>;</strong>, <strong>.a</strong>, or <strong>,a</strong> (e.g. ';My life for the queen!')")

/datum/job/tyranid/handle_special_preview(client/parent)
	parent.show_character_previews(image('modular_imperium/master_files/icons/tyranid/castes/larva.dmi', icon_state = "Bloody Larva", dir = SOUTH))
	return TRUE

/datum/job/tyranid/add_job_positions(amount)
	if(!(SSticker.mode.round_type_flags & MODE_TYRANID_SPAWN_PROTECT))
		if(free_tyranid_at_start > 0)
			free_tyranid_at_start--
			return
	. = ..()
	if(!.)
		return
	var/datum/hive_status/normal/HS = GLOB.hive_datums[TYRANID_HIVE_NORMAL]
	HS.give_larva_to_next_in_queue()

/datum/job/tyranid/after_spawn(mob/living/carbon/tyranid/tyranid, mob/M, latejoin)
	. = ..()
	SSminimaps.add_marker(tyranid, MINIMAP_FLAG_TYRANID, image('icons/UI_icons/map_blips.dmi', null, tyranid.tyranid_caste.minimap_icon))

/datum/job/tyranid/queen
	title = ROLE_TYRANID_QUEEN
	req_admin_notify = TRUE
	supervisors = "Queen mother"
	selection_color = "#8972AA"
	display_order = JOB_DISPLAY_ORDER_TYRANID_QUEEN
	exp_requirements = XP_REQ_EXPERIENCED
	job_flags = JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_NOHEADSET|JOB_FLAG_OVERRIDELATEJOINSPAWN|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_HIDE_CURRENT_POSITIONS|JOB_FLAG_LOUDER_TTS
	jobworth = list(/datum/job/survivor/rambo = SURVIVOR_POINTS_REGULAR)
	html_description = {"
		<b>Difficulty</b>: Soul crushing<br /><br />
		<b>You answer to the</b> Queen Mother<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Crash, Nuclear War<br /><br /><br />
		<b>Duty</b>: Lead the hive and ensure success isn’t snatched away by your enemies. Manage the supply of psypoints
	"}

/datum/job/tyranid/queen/return_spawn_type(datum/preferences/prefs)
	return /mob/living/carbon/tyranid/shrike

/datum/job/tyranid/queen/return_spawn_turf()
	return pick(GLOB.spawns_by_job[/datum/job/tyranid])

/datum/job/tyranid/queen/radio_help_message(mob/M)
	to_chat(M, "<b>You are now the alien ruler!<br>\
	Your job is to spread the hive.</b><br>\
	Talk in Hivemind using <strong>;</strong>, <strong>.a</strong>, or <strong>,a</strong> (e.g. ';My life for the hive!')")

/datum/job/tyranid/queen/handle_special_preview(client/parent)
	parent.show_character_previews(image('modular_imperium/master_files/icons/tyranid/castes/larva.dmi', icon_state = "Larva", dir = SOUTH))
	return TRUE
