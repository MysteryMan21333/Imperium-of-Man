/datum/tyranid_caste/warlock
	caste_name = "Warlock"
	display_name = "Warlock"
	upgrade_name = ""
	caste_desc = "A powerful psychic tyranid. The Warlock devastates enemies of the hive with its psychic might, but it's physically very frail."
	caste_type_path = /mob/living/carbon/tyranid/warlock

	tier = TYRANID_TIER_THREE
	upgrade = TYRANID_UPGRADE_BASETYPE
	wound_type = "warlock"
	melee_damage = 18
	speed = -0.5
	plasma_max = 1700
	plasma_gain = 60
	max_health = 325
	upgrade_threshold = TIER_THREE_THRESHOLD
	spit_types = list(/datum/ammo/energy/tyranid/psy_blast)

	deevolves_to = /datum/tyranid_caste/wraith
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER
	caste_traits = null
	soft_armor = list(MELEE = 40, BULLET = 40, LASER = 40, ENERGY = 40, BOMB = 10, BIO = 35, FIRE = 35, ACID = 35)
	minimap_icon = "warlock"
	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/psy_crush,
		/datum/action/ability/activable/tyranid/psy_blast,
		/datum/action/ability/activable/tyranid/psychic_shield,
		/datum/action/ability/activable/tyranid/transfer_plasma/drone,
		/datum/action/ability/tyranid_action/psychic_whisper,
	)

/datum/tyranid_caste/warlock/normal
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/warlock/primordial
	upgrade_name = "Primordial"
	caste_desc = "An overwhelming psychic beacon. The air around it seems to dance with barely contained power."
	primordial_message = "We see the beauty of the unlimited psychic power of the hive. Enlighten the tallhosts to its majesty."
	upgrade = TYRANID_UPGRADE_PRIMO

	spit_types = list(/datum/ammo/energy/tyranid/psy_blast, /datum/ammo/energy/tyranid/psy_blast/psy_lance)

