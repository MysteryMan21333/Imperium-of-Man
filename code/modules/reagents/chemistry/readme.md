# Reagents

NOTE: IF YOU UPDATE THE REAGENT-SYSTEM, ALSO UPDATE THIS README.

## Structure:
```
		///////////////////          //////////////////////////
		// Mob or object // -------> // Reagents var (datum)
									 // Is a reference to the datum that holds the reagents.
		///////////////////          //////////////////////////
				|				    			 |
	The object that holds everything.   			 V
										reagent_list var (list)   	A List of datums, each datum is a reagent.

										|        |         |
										V          V          V

											reagents (datums)	    	Reagents. I.e. Water , dylovene or mercury.
```
## Random important notes:

	An objects on_reagent_change will be called every time the objects reagents change.
	Useful if you want to update the objects icon etc.

## About the Holder:

	The holder (reagents datum) is the datum that holds a list of all reagents
	currently in the object.It also has all the procs needed to manipulate reagents

		remove_any(amount)
			This proc removes reagents from the holder until the passed amount
			is matched. It'll try to remove some of ALL reagents contained.

		trans_to(obj/target, amount)
			This proc equally transfers the contents of the holder to another
			objects holder. You need to pass it the object (not the holder) you want
			to transfer to and the amount you want to transfer. Its return value is the
			actual amount transfered (if one of the objects is full/empty)

		trans_id_to(obj/target, reagent, amount)
			Same as above but only for a specific reagent in the reagent list.
			If the specified amount is greater than what is available, it will use
			the amount of the reagent that is available. If no reagent exists, returns null.

		metabolize(mob/M)
			This proc is called by the mobs life proc. It simply calls on_mob_life for
			all contained reagents. You shouldnt have to use this one directly.

		handle_reactions()
			This proc check all recipes and, on a match, uses them.
			It will also call the recipe's on_reaction proc (for explosions or w/e).
			Currently, this proc is automatically called by trans_to.
			- Modified from the original to preserve reagent data across reactions (originally for tyranidarchaeology)

		isolate_reagent(reagent)
			Pass it a reagent id and it will remove all reagents but that one.
			It's that simple.

		del_reagent(reagent)
			Completely remove the reagent with the matching id.

		reaction_fire(exposed_temp)
			Simply calls the reaction_fire procs of all contained reagents.

		update_total()
			This one simply updates the total volume of the holder.
			(the volume of all reagents added together)

		clear_reagents()
			This proc removes ALL reagents from the holder.

		reaction(atom/A, method = TOUCH, volume_modifier = 0)
			This proc calls the appropriate reaction procs of the reagents.
			I.e. if A is an object, it will call the reagents reaction_obj
			proc. The method var is used for reaction on mobs. It simply tells
			us if the mob TOUCHed, INGESTed, or was VAPORed/PATCHed by, the reagent.
			Since the volume can be checked in a reagents proc, you might want to
			use the volume_modifier var to modifiy the passed value without actually
			changing the volume of the reagents.
			If you're not sure if you need to use this the answer is very most likely 'No'.
			You'll want to use this proc whenever an atom first comes in
			contact with the reagents of a holder. (in the 'splash' part of a beaker i.e.)
			More on the reaction in the reagent part of this readme.

		add_reagent(reagent, amount, data)
			Attempts to add X of the matching reagent to the holder.
			You wont use this much. Mostly in new procs for pre-filled
			objects.

		remove_reagent(reagent, amount)
			The exact opposite of the add_reagent proc.
			- Modified from original to return the reagent's data, in order to preserve reagent data across reactions (originally for tyranidarchaeology)

		has_reagent(reagent, amount)
			Returns TRUE if the holder contains this reagent.
			Or FALSE if not.
			If you pass it an amount it will additionally check
			if the amount is matched. This is optional.

		get_reagent_amount(reagent)
			Returns the amount of the matching reagent inside the
			holder. Returns FALSE if the reagent is missing.

		Important variables:

			total_volume
				This variable contains the total volume of all reagents in this holder.

			reagent_flags
				a bitfield used to specify the properties of the holder, such as if it's OPENCONTAINER or TRASPARENT (the volume can be examined).
				for the bitflags and their infos, check __DEFINES/reagents.dm.

			reagent_list
				This is a list of all contained reagents. More specifically, references
				to the reagent datums.

			maximum_volume
				This is the maximum volume of the holder.

			my_atom
				This is the weakref to the atom the holder is 'in'. Useful if you need to find the location.
				(i.e. for explosions)


