
/mob/living/carbon/tyranid/proc/death_cry()
	playsound(loc, prob(50) ? 'sound/voice/alien/death.ogg' : 'sound/voice/alien/death2.ogg', 25, 1)


/mob/living/carbon/tyranid/death(gibbing, deathmessage = "lets out a waning guttural screech, green blood bubbling from its maw.", silent)
	return ..() //we're just changing the death message

/mob/living/carbon/tyranid/on_death()
	GLOB.alive_tyranid_list -= src
	LAZYREMOVE(GLOB.alive_tyranid_list_hive[hivenumber], src)
	GLOB.dead_tyranid_list += src

	QDEL_NULL(current_aura)
	QDEL_NULL(leader_current_aura)

	hive?.on_tyranid_death(src)
	hive?.update_tier_limits() //Update our tier limits.

	if(tyranid_flags & TYRANID_ZOOMED)
		zoom_out()

	if(GLOB.tyranid_stat_multiplicator_buff == 1) //if autobalance is on, it won't equal 1, so tyranid respawn timer is not set
		switch(tier)
			if(TYRANID_TIER_ZERO, TYRANID_TIER_ONE, TYRANID_TIER_TWO, TYRANID_TIER_THREE) //minions and tier fours have no respawn timer
				GLOB.key_to_time_of_tyranid_death[key] = world.time

	SSminimaps.remove_marker(src)
	set_light_on(FALSE)

	if(hud_used)
		if(hud_used.healths)
			hud_used.healths.icon_state = "health_dead"
		if(hud_used.staminas)
			hud_used.staminas.icon_state = "staminaloss200"
		if(hud_used.alien_plasma_display)
			hud_used.alien_plasma_display.icon_state = "power_display_empty"
	update_icons()
	hud_set_plasma()
	hud_update_rank()

	death_cry()

	tyranid_death_alert()

	hud_set_queen_overwatch() //updates the overwatch hud to remove the upgrade chevrons, gold star, etc

	GLOB.round_statistics.total_tyranid_deaths++
	SSblackbox.record_feedback("tally", "round_statistics", 1, "total_tyranid_deaths")

	switch (upgrade)
		if(TYRANID_UPGRADE_NORMAL)
			switch(tier)
				if(TYRANID_TIER_TWO)
					SSmonitor.stats.normal_T2--
				if(TYRANID_TIER_THREE)
					SSmonitor.stats.normal_T3--
				if(TYRANID_TIER_FOUR)
					SSmonitor.stats.normal_T4--
		if(TYRANID_UPGRADE_PRIMO)
			switch(tier)
				if(TYRANID_TIER_TWO)
					SSmonitor.stats.primo_T2--
				if(TYRANID_TIER_THREE)
					SSmonitor.stats.primo_T3--
				if(TYRANID_TIER_FOUR)
					SSmonitor.stats.primo_T4--

	eject_victim()

	to_chat(src,"<b>[span_deadsay("<p style='font-size:1.5em'><big>We have perished.</big><br><small>But it is not the end of us yet... wait until a newborn can rise in this world...</small></p>")]</b>")

	return ..()


/mob/living/carbon/tyranid/proc/tyranid_death_alert()
	if(is_centcom_level(z))
		return
	if(tyranid_caste.caste_flags & CASTE_DO_NOT_ANNOUNCE_DEATH)
		return
	var/area/A = get_area(src)
	tyranid_message("Hive: \The [src] has <b>died</b>[A? " at [A]":""]!", "tyranidannounce", tyranid_caste.caste_flags & CASTE_DO_NOT_ALERT_LOW_LIFE ? 2 : 5, hivenumber)

/mob/living/carbon/tyranid/gib()

	var/obj/effect/decal/remains/tyranid/remains = new(get_turf(src))
	remains.icon = icon
	remains.pixel_x = pixel_x //For 2x2.

	SEND_SIGNAL(src, COMSIG_TYRANID_GIBBING)

	remains.icon_state = tyranid_caste.gib_anim

	check_blood_splash(35, BURN, 65, 2)

	return ..()

/mob/living/carbon/tyranid/gib_animation()
	new /obj/effect/overlay/temp/gib_animation/tyranid(loc, 0, src, tyranid_caste.gib_flick, icon)

/mob/living/carbon/tyranid/spawn_gibs()
	xgibs(get_turf(src))

/mob/living/carbon/tyranid/dust_animation()
	new /obj/effect/overlay/temp/dust_animation(loc, 0, src, "dust-a")
