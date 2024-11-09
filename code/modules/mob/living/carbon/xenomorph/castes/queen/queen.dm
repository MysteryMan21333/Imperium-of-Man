/mob/living/carbon/tyranid/queen
	caste_base_type = /datum/tyranid_caste/queen
	name = "Queen"
	desc = "A huge, looming alien creature. The biggest and the baddest."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/queen.dmi'
	icon_state = "Queen Walking"
	attacktext = "bites"
	attack_sound = null
	friendly = "nuzzles"
	health = 300
	maxHealth = 300
	plasma_stored = 300
	pixel_x = -16
	mob_size = MOB_SIZE_BIG
	drag_delay = 6 //pulling a big dead tyranid is hard
	tier = TYRANID_TIER_FOUR //Queen doesn't count towards population limit.
	upgrade = TYRANID_UPGRADE_NORMAL
	bubble_icon = "alienroyal"

	var/breathing_counter = 0
	inherent_verbs = list(
		/mob/living/carbon/tyranid/proc/hijack,
	)

// ***************************************
// *********** Init
// ***************************************
/mob/living/carbon/tyranid/queen/Initialize(mapload)
	RegisterSignal(src, COMSIG_HIVE_BECOME_RULER, PROC_REF(on_becoming_ruler))
	. = ..()
	hive.RegisterSignal(src, COMSIG_HIVE_TYRANID_DEATH, TYPE_PROC_REF(/datum/hive_status, on_queen_death))
	playsound(loc, 'sound/voice/alien/queen_command.ogg', 75, 0)

// ***************************************
// *********** Mob overrides
// ***************************************

/mob/living/carbon/tyranid/queen/handle_special_state()
	if(is_charging >= CHARGE_ON)
		icon_state = "[tyranid_caste.caste_name][(tyranid_flags & TYRANID_ROUNY) ? " rouny" : ""] Charging"
		return TRUE
	return FALSE

/mob/living/carbon/tyranid/reset_perspective(atom/A)
	if (!client)
		return

	if(observed_tyranid && !stat)
		client.perspective = EYE_PERSPECTIVE
		client.eye = observed_tyranid
		return

	if (ismovableatom(A))
		client.perspective = EYE_PERSPECTIVE
		client.eye = A
		return

	if (isturf(loc))
		client.eye = client.mob
		client.perspective = MOB_PERSPECTIVE
		return

	client.perspective = EYE_PERSPECTIVE
	client.eye = loc

/mob/living/carbon/tyranid/queen/upgrade_tyranid(newlevel, silent = FALSE)
	. = ..()
	hive?.update_leader_pheromones()

// ***************************************
// *********** Name
// ***************************************
/mob/living/carbon/tyranid/queen/generate_name()
	var/playtime_mins = client?.get_exp(tyranid_caste.caste_name)
	var/prefix = (hive.prefix || tyranid_caste.upgrade_name) ? "[hive.prefix][tyranid_caste.upgrade_name] " : ""
	if(!client?.prefs.show_tyranid_rank || !client)
		name = prefix + "Queen ([nicknumber])"
		real_name = name
		if(mind)
			mind.name = name
		return
	switch(playtime_mins)
		if(0 to 600)
			name = prefix + "Young Queen ([nicknumber])"
		if(601 to 1500)
			name = prefix + "Mature Queen ([nicknumber])"
		if(1501 to 4200)
			name = prefix + "Elder Empress ([nicknumber])"
		if(4201 to 10500)
			name = prefix + "Ancient Empress ([nicknumber])"
		if(10501 to INFINITY)
			name = prefix + "Prime Empress ([nicknumber])"
		else
			name = prefix + "Young Queen ([nicknumber])"

	real_name = name
	if(mind)
		mind.name = name


// ***************************************
// *********** Death
// ***************************************
/mob/living/carbon/tyranid/queen/death_cry()
	playsound(loc, 'sound/voice/alien/queen_died.ogg', 75, 0)

/mob/living/carbon/tyranid/queen/tyranid_death_alert()
	return


// ***************************************
// *********** Larva Mother
// ***************************************

/mob/living/carbon/tyranid/queen/proc/is_burrowed_larva_host(datum/source, list/mothers, list/silos)
	if(!incapacitated(TRUE))
		mothers += src //Adding us to the list.
