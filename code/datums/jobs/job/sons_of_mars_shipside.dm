//officer roles
/datum/job/chaos/command
	job_category = JOB_CAT_COMMAND
	selection_color = "#ddddff"
	supervisors = "the acting captain"
	exp_type_department = EXP_TYPE_COMMAND
	jobworth = list(
		/datum/job/tyranid = LARVA_POINTS_REGULAR,
		/datum/job/chaos/squad/veteran = VETERAN_POINTS_REGULAR,
	)

//General
/datum/job/chaos/command/commander
	title = CHAOS_COMMANDER
	req_admin_notify = TRUE
	paygrade = "CHAOS_O7"
	comm_title = "CMDR"
	supervisors = "CHAOS high command"
	selection_color = "#ccccff"
	total_positions = 1
	skills_type = /datum/skills/captain
	minimal_access = ALL_GUARDSMAN_ACCESS
	display_order = JOB_DISPLAY_ORDER_CAPTAIN
	outfit = /datum/outfit/job/chaos/command/commander
	exp_requirements = XP_REQ_EXPERT
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP|JOB_FLAG_LOUDER_TTS
	html_description = {"
		<b>Difficulty</b>: Hard<br /><br />
		<b>You answer to</b> CHAOS High Command<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Campaign<br /><br /><br />
		<b>Duty</b>: Lead the CHAOS forces and complete your mission. Support the guardsmans and communicate with your command staff, execute orders.
	"}
	minimap_icon = "captain" //placeholder

/datum/job/chaos/command/commander/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"As the senior officer in command of this CHAOS battallion you are held by higher standard and are expected to act competently.
Your primary task is to command and support the CHAOS guardsmans under your command from the command center in [SSmapping.configs[SHIP_MAP].map_name].
Your first order of business should be briefing the guardsmans on the mission they are about to undertake, and providing them with all the required attrition and asset support they need to succeed.
You should not be voluntarily leaving your base under any circumstances. You are a senior officer, not a field officer.
If you require any help, use <b>mentorhelp</b> to ask mentors about what you're supposed to do.
Godspeed, commander! And remember, you are not above the law."})


/datum/outfit/job/chaos/command/commander
	name = CHAOS_COMMANDER
	jobtype = /datum/job/chaos/command/commander

	id = /obj/item/card/id/gold

/datum/outfit/job/chaos/command/commander/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/binoculars/fire_support/campaign/chaos, SLOT_IN_R_POUCH)

/datum/job/chaos/command/commander/after_spawn(mob/living/new_mob, mob/user, latejoin)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) // starting
			new_human.wear_id.paygrade = "CHAOS_O7"
		if(1501 to 6000) // 25 hrs
			new_human.wear_id.paygrade = "CHAOS_G1"
		if(6001 to 18000) // 100 hrs
			new_human.wear_id.paygrade = "CHAOS_G2"
		if(18001 to 30000) // 300 hrs
			new_human.wear_id.paygrade = "CHAOS_G3"
		if(30001 to INFINITY) // 500 hrs
			new_human.wear_id.paygrade = "CHAOS_G4"

//Field Commander
/datum/job/chaos/command/fieldcommander
	title = CHAOS_FIELD_COMMANDER
	req_admin_notify = TRUE
	paygrade = "CHAOS_O3"
	comm_title = "FCDR"
	total_positions = 1
	skills_type = /datum/skills/fo
	display_order = JOB_DISPLAY_ORDER_EXECUTIVE_OFFICER
	outfit = /datum/outfit/job/chaos/command/fieldcommander
	exp_requirements = XP_REQ_EXPERIENCED
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP|JOB_FLAG_LOUDER_TTS
	html_description = {"
		<b>Difficulty</b>:Very Hard<br /><br />
		<b>You answer to the</b> commanding officer<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Campaign<br /><br /><br />
		<b>Duty</b>: Lead your platoon on the field. Take advantage of the military staff and assets you will need for the mission, keep good relations between command and the guardsmans. Assist your commander if available.
	"}
	minimap_icon = "chaos_fieldcommander"

/datum/job/chaos/command/fieldcommander/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"You are charged with overseeing the operation on the ground, and are the highest-ranked deployed CHAOS guardsman.
Your duties are to ensure the CHAOS are following orders and achieving objectives.
Lead by example and support those under your command.
Make the CHAOS proud!"})

/datum/job/chaos/command/fieldcommander/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	SSdirection.set_leader(TRACKING_ID_CHAOS_COMMANDER, new_mob)
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) // starting
			new_human.wear_id.paygrade = "CHAOS_O3"
		if(1501 to 6000) // 25 hrs
			new_human.wear_id.paygrade = "CHAOS_O4"
		if(6001 to 18000) // 100 hrs
			new_human.wear_id.paygrade = "CHAOS_O5"
		if(18001 to 30000) // 300 hrs
			new_human.wear_id.paygrade = "CHAOS_O6"
		if(30001 to INFINITY) // 500 hrs
			new_human.wear_id.paygrade = "CHAOS_O7"

