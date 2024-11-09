GLOBAL_LIST_INIT(quick_loadouts, init_quick_loadouts())

///The list is shared across all quick vendors, but they will only display the tabs specified by the vendor, and only show the loadouts with jobs that match the displayed tabs.
/proc/init_quick_loadouts()
	. = list()
	var/list/loadout_list = list(
		/datum/outfit/quick/tgmc/guardsman/standard_carbine,
		/datum/outfit/quick/tgmc/guardsman/standard_assaultrifle,
		/datum/outfit/quick/tgmc/guardsman/combat_rifle,
		/datum/outfit/quick/tgmc/guardsman/standard_laserrifle,
		/datum/outfit/quick/tgmc/guardsman/standard_battlerifle,
		/datum/outfit/quick/tgmc/guardsman/standard_skirmishrifle,
		/datum/outfit/quick/tgmc/guardsman/alf_shocktrooper,
		/datum/outfit/quick/tgmc/guardsman/standard_machinegunner,
		/datum/outfit/quick/tgmc/guardsman/medium_machinegunner,
		/datum/outfit/quick/tgmc/guardsman/standard_lasermg,
		/datum/outfit/quick/tgmc/guardsman/pyro,
		/datum/outfit/quick/tgmc/guardsman/standard_shotgun,
		/datum/outfit/quick/tgmc/guardsman/standard_lasercarbine,
		/datum/outfit/quick/tgmc/guardsman/light_carbine,
		/datum/outfit/quick/tgmc/guardsman/shield_tank,
		/datum/outfit/quick/tgmc/guardsman/machete,
		/datum/outfit/quick/tgmc/guardsman/scout,
		/datum/outfit/quick/tgmc/engineer/rrengineer,
		/datum/outfit/quick/tgmc/engineer/sentry,
		/datum/outfit/quick/tgmc/engineer/demolition,
		/datum/outfit/quick/tgmc/corpsman/standard_medic,
		/datum/outfit/quick/tgmc/corpsman/standard_smg,
		/datum/outfit/quick/tgmc/corpsman/standard_skirmishrifle,
		/datum/outfit/quick/tgmc/corpsman/auto_shotgun,
		/datum/outfit/quick/tgmc/corpsman/laser_medic,
		/datum/outfit/quick/tgmc/corpsman/laser_carbine,
		/datum/outfit/quick/tgmc/smartgunner/standard_sg,
		/datum/outfit/quick/tgmc/smartgunner/minigun_sg,
		/datum/outfit/quick/tgmc/smartgunner/target_rifle,
		/datum/outfit/quick/tgmc/leader/standard_assaultrifle,
		/datum/outfit/quick/tgmc/leader/standard_carbine,
		/datum/outfit/quick/tgmc/leader/combat_rifle,
		/datum/outfit/quick/tgmc/leader/standard_battlerifle,
		/datum/outfit/quick/tgmc/leader/auto_shotgun,
		/datum/outfit/quick/tgmc/leader/standard_laserrifle,
		/datum/outfit/quick/tgmc/leader/oicw,
		/datum/outfit/quick/chaos/guardsman/standard_assaultrifle,
		/datum/outfit/quick/chaos/guardsman/mpi,
		/datum/outfit/quick/chaos/guardsman/light_carbine,
		/datum/outfit/quick/chaos/guardsman/scout,
		/datum/outfit/quick/chaos/guardsman/shotgunner,
		/datum/outfit/quick/chaos/guardsman/pyro,
		/datum/outfit/quick/chaos/guardsman/breacher,
		/datum/outfit/quick/chaos/guardsman/breacher_melee,
		/datum/outfit/quick/chaos/guardsman/machine_gunner,
		/datum/outfit/quick/chaos/guardsman/charger,
		/datum/outfit/quick/chaos/engineer/standard_assaultrifle,
		/datum/outfit/quick/chaos/engineer/mpi,
		/datum/outfit/quick/chaos/engineer/standard_carbine,
		/datum/outfit/quick/chaos/engineer/standard_smg,
		/datum/outfit/quick/chaos/engineer/standard_shotgun,
		/datum/outfit/quick/chaos/medic/standard_assaultrifle,
		/datum/outfit/quick/chaos/medic/mpi,
		/datum/outfit/quick/chaos/medic/standard_carbine,
		/datum/outfit/quick/chaos/medic/standard_smg,
		/datum/outfit/quick/chaos/medic/standard_shotgun,
		/datum/outfit/quick/chaos/veteran/standard_assaultrifle,
		/datum/outfit/quick/chaos/veteran/standard_smg,
		/datum/outfit/quick/chaos/veteran/mpi,
		/datum/outfit/quick/chaos/veteran/carbine,
		/datum/outfit/quick/chaos/veteran/charger,
		/datum/outfit/quick/chaos/veteran/breacher,
		/datum/outfit/quick/chaos/veteran/caliver,
		/datum/outfit/quick/chaos/veteran/caliver_pack,
		/datum/outfit/quick/chaos/veteran/culverin,
		/datum/outfit/quick/chaos/veteran/rocket_man,
		/datum/outfit/quick/chaos/veteran/blinker,
		/datum/outfit/quick/chaos/squad_leader/standard_assaultrifle,
		/datum/outfit/quick/chaos/squad_leader/standard_smg,
		/datum/outfit/quick/chaos/squad_leader/charger,
		/datum/outfit/quick/chaos/squad_leader/caliver,
		/datum/outfit/quick/chaos/squad_leader/mpi,
	)

	for(var/X in loadout_list)
		.[X] = new X

