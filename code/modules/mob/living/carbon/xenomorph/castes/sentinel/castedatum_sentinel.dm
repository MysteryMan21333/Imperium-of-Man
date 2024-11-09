/datum/tyranid_caste/sentinel
	caste_name = "Sentinel"
	display_name = "Sentinel"
	upgrade_name = ""
	caste_desc = "A weak ranged combat alien."
	caste_type_path = /mob/living/carbon/tyranid/sentinel
	tier = TYRANID_TIER_ONE
	upgrade = TYRANID_UPGRADE_BASETYPE

	gib_anim = "gibbed-a-small-corpse"
	gib_flick = "gibbed-a-small"

	// *** Melee Attacks *** //
	melee_damage = 16

	// *** Speed *** //
	speed = -0.9

	// *** Plasma *** //
	plasma_max = 600
	plasma_gain = 20

	// *** Health *** //
	max_health = 300

	// *** Evolution *** //
	evolution_threshold = 100
	upgrade_threshold = TIER_ONE_THRESHOLD

	// *** Flags *** //
	caste_flags = CASTE_EVOLUTION_ALLOWED
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER|CASTE_CAN_RIDE_CRUSHER
	caste_traits = list(TRAIT_CAN_VENTCRAWL)

	// *** Defense *** //
	soft_armor = list(MELEE = 25, BULLET = 25, LASER = 25, ENERGY = 25, BOMB = 0, BIO = 25, FIRE = 26, ACID = 25)

	// *** Ranged Attack *** //
	spit_delay = 1.0 SECONDS
	spit_types = list(/datum/ammo/tyranid/acid/toxic_spit)

	// *** Sentinel Abilities ***
	additional_stacks = 3

	// *** Minimap Icon *** //
	minimap_icon = "sentinel"

	// *** Abilities *** //
	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/corrosive_acid/drone,
		/datum/action/ability/activable/tyranid/tyranid_spit/toxic_spit,
		/datum/action/ability/tyranid_action/toxic_slash,
		/datum/action/ability/activable/tyranid/drain_sting,
	)

/datum/tyranid_caste/sentinel/normal
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/sentinel/retrograde/normal
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/sentinel/primordial
	upgrade_name = "Primordial"
	caste_desc = "A doctors worst nightmare. It's stinger drips with poison."
	primordial_message = "All will succumb to our toxins. Leave noone standing."
	upgrade = TYRANID_UPGRADE_PRIMO

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/corrosive_acid/drone,
		/datum/action/ability/activable/tyranid/tyranid_spit/toxic_spit,
		/datum/action/ability/tyranid_action/toxic_slash,
		/datum/action/ability/activable/tyranid/drain_sting,
		/datum/action/ability/activable/tyranid/toxic_grenade,
	)

/datum/tyranid_caste/sentinel/retrograde
	caste_type_path = /mob/living/carbon/tyranid/sentinel/retrograde
	upgrade_name = ""
	caste_name = "Retrograde Sentinel"
	display_name = "Sentinel"
	upgrade = TYRANID_UPGRADE_BASETYPE
	caste_desc = "A weak ranged combat alien. This one seems to have a different kind of spit."

		// *** Ranged Attack *** //
	spit_delay = 1 SECONDS
	spit_types = list(/datum/ammo/tyranid/toxin, /datum/ammo/tyranid/acid/passthrough)

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/corrosive_acid/drone,
		/datum/action/ability/activable/tyranid/neurotox_sting,
		/datum/action/ability/activable/tyranid/tyranid_spit,
	)

/datum/tyranid_caste/sentinel/retrograde/primordial
	upgrade_name = "Primordial"
	upgrade = TYRANID_UPGRADE_PRIMO
	caste_desc = "A neurotoxic nightmare. It's stingers drip with poison."

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/corrosive_acid/drone,
		/datum/action/ability/activable/tyranid/neurotox_sting,
		/datum/action/ability/activable/tyranid/tyranid_spit,
		/datum/action/ability/activable/tyranid/toxic_grenade/neuro
	)