/datum/outfit/job/chaos/command/fieldcommander
	name = CHAOS_FIELD_COMMANDER
	jobtype = /datum/job/chaos/command/fieldcommander

	id = /obj/item/card/id/dogtag/fc

//Staff Officer
/datum/job/chaos/command/staffofficer
	title = CHAOS_STAFF_OFFICER
	paygrade = "CHAOS_W5"
	comm_title = "SO"
	total_positions = 4
	access = list(ACCESS_GUARDSMAN_BRIDGE, ACCESS_GUARDSMAN_BRIG, ACCESS_GUARDSMAN_CARGO, ACCESS_GUARDSMAN_DROPSHIP, ACCESS_GUARDSMAN_LOGISTICS, ACCESS_GUARDSMAN_ALPHA, ACCESS_GUARDSMAN_BRAVO, ACCESS_GUARDSMAN_CHARLIE, ACCESS_GUARDSMAN_DELTA)
	minimal_access = ALL_GUARDSMAN_ACCESS
	skills_type = /datum/skills/so
	display_order = JOB_DISPLAY_ORDER_STAFF_OFFICER
	outfit = /datum/outfit/job/chaos/command/staffofficer
	exp_requirements = XP_REQ_INTERMEDIATE
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
	html_description = {"
		<b>Difficulty</b>: Medium<br /><br />
		<b>You answer to the</b> Captain<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Campaign<br /><br /><br />
		<b>Duty</b>: Take charge of one of the four squads, be their eyes and ears providing intel and additional shipside support via Orbital Bombardments.
	"}

	minimap_icon = "staffofficer"

/datum/job/chaos/command/staffofficer/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your job is to monitor the CHAOS forces on the ground, man the CIC, and listen to your superior officers.
You are in charge of logistics and the overwatch system. You are also in line to take command after the senior officer."})

/datum/job/chaos/command/staffofficer/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) // starting
			new_human.wear_id.paygrade = "CHAOS_W5"
		if(1501 to 6000) // 25 hrs
			new_human.wear_id.paygrade = "CHAOS_O1"
		if(6001 to 18000) // 100 hrs
			new_human.wear_id.paygrade = "CHAOS_O2"
		if(18001 to 30000) // 300 hrs
			new_human.wear_id.paygrade = "CHAOS_O3"
		if(30001 to INFINITY) // 500 hrs
			new_human.wear_id.paygrade = "CHAOS_O4"

/datum/outfit/job/chaos/command/staffofficer
	name = CHAOS_STAFF_OFFICER
	jobtype = /datum/job/chaos/command/staffofficer

	id = /obj/item/card/id/silver

