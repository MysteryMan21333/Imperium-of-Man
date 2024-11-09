/*
//================================================
					Boiler gas, mostly
//================================================
*/

/datum/ammo/tyranid/boiler_gas
	name = "glob of gas"
	icon_state = "boiler_gas2"
	ping = "ping_x"
	///Key used for icon stuff during bombard ammo selection.
	var/icon_key = BOILER_GLOB_NEURO
	///This text will show up when a boiler selects this ammo. Span proc should be applied when this var is used.
	var/select_text = "We will now fire neurotoxic gas. This is nonlethal."
	ammo_behavior_flags = AMMO_TYRANID|AMMO_SKIPS_ALIENS|AMMO_TARGET_TURF
	var/danger_message = span_danger("A glob of acid lands with a splat and explodes into noxious fumes!")
	armor_type = BIO
	accuracy_var_high = 10
	max_range = 16
	damage = 50
	damage_type = STAMINA
	damage_falloff = 0
	penetration = 50
	bullet_color = BOILER_LUMINOSITY_AMMO_NEUROTOXIN_COLOR
	reagent_transfer_amount = 30
	///On a direct hit, how long is the target paralyzed?
	var/hit_paralyze_time = 1 SECONDS
	///On a direct hit, how much do the victim's eyes get blurred?
	var/hit_eye_blur = 11
	///On a direct hit, how much drowsyness gets added to the target?
	var/hit_drowsyness = 12
	///Base spread range
	var/fixed_spread_range = 3
	///Which type is the smoke we leave on passed tiles, provided the projectile has AMMO_LEAVE_TURF enabled?
	var/passed_turf_smoke_type = /datum/effect_system/smoke_spread/tyranid/neuro/light
	///We're going to reuse one smoke spread system repeatedly to cut down on processing.
	var/datum/effect_system/smoke_spread/tyranid/trail_spread_system

/datum/ammo/tyranid/boiler_gas/on_leave_turf(turf/target_turf, obj/projectile/proj)
	if(istyranid(proj.firer))
		var/mob/living/carbon/tyranid/X = proj.firer
		trail_spread_system.strength = X.tyranid_caste.bomb_strength
	trail_spread_system.set_up(0, target_turf)
	trail_spread_system.start()

/**
 * Loads a trap with a gas cloud depending on current glob type
 * Called when something with a boiler glob as current ammo interacts with an empty resin trap.
 * * Args:
 * * trap: The trap being loaded
 * * user_tyranid: The tyranid interacting with the trap
 * * Returns: TRUE on success, FALSE on failure.
**/
/datum/ammo/tyranid/boiler_gas/proc/enhance_trap(obj/structure/tyranid/trap/trap, mob/living/carbon/tyranid/user_tyranid)
	if(!do_after(user_tyranid, 2 SECONDS, NONE, trap))
		return FALSE
	trap.set_trap_type(TRAP_SMOKE_NEURO)
	trap.smoke = new /datum/effect_system/smoke_spread/tyranid/neuro/medium
	trap.smoke.set_up(2, get_turf(trap))
	return TRUE

/datum/ammo/tyranid/boiler_gas/New()
	. = ..()
	if((ammo_behavior_flags & AMMO_LEAVE_TURF) && passed_turf_smoke_type)
		trail_spread_system = new passed_turf_smoke_type(only_once = FALSE)

/datum/ammo/tyranid/boiler_gas/Destroy()
	if(trail_spread_system)
		QDEL_NULL(trail_spread_system)
	return ..()

///Set up the list of reagents the spit transfers upon impact
/datum/ammo/tyranid/boiler_gas/proc/set_reagents()
	spit_reagents = list(/datum/reagent/toxin/tyranid_neurotoxin = reagent_transfer_amount)

/datum/ammo/tyranid/boiler_gas/on_hit_mob(mob/target_mob, obj/projectile/proj)
	drop_nade(get_turf(target_mob), proj.firer)
	if(target_mob.stat == DEAD || !ishuman(target_mob))
		return
	var/mob/living/carbon/human/human_victim = target_mob

	human_victim.Paralyze(hit_paralyze_time)
	human_victim.blur_eyes(hit_eye_blur)
	human_victim.adjustDrowsyness(hit_drowsyness)

	if(!reagent_transfer_amount)
		return

	set_reagents()
	for(var/reagent_id in spit_reagents)
		spit_reagents[reagent_id] = human_victim.modify_by_armor(spit_reagents[reagent_id], armor_type, penetration, proj.def_zone)

	human_victim.reagents.add_reagent_list(spit_reagents)

/datum/ammo/tyranid/boiler_gas/on_hit_obj(obj/target_obj, obj/projectile/proj)
	if(ismecha(target_obj))
		proj.damage *= 7 //Globs deal much higher damage to mechs.
	var/turf/target_turf = get_turf(target_obj)
	drop_nade(target_obj.density ? get_step_towards(target_obj, proj) : target_turf, proj.firer)

