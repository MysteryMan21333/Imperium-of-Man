// ***************************************
// *********** Bull charge types
// ***************************************

/datum/action/ability/activable/tyranid/bull_charge
	name = "Plow Charge"
	action_icon_state = "bull_charge"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/bull.dmi'
	desc = "When you hit a host, knock them out of your way while continuing your charge undeterred. The force of your charge also disarms them."
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_BULLCHARGE,
	)
	var/new_charge_type = CHARGE_BULL


/datum/action/ability/activable/tyranid/bull_charge/on_selection()
	SEND_SIGNAL(owner, COMSIG_TYRANIDACTION_TOGGLECHARGETYPE, new_charge_type)


/datum/action/ability/activable/tyranid/bull_charge/headbutt
	name = "Headbutt Charge"
	action_icon_state = "bull_headbutt"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/bull.dmi'
	desc = "When you hit a host, stops your charge while headbutting them, flinging them in the air and stunning them for some time."
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_BULLHEADBUTT,
	)
	new_charge_type = CHARGE_BULL_HEADBUTT

/datum/action/ability/activable/tyranid/bull_charge/gore
	name = "Gore Charge"
	action_icon_state = "bull_gore"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/bull.dmi'
	desc = "When you hit a host, stops your charge while piercing and injecting them with Ozelomelyn."
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_BULLGORE,
	)
	new_charge_type = CHARGE_BULL_GORE
