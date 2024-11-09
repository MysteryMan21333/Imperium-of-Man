/mob/living/carbon/tyranid/get_antag_info()
	var/list/entries = SScodex.retrieve_entries_for_string(name)
	var/datum/codex_entry/general_entry = LAZYACCESS(entries, 1)
	return general_entry?.antag_text

/mob/living/carbon/tyranid/get_lore_info()
	var/list/entries = SScodex.retrieve_entries_for_string(name)
	var/datum/codex_entry/general_entry = LAZYACCESS(entries, 1)
	return general_entry?.lore_text

/mob/living/carbon/tyranid/get_mechanics_info()
	. = ..()
	var/list/tyranid_strings = list()

	var/list/entries = SScodex.retrieve_entries_for_string(name)
	var/datum/codex_entry/general_entry = LAZYACCESS(entries, 1)
	if(general_entry?.mechanics_text)
		tyranid_strings += general_entry?.mechanics_text + "<br>"

	tyranid_strings += "<br><U>Basic Statistics for this Tyranid are as follows</U>:"

	tyranid_strings += "Name: '[tyranid_caste.caste_name]'"
	tyranid_strings += "Tier: [GLOB.tier_as_number[tier]]"
	tyranid_strings += "Melee slash damage: [tyranid_caste.melee_damage * tyranid_melee_damage_modifier]"
	switch(mob_size)
		if(MOB_SIZE_BIG)
			tyranid_strings += "Can smash walls: Yes"
		if(MOB_SIZE_TYRANID)
			tyranid_strings += "Can smash walls: No"
	tyranid_strings += "Max health: [tyranid_caste.max_health]"
	var/list/armor_in_list = soft_armor.getList()
	for(var/armor_type in armor_in_list)
		tyranid_strings += "Soft [armor_type] armor: [armor_in_list[armor_type]]"
	armor_in_list = hard_armor.getList()
	for(var/armor_type in armor_in_list)
		tyranid_strings += "Hard [armor_type] armor: [armor_in_list[armor_type]]"
	tyranid_strings += "Max plasma: [tyranid_caste.plasma_max]"
	tyranid_strings += "Plasma gain: [tyranid_caste.plasma_gain]"
	tyranid_strings += "Hive: [hive?.name]"

	if(tyranid_caste.caste_flags & CASTE_EVOLUTION_ALLOWED)
		tyranid_strings += "<br><U>This can evolve to</U>:"
		for(var/type in get_evolution_options())
			tyranid_strings += "[GLOB.tyranid_caste_datums[type][TYRANID_UPGRADE_BASETYPE].caste_name]"

	if(length(actions))
		tyranid_strings += "<br><U>This has the following abilities</U>:"
		for(var/datum/action/ability/tyranid_action/A in actions)
			tyranid_strings += "<U>[A.name]</U>: [A.desc]<br>"

	. += jointext(tyranid_strings, "<br>")


/datum/codex_entry/tyranid
	display_name = "tyranid"
	associated_paths = list(/mob/living/carbon/tyranid)
	mechanics_text = "Tyranids are a hostile lifeform. They are very powerful individually and also in groups. \
	They reproduce by capturing hosts and impregnating them with facehuggers. Some time later the larva growing in the hosts \
	chest will violently burst out killing the host in the process. <br><br>Not suitable for pet ownership."
