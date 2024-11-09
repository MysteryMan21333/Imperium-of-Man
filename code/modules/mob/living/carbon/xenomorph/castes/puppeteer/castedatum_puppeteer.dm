/datum/tyranid_caste/puppeteer
	caste_name = "Puppeteer"
	display_name = "Puppeteer"
	upgrade_name = ""
	caste_desc = "An alien creature of terrifying display, it has a tail adorned with needles that drips a strange chemical and elongated claws."
	caste_type_path = /mob/living/carbon/tyranid/puppeteer
	primordial_message = "The organics will tremble at our swarm. We are legion."

	tier = TYRANID_TIER_TWO
	upgrade = TYRANID_UPGRADE_BASETYPE
	wound_type = "puppeteer"
	speed = -0.8
	melee_damage = 18
	plasma_max = 750
	plasma_gain = 0
	plasma_regen_limit = 0
	plasma_icon_state = "fury"
	max_health = 365
	upgrade_threshold = TIER_TWO_THRESHOLD
	evolution_threshold = 225

	deevolves_to = /datum/tyranid_caste/defender
	caste_flags = CASTE_INNATE_PLASMA_REGEN|CASTE_PLASMADRAIN_IMMUNE|CASTE_EVOLUTION_ALLOWED
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_LEADER
	caste_traits = null
	soft_armor = list(MELEE = 20, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 10, BIO = 20, FIRE = 20, ACID = 20)
	minimap_icon = "puppeteer"
	flay_plasma_gain = 100
	max_puppets = 3
	aura_strength = 2.8

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain/free,
		/datum/action/ability/activable/tyranid/flay,
		/datum/action/ability/activable/tyranid/pincushion,
		/datum/action/ability/tyranid_action/dreadful_presence,
		/datum/action/ability/activable/tyranid/refurbish_husk,
		/datum/action/ability/activable/tyranid/puppet,
		/datum/action/ability/activable/tyranid/organic_bomb,
		/datum/action/ability/tyranid_action/puppeteer_unleash,
		/datum/action/ability/tyranid_action/puppeteer_recall,
		/datum/action/ability/activable/tyranid/articulate,
		/datum/action/ability/activable/tyranid/puppet_blessings,
	)

/datum/tyranid_caste/puppeteer/normal
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/puppeteer/primordial
	upgrade_name = "Primordial"
	caste_desc = "Being within mere eyeshot of this hulking monstrosity fills you with a deep, unshakeable sense of unease. You are unsure if you can even harm it."
	upgrade = TYRANID_UPGRADE_PRIMO
	speed = -0.8
	melee_damage = 18
	plasma_max = 750
	max_health = 385
	soft_armor = list(MELEE = 20, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 10, BIO = 20, FIRE = 20, ACID = 20)
	max_puppets = 3

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain/free,
		/datum/action/ability/activable/tyranid/flay,
		/datum/action/ability/activable/tyranid/pincushion,
		/datum/action/ability/tyranid_action/dreadful_presence,
		/datum/action/ability/activable/tyranid/refurbish_husk,
		/datum/action/ability/activable/tyranid/puppet,
		/datum/action/ability/activable/tyranid/organic_bomb,
		/datum/action/ability/activable/tyranid/tendril_patch,
		/datum/action/ability/tyranid_action/puppeteer_unleash,
		/datum/action/ability/tyranid_action/puppeteer_recall,
		/datum/action/ability/activable/tyranid/articulate,
		/datum/action/ability/activable/tyranid/puppet_blessings,
	)

	aura_strength = 3
