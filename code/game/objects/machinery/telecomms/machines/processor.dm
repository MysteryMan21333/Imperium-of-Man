/*
	The processor is a very simple machine that decompresses subspace signals and
	transfers them back to the original bus. It is essential in producing audible
	data.

	Link to servers if bus is not present
*/
/obj/machinery/telecomms/processor
	name = "processor unit"
	icon_state = "processor"
	desc = "This machine is used to process large quantities of information."
	telecomms_type = /obj/machinery/telecomms/processor
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 30
	circuit = /obj/item/circuitboard/machine/telecomms/processor
	var/process_mode = 1 // 1 = Uncompress Signals, 0 = Compress Signals


/obj/machinery/telecomms/processor/receive_information(datum/signal/subspace/signal, obj/machinery/telecomms/machine_from)
	if(!is_freq_listening(signal))
		return

	if(!process_mode)
		signal.data["compression"] = 100 // even more compressed signal

	if(istype(machine_from, /obj/machinery/telecomms/bus))
		relay_direct_information(signal, machine_from) // send the signal back to the machine
	else // no bus detected - send the signal to servers instead
		signal.data["slow"] += rand(5, 10) // slow the signal down
		relay_information(signal, signal.server_type)


//Preset Processors
/obj/machinery/telecomms/processor/preset_one
	id = "Processor 1"
	network = "tcommsat"
	autolinkers = list("processor1") // processors are sort of isolated; they don't need backward links


/obj/machinery/telecomms/processor/preset_two
	id = "Processor 2"
	network = "tcommsat"
	autolinkers = list("processor2")


/obj/machinery/telecomms/processor/preset_three
	id = "Processor 3"
	network = "tcommsat"
	autolinkers = list("processor3")


/obj/machinery/telecomms/processor/preset_four
	id = "Processor 4"
	network = "tcommsat"
	autolinkers = list("processor4")

//proper backup server for CIC
/obj/machinery/telecomms/processor/preset_four/cicbackup
	on = 0
	id = "Backup Processor 4"
	network = "tcommsat"
	autolinkers = list("processor4")

/obj/machinery/telecomms/processor/preset_one/chaos
	id = "Processor 1 chaos"
	autolinkers = list("processor1_som")


/obj/machinery/telecomms/processor/preset_two/chaos
	id = "Processor 2 chaos"
	autolinkers = list("processor2_som")


/obj/machinery/telecomms/processor/preset_three/chaos
	id = "Processor 3 chaos"
	autolinkers = list("processor3_som")


/obj/machinery/telecomms/processor/preset_four/chaos
	id = "Processor 4 chaos"
	autolinkers = list("processor4_som")
