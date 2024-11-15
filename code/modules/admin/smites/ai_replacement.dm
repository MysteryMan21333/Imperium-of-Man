/// Fattens the target
/datum/smite/ai_replacement
	name = "Replace by ai"

/datum/smite/ai_replacement/effect(client/user, mob/living/carbon/C)
	. = ..()

	if (!istyranid(C))
		to_chat(user, span_warning("Guardsmans have no ai available, aborting!"))
		return

	var/mob/living/carbon/tyranid/skill_less_tyranid = C
	skill_less_tyranid.replace_by_ai()
