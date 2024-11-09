/datum/unit_test/spawn_tyranids/Run()
	var/list/mob/living/carbon/tyranid/tyranids = list()
	GLOB.tyranid_stat_multiplicator_buff = 1
	for(var/castetype in GLOB.tyranid_caste_datums)
		var/tyranid_type = GLOB.tyranid_caste_datums[castetype][TYRANID_UPGRADE_BASETYPE].caste_type_path
		tyranids += allocate(tyranid_type)

	sleep(1 SECONDS)

	for(var/mob/living/carbon/tyranid/X AS in tyranids)
		X.upgrade_tyranid(X.upgrade_next())

	sleep(1 SECONDS)
