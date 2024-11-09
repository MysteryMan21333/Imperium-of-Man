//Beginner Vendor

GLOBAL_LIST_INIT(beginner_loadouts, init_beginner_loadouts())

/proc/init_beginner_loadouts() //List of all loadouts in quick_load_beginners.dm
	. = list()
	var/list/loadout_list = list(
		/datum/outfit/quick/beginner/guardsman/rifleman,
		/datum/outfit/quick/beginner/guardsman/machinegunner,
		/datum/outfit/quick/beginner/guardsman/marksman,
		/datum/outfit/quick/beginner/guardsman/shotgunner,
		/datum/outfit/quick/beginner/guardsman/shocktrooper,
		/datum/outfit/quick/beginner/guardsman/hazmat,
		/datum/outfit/quick/beginner/guardsman/cqc,
		/datum/outfit/quick/beginner/guardsman/chad,
		/datum/outfit/quick/beginner/engineer/builder,
		/datum/outfit/quick/beginner/engineer/burnitall,
		/datum/outfit/quick/beginner/engineer/pcenjoyer,
		/datum/outfit/quick/beginner/corpsman/lifesaver,
		/datum/outfit/quick/beginner/corpsman/hypobelt,
		/datum/outfit/quick/beginner/smartgunner/sg29,
		/datum/outfit/quick/beginner/smartgunner/sg85,
	)

	for(var/loadout in loadout_list)
		.[loadout] = new loadout

GLOBAL_LIST_INIT(robot_loadouts, init_robot_loadouts())

/proc/init_robot_loadouts()
	. = list()
	var/list/loadout_list = list(
		//Guardsman
		/datum/outfit/quick/beginner_robot/guardsman/rifleman,
		/datum/outfit/quick/beginner_robot/guardsman/machinegunner,
		/datum/outfit/quick/beginner_robot/guardsman/marksman,
		/datum/outfit/quick/beginner_robot/guardsman/shotgunner,
		/datum/outfit/quick/beginner_robot/guardsman/shocktrooper,
		//Engineer
		/datum/outfit/quick/beginner_robot/engineer/builder,
		/datum/outfit/quick/beginner_robot/engineer/burnitall,
		/datum/outfit/quick/beginner_robot/engineer/pcenjoyer,
		//Corpsman
		/datum/outfit/quick/beginner_robot/corpsman/lifesaver,
		/datum/outfit/quick/beginner_robot/corpsman/hypobelt,
		//Smartgunner
		/datum/outfit/quick/beginner_robot/smartgunner/sg29,
		/datum/outfit/quick/beginner_robot/smartgunner/sg85,
	)

	for(var/loadout in loadout_list)
		.[loadout] = new loadout

/obj/machinery/quick_vendor/beginner //Loadout vendor that shits out basic pre-made loadouts so new players can get something usable
	icon_state = "loadoutvendor"
	categories = list(
		"Squad Guardsman",
		"Squad Engineer",
		"Squad Corpsman",
		"Squad Smartgunner",
	)
	drop_worn_items = TRUE

/obj/machinery/quick_vendor/beginner/set_stock_list()
	global_list_to_use = GLOB.beginner_loadouts
