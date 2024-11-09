/datum/unit_test/tyranid_logical_scaling/Run()
	var/list/by_tyranid = list()
	for(var/datum/tyranid_caste/caste AS in subtypesof(/datum/tyranid_caste))
		var/typepath = initial(caste.caste_type_path)
		var/upgrade = initial(caste.upgrade)
		if(isnull(typepath))
			Fail("[caste] has a null caste_type_path")
			continue
		if(upgrade == TYRANID_UPGRADE_BASETYPE)
			continue
		if(isnull(upgrade))
			Fail("[caste] has a null upgrade")
			continue
		if(!("[typepath]" in by_tyranid))
			by_tyranid["[typepath]"] = list()
		by_tyranid["[typepath]"] += list("[upgrade]" = caste)
	var/datum/tyranid_caste/caste
	for(var/tyranidpath in by_tyranid)
		var/list/mob_data = by_tyranid[tyranidpath]
		// Each of these values should get larger or stay the same each evolution
		var/list/greater_test_vars = list(
			"max_health" = 0,
			"melee_damage" = 0,
			"plasma_max" = 0,
			"plasma_gain" = 0,
		)
		// Each of these values should get smaller or stay the same each evolution
		var/list/lesser_test_vars = list(
			"speed" = 99,
		)
		for(var/upgradepath in mob_data)
			var/typepath = mob_data[upgradepath]
			caste = new typepath
			// Check for values that are should grow with each level
			for(var/stat in greater_test_vars)
				if(caste.vars[stat] < greater_test_vars[stat])
					Fail("Invalid stats on [tyranidpath]. It's [stat]@[upgradepath] has [caste.vars[stat]] compared to base value of [greater_test_vars[stat]] (expected greater)")
				greater_test_vars[stat] = caste.vars[stat]
			// Test for values that are should shrink with each level
			for(var/stat in lesser_test_vars)
				if(caste.vars[stat] > lesser_test_vars[stat])
					Fail("Invalid stats on [tyranidpath]. It's [stat]@[TYRANID_UPGRADE_NORMAL] has [caste.vars[stat]] compared to base value of [lesser_test_vars[stat]] (expected lower)")
				lesser_test_vars[stat] = caste.vars[stat]