//Pilot Officer
/datum/job/chaos/command/pilot
	title = CHAOS_PILOT_OFFICER
	paygrade = "CHAOS_W2"
	comm_title = "PO"
	total_positions = 2
	access = list(ACCESS_GUARDSMAN_BRIDGE, ACCESS_GUARDSMAN_DROPSHIP, ACCESS_GUARDSMAN_PILOT)
	minimal_access = list(ACCESS_GUARDSMAN_BRIDGE, ACCESS_GUARDSMAN_DROPSHIP, ACCESS_GUARDSMAN_PILOT, ACCESS_GUARDSMAN_LOGISTICS, ACCESS_GUARDSMAN_CARGO, ACCESS_GUARDSMAN_RO, ACCESS_GUARDSMAN_MEDBAY)
	skills_type = /datum/skills/pilot
	display_order = JOB_DISPLAY_ORDER_PILOT_OFFICER
	outfit = /datum/outfit/job/chaos/command/pilot
	exp_requirements = XP_REQ_INTERMEDIATE
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD
	html_description = {"
		<b>Difficulty</b>: Medium<br /><br />
		<b>You answer to the</b> acting Command Staff<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Campaign<br /><br /><br />
		<b>Duty</b>: Choose between the Condor, a modular attack aircraft that provides close air support with a variety of weapons ranging from the inbuilt gatling to wing mounted rockets; or the Tadpole, a versatile dropship capable of fulfilling roles ranging from ambulance to mobile bunker.
	"}
	minimap_icon = "pilot"

/datum/job/chaos/command/pilot/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) // starting
			new_human.wear_id.paygrade = "CHAOS_W2"
		if(1501 to 6000) // 25 hrs
			new_human.wear_id.paygrade = "CHAOS_W3"
		if(6001 to 18000) // 100 hrs
			new_human.wear_id.paygrade = "CHAOS_W4"
		if(18001 to 30000) // 300 hrs
			new_human.wear_id.paygrade = "CHAOS_W5"
		if(30001 to INFINITY) // 500 hrs
			new_human.wear_id.paygrade = "CHAOS_W6"

/datum/job/chaos/command/pilot/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your job is to support guardsmans with either close air support via the Condor, or mobile dropship support with the Tadpole.
While you are in charge of all aerial crafts the Alamo does not require supervision outside of turning automatic mode on or off at crucial times, and you are expected to choose between the Condor and Tadpole.
Though you are a warrant officer, your authority is limited to the dropship and your chosen aerial craft, where you have authority over the enlisted personnel.
"})


/datum/outfit/job/chaos/command/pilot
	name = CHAOS_PILOT_OFFICER
	jobtype = /datum/job/chaos/command/pilot

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/holster/belt/pistol/m4a3/vp70
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/guardsman/officer/pilot
	wear_suit = /obj/item/clothing/suit/storage/guardsman/pilot
	shoes = /obj/item/clothing/shoes/guardsman/full
	gloves = /obj/item/clothing/gloves/insulated
	glasses = /obj/item/clothing/glasses/sunglasses/aviator
	head = /obj/item/clothing/head/helmet/guardsman/pilot
	r_store = /obj/item/storage/pouch/general/large
	l_store = /obj/item/hud_tablet/pilot

//Mech pilot
/datum/job/chaos/command/mech_pilot
	title = CHAOS_MECH_PILOT
	req_admin_notify = TRUE
	paygrade = "CHAOS_W1"
	comm_title = "MCH"
	total_positions = 0
	skills_type = /datum/skills/mech_pilot
	access = list(ACCESS_GUARDSMAN_WO, ACCESS_GUARDSMAN_PREP, ACCESS_GUARDSMAN_MECH, ACCESS_CIVILIAN_PUBLIC)
	minimal_access = list(ACCESS_GUARDSMAN_WO, ACCESS_GUARDSMAN_PREP, ACCESS_GUARDSMAN_MECH, ACCESS_CIVILIAN_PUBLIC, ACCESS_GUARDSMAN_BRIDGE, ACCESS_GUARDSMAN_DROPSHIP, ACCESS_GUARDSMAN_LOGISTICS, ACCESS_GUARDSMAN_CARGO)
	display_order = JOB_DISPLAY_ORDER_MECH_PILOT
	outfit = /datum/outfit/job/chaos/command/mech_pilot
	exp_requirements = XP_REQ_EXPERT
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
	job_points_needed = 80
	html_description = {"
		<b>Difficulty</b>:Very Hard<br /><br />
		<b>You answer to the</b> acting Command Staff<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Campaign<br /><br /><br />
		<b>Duty</b>: Act as the spearhead of the operation
	"}
	minimap_icon = "mech_pilot"

/datum/job/chaos/command/mech_pilot/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"\nYou are the operator of a very expensive and valuable Mech, and are trained and expected to use it in the field of combat.
You can serve your Division in a variety of roles, so choose carefully."})

/datum/job/chaos/command/mech_pilot/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) // starting
			new_human.wear_id.paygrade = "CHAOS_W1"
		if(1501 to 6000) // 25 hrs
			new_human.wear_id.paygrade = "CHAOS_W2"
		if(6001 to 18000) // 100 hrs
			new_human.wear_id.paygrade = "CHAOS_W3"
		if(18001 to 30000) // 300 hrs
			new_human.wear_id.paygrade = "CHAOS_W4"
		if(30001 to INFINITY) // 500 hrs
			new_human.wear_id.paygrade = "CHAOS_W5"

