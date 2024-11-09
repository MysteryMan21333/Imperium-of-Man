/mob/living/carbon/tyranid/carrier
	caste_base_type = /datum/tyranid_caste/carrier
	name = "Carrier"
	desc = "A strange-looking alien creature. It carries a number of scuttling jointed crablike creatures."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/carrier.dmi' //They are now like, 2x2
	icon_state = "Carrier Walking"
	bubble_icon = "alienroyal"
	health = 200
	maxHealth = 200
	plasma_stored = 50
	///Number of huggers the carrier is currently carrying
	var/huggers = 0
	tier = TYRANID_TIER_TWO
	upgrade = TYRANID_UPGRADE_NORMAL
	pixel_x = -16 //Needed for 2x2
	inherent_verbs = list(
		/mob/living/carbon/tyranid/proc/vent_crawl,
	)
	///Facehuggers overlay
	var/mutable_appearance/hugger_overlays_icon

// ***************************************
// *********** Life overrides
// ***************************************
/mob/living/carbon/tyranid/carrier/Initialize(mapload)
	. = ..()
	hugger_overlays_icon = mutable_appearance('modular_imperium/master_files/icons/tyranid/castes/carrier.dmi',"empty")

/mob/living/carbon/tyranid/carrier/get_status_tab_items()
	. = ..()
	. += "Stored Huggers: [huggers] / [tyranid_caste.huggers_max]"

/mob/living/carbon/tyranid/carrier/update_icons()
	. = ..()

	if(!hugger_overlays_icon)
		return

	overlays -= hugger_overlays_icon
	hugger_overlays_icon.overlays.Cut()

	if(!huggers)
		return

	///Dispayed number of huggers
	var/displayed = round(( huggers / tyranid_caste.huggers_max ) * 3.999) + 1

	for(var/i = 1; i <= displayed; i++)
		if(stat == DEAD)
			hugger_overlays_icon.overlays += mutable_appearance(icon, "clinger_[i] Knocked Down")
		else if(lying_angle)
			if((resting || IsSleeping()) && (!IsParalyzed() && !IsUnconscious() && health > 0))
				hugger_overlays_icon.overlays += mutable_appearance(icon, "clinger_[i] Sleeping")
			else
				hugger_overlays_icon.overlays +=mutable_appearance(icon, "clinger_[i] Knocked Down")
		else
			hugger_overlays_icon.overlays +=mutable_appearance(icon, "clinger_[i]")

	overlays += hugger_overlays_icon
