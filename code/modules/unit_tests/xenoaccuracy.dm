/datum/unit_test/tyranidaccuracy

/datum/unit_test/tyranidaccuracy/Run()
	for(var/datum/tyranid_caste/caste AS in subtypesof(/datum/tyranid_caste))
		if(initial(caste.accuracy_malus) >= TYRANID_DEFAULT_ACCURACY)
			Fail("A tyranid accuracy malus of 70 or over was detected, negatives cannot be used in accuracy calculations.")