/obj/machinery/quick_vendor
	name = "Kwik-E-Quip vendor"
	desc = "An advanced vendor to instantly arm soldiers with specific sets of equipment, allowing for immediate combat deployment. \
	Mutually exclusive with the GHMME."
	icon = 'modular_imperium/master_files/icons/obj/machines/vending.dmi'
	icon_state = "specialist"
	density = TRUE
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	req_access = null
	req_one_access = null
	interaction_flags = INTERACT_MACHINE_TGUI
	light_range = 1
	light_power = 0.5
	light_color = LIGHT_COLOR_BLUE
	///The faction of this quick load vendor
	var/faction = FACTION_NEUTRAL
	//the different tabs in the vendor
	var/list/categories = list(
		"Squad Guardsman",
		"Squad Engineer",
		"Squad Corpsman",
		"Squad Smartgunner",
		"Squad Leader",
	)
	///Whichever global loadout is used to build the vendor stock
	var/list/global_list_to_use
	///If the vendor drops your items, or deletes them when you vend a loadout
	var/drop_worn_items = FALSE

/obj/machinery/quick_vendor/Initialize(mapload)
	. = ..()
	set_stock_list()

///Chooses which global list the vendor will build stock from, gets run on Initialize()
/obj/machinery/quick_vendor/proc/set_stock_list()
	global_list_to_use = GLOB.quick_loadouts

/obj/machinery/quick_vendor/Initialize(mapload)
	. = ..()
	update_icon()

/obj/machinery/quick_vendor/update_icon()
	. = ..()
	if(is_operational())
		set_light(initial(light_range))
	else
		set_light(0)

/obj/machinery/quick_vendor/update_icon_state()
	. = ..()
	if(is_operational())
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]-off"

/obj/machinery/quick_vendor/update_overlays()
	. = ..()
	if(!is_operational())
		return
	. += emissive_appearance(icon, "[icon_state]_emissive")

/obj/machinery/quick_vendor/can_interact(mob/user)
	. = ..()
	if(!.)
		return FALSE

	if(!ishuman(user))
		return FALSE

	var/mob/living/carbon/human/human_user = user
	if(!allowed(human_user))
		return FALSE

	if(!isidcard(human_user.get_idcard())) //not wearing an ID
		return FALSE

	var/obj/item/card/id/user_id = human_user.get_idcard()
	if(user_id.registered_name != human_user.real_name)
		return FALSE

	return TRUE

