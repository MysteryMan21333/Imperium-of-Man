/datum/job/fallen/after_spawn(mob/living/new_mob, mob/M, latejoin)
	RegisterSignals(new_mob, list(COMSIG_MOB_DEATH, COMSIG_MOB_LOGOUT), PROC_REF(delete_mob))
	to_chat(new_mob, span_danger("This is a place for everyone to experiment and RP. Standard rules applies here. Do not blow up the vendors, do not grief, \
	do not try to lag the server with explosions. Alternatively, don't fill the tyranid asteroid with walls or other structures."))

/datum/job/fallen/return_spawn_type(datum/preferences/prefs)
	switch(prefs?.species)
		if("Combat Robot")
			switch(prefs?.robot_type)
				if("Basic")
					return /mob/living/carbon/human/species/robot
				if("Hammerhead")
					return /mob/living/carbon/human/species/robot/alpharii
				if("Chilvaris")
					return /mob/living/carbon/human/species/robot/charlit
				if("Ratcher")
					return /mob/living/carbon/human/species/robot/deltad
				if("Sterling")
					return /mob/living/carbon/human/species/robot/bravada
		if("Vatborn")
			return /mob/living/carbon/human/species/vatborn
		else
			return /mob/living/carbon/human

///Delete the mob when you log out or when it's dead
/datum/job/fallen/proc/delete_mob(mob/living/source)
	SIGNAL_HANDLER
	if(QDELING(source))
		return
	source.visible_message(span_danger("[source] suddenly disappears!"))
	qdel(source)

/datum/job/fallen/guardsman
	title = ROLE_FALLEN(SQUAD_GUARDSMAN)
	access = list(ACCESS_GUARDSMAN_PREP)
	minimal_access = list(ACCESS_GUARDSMAN_PREP, ACCESS_GUARDSMAN_DROPSHIP)
	outfit = /datum/outfit/job/guardsman/standard

/datum/job/fallen/guardsman/standard

/datum/job/fallen/guardsman/engineer
	title = ROLE_FALLEN(SQUAD_ENGINEER)
	skills_type = /datum/skills/combat_engineer
	access = list(ACCESS_GUARDSMAN_PREP, ACCESS_GUARDSMAN_ENGPREP, ACCESS_CIVILIAN_ENGINEERING, ACCESS_GUARDSMAN_REMOTEBUILD, ACCESS_GUARDSMAN_ENGINEERING)
	minimal_access = list(ACCESS_GUARDSMAN_PREP, ACCESS_GUARDSMAN_ENGPREP, ACCESS_CIVILIAN_ENGINEERING, ACCESS_GUARDSMAN_DROPSHIP, ACCESS_GUARDSMAN_REMOTEBUILD, ACCESS_GUARDSMAN_ENGINEERING)
	outfit = /datum/outfit/job/guardsman/engineer

/datum/job/fallen/guardsman/corpsman
	title = ROLE_FALLEN(SQUAD_CORPSMAN)
	skills_type = /datum/skills/combat_medic
	access = list(ACCESS_GUARDSMAN_PREP, ACCESS_GUARDSMAN_MEDPREP, ACCESS_GUARDSMAN_MEDBAY, ACCESS_GUARDSMAN_CHEMISTRY)
	minimal_access = list(ACCESS_GUARDSMAN_PREP, ACCESS_GUARDSMAN_MEDPREP, ACCESS_GUARDSMAN_MEDBAY, ACCESS_GUARDSMAN_CHEMISTRY, ACCESS_GUARDSMAN_DROPSHIP)
	outfit = /datum/outfit/job/guardsman/corpsman

/datum/job/fallen/guardsman/smartgunner
	title = ROLE_FALLEN(SQUAD_SMARTGUNNER)
	skills_type = /datum/skills/smartgunner
	access = list(ACCESS_GUARDSMAN_PREP, ACCESS_GUARDSMAN_SMARTPREP)
	minimal_access = list(ACCESS_GUARDSMAN_PREP, ACCESS_GUARDSMAN_SMARTPREP, ACCESS_GUARDSMAN_DROPSHIP)
	outfit = /datum/outfit/job/guardsman/smartgunner

/datum/job/fallen/guardsman/leader
	title = ROLE_FALLEN(SQUAD_LEADER)
	skills_type = /datum/skills/sl
	access = list(ACCESS_GUARDSMAN_PREP, ACCESS_GUARDSMAN_LEADER, ACCESS_GUARDSMAN_DROPSHIP, ACCESS_GUARDSMAN_TADPOLE)
	minimal_access = list(ACCESS_GUARDSMAN_PREP, ACCESS_GUARDSMAN_LEADER, ACCESS_GUARDSMAN_DROPSHIP, ACCESS_GUARDSMAN_TADPOLE)
	outfit = /datum/outfit/job/guardsman/leader

/datum/job/fallen/guardsman/mechpilot
	title = ROLE_FALLEN(MECH_PILOT)
	skills_type = /datum/skills/mech_pilot
	access = list(ACCESS_GUARDSMAN_WO, ACCESS_GUARDSMAN_PREP, ACCESS_GUARDSMAN_MECH, ACCESS_CIVILIAN_PUBLIC)
	minimal_access = list(ACCESS_GUARDSMAN_WO, ACCESS_GUARDSMAN_PREP, ACCESS_GUARDSMAN_MECH, ACCESS_CIVILIAN_PUBLIC, ACCESS_GUARDSMAN_BRIDGE, ACCESS_GUARDSMAN_DROPSHIP, ACCESS_GUARDSMAN_LOGISTICS, ACCESS_GUARDSMAN_CARGO)
	outfit = /datum/outfit/job/command/mech_pilot/fallen

/datum/job/fallen/guardsman/fieldcommander
	title = ROLE_FALLEN(FIELD_COMMANDER)
	skills_type = /datum/skills/fo
	access = ALL_GUARDSMAN_ACCESS
	minimal_access = ALL_GUARDSMAN_ACCESS
	outfit = /datum/outfit/job/command/fieldcommander
	multiple_outfits = TRUE
	outfits = list(
		/datum/outfit/job/command/fieldcommander,
		/datum/outfit/job/command/fieldcommander/robot,
	)

/datum/job/fallen/guardsman/synthetic
	title = ROLE_FALLEN(SYNTHETIC)
	skills_type = /datum/skills/synthetic
	access = ALL_ACCESS
	minimal_access = ALL_ACCESS
	outfit = /datum/outfit/job/civilian/synthetic

/datum/job/fallen/guardsman/synthetic/get_special_name(client/preference_source)
	return preference_source.prefs.synthetic_name

/datum/job/fallen/guardsman/synthetic/return_spawn_type(datum/preferences/prefs)
	if(prefs?.synthetic_type == "Early Synthetic")
		return /mob/living/carbon/human/species/early_synthetic
	return /mob/living/carbon/human/species/synthetic

/datum/job/fallen/guardsman/synthetic/return_skills_type(datum/preferences/prefs)
	if(prefs?.synthetic_type == "Early Synthetic")
		return /datum/skills/early_synthetic
	return ..()

/datum/job/fallen/tyranid
	title = ROLE_FALLEN(ROLE_TYRANID)
	faction = FACTION_TYRANID
