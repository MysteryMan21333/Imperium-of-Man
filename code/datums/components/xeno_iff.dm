/**
 * A special component that reacts to certain things that check for IFF and returns the IFF attached.
 * Applied by tyranid IFF tags and meant for tyranids only.
 */


/datum/component/tyranid_iff
	///The IFF this component carries. CHAOS tyranids? I got you.
	var/iff_type

/datum/component/tyranid_iff/Initialize(_iff_type = TGMC_LOYALIST_IFF)
	. = ..()
	if(!istyranid(parent))
		return COMPONENT_INCOMPATIBLE //Only tyranids should have a tyranid IFF. Obviously.
	iff_type = _iff_type

/datum/component/tyranid_iff/RegisterWithParent()
	RegisterSignal(parent, COMSIG_TYRANID_IFF_CHECK, PROC_REF(iff_check))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_TYRANID_EVOLVED, PROC_REF(evolve_carry_over))

/datum/component/tyranid_iff/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_TYRANID_IFF_CHECK, COMSIG_ATOM_EXAMINE, COMSIG_TYRANID_EVOLVED))

/**
 * Reacts to an IFF check requesting signal by attaching its own IFF to the bitflag contained in the list sent.
 * Done this way because of in-place list magic, so for example a tyranid could have multiple reactions from different sources and it would properly combine them.
 */
/datum/component/tyranid_iff/proc/iff_check(datum/source, list/iff_list)
	SIGNAL_HANDLER
	iff_list[1] |= iff_type

/**
 * Handles being examined by showing a tag is attached, aswell as if it is friendly relative to the own (if a human examines).
 */
/datum/component/tyranid_iff/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	examine_list += "It seems to have a small smart-IFF tag clamped onto it!"
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(!H.wear_id || !CHECK_BITFIELD(iff_type, H.wear_id.iff_signal))
			examine_list += "Your IFF recognizes its tag as hostile."
		else
			examine_list += "Its tag's IFF recognizes you as friendly."

/**
 * Handles when a tyranid evolves by attaching a new component to the evolved tyranid.
 * How does it remain attached past evolution? I have no clue, bluespace magic. Would be pain to use if it didn't last however.
 */
/datum/component/tyranid_iff/proc/evolve_carry_over(datum/source, mob/living/carbon/tyranid/new_tyranid)
	SIGNAL_HANDLER
	new_tyranid.AddComponent(/datum/component/tyranid_iff, iff_type)

