/*
	The receiver idles and receives messages from subspace-compatible radio equipment;
	primarily headsets. They then just relay this information to all linked devices,
	which can would probably be network hubs.

	Link to Processor Units in case receiver can't send to bus units.
*/
/obj/machinery/telecomms/receiver
	name = "subspace receiver"
	icon_state = "broadcast receiver"
	desc = "This machine has a dish-like shape and green lights. It is designed to detect and process subspace radio activity."
	telecomms_type = /obj/machinery/telecomms/receiver
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 30
	circuit = /obj/item/circuitboard/machine/telecomms/receiver


/obj/machinery/telecomms/receiver/receive_signal(datum/signal/subspace/signal)
	if(!on || !istype(signal) || !check_receive_level(signal) || signal.transmission_method != TRANSMISSION_SUBSPACE)
		return

	if(!is_freq_listening(signal))
		return

	signal.levels = list()

	// send the signal to the hub if possible, or a bus otherwise
	if(!relay_information(signal, /obj/machinery/telecomms/hub))
		relay_information(signal, /obj/machinery/telecomms/bus)


/obj/machinery/telecomms/receiver/proc/check_receive_level(datum/signal/subspace/signal)
	if(z in signal.levels)
		return TRUE

	for(var/obj/machinery/telecomms/hub/H in links)
		for(var/obj/machinery/telecomms/relay/R in H.links)
			if(R.can_receive(signal) && (R.z in signal.levels))
				return TRUE

	return FALSE


//Preset Receivers
//--PRESET LEFT--//
/obj/machinery/telecomms/receiver/preset_left
	id = "Receiver A"
	network = "tcommsat"
	autolinkers = list("receiverA") // link to relay
	freq_listening = list(FREQ_MEDICAL, FREQ_REQUISITIONS, FREQ_ALPHA, FREQ_BRAVO, FREQ_CHARLIE, FREQ_DELTA, FREQ_COMMAND, FREQ_ENGINEERING, FREQ_CAS, FREQ_PMC, FREQ_COLONIST, FREQ_USL, FREQ_DEATHSQUAD, FREQ_IMPERIAL, FREQ_CHAOS, FREQ_SECTOID, FREQ_ECHO)

/obj/machinery/telecomms/receiver/preset_left/chaos
	id = "Receiver A chaos"
	autolinkers = list("receiverA_som") // link to relay
	freq_listening = list(FREQ_MEDICAL_CHAOS, FREQ_ZULU, FREQ_YANKEE, FREQ_XRAY, FREQ_WHISKEY, FREQ_COMMAND_CHAOS, FREQ_ENGINEERING_CHAOS) //ert channels shouldn't be needed. Probably.


//--PRESET RIGHT--//
/obj/machinery/telecomms/receiver/preset_right
	id = "Receiver B"
	network = "tcommsat"
	autolinkers = list("receiverB") // link to relay
	freq_listening = list(FREQ_COMMON)

//proper cicbackup reciver
/obj/machinery/telecomms/receiver/preset_right/cicbackup
	on = 0
	id = "Backup Receiver B"
	network = "tcommsat"
	autolinkers = list("receiverB") // link to relay
	freq_listening = list(FREQ_COMMON)

/obj/machinery/telecomms/receiver/preset_right/chaos
	id = "Receiver B chaos"
	autolinkers = list("receiverB_som") // link to relay
	freq_listening = list(FREQ_CHAOS)


//Common and other radio frequencies for people to freely use
/obj/machinery/telecomms/receiver/preset_right/Initialize(mapload)
	. = ..()
	for(var/i = MIN_FREQ, i <= MAX_FREQ, i += 2)
		freq_listening |= i