/datum/outfit/job/chaos/command/mech_pilot
	name = CHAOS_MECH_PILOT
	jobtype = /datum/job/chaos/command/mech_pilot

	id = /obj/item/card/id/dogtag
	belt = /obj/item/storage/belt/utility/full
	glasses = /obj/item/clothing/glasses/welding
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/guardsman/officer/mech
	wear_suit = /obj/item/clothing/suit/storage/guardsman/mech_pilot
	head = /obj/item/clothing/head/helmet/guardsman/mech_pilot
	shoes = /obj/item/clothing/shoes/guardsman/full
	gloves = /obj/item/clothing/gloves/guardsman

/datum/job/chaos/engineering
	job_category = JOB_CAT_ENGINEERING
	selection_color = "#fff5cc"
	supervisors = "the acting captain"
	exp_type_department = EXP_TYPE_ENGINEERING


//Chief Ship Engineer
/datum/job/chaos/engineering/chief
	title = CHAOS_CHIEF_ENGINEER
	paygrade = "CHAOS_W2"
	comm_title = "CE"
	selection_color = "#ffeeaa"
	total_positions = 1
	access = list(ACCESS_GUARDSMAN_CE, ACCESS_GUARDSMAN_ENGINEERING, ACCESS_GUARDSMAN_BRIDGE, ACCESS_CIVILIAN_ENGINEERING, ACCESS_GUARDSMAN_CARGO, ACCESS_GUARDSMAN_DROPSHIP, ACCESS_GUARDSMAN_PREP)
	minimal_access = list(ACCESS_GUARDSMAN_CE, ACCESS_GUARDSMAN_ENGINEERING, ACCESS_GUARDSMAN_BRIDGE, ACCESS_CIVILIAN_ENGINEERING, ACCESS_GUARDSMAN_CARGO, ACCESS_GUARDSMAN_DROPSHIP, ACCESS_GUARDSMAN_LOGISTICS, ACCESS_GUARDSMAN_PREP, ACCESS_GUARDSMAN_RO, ACCESS_GUARDSMAN_MEDBAY)
	skills_type = /datum/skills/ce
	display_order = JOB_DISPLAY_ORDER_CHIEF_ENGINEER
	outfit = /datum/outfit/job/chaos/engineering/chief
	exp_requirements = XP_REQ_EXPERIENCED
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD
	html_description = {"
		<b>Difficulty</b>: Hard<br /><br />
		<b>You answer to the</b> acting Command Staff<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Campaign<br /><br /><br />
		<b>Duty</b>: Supervise the engineers and technicians on duty. Overview the ship’s engine. Teach what’s right and what’s wrong about engineering, cut corners and find places in any FOB that can easily be destroyed.
	"}
	minimap_icon = "cse"

/datum/job/chaos/engineering/chief/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) // starting
			new_human.wear_id.paygrade = "CHAOS_W2"
		if(1501 to 6000) // 25 hrs
			new_human.wear_id.paygrade = "CHAOS_W3"
		if(6001 to 18000) // 100 hrs
			new_human.wear_id.paygrade = "CHAOS_W4"
		if(18001 to 30000) // 300 hrs
			new_human.wear_id.paygrade = "CHAOS_W5"
		if(30001 to INFINITY) // 500 hrs
			new_human.wear_id.paygrade = "CHAOS_W6"

