/datum/job/mercenaries
	job_category = JOB_CAT_GUARDSMAN
	access = ALL_GUARDSMAN_ACCESS
	minimal_access = ALL_GUARDSMAN_ACCESS
	skills_type = /datum/skills/mercenary
	faction = FACTION_UNKN_MERCS


//Mercenary Heavy
/datum/job/mercenaries/heavy
	title = "Mercenary Heavy"
	paygrade = "MRC1"
	outfit = /datum/outfit/job/mercenaries/heavy



/datum/outfit/job/mercenaries/heavy
	name = "Mercenary Heavy"
	jobtype = /datum/job/mercenaries/heavy

	id = /obj/item/card/id/silver
	ears = /obj/item/radio/headset/distress/dutch
	w_uniform = /obj/item/clothing/under/guardsman/veteran/mercenary
	shoes = /obj/item/clothing/shoes/guardsman/pmc/full
	wear_suit = /obj/item/clothing/suit/storage/guardsman/veteran/mercenary
	gloves = /obj/item/clothing/gloves/combat
	head = /obj/item/clothing/head/helmet/guardsman/veteran/mercenary
	mask = /obj/item/clothing/mask/gas/pmc
	back = /obj/item/storage/backpack/satchel/norm


//Mercenary Miner
/datum/job/mercenaries/miner
	title = "Mercenary Miner"
	paygrade = "MRC2"
	outfit = /datum/outfit/job/mercenaries/miner


/datum/outfit/job/mercenaries/miner
	name = "Mercenary Miner"
	jobtype = /datum/job/mercenaries/miner

	id = /obj/item/card/id/silver
	ears = /obj/item/radio/headset/distress/dutch
	w_uniform = /obj/item/clothing/under/guardsman/veteran/mercenary/miner
	shoes = /obj/item/clothing/shoes/guardsman/pmc/full
	wear_suit = /obj/item/clothing/suit/storage/guardsman/veteran/mercenary/miner
	gloves = /obj/item/clothing/gloves/combat
	head = /obj/item/clothing/head/helmet/guardsman/veteran/mercenary/miner
	mask = /obj/item/clothing/mask/gas/pmc
	back = /obj/item/storage/backpack/satchel/norm


//Mercenary Engineer
/datum/job/mercenaries/engineer
	title = "Mercenary Engineer"
	paygrade = "MRC3"
	outfit = /datum/outfit/job/mercenaries/engineer


/datum/outfit/job/mercenaries/engineer
	name = "Mercenary Engineer"
	jobtype = /datum/job/mercenaries/engineer

	id = /obj/item/card/id/silver
	ears = /obj/item/radio/headset/distress/dutch
	w_uniform = /obj/item/clothing/under/guardsman/veteran/mercenary/engineer
	belt = /obj/item/storage/belt/utility/full
	shoes = /obj/item/clothing/shoes/guardsman/pmc/full
	wear_suit = /obj/item/clothing/suit/storage/guardsman/veteran/mercenary/engineer
	gloves = /obj/item/clothing/gloves/combat
	head = /obj/item/clothing/head/helmet/guardsman/veteran/mercenary/engineer
	glasses = /obj/item/clothing/glasses/welding/flipped
	mask = /obj/item/clothing/mask/gas/pmc
	back = /obj/item/storage/backpack/satchel/eng
