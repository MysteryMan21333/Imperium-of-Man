/datum/tyranid_caste/queen
	caste_name = "Queen"
	display_name = "Queen"
	upgrade_name = ""
	caste_type_path = /mob/living/carbon/tyranid/queen
	caste_desc = "The biggest and baddest tyranid. The Queen controls the hive."
	job_type = /datum/job/tyranid/queen

	tier = TYRANID_TIER_FOUR
	upgrade = TYRANID_UPGRADE_BASETYPE
	wound_type = "queen" //used to match appropriate wound overlays

	// *** Melee Attacks *** //
	melee_damage = 28

	// *** Speed *** //
	speed = -0.3

	// *** Plasma *** //
	plasma_max = 1200
	plasma_gain = 90

	// *** Health *** //
	max_health = 600

	// *** Sunder *** //
	sunder_multiplier = 0.8

	// *** Evolution *** //
	upgrade_threshold = TIER_THREE_THRESHOLD
	evolve_min_tyranids = 8
	maximum_active_caste = 1
	death_evolution_delay = 5 MINUTES

	// *** Flags *** //
	caste_flags = CASTE_IS_INTELLIGENT|CASTE_IS_BUILDER|CASTE_STAGGER_RESISTANT|CASTE_LEADER_TYPE|CASTE_INSTANT_EVOLUTION
	can_hold_eggs = CAN_HOLD_TWO_HANDS
	can_flags = CASTE_CAN_HOLD_FACEHUGGERS|CASTE_CAN_HOLD_JELLY|CASTE_CAN_CORRUPT_GENERATOR|CASTE_CAN_BE_GIVEN_PLASMA
	caste_traits = null

	// *** Defense *** //
	soft_armor = list(MELEE = 65, BULLET = 65, LASER = 65, ENERGY = 65, BOMB = 30, BIO = 60, FIRE = 60, ACID = 60)

	// *** Ranged Attack *** //
	spit_delay = 1.1 SECONDS
	spit_types = list(/datum/ammo/tyranid/sticky, /datum/ammo/tyranid/acid/medium)

	// *** Pheromones *** //
	aura_strength = 5 //The Queen's aura is strong and stays so, and gets devastating late game. Climbs by 1 to 5

	// *** Queen Abilities *** //
	queen_leader_limit = 4 //Amount of leaders allowed

	minimap_icon = "tyranidqueen"

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/cocoon,
		/datum/action/ability/activable/tyranid/plant_weeds,
		/datum/action/ability/activable/tyranid/secrete_resin,
		/datum/action/ability/activable/tyranid/secrete_special_resin,
		/datum/action/ability/tyranid_action/blessing_menu,
		/datum/action/ability/tyranid_action/place_acidwell,
		/datum/action/ability/tyranid_action/lay_egg,
		/datum/action/ability/tyranid_action/call_of_the_burrowed,
		/datum/action/ability/activable/tyranid/screech,
		/datum/action/ability/tyranid_action/bulwark,
		/datum/action/ability/activable/tyranid/corrosive_acid/strong,
		/datum/action/ability/activable/tyranid/tyranid_spit,
		/datum/action/ability/activable/tyranid/psychic_cure/queen_give_heal,
		/datum/action/ability/activable/tyranid/neurotox_sting/ozelomelyn,
		/datum/action/ability/tyranid_action/pheromones,
		/datum/action/ability/tyranid_action/pheromones/emit_recovery,
		/datum/action/ability/tyranid_action/pheromones/emit_warding,
		/datum/action/ability/tyranid_action/pheromones/emit_frenzy,
		/datum/action/ability/tyranid_action/toggle_queen_zoom,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/tyranid_action/set_tyranid_lead,
		/datum/action/ability/activable/tyranid/queen_give_plasma,
		/datum/action/ability/tyranid_action/hive_message,
		/datum/action/ability/tyranid_action/rally_hive,
		/datum/action/ability/activable/tyranid/command_minions,
	)


/datum/tyranid_caste/queen/young
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/queen/primordial
	upgrade_name = "Primordial"
	caste_desc = "A fearsome Tyranid hulk of titanic proportions. Nothing can stand in it's way."
	primordial_message = "Destiny bows to our will as the universe trembles before us."
	upgrade = TYRANID_UPGRADE_PRIMO

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/cocoon,
		/datum/action/ability/activable/tyranid/plant_weeds,
		/datum/action/ability/activable/tyranid/secrete_resin,
		/datum/action/ability/activable/tyranid/secrete_special_resin,
		/datum/action/ability/tyranid_action/blessing_menu,
		/datum/action/ability/tyranid_action/place_acidwell,
		/datum/action/ability/tyranid_action/lay_egg,
		/datum/action/ability/tyranid_action/call_of_the_burrowed,
		/datum/action/ability/activable/tyranid/screech, // Primo enables alterative action for screech.
		/datum/action/ability/tyranid_action/bulwark,
		/datum/action/ability/activable/tyranid/corrosive_acid/strong,
		/datum/action/ability/activable/tyranid/tyranid_spit,
		/datum/action/ability/activable/tyranid/psychic_cure/queen_give_heal,
		/datum/action/ability/activable/tyranid/neurotox_sting/ozelomelyn,
		/datum/action/ability/tyranid_action/pheromones,
		/datum/action/ability/tyranid_action/pheromones/emit_recovery,
		/datum/action/ability/tyranid_action/pheromones/emit_warding,
		/datum/action/ability/tyranid_action/pheromones/emit_frenzy,
		/datum/action/ability/tyranid_action/toggle_queen_zoom,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/tyranid_action/set_tyranid_lead,
		/datum/action/ability/activable/tyranid/queen_give_plasma,
		/datum/action/ability/tyranid_action/sow,
		/datum/action/ability/tyranid_action/hive_message,
		/datum/action/ability/tyranid_action/rally_hive,
		/datum/action/ability/activable/tyranid/command_minions,
		/datum/action/ability/tyranid_action/ready_charge/queen_charge,
	)