/datum/job/chaos/engineering/chief/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your job is to maintain the ship's engine and keep everything running.
If you have no idea how to set up the engine, or it's your first time, <b>mentorhelp</b> so that a mentor can assist you.
You are also next in the chain of command, should the bridge crew fall in the line of duty."})


/datum/outfit/job/chaos/engineering/chief
	name = CHAOS_CHIEF_ENGINEER
	jobtype = /datum/job/chaos/engineering/chief

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/belt/utility/full
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/guardsman/officer/ce
	wear_suit = /obj/item/clothing/suit/storage/guardsman/officer/req
	shoes = /obj/item/clothing/shoes/guardsman/full
	glasses = /obj/item/clothing/glasses/welding/superior
	gloves = /obj/item/clothing/gloves/insulated
	head = /obj/item/clothing/head/beret/guardsman/techofficer
	r_store = /obj/item/storage/pouch/construction
	back = /obj/item/storage/backpack/guardsman/engineerpack

/datum/outfit/job/chaos/engineering/chief/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/large_stack, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/stack/sheet/plasteel/large_stack, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/stack/sandbags/large_stack, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/stack/barbed_wire/full, SLOT_IN_R_POUCH)

//Ship Engineer
/datum/job/chaos/engineering/tech
	title = CHAOS_TECH
	comm_title = "TECH"
	paygrade = "CHAOS_E2"
	total_positions = 5
	supervisors = "the chief station engineer and the requisitions officer"
	access = list(ACCESS_GUARDSMAN_ENGINEERING, ACCESS_GUARDSMAN_PREP, ACCESS_GUARDSMAN_MEDBAY, ACCESS_GUARDSMAN_CARGO, ACCESS_CIVILIAN_ENGINEERING)
	minimal_access = list(ACCESS_GUARDSMAN_ENGINEERING, ACCESS_GUARDSMAN_PREP, ACCESS_GUARDSMAN_MEDBAY, ACCESS_GUARDSMAN_DROPSHIP, ACCESS_GUARDSMAN_CARGO, ACCESS_CIVILIAN_ENGINEERING)
	skills_type = /datum/skills/st
	display_order = JOB_DISPLAY_ORDER_SHIP_TECH
	outfit = /datum/outfit/job/chaos/engineering/tech
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD
	html_description = {"
		<b>Difficulty</b>: Medium<br /><br />
		<b>You answer to the</b> Chief Ship Engineer<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Campaign<br /><br /><br />
		<b>Duty</b>: Maintain the ship, be in charge of the engines. Be the secondary engineer to a forward operating base, prepare the shipside defenses if needed. Help the Pilot Officer in preparing the dropship.
	"}
	minimap_icon = "st"

/datum/job/chaos/engineering/tech/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) // starting
			new_human.wear_id.paygrade = "CHAOS_E2"
		if(1501 to 6000) // 25 hrs
			new_human.wear_id.paygrade = "CHAOS_E3"
		if(6001 to 18000) // 100 hrs
			new_human.wear_id.paygrade = "CHAOS_E4"
		if(18001 to 30000) // 300 hrs
			new_human.wear_id.paygrade = "CHAOS_E5"
		if(30001 to INFINITY) // 500 hrs
			new_human.wear_id.paygrade = "CHAOS_S1"

/datum/job/chaos/engineering/tech/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your job is to make sure the base is operational, you should firstly focus on manning the
requisitions line and later on to be ready to send supplies for guardsmans who are groundside."})


/datum/outfit/job/chaos/engineering/tech
	name = CHAOS_TECH
	jobtype = /datum/job/chaos/engineering/tech

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/belt/utility/full
	ears = /obj/item/radio/headset/mainship/st
	w_uniform = /obj/item/clothing/under/guardsman/officer/engi
	wear_suit = /obj/item/clothing/suit/storage/guardsman/ship_tech
	shoes = /obj/item/clothing/shoes/guardsman/full
	gloves = /obj/item/clothing/gloves/insulated
	glasses = /obj/item/clothing/glasses/welding/flipped
	head = /obj/item/clothing/head/tgmccap/req
	r_store = /obj/item/storage/pouch/general/medium
	back = /obj/item/storage/backpack/guardsman/engineerpack

