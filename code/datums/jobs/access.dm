/obj/proc/allowed(mob/M)
	//check if it doesn't require any access at all
	if(check_access())
		return TRUE

	if(issilicon(M))
		return TRUE //Silicons can access whatever they want

	if(IsAdminGhost(M))
		return TRUE

	var/obj/item/card/id/I = M.get_idcard() //if they are holding or wearing a card that has access, that works.
	if(check_access(I))
		return TRUE


/obj/proc/check_access(obj/item/card/id/ID)
	if(!LAZYLEN(req_access) && !LAZYLEN(req_one_access))
		return TRUE

	if(!istype(ID))
		return FALSE

	for(var/i in req_access)
		if(!(i in ID.access))
			return FALSE

	if(LAZYLEN(req_one_access))
		for(var/i in req_one_access)
			if(!(i in ID.access))
				continue
			return TRUE
		return FALSE

	return TRUE

/proc/get_region_accesses(code)
	switch(code)
		if(0)
			return ALL_ACCESS
		if(1)
			return list(ACCESS_GUARDSMAN_CAPTAIN, ACCESS_GUARDSMAN_COMMANDER, ACCESS_GUARDSMAN_LOGISTICS, ACCESS_GUARDSMAN_DROPSHIP, ACCESS_GUARDSMAN_TADPOLE, ACCESS_GUARDSMAN_PILOT, ACCESS_GUARDSMAN_MECH, ACCESS_GUARDSMAN_BRIDGE, ACCESS_GUARDSMAN_ARMORED)//command
		if(2)
			return list(ACCESS_GUARDSMAN_CE, ACCESS_GUARDSMAN_ENGINEERING, ACCESS_GUARDSMAN_REMOTEBUILD)//engineering and maintenance
		if(3)
			return list(ACCESS_GUARDSMAN_CMO, ACCESS_GUARDSMAN_MEDBAY, ACCESS_GUARDSMAN_CHEMISTRY, ACCESS_GUARDSMAN_RESEARCH)//medbay
		if(4)
			return list(ACCESS_GUARDSMAN_RO, ACCESS_GUARDSMAN_CARGO)//req
		if(5)
			return list(ACCESS_GUARDSMAN_WO, ACCESS_GUARDSMAN_ARMORY, ACCESS_GUARDSMAN_BRIG)//security
		if(6)
			return list(ACCESS_GUARDSMAN_PREP, ACCESS_GUARDSMAN_MEDPREP, ACCESS_GUARDSMAN_ENGPREP, ACCESS_GUARDSMAN_SMARTPREP, ACCESS_GUARDSMAN_LEADER)//spess mahreens
		if(7)
			return list(ACCESS_GUARDSMAN_ALPHA, ACCESS_GUARDSMAN_BRAVO, ACCESS_GUARDSMAN_CHARLIE, ACCESS_GUARDSMAN_DELTA)//squads
		if(8)
			return list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_LOGISTICS, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING)//Civilian


/proc/get_region_accesses_name(code)
	switch(code)
		if(0)
			return "All"
		if(1)
			return "[SSmapping.configs[SHIP_MAP].map_name] Command"//command
		if(2)
			return "[SSmapping.configs[SHIP_MAP].map_name] Engineering"//engineering
		if(3)
			return "[SSmapping.configs[SHIP_MAP].map_name] Medical"//medbay
		if(4)
			return "[SSmapping.configs[SHIP_MAP].map_name] Requisitions"//requisitions
		if(5)
			return "[SSmapping.configs[SHIP_MAP].map_name] Security"//security
		if(6)
			return "[SSmapping.configs[SHIP_MAP].map_name] Guardsman"//guardsman prep
		if(7)
			return "Squad Access"//squads
		if(8)
			return "Civilian"//Civilian


