/datum/element/accelerate_on_crossed/Attach(datum/target)
	. = ..()
	var/static/list/connections = list(
		COMSIG_ATOM_ENTERED = TYPE_PROC_REF(/atom, accelerate_crosser),
	)
	target.AddElement(/datum/element/connect_loc, connections)

///Speeds up tyranid on crossed
/atom/proc/accelerate_crosser(datum/source, atom/movable/crosser)
	SIGNAL_HANDLER
	if(istyranid(crosser))
		var/mob/living/carbon/tyranid/X = crosser
		X.next_move_slowdown += X?.tyranid_caste?.weeds_speed_mod
