/datum/element/plasma_on_attacked
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 2

	///the multiplier of plasma gained via receiving damage.
	var/damage_plasma_multiplier = 1

/datum/element/plasma_on_attacked/Attach(datum/target, damage_plasma_multiplier)
	. = ..()
	if(!istyranid(target))
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(target, COMSIG_TYRANID_TAKING_DAMAGE, PROC_REF(damage_suffered))
	src.damage_plasma_multiplier = damage_plasma_multiplier

/datum/element/plasma_on_attacked/Detach(datum/source, force)
	. = ..()
	UnregisterSignal(source, COMSIG_TYRANID_TAKING_DAMAGE)


/datum/element/plasma_on_attacked/proc/damage_suffered(datum/source, damage)
	SIGNAL_HANDLER
	var/mob/living/carbon/tyranid/furious = source
	furious.gain_plasma(damage * damage_plasma_multiplier)
