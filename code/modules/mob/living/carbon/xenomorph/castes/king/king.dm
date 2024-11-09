/mob/living/carbon/tyranid/king
	caste_base_type = /datum/tyranid_caste/king
	name = "King"
	desc = "A primordial creature, evolved to smash the hardiest of defences and hunt the hardiest of prey."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/king.dmi'
	icon_state = "King Walking"
	attacktext = "bites"
	attack_sound = null
	friendly = "nuzzles"
	health = 500
	maxHealth = 500
	plasma_stored = 300
	pixel_x = -16
	mob_size = MOB_SIZE_BIG
	drag_delay = 6
	tier = TYRANID_TIER_FOUR //King, like queen, doesn't count towards population limit.
	upgrade = TYRANID_UPGRADE_NORMAL
	bubble_icon = "alienroyal"
	inherent_verbs = list(
		/mob/living/carbon/tyranid/proc/hijack,
	)

/mob/living/carbon/tyranid/king/Initialize(mapload)
	. = ..()
	playsound(loc, 'modular_imperium/master_files/sound/voice/alien/xenos_roaring.ogg', 75, 0)

/mob/living/carbon/tyranid/king/generate_name()
	var/playtime_mins = client?.get_exp(tyranid_caste.caste_name)
	var/prefix = (hive.prefix || tyranid_caste.upgrade_name) ? "[hive.prefix][tyranid_caste.upgrade_name] " : ""
	if(!client?.prefs.show_tyranid_rank || !client)
		name = prefix + "King ([nicknumber])"
		real_name = name
		if(mind)
			mind.name = name
		return
	switch(playtime_mins)
		if(0 to 600)
			name = prefix + "Young King ([nicknumber])"
		if(601 to 1500)
			name = prefix + "Mature King ([nicknumber])"
		if(1501 to 4200)
			name = prefix + "Elder Emperor ([nicknumber])"
		if(4201 to 10500)
			name = prefix + "Ancient Emperor ([nicknumber])"
		if(10501 to INFINITY)
			name = prefix + "Prime Emperor ([nicknumber])"
		else
			name = prefix + "Young King ([nicknumber])"

	real_name = name
	if(mind)
		mind.name = name

/mob/living/carbon/tyranid/king/death_cry()
	playsound(loc, 'sound/voice/alien/king_died.ogg', 75, 0)