## About Reagents:

	Reagents are all the things you can mix and fille in bottles etc. This can be anything from
	rejuvs over water to ... iron. Each reagent also has a few procs - i'll explain those below.

		reaction_mob(mob/M, method = TOUCH)
			This is called by the holder's reation proc.
			This version is only called when the reagent
			reacts with a mob. The method arg should be either
			TOUCH, INGEST, VAPOR or PATCH. You'll want to put stuff like
			acid-facemelting in here.

		reaction_obj(obj/O)
			This is called by the holder's reation proc.
			This version is called when the reagents reacts
			with an object. You'll want to put stuff like
			object melting in here ... or something. i dunno.

		reaction_turf(turf/T)
			This is called by the holder's reaction proc.
			This version is called when the reagents reacts
			with a turf. You'll want to put stuff like extra
			slippery floors for lube or something in here.

		on_mob_life(mob/M)
			This proc is called everytime the mobs life proc executes.
			This is the place where you put damage for toxins ,
			drowsyness for sleep toxins etc etc.
			You'll want to call the parents proc at the end by using return ..() .
			If you don't, the chemical will stay in the mob forever -
			unless you write your own piece of code to slowly remove it.
			(Should be pretty easy, 1 line of code)

	Important variables:

		holder
			This variable contains a reference to the holder the chemical is 'in'

		volume
			This is the volume of the reagent.

		id
			The id of the reagent

		name
			The name of the reagent.

		data
			This var can be used for whatever the fuck you want. I used it for the sleep
			toxins to make them work slowly instead of instantly. You could also use this
			for DNA in a blood reagent or ... well whatever you want.

		color
			This is a hexadecimal color that represents the reagent outside of containers,
			you define it as "#RRGGBB", or, red green blue. You can also define it using the
			rgb() proc, which returns a hexadecimal value too. The color is black by default.

			A good website for color calculations: http://www.psyclops.com/tools/rgb/




## About Recipes:

	Recipes are simple datums that contain a list of required reagents and a result.
	They also have a proc that is called when the recipe is matched.

		on_reaction(datum/reagents/holder, created_volume)
			This proc is called when the recipe is matched.
			You'll want to add explosions etc here.
			To find the location you'll have to do something
			like get_turf(holder.my_atom)

		name & id
			Should be pretty obvious.

		result
			This var contains the id of the resulting reagent.

		required_reagents
			This is a list of ids of the required reagents.
			Each id also needs an associated value that gives us the minimum required amount
			of that reagent. The handle_reaction proc can detect mutiples of the same recipes
			so for most cases you want to set the required amount to 1.

		required_catalysts
			This is a list of the ids of the required catalysts.
			Functionally similar to required_reagents, it is a list of reagents that are required
			for the reaction. However, unlike required_reagents, catalysts are NOT consumed.
			They mearly have to be present in the container.

		result_amount
			This is the amount of the resulting reagent this recipe will produce.
			I recommend you set this to the total volume of all required reagent.

		required_temp
			The necessary temperature required for the reaction to occur, if is_cold_recipe is TRUE,
			it will check if the temperature is lower than the threshold, otherwise if greater.

		is_cold_recipe.
			See above.

		mix_message
			The visible message displayed upon reaction.

		mix_sound
			The sound heard upon reaction.

		required_container
			The container the recipe has to take place in in order to happen. Leave this blank/null
			if you want the reaction to happen anywhere.

		required_other
			Basically like a reagent's data variable. You can set extra requirements for a
			reaction with this.

		hidden_from_codex
			Wheter this reagent can be searched up through the codex or not.


## About the Tools:

	By default, all atom have a reagents var - but its null. if you want to use an object for the chem.
	system, that should be done by calling this convenience proc:

		atom/proc/create_reagents(max_volume, new_flags, list/initial_reagents, data)
			This will create a new reagents datum with the max_volume arg as maximum volume,
			new_flags used as its new reagent_flags bitflags.
			list/initial_reagents and data are both used to add the initial reagents to the holder through add_reagent_list().

	Other important stuff:

		amount_per_transfer_from_this var
			This var is mostly used by beakers and bottles.
			It simply tells us how much to transfer when
			'pouring' our reagents into something else.

		/atom/proc/is_open_container()
			checks if both is_refillable() and is_drainable() return TRUE.
			If TRUE, you can freely use syringes, beakers etc to manipulate its reagents,
			otherwise some functionalities may be unavailable.

		/atom/proc/is_refillable()
			checks if the reagents exist and their REFILLABLE reagents_flag is enabled
			If TRUE, it can be freely refilled through reagent dispensers, syringes, beakers etc.

		/atom/proc/is_drainable()
			checks if the reagents exist and their DRAINABLE bitflag is enabled.
			if TRUE, it can be freely drained to other beakers etc as long as the latters are refillable.

		/atom/proc/is_injectable(allowmobs = TRUE)
			checks if the reagents exist and their INJECTABLE or REFILLABLE bitflags are enabled.
			if the atom happens to be a living mob and allowmobs is FALSE, it will return FALSE
			otherwise it will check their can_inject() proc instead.
			if TRUE, it can be freely injected by syringes, hyposprays etc.

		/atom/proc/is_drawable(allowmobs = TRUE)
			checks if the reagents exist and their DRAWABLE or DRAINABLE bitflags are enabled.
			if the atom happens to be a living mob and allowmobs is FALSE, it will return FALSE
			otherwise it will check their can_inject() proc instead.
			if TRUE, its reagents can be freely drawed by syringes, hyposprays etc.

