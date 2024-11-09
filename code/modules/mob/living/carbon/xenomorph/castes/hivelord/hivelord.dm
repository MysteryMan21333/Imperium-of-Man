/mob/living/carbon/tyranid/hivelord
	caste_base_type = /datum/tyranid_caste/hivelord
	name = "Hivelord"
	desc = "A huge ass tyranid covered in weeds! Oh shit!"
	icon = 'modular_imperium/master_files/icons/tyranid/castes/hivelord.dmi'
	icon_state = "Hivelord Walking"
	bubble_icon = "alienroyal"
	health = 250
	maxHealth = 250
	plasma_stored = 200
	pixel_x = -16
	mob_size = MOB_SIZE_BIG
	drag_delay = 6 //pulling a big dead tyranid is hard
	tier = TYRANID_TIER_TWO
	upgrade = TYRANID_UPGRADE_NORMAL
	var/list/tunnels = list() //list of active tunnels

// ***************************************
// *********** Init
// ***************************************
/mob/living/carbon/tyranid/hivelord/Initialize(mapload)
	. = ..()
	update_spits()


/mob/living/carbon/tyranid/hivelord/get_status_tab_items()
	. = ..()
	. += "Active Tunnel Sets: [LAZYLEN(tunnels)] / [HIVELORD_TUNNEL_SET_LIMIT]"
