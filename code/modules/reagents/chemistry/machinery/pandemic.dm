//this machine does nothing
/obj/machinery/disease2/diseaseanalyser
	name = "Disease Analyser"
	icon = 'modular_imperium/master_files/icons/obj/machines/virology.dmi'
	icon_state = "analyser"
	anchored = TRUE
	density = TRUE


/obj/machinery/computer/pandemic
	name = "PanD.E.M.I.C 2200"
	density = TRUE
	anchored = TRUE
	icon = 'modular_imperium/master_files/icons/obj/machines/chemical_machines.dmi'
	icon_state = "mixer0"
	layer = BELOW_OBJ_LAYER
	circuit = /obj/item/circuitboard/computer/pandemic