/proc/get_access_desc(A)
	switch(A)
		if(ACCESS_GUARDSMAN_WO)
			return "WO's Office"
		if(ACCESS_GUARDSMAN_BRIG)
			return "Brig"
		if(ACCESS_GUARDSMAN_ARMORY)
			return "Armory"
		if(ACCESS_GUARDSMAN_CMO)
			return "CMO's Office"
		if(ACCESS_GUARDSMAN_MEDBAY)
			return "Medbay"
		if(ACCESS_GUARDSMAN_CHEMISTRY)
			return "Chemistry"
		if(ACCESS_GUARDSMAN_RESEARCH)
			return "Research"
		if(ACCESS_GUARDSMAN_CE)
			return "CE's Office"
		if(ACCESS_GUARDSMAN_ENGINEERING)
			return "Engineering"
		if(ACCESS_GUARDSMAN_REMOTEBUILD)
			return "FOB Construction Drone"
		if(ACCESS_GUARDSMAN_CAPTAIN)
			return "Captain's Quarters"
		if(ACCESS_GUARDSMAN_COMMANDER)
			return "Field Commander's Quarters"
		if(ACCESS_GUARDSMAN_LOGISTICS)
			return "Logistics"
		if(ACCESS_GUARDSMAN_BRIDGE)
			return "Bridge"
		if(ACCESS_GUARDSMAN_PREP)
			return "Guardsman Prep"
		if(ACCESS_GUARDSMAN_ENGPREP)
			return "Guardsman Squad Engineering"
		if(ACCESS_GUARDSMAN_MEDPREP)
			return "Guardsman Squad Medical"
		if(ACCESS_GUARDSMAN_SMARTPREP)
			return "Guardsman Smartgunner"
		if(ACCESS_GUARDSMAN_LEADER)
			return "Guardsman Leader"
		if(ACCESS_GUARDSMAN_ALPHA)
			return "Alpha Squad"
		if(ACCESS_GUARDSMAN_BRAVO)
			return "Bravo Squad"
		if(ACCESS_GUARDSMAN_CHARLIE)
			return "Charlie Squad"
		if(ACCESS_GUARDSMAN_DELTA)
			return "Delta Squad"
		if(ACCESS_GUARDSMAN_RO)
			return "RO's Office"
		if(ACCESS_GUARDSMAN_CARGO)
			return "Requisitions"
		if(ACCESS_GUARDSMAN_DROPSHIP)
			return "Dropship Piloting"
		if(ACCESS_GUARDSMAN_TADPOLE)
			return "Tadpole Piloting"
		if(ACCESS_GUARDSMAN_PILOT)
			return "Pilot Gear"
		if(ACCESS_GUARDSMAN_MECH)
			return "Mech"
		if(ACCESS_GUARDSMAN_ARMORED)
			return "Armored Vehicle Bay"
		if(ACCESS_CIVILIAN_RESEARCH)
			return "Civilian Research"
		if(ACCESS_CIVILIAN_LOGISTICS)
			return "Civilian Command"
		if(ACCESS_CIVILIAN_ENGINEERING)
			return "Civilian Engineering"
		if(ACCESS_CIVILIAN_PUBLIC)
			return "Civilian"

/proc/get_centcom_access_desc(A)
	switch(A)
		if(ACCESS_NT_PMC_GREEN)
			return "NT PMC Green"
		if(ACCESS_NT_PMC_ORANGE)
			return "NT PMC Orange"
		if(ACCESS_NT_PMC_RED)
			return "NT PMC Red"
		if(ACCESS_NT_PMC_BLACK)
			return "NT PMC Black"
		if(ACCESS_NT_PMC_WHITE)
			return "NT PMC White"
		if(ACCESS_NT_CORPORATE)
			return "NT Executive"


/proc/get_access_job_name(obj/item/card/id/ID)
	var/first_matched
	for(var/i in SSjob.occupations)
		var/datum/job/J = i
		if(J.title == ID.rank)
			return J.title
		if(!first_matched && (J.access ~= ID.access))
			first_matched = J.title
	if(first_matched)
		return first_matched
	else if(length(ID.access))
		return "Custom [ADMIN_VV(ID.access)]"
	else
		return "None"


