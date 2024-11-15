/datum/tyranid_caste/defiler
	caste_name = "Defiler"
	display_name = "Defiler"
	upgrade_name = ""
	caste_desc = "A frightening looking, bulky tyranid that drips with suspect green fluids."

	caste_type_path = /mob/living/carbon/tyranid/defiler

	tier = TYRANID_TIER_THREE
	upgrade = TYRANID_UPGRADE_BASETYPE
	wound_type = "defiler" //used to match appropriate wound overlays

	// *** Melee Attacks *** //
	melee_damage = 26

	// *** Speed *** //
	speed = -0.9

	// *** Plasma *** //
	plasma_max = 575
	plasma_gain = 35

	// *** Health *** //
	max_health = 400

	// *** Evolution *** //
	upgrade_threshold = TIER_THREE_THRESHOLD

	deevolves_to = /datum/tyranid_caste/carrier

	// *** Flags *** //
	caste_flags = CASTE_EVOLUTION_ALLOWED
	can_hold_eggs = CAN_HOLD_ONE_HAND
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER
	caste_traits = list(TRAIT_CAN_VENTCRAWL)

	// *** Defense *** //
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 10, BIO = 40, FIRE = 40, ACID = 40)

	// *** Minimap Icon *** //
	minimap_icon = "defiler"

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/cocoon,
		/datum/action/ability/activable/tyranid/plant_weeds,
		/datum/action/ability/activable/tyranid/defile,
		/datum/action/ability/tyranid_action/lay_egg,
		/datum/action/ability/activable/tyranid/inject_egg_neurogas,
		/datum/action/ability/tyranid_action/emit_neurogas,
		/datum/action/ability/tyranid_action/select_reagent,
		/datum/action/ability/tyranid_action/reagent_slash,
		/datum/action/ability/tyranid_action/pheromones,
		/datum/action/ability/tyranid_action/pheromones/emit_recovery,
		/datum/action/ability/tyranid_action/pheromones/emit_warding,
		/datum/action/ability/tyranid_action/pheromones/emit_frenzy,
	)

	available_reagents_define = list(
		/datum/reagent/toxin/tyranid_hemodile,
		/datum/reagent/toxin/tyranid_transvitox,
		/datum/reagent/toxin/tyranid_neurotoxin,
		/datum/reagent/toxin/tyranid_ozelomelyn,
	)

	// *** Pheromones *** //
	aura_strength = 2.6 //It's .1 better than a carrier.

/datum/tyranid_caste/defiler/normal
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/defiler/primordial
	upgrade_name = "Primordial"
	caste_desc = "An unspeakable hulking horror dripping and exuding the most vile of substances."
	primordial_message = "Death follows everywhere we go. We are the plague."
	upgrade = TYRANID_UPGRADE_PRIMO

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/cocoon,
		/datum/action/ability/activable/tyranid/plant_weeds,
		/datum/action/ability/activable/tyranid/defile,
		/datum/action/ability/tyranid_action/lay_egg,
		/datum/action/ability/activable/tyranid/inject_egg_neurogas,
		/datum/action/ability/tyranid_action/emit_neurogas,
		/datum/action/ability/tyranid_action/select_reagent,
		/datum/action/ability/tyranid_action/reagent_slash,
		/datum/action/ability/tyranid_action/pheromones,
		/datum/action/ability/tyranid_action/pheromones/emit_recovery,
		/datum/action/ability/tyranid_action/pheromones/emit_warding,
		/datum/action/ability/tyranid_action/pheromones/emit_frenzy,
		/datum/action/ability/activable/tyranid/tentacle,
	)
