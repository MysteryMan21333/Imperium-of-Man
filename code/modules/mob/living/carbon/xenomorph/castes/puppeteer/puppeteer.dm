/mob/living/carbon/tyranid/puppeteer
	caste_base_type = /datum/tyranid_caste/puppeteer
	name = "Puppeteer"
	desc = "A tyranid of terrifying display, it has a tail adorned with needles that drips a strange chemical and elongated claws."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/puppeteer.dmi'
	icon_state = "Puppeteer Running"
	health = 250
	maxHealth = 250
	plasma_stored = 350
	pixel_x = -16
	tier = TYRANID_TIER_TWO
	upgrade = TYRANID_UPGRADE_NORMAL
	drag_delay = 5 //pulling a big dead tyranid is hard
	bubble_icon = "alien"

/mob/living/carbon/tyranid/puppeteer/Initialize(mapload)
	. = ..()
	GLOB.huds[DATA_HUD_TYRANID_HEART].add_hud_to(src)
	RegisterSignal(src, COMSIG_TYRANID_POSTATTACK_LIVING, PROC_REF(postattack))

/mob/living/carbon/tyranid/puppeteer/proc/postattack(mob/living/source, mob/living/target, damage)
	SIGNAL_HANDLER
	if(target.stat == DEAD)
		return
	gain_plasma(floor(damage / 0.8))
	SEND_SIGNAL(src, COMSIG_PUPPET_CHANGE_ALL_ORDER, PUPPET_ATTACK, target) //we are on harm intent so it probably means we want to kill the target
