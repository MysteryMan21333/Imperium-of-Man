// Toggle Bumpattacks
/datum/action/bump_attack_toggle
	name = "Toggle Bump Attacks"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/general.dmi'
	action_type = ACTION_TOGGLE
	/// If we are toggled to attack whoever we bump onto, set by the bumping attack component when its toggled
	var/attacking = FALSE

/datum/action/bump_attack_toggle/update_button_icon()
	action_icon_state = attacking ? "bumpattack_off" : "bumpattack_on"
	return ..()