/datum/job/chaos/requisitions
	job_category = JOB_CAT_REQUISITIONS
	selection_color = "#BAAFD9"
	supervisors = "the acting commander"
	exp_type_department = EXP_TYPE_REQUISITIONS


//Requisitions Officer
/datum/job/chaos/requisitions/officer
	title = CHAOS_REQUISITIONS_OFFICER
	req_admin_notify = TRUE
	paygrade = "CHAOS_W1"
	comm_title = "RO"
	selection_color = "#9990B2"
	total_positions = 1
	access = list(ACCESS_GUARDSMAN_DROPSHIP, ACCESS_GUARDSMAN_CARGO, ACCESS_GUARDSMAN_RO, ACCESS_GUARDSMAN_BRIDGE, ACCESS_GUARDSMAN_PREP, ACCESS_GUARDSMAN_ALPHA, ACCESS_GUARDSMAN_BRAVO, ACCESS_GUARDSMAN_CHARLIE, ACCESS_GUARDSMAN_DELTA)
	minimal_access = list(ACCESS_GUARDSMAN_CARGO, ACCESS_GUARDSMAN_RO, ACCESS_GUARDSMAN_BRIDGE, ACCESS_GUARDSMAN_PREP, ACCESS_GUARDSMAN_ALPHA, ACCESS_GUARDSMAN_BRAVO, ACCESS_GUARDSMAN_CHARLIE, ACCESS_GUARDSMAN_DELTA, ACCESS_GUARDSMAN_MEDBAY, ACCESS_GUARDSMAN_DROPSHIP, ACCESS_GUARDSMAN_LOGISTICS)
	skills_type = /datum/skills/ro
	display_order = JOB_DISPLAY_ORDER_REQUISITIONS_OFFICER
	outfit = /datum/outfit/job/chaos/requisitions/officer
	exp_requirements = XP_REQ_UNSEASONED
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD
	html_description = {"
		<b>Difficulty</b>: Medium<br /><br />
		<b>You answer to the</b> acting Command Staff<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Campaign<br /><br /><br />
		Supply the CHAOS with deluxe equipment to ensure success.
	"}
	minimap_icon = "requisition"

/datum/job/chaos/requisitions/officer/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) // starting
			new_human.wear_id.paygrade = "CHAOS_W1"
		if(1501 to 6000) // 25 hrs
			new_human.wear_id.paygrade = "CHAOS_W2"
		if(6001 to 18000) // 100 hrs
			new_human.wear_id.paygrade = "CHAOS_W3"
		if(18001 to 30000) // 300 hrs
			new_human.wear_id.paygrade = "CHAOS_W4"
		if(30001 to INFINITY) // 500 hrs
			new_human.wear_id.paygrade = "CHAOS_W5"

/datum/job/chaos/requisitions/officer/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your job is to dispense supplies to the CHAOS.
While you may request paperwork for supplies, do not go out of your way to screw with guardsmans, unless you want to get deposed.
A happy base is a well-functioning base."})


/datum/outfit/job/chaos/requisitions/officer
	name = CHAOS_REQUISITIONS_OFFICER
	jobtype = /datum/job/chaos/requisitions/officer

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/holster/belt/m44/full
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/guardsman/officer/ro_suit
	wear_suit = /obj/item/clothing/suit/storage/guardsman/officer/req
	suit_store = /obj/item/weapon/gun/energy/taser
	shoes = /obj/item/clothing/shoes/guardsman/full
	gloves = /obj/item/clothing/gloves/insulated
	head = /obj/item/clothing/head/tgmccap/req
	r_store = /obj/item/storage/pouch/general/large

/datum/job/chaos/medical
	job_category = JOB_CAT_MEDICAL
	selection_color = "#BBFFBB"
	exp_type_department = EXP_TYPE_MEDICAL


