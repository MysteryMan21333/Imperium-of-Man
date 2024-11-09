/mob/living/carbon/tyranid/puppet
	caste_base_type = /datum/tyranid_caste/puppet
	name = "Puppet"
	desc = "A reanimated body, crudely pieced together and held in place by an ominous energy tethered to some unknown force."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/puppet.dmi'
	icon_state = "Puppet Running"
	health = 250
	maxHealth = 250
	plasma_stored = 0
	pixel_x = 0
	tier = TYRANID_TIER_MINION
	upgrade = TYRANID_UPGRADE_BASETYPE
	pull_speed = -1
	allow_pass_flags = PASS_TYRANID
	pass_flags = PASS_TYRANID
	voice_filter = @{"[0:a] asplit [out0][out2]; [out0] asetrate=%SAMPLE_RATE%*0.9,aresample=%SAMPLE_RATE%,atempo=1/0.9,aformat=channel_layouts=mono,volume=0.2 [p0]; [out2] asetrate=%SAMPLE_RATE%*1.1,aresample=%SAMPLE_RATE%,atempo=1/1.1,aformat=channel_layouts=mono,volume=0.2[p2]; [p0][0][p2] amix=inputs=3"}
	///our masters weakref
	var/datum/weakref/weak_master

/mob/living/carbon/tyranid/puppet/handle_special_state() //prevent us from using different run/walk sprites
	icon_state = "[tyranid_caste.caste_name] Running"
	return TRUE

/mob/living/carbon/tyranid/puppet/Initialize(mapload, mob/living/carbon/tyranid/puppeteer)
	. = ..()
	if(puppeteer)
		weak_master = WEAKREF(puppeteer)
		transfer_to_hive(puppeteer.hivenumber)
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/puppet, puppeteer)

/mob/living/carbon/tyranid/puppet/on_death()
	. = ..()
	if(!QDELETED(src))
		gib()

/mob/living/carbon/tyranid/puppet/Life(seconds_per_tick, times_fired)
	. = ..()
	var/atom/movable/master = weak_master?.resolve()
	if(!master)
		return
	if(get_dist(src, master) > PUPPET_WITHER_RANGE)
		adjustBruteLoss(15)
	else
		adjustBruteLoss(-5)

/mob/living/carbon/tyranid/puppet/can_receive_aura(aura_type, atom/source, datum/aura_bearer/bearer)
	. = ..()
	var/atom/movable/master = weak_master?.resolve()
	if(!master)
		return
	if(source != master) //puppeteer phero only
		return FALSE

/mob/living/carbon/tyranid/puppet/med_hud_set_status()
	. = ..()
	hud_set_blessings()

/mob/living/carbon/tyranid/puppet/proc/hud_set_blessings()
	var/image/holder = hud_list[TYRANID_BLESSING_HUD]
	if(!holder)
		return
	for(var/datum/status_effect/effect AS in status_effects)
		if(istype(effect, /datum/status_effect/blessing))
			holder.overlays += image('modular_imperium/master_files/icons/mob/hud/xeno.dmi', icon_state = initial(effect.id))
