/datum/tyranid_caste/spitter
	caste_name = "Spitter"
	display_name = "Spitter"
	upgrade_name = ""
	caste_desc = "Gotta dodge!"
	caste_type_path = /mob/living/carbon/tyranid/spitter
	tier = TYRANID_TIER_TWO
	upgrade = TYRANID_UPGRADE_BASETYPE
	wound_type = "spitter" //used to match appropriate wound overlays

	// *** Melee Attacks *** //
	melee_damage = 20

	// *** Speed *** //
	speed = -0.6

	// *** Plasma *** //
	plasma_max = 925
	plasma_gain = 40

	// *** Health *** //
	max_health = 360

	// *** Evolution *** //
	evolution_threshold = 225
	upgrade_threshold = TIER_TWO_THRESHOLD

	deevolves_to = /datum/tyranid_caste/sentinel

	// *** Flags *** //
	caste_flags = CASTE_EVOLUTION_ALLOWED
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER|CASTE_CAN_RIDE_CRUSHER
	caste_traits = list(TRAIT_CAN_VENTCRAWL)

	// *** Defense *** //
	soft_armor = list(MELEE = 25, BULLET = 35, LASER = 35, ENERGY = 35, BOMB = 0, BIO = 20, FIRE = 35, ACID = 20)

	// *** Minimap Icon *** //
	minimap_icon = "spitter"

	// *** Ranged Attack *** //
	spit_delay = 0.5 SECONDS
	spit_types = list(/datum/ammo/tyranid/acid/medium) //Gotta give them their own version of heavy acid; kludgy but necessary as 100 plasma is way too costly.

	acid_spray_duration = 10 SECONDS
	acid_spray_damage_on_hit = 45
	acid_spray_damage = 20
	acid_spray_structure_damage = 45

	// *** Abilities *** //
	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/corrosive_acid,
		/datum/action/ability/activable/tyranid/tyranid_spit,
		/datum/action/ability/activable/tyranid/scatter_spit,
		/datum/action/ability/activable/tyranid/spray_acid/line,
	)

/datum/tyranid_caste/spitter/normal
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/spitter/primordial
	upgrade_name = "Primordial"
	caste_desc = "Master of ranged combat, this tyranid knows no equal."
	upgrade = TYRANID_UPGRADE_PRIMO
	primordial_message = "Our suppression is unmatched! Let nothing show its head!"
	caste_flags = CASTE_EVOLUTION_ALLOWED|CASTE_ACID_BLOOD

	spit_delay = 0.3 SECONDS
	spit_types = list(/datum/ammo/tyranid/acid/auto, /datum/ammo/tyranid/acid/medium)