/datum/job/chaos/medical/professor
	title = CHAOS_CHIEF_MEDICAL_OFFICER
	req_admin_notify = TRUE
	comm_title = "CMO"
	paygrade = "CHO"
	total_positions = 1
	supervisors = "the acting commander"
	selection_color = "#99FF99"
	access = list(ACCESS_GUARDSMAN_DROPSHIP, ACCESS_GUARDSMAN_CMO, ACCESS_GUARDSMAN_MEDBAY, ACCESS_GUARDSMAN_RESEARCH, ACCESS_GUARDSMAN_BRIDGE, ACCESS_GUARDSMAN_CHEMISTRY)
	minimal_access = list(ACCESS_GUARDSMAN_CMO, ACCESS_GUARDSMAN_MEDBAY, ACCESS_GUARDSMAN_RESEARCH, ACCESS_GUARDSMAN_BRIDGE, ACCESS_GUARDSMAN_CHEMISTRY, ACCESS_GUARDSMAN_CARGO, ACCESS_GUARDSMAN_DROPSHIP, ACCESS_GUARDSMAN_LOGISTICS)
	skills_type = /datum/skills/cmo
	display_order = JOB_DISPLAY_ORDER_CHIEF_MEDICAL_OFFICER
	outfit = /datum/outfit/job/chaos/medical/professor
	exp_requirements = XP_REQ_EXPERIENCED
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD
	html_description = {"
		<b>Difficulty</b>: Hard<br /><br />
		<b>You answer to the</b> acting Command Staff<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Campaign<br /><br /><br />
		<b>Duty</b>: Communicate and lead your fellow medical staff (if available), supervise the medical department. Coordinate and teach fellow medical staff and corpsmen what they’re doing for treating an injury. Be the sole doctor in the Canterbury.
	"}
	minimap_icon = "chief_medical"

/datum/job/chaos/medical/professor/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"You are the chief medical officer stationed behind the frontlines and supervisor to the medical department.
You have final authority over the medical department, medications, and treatments.
Make sure that the doctors and nurses are doing their jobs and keeping the CHAOS healthy and strong."})

/datum/job/chaos/medical/professor/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 3000) // starting
			new_human.wear_id.paygrade = "CHO"
		if(3001 to INFINITY) // 50 hrs
			new_human.wear_id.paygrade = "CMO"

/datum/outfit/job/chaos/medical/professor
	name = CHAOS_CHIEF_MEDICAL_OFFICER
	jobtype = /datum/job/chaos/medical/professor

	id = /obj/item/card/id
	belt = /obj/item/storage/belt/rig/medical
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/rank/medical/blue
	wear_suit = /obj/item/clothing/suit/storage/labcoat/cmo
	shoes = /obj/item/clothing/shoes/white
	gloves = /obj/item/clothing/gloves/latex
	glasses = /obj/item/clothing/glasses/hud/health
	mask = /obj/item/clothing/mask/surgical
	head = /obj/item/clothing/head/cmo
	r_store = /obj/item/storage/pouch/medkit/doctor
	l_store = /obj/item/storage/pouch/surgery

/datum/outfit/job/chaos/medical/professor/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/tweezers_advanced, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/glass/bottle/lemoline/doctor, SLOT_IN_BACKPACK)

//Medical Officer
/datum/job/chaos/medical/medicalofficer
	title = CHAOS_MEDICAL_DOCTOR
	comm_title = "MD"
	paygrade = "RES"
	total_positions = 6
	supervisors = "the chief medical officer"
	access = list(ACCESS_GUARDSMAN_MEDBAY, ACCESS_GUARDSMAN_CHEMISTRY)
	minimal_access = list(ACCESS_GUARDSMAN_MEDBAY, ACCESS_GUARDSMAN_CHEMISTRY, ACCESS_GUARDSMAN_CARGO, ACCESS_GUARDSMAN_DROPSHIP)
	skills_type = /datum/skills/doctor
	display_order = JOB_DISPLAY_ORDER_DOCTOR
	outfit = /datum/outfit/job/chaos/medical/medicalofficer
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD
	html_description = {"
		<b>Difficulty</b>: Medium<br /><br />
		<b>You answer to the</b> Chief Medical Officer<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Campaign<br /><br /><br />
		<b>Duty</b>: Tend severely wounded patients to your aid in the form of surgery, repair broken bones and damaged organs, fix internal bleeding and prevent the birth of a tyranid larva. Develop superior healing medicines.
	"}
	minimap_icon = "medical"

/datum/job/chaos/medical/medicalofficer/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 3000) // starting
			new_human.wear_id.paygrade = "RES"
		if(3001 to INFINITY) // 50 hrs
			new_human.wear_id.paygrade = "MD"