/obj/machinery/quick_vendor/ui_interact(mob/living/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(ui)
		return
	ui = new(user, src, "Quickload")
	ui.open()

/obj/machinery/quick_vendor/ui_state(mob/user)
	return GLOB.human_adjacent_state

/obj/machinery/quick_vendor/ui_data(mob/living/user)
	. = ..()
	var/list/data = list()
	var/list/loadouts_data_tgui = list()
	var/list/loadouts_list = isrobot(user) ? GLOB.robot_loadouts : global_list_to_use
	for(var/loadout_data in loadouts_list)
		var/list/next_loadout_data = list() //makes a list item with the below lines, for each loadout entry in the list
		var/datum/outfit/quick/current_loadout = loadouts_list[loadout_data]
		next_loadout_data["job"] = current_loadout.jobtype
		next_loadout_data["name"] = current_loadout.name
		next_loadout_data["desc"] = current_loadout.desc
		next_loadout_data["amount"] = current_loadout.quantity
		next_loadout_data["outfit"] = current_loadout.type
		loadouts_data_tgui += list(next_loadout_data)
	data["loadout_list"] = loadouts_data_tgui
	var/ui_theme
	switch(faction)
		if(FACTION_CHAOS)
			ui_theme = "chaos"
		else
			ui_theme = "ntos"
	data["ui_theme"] = ui_theme
	data["vendor_categories"] = categories
	return data

/obj/machinery/quick_vendor/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("selectLoadout")
			var/datum/outfit/quick/selected_loadout = isrobot(ui.user) ? GLOB.robot_loadouts[text2path(params["loadout_outfit"])] : global_list_to_use[text2path(params["loadout_outfit"])]
			if(!selected_loadout)
				to_chat(ui.user, span_warning("Error when loading this loadout"))
				CRASH("Fail to load loadouts")
			if(selected_loadout.quantity == 0)
				to_chat(usr, span_warning("This loadout has been depleted, you'll need to pick another."))
				return
			var/obj/item/card/id/user_id = usr.get_idcard() //ui.user better?
			var/user_job = user_id.rank
			user_job = replacetext(user_job, "Fallen ", "") //So that jobs in valhalla can vend a loadout too
			if(selected_loadout.jobtype != user_job && selected_loadout.require_job != FALSE)
				to_chat(usr, span_warning("You are not in the right job for this loadout!"))
				return
			if(user_id.id_flags & USED_GHMME) //Same check here, in case they opened the UI before vending a loadout somehow
				to_chat(ui.user, span_warning("Access denied, continue using the GHHME."))
				return FALSE
			if(user_id.id_flags & CAN_BUY_LOADOUT)
				for(var/points in user_id.guardsman_points)
					if(user_id.guardsman_points[points] != GLOB.default_guardsman_points[points])
						to_chat(ui.user, span_warning("Access denied, continue using the GHHME."))
						return FALSE
				for(var/option in user_id.guardsman_buy_choices)
					if(user_id.guardsman_buy_choices[option] != GLOB.guardsman_selector_cats[option])
						to_chat(ui.user, span_warning("Access denied, continue using the GHHME."))
						return FALSE
				user_id.id_flags &= ~CAN_BUY_LOADOUT
				selected_loadout.quantity --
				if(drop_worn_items)
					for(var/obj/item/inventory_items in ui.user)
						if(inventory_items.equip_slot_flags == ITEM_SLOT_ID)
							continue
						ui.user.dropItemToGround(inventory_items)
				selected_loadout.equip(ui.user) //actually equips the loadout
				//After vending a quick loadout, remove points and GHMME options so that you can't vend them via loadout vendor
				for(var/points in user_id.guardsman_points)
					user_id.guardsman_points[points] = 0
				for(var/option in user_id.guardsman_buy_choices)
					user_id.guardsman_buy_choices[option] = 0
			else
				to_chat(usr, span_warning("You can't buy things from this category anymore."))

/obj/machinery/quick_vendor/chaos
	faction = FACTION_CHAOS
	categories = list(
		"CHAOS Squad Standard",
		"CHAOS Squad Engineer",
		"CHAOS Squad Medic",
		"CHAOS Squad Veteran",
		"CHAOS Squad Leader",
	)