/datum/ammo/tyranid/boiler_gas/on_hit_turf(turf/target_turf, obj/projectile/proj)
	drop_nade(target_turf.density ? get_step_towards(target_turf, proj) : target_turf, proj.firer) //we don't want the gas globs to land on dense turfs, they block smoke expansion.

/datum/ammo/tyranid/boiler_gas/do_at_max_range(turf/target_turf, obj/projectile/proj)
	drop_nade(target_turf.density ? get_step_towards(target_turf, proj) : target_turf, proj.firer)

/datum/ammo/tyranid/boiler_gas/set_smoke()
	smoke_system = new /datum/effect_system/smoke_spread/tyranid/neuro()

/datum/ammo/tyranid/boiler_gas/drop_nade(turf/T, atom/firer, range = 1)
	set_smoke()
	if(istyranid(firer))
		var/mob/living/carbon/tyranid/X = firer
		smoke_system.strength = X.tyranid_caste.bomb_strength
		range = fixed_spread_range
	smoke_system.set_up(range, T)
	smoke_system.start()
	smoke_system = null
	T.visible_message(danger_message)

/datum/ammo/tyranid/boiler_gas/corrosive
	name = "glob of acid"
	icon_state = "boiler_gas"
	sound_hit = SFX_ACID_HIT
	sound_bounce = SFX_ACID_BOUNCE
	icon_key = BOILER_GLOB_ACID
	select_text = "We will now fire corrosive acid. This is lethal!"
	ammo_behavior_flags = AMMO_TYRANID|AMMO_SKIPS_ALIENS|AMMO_TARGET_TURF
	armor_type = ACID
	danger_message = span_danger("A glob of acid lands with a splat and explodes into corrosive bile!")
	damage = 50
	damage_type = BURN
	penetration = 50
	bullet_color = BOILER_LUMINOSITY_AMMO_CORROSIVE_COLOR
	hit_paralyze_time = 1 SECONDS
	hit_eye_blur = 1
	hit_drowsyness = 1
	reagent_transfer_amount = 0

/datum/ammo/tyranid/boiler_gas/corrosive/enhance_trap(obj/structure/tyranid/trap/trap, mob/living/carbon/tyranid/user_tyranid)
	if(!do_after(user_tyranid, 3 SECONDS, NONE, trap))
		return FALSE
	trap.set_trap_type(TRAP_SMOKE_ACID)
	trap.smoke = new /datum/effect_system/smoke_spread/tyranid/acid/opaque
	trap.smoke.set_up(1, get_turf(trap))
	return TRUE

/datum/ammo/tyranid/boiler_gas/corrosive/on_shield_block(mob/target_mob, obj/projectile/proj)
	airburst(target_mob, proj)

/datum/ammo/tyranid/boiler_gas/corrosive/set_smoke()
	smoke_system = new /datum/effect_system/smoke_spread/tyranid/acid/opaque()

/datum/ammo/tyranid/boiler_gas/lance
	name = "pressurized glob of gas"
	icon_key = BOILER_GLOB_NEURO_LANCE
	select_text = "We will now fire a pressurized neurotoxic lance. This is barely nonlethal."
	///As opposed to normal globs, this will pass by the target tile if they hit nothing.
	ammo_behavior_flags = AMMO_TYRANID|AMMO_SKIPS_ALIENS|AMMO_LEAVE_TURF
	danger_message = span_danger("A pressurized glob of acid lands with a nasty splat and explodes into noxious fumes!")
	max_range = 16
	damage = 75
	penetration = 70
	reagent_transfer_amount = 55
	passed_turf_smoke_type = /datum/effect_system/smoke_spread/tyranid/neuro/light
	hit_paralyze_time = 2 SECONDS
	hit_eye_blur = 16
	hit_drowsyness = 18
	fixed_spread_range = 2
	accuracy = 100
	accurate_range = 30
	shell_speed = 1.5

/datum/ammo/tyranid/boiler_gas/corrosive/lance
	name = "pressurized glob of acid"
	icon_key = BOILER_GLOB_ACID_LANCE
	select_text = "We will now fire a pressurized corrosive lance. This lethal!"
	///As opposed to normal globs, this will pass by the target tile if they hit nothing.
	ammo_behavior_flags = AMMO_TYRANID|AMMO_SKIPS_ALIENS|AMMO_LEAVE_TURF
	danger_message = span_danger("A pressurized glob of acid lands with a concerning hissing sound and explodes into corrosive bile!")
	max_range = 16
	damage = 75
	penetration = 70
	passed_turf_smoke_type = /datum/effect_system/smoke_spread/tyranid/acid/light
	hit_paralyze_time = 1.5 SECONDS
	hit_eye_blur = 4
	hit_drowsyness = 2
	fixed_spread_range = 2
	accuracy = 100
	shell_speed = 1.5