/datum/job/chaos/medical/medicalofficer/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"You are a CHAOS medical doctor stationed behind the frontlines.
You are tasked with keeping the CHAOS healthy and strong, usually in the form of surgery.
You are also an expert when it comes to medication and treatment. If you do not know what you are doing, <b>mentorhelp</b> so a mentor can assist you."})


/datum/outfit/job/chaos/medical/medicalofficer
	name = CHAOS_MEDICAL_DOCTOR
	jobtype = /datum/job/chaos/medical/medicalofficer

	id = /obj/item/card/id
	belt = /obj/item/storage/belt/rig/medical
	ears = /obj/item/radio/headset/mainship/doc
	w_uniform = /obj/item/clothing/under/rank/medical/purple
	wear_suit = /obj/item/clothing/suit/storage/labcoat
	shoes = /obj/item/clothing/shoes/white
	gloves = /obj/item/clothing/gloves/latex
	glasses = /obj/item/clothing/glasses/hud/health
	mask = /obj/item/clothing/mask/surgical
	head = /obj/item/clothing/head/surgery/purple

/datum/outfit/job/chaos/medical/medicalofficer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/tweezers_advanced, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/glass/bottle/lemoline/doctor, SLOT_IN_BACKPACK)


/datum/job/chaos/civilian
	job_category = JOB_CAT_CIVILIAN
	selection_color = "#ffeedd"

/datum/job/chaos/civilian/chef
	title = CHAOS_CHEF
	comm_title = "CHEF"
	paygrade = "CHAOS_E1"
	total_positions = 2
	supervisors = "the acting commander"
	display_order = JOB_DISPLAY_ORDER_DOCTOR
	outfit = /datum/outfit/job/chaos/civilian/chef
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD
	html_description = {"
		<b>Difficulty</b>: Medium<br /><br />
		<b>You answer to the</b> acting CHAOS commander<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Campaign<br /><br /><br />
		<b>Duty</b>: Keep the CHAOS well fed and happy. Fight for your team if things get desperate.
	"}
	minimap_icon = "medical"

/datum/job/chaos/civilian/chef/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 3000) // starting
			new_human.wear_id.paygrade = "CHAOS_E1"
		if(3001 to INFINITY) // 50 hrs
			new_human.wear_id.paygrade = "CHAOS_E2"

/datum/job/chaos/civilian/chef/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"You are a chef stationed behind the frontlines.
You are tasked with keeping the CHAOS well fed and happy, usually in the form of delicious food.
You are also an expert when it comes to botany and hydroponics. If you do not know what you are doing, <b>mentorhelp</b> so a mentor can assist you."})


/datum/outfit/job/chaos/civilian/chef
	name = CHAOS_CHEF
	jobtype = /datum/job/chaos/civilian/chef

	id = /obj/item/card/id
	belt = /obj/item/storage/belt/rig/medical
	ears = /obj/item/radio/headset/mainship/doc
	w_uniform = /obj/item/clothing/under/rank/medical/purple
	wear_suit = /obj/item/clothing/suit/storage/labcoat
	shoes = /obj/item/clothing/shoes/white
	gloves = /obj/item/clothing/gloves/latex
	glasses = /obj/item/clothing/glasses/hud/health
	mask = /obj/item/clothing/mask/surgical
	head = /obj/item/clothing/head/surgery/purple

/datum/outfit/job/chaos/civilian/chef/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/tweezers_advanced, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/glass/bottle/lemoline/doctor, SLOT_IN_BACKPACK)