/proc/get_paygrades(paygrade, size, gender)
	if(!paygrade)
		return
	switch(paygrade)
		if("C")
			. = size ? "" : "Civilian"
		if("MS")
			. = size ? "MS" : "Medical Student"
		if("JR")
			. = size ? "JR" : "Junior Resident"
		if("SR")
			. = size ? "SR" : "Senior Resident"
		if("GP")
			. = size ? "GP" : "General Practitioner"
		if("AP")
			. = size ? "AP" : "Attending Physician"
		if("SP")
			. = size ? "SP" : "Senior Physician"
		if("HP")
			. = size ? "HP" : "Head Physician"
		if("MSPVR")
			. = size ? "MSPVR" : "Medical Supervisor"
		if("MDR")
			. = size ? "MDR" : "Medical Director"
		if("RSRA")
			. = size ? "RSRA" : "Research Assistant"
		if("RSR")
			. = size ? "RSR" : "Researcher"
		if("LECT")
			. = size ? "LECT" : "Lecturer"
		if("APROF")
			. = size ? "APROF" : "Associate Professor"
		if("PROF")
			. = size ? "PROF" : "Professor"
		if("CMO")
			. = size ? "CMO" : "Chief Medical Officer"
		if("CMN")
			. = size ? "CMN" : "Crewman"
		if("PMC1")
			. = size ? "PMC" : "PM Contractor"
		if("PMC2")
			. = size ? "PMSC" : "PM Senior Contractor"
		if("PMC3")
			. = size ? "PMSC" : "PM Senior Contractor"
		if("PMC4")
			. = size ? "PMTL" : "PM Team Leader"
		if("PMCDS")
			. = size ? "APS" : "Assets Protection Specialist"
		if("PMCDSL")
			. = size ? "APTL" : "Assets Protection Team Leader"
		if("NT1")
			. = size ? "INT" : "Corporate Intern"
		if("NT2")
			. = size ? "ASSOC" : "Corporate Associate"
		if("NT3")
			. = size ? "PTNR" : "Corporate Partner"
		if("NT4")
			. = size ? "ANLST" : "Corporate Analyst"
		if("NT5")
			. = size ? "SPVR" : "Corporate Supervisor"
		if("E1")
			. = size ? "PVT" : "Private"
		if("E2")
			. = size ? "PFC" : "Private First Class"
		if("E3")
			. = size ? "LCPL" : "Lance Corporal"
		if("E3E")
			. = size ? "SCPL" : "Section Corporal" //Anachronistic if we're going by common US ranks, above E3 but below E4.
		if("E4")
			. = size ? "CPL" : "Corporal"
		if("E5")
			. = size ? "SGT" : "Sergeant"
		if("E6")
			. = size ? "SSGT" : "Staff Sergeant"
		if("E7")
			. = size ? "SFC" : "Sergeant First Class"
		if("E7E")
			. = size ? "GYSGT" : "Gunnery Sergeant"
		if("E8")
			. = size ? "MSGT" : "Master Sergeant"
		if("E8E")
			. = size ? "FSGT" : "First Sergeant"
		if("E9")
			. = size ? "MGYSGT" : "Master Gunnery Sergeant"
		if("E9A")
			. = size ? "SGM" : "Sergeant Major" //above master gunnery sergeant, below command sergeant major
		if("E9E")
			. = size ? "CSGM" : "Command Sergeant Major"
		if("O1")
			. = size ? "ENS" : "Ensign"
		if("O2")
			. = size ? "LTJG" : "Lieutenant Junior Grade"
		if("O3")
			. = size ? "LT" : "Lieutenant"
		if("O4")
			. = size ? "LCDR" : "Lieutenant Commander"
		if("O5")
			. = size ? "CDR" : "Commander"
		if("O6")
			. = size ? "CPT" : "Captain"
		if("O7")
			. = size ? "COMM" : "Commodore"
		if("O8")
			. = size ? "RADM" : "Rear Admiral"
		if("O9")
			. = size ? "VADM" : "Vice Admiral"
		if("10")
			. = size ? "ADM" : "Admiral"
		if("11")
			. = size ? "FADM" : "Fleet Admiral"
		if("WO")
			. = size ? "WO" : "Warrant Officer"
		if("CWO")
			. = size ? "CWO" : "Chief Warrant Officer"
		if("PO3")
			. = size ? "PO3" : "Petty Officer Third Class"
		if("PO2")
			. = size ? "PO2" : "Petty Officer Second Class"
		if("PO1")
			. = size ? "PO1" : "Petty Officer First Class"
		if("CPO")
			. = size ? "CPO" : "Chief Petty Officer"
		if("SCPO")
			. = size ? "SCPO" : "Senior Chief Petty Officer"
		if("MO4")
			. = size ? "MAJ" : "Major"
		if("MO5")
			. = size ? "LtCol" : "Lieutenant Colonel"
		if("MO6")
			. = size ? "Col" : "Colonel"
		if("M10")
			. = size ? "Gen" : "General"
		if("UPP1")
			. = size ? "UGNR" : "USL Gunner"
		if("UPP2")
			. = size ? "USUR" : "USL Surgeon"
		if("UPP3")
			. = size ? "UPOM" : "USL Powder Monkey"
		if("UPP4")
			. = size ? "UCPT" : "USL Captain"
		if("UPP5")
			. = size ? "UQM" : "USL Quartermaster"
		if("UPP6")
			. = size ? "USSGT" : "USL Staff Sergeant"
		if("UPP7")
			. = size ? "UENS" : "USL Ensign"
		if("UPP8")
			. = size ? "ULT" : "USL Lieutenant"
		if("UPP9")
			. = size ? "ULCDR" : "USL Lieutenant Commander"
		if("UPP10")
			. = size ? "UCDR" : "USL Commander"
		if("UPP11")
			. = size ? "UADM" : "USL Admiral"
		if("UPPC1")
			. = size ? "UEPM" : "USL Elite Powder Monkey"
		if("UPPC2")
			. = size ? "UESUR" : "USL Elite Surgeon"
		if("UPPC3")
			. = size ? "UECPT" : "USL Elite Captain"
		if("FRE1")
			. = size ? "FRE" : "Freelancer Standard"
		if("FRE2")
			. = size ? "FRE" : "Freelancer Medic"
		if("FRE3")
			. = size ? "FRE" : "Freelancer Veteran"
		if("FRE4")
			. = size ? "FRE" : "Freelancer Leader"
		if("CLF1")
			. = size ? "CLF" : "CLF Standard"
		if("CLF2")
			. = size ? "CLF" : "CLF Medic"
		if("CLF3")
			. = size ? "CLF" : "CLF Leader"
		if("CHAOS_E1")
			. = size ? "PTE" : "CHAOS Private"
		if("CHAOS_E2")
			. = size ? "PFC" : "CHAOS Private First Class"
		if("CHAOS_E3")
			. = size ? "LCP" : "CHAOS Lance Corporal"
		if("CHAOS_E4")
			. = size ? "CPL" : "CHAOS Corporal"
		if("CHAOS_E5")
			. = size ? "CFC" : "CHAOS Corporal First Class"
		if("CHAOS_S1")
			. = size ? "3SG" : "CHAOS Third Sergeant"
		if("CHAOS_S2")
			. = size ? "2SG" : "CHAOS Second Sergeant"
		if("CHAOS_S3")
			. = size ? "1SG" : "CHAOS First Sergeant"
		if("CHAOS_S4")
			. = size ? "SSG" : "CHAOS Staff Sergeant"
		if("CHAOS_S5")
			. = size ? "MSG" : "CHAOS Master Sergeant"
		if("CHAOS_W1")
			. = size ? "3WO" : "CHAOS Third Warrant Officer"
		if("CHAOS_W2")
			. = size ? "2WO" : "CHAOS Second Warrant Officer"
		if("CHAOS_W3")
			. = size ? "1WWO" : "CHAOS First Warrant Officer"
		if("CHAOS_W4")
			. = size ? "MWO" : "CHAOS Master Warrant Officer"
		if("CHAOS_W5")
			. = size ? "SWO" : "CHAOS Senior Warrant Officer"
		if("CHAOS_W6")
			. = size ? "CWO" : "CHAOS Chief Warrant Officer"
		if("CHAOS_O1")
			. = size ? "2LT" : "CHAOS Second Lieutenant"
		if("CHAOS_O2")
			. = size ? "LTA" : "CHAOS Lieutenant"
		if("CHAOS_O3")
			. = size ? "CPT" : "CHAOS Captain"
		if("CHAOS_O4")
			. = size ? "MAJ" : "CHAOS Major"
		if("CHAOS_O5")
			. = size ? "LTC" : "CHAOS Lieutenant-Colonel"
		if("CHAOS_O6")
			. = size ? "SLTC" : "CHAOS Senior Lieutenant-Colonel"
		if("CHAOS_O7")
			. = size ? "COL" : "CHAOS Colonel"
		if("CHAOS_G1")
			. = size ? "BG" : "CHAOS Brigadier-General"
		if("CHAOS_G2")
			. = size ? "MG" : "CHAOS Major-General"
		if("CHAOS_G3")
			. = size ? "LG" : "CHAOS Lieutenant-General"
		if("CHAOS_G4")
			. = size ? "GEN" : "CHAOS General"
		if("CHAOS_A1")
			. = size ? "RADM(1)" : "CHAOS Rear-Admiral"
		if("CHAOS_A2")
			. = size ? "RADM(2)" : "CHAOS Rear-Admiral"
		if("CHAOS_A3")
			. = size ? "VADM" : "CHAOS Vice-Admiral"
		if("CHAOS_A4")
			. = size ? "ADM" : "CHAOS Admiral"
		if("ICC1")
			. = size ? "ICC" : "ICC Standard"
		if("ICC2")
			. = size ? "ICC" : "ICC Medic"
		if("ICC3")
			. = size ? "ICCG" : "ICC Guard"
		if("ICC4")
			. = size ? "ICCL" : "ICC Leader"
		if("VSD1")
			. = size ? "JSGT" : "VSD Mládshiy serzhánt"
		if("VSD2")
			. = size ? "SSGT" : "VSD Stárshiy serzhánt"
		if("VSD3")
			. = size ? "SGM" : "VSD Starshiná"
		if("VSD4")
			. = size ? "LT" : "VSD Leytenánt"
		if("VSD5")
			. = size ? "COLGEN" : "VSD Generál-polkóvnik"
		if("MRC1")
			. = size ? "MERC" : "MERC Heavy"
		if("MRC2")
			. = size ? "MERC" : "MERC Miner"
		if("MRC3")
			. = size ? "MERC" : "MERC Engineer"
		if("VM")
			. = size ? "VAT" : "VatGrown Guardsman"
		if("Mk.V")
			. = size ? "Mk.V" : "Mark V"
		if("Mk.IV")
			. = size ? "Mk.IV" : "Mark IV"
		if("Mk.III")
			. = size ? "Mk.III" : "Mark III"
		if("Mk.II")
			. = size ? "Mk.II" : "Mark II"
		if("Mk.I")
			. = size ? "Mk.I" : "Mark I"
		else
			. = paygrade //custom paygrade
