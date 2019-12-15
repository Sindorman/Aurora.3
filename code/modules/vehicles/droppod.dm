#define READY 0
#define USED 1
#define LAUNCHING 2

/obj/vehicle/droppod
	name = "drop pod"
	desc = "A big metal pod, what could be inside?"
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "droppod"
	dir = SOUTH
	layer = MOB_LAYER - 0.1

	load_item_visible = 0
	health = 500 // pretty strong because it can't move or be shot out of
	maxhealth = 500

	fire_dam_coeff = 0.6
	brute_dam_coeff = 0.5
	var/list/validfirelocations = list(1, 7, 9) // above the station, at the centcomm z-level and at derelicts.

	var/status = READY

	var/mob/humanload
	var/mob/passenger

	var/connected_blastdoor //Connect a blast door's _wifi_id here to have it close when the droppod is launched.

/obj/vehicle/droppod/legion
	name = "legion drop pod"
	desc = "A big metal pod painted in the colors of the Tau Ceti Foreign Legion."
	icon_state = "legion_pod"

/obj/vehicle/droppod/legion
	name = "legion drop pod"
	desc = "A big metal pod. Painted in the colors of the Tau Ceti Foreign Legion."
	icon_state = "legion_pod"

/obj/vehicle/droppod/Initialize()
	. = ..()

/obj/vehicle/droppod/emag_act()
	return

/obj/vehicle/droppod/Move()
	return

/obj/vehicle/droppod/attackby(obj/item/I as obj, mob/user as mob)
	if(I.iswelder() && status == USED && !humanload && !passenger)
		var/obj/item/weldingtool/W = I
		if(W.welding)
			src.visible_message(span("notice","[user] starts cutting \the [src] apart."))
			if(do_after(user, 200))
				src.visible_message(span("danger","\The [src] is cut apart by [user]!"))
				playsound(src, 'sound/items/Welder.ogg', 100, 1)
				new /obj/item/stack/material/titanium(src.loc, 10)
				new /obj/item/stack/material/plasteel(src.loc, 10)
				var/obj/item/stack/cable_coil/C = new /obj/item/stack/cable_coil(src.loc)
				C.amount = rand(5,15)
				qdel(src)
	else
		return ..()

/obj/vehicle/droppod/verb/launchinterface()
	set src in oview(1)
	set category = "Vehicle"
	set name = "Open launch interface"

	if(status == READY)
		ui_interact(usr)

/obj/vehicle/droppod/verb/eject()
	set src in oview(1)
	set category = "Vehicle"
	set name = "Eject Pod"

	if(!usr.canmove || usr.stat || usr.restrained())
		return
	unload(usr)

/obj/vehicle/droppod/verb/eject()
	set src in oview(1)
	set category = "Vehicle"
	set name = "Open Pod"

	if(!usr.canmove || usr.stat || usr.restrained())
		return
	unload(usr)

/obj/vehicle/droppod/load(var/mob/C) // this won't call the parent proc due to the differences and the fact it doesn't use load. Also only mobs can be loaded.
	if(!ismob(C))
		return 0
	if(!isturf(C.loc))
		return 0
	if((humanload && passenger) || C.anchored)
		return 0
	if(humanload)
		passenger = C
	else
		humanload = C

	C.forceMove(src)

	C.set_dir(dir)
	C.anchored = 1
	user_buckle_mob(C, C)
	icon_state = initial(icon_state)
	return 1

/obj/vehicle/droppod/unload(var/mob/user, var/direction) // this also won't call the parent proc because it relies on load and doesn't expect a 2nd person
	if(!(humanload || passenger))
		return 0

	var/turf/dest = null

	if(direction)
		dest = get_step(src, direction)
	else if(user)
		dest = get_turf(src)
	if(!dest)
		dest = get_step_to(src, get_step(src, turn(dir, 90)))

	if(!dest || dest == get_turf(src))
		var/list/options = new()
		for(var/test_dir in alldirs)
			var/new_dir = get_step_to(src, get_step(src, test_dir))
			if(new_dir && user.Adjacent(new_dir))
				options += new_dir
		if(options.len)
			dest = pick(options)
		else
			dest = get_turf(src)

	if(!isturf(dest))
		return 0
	for(var/a in contents)
		if(isliving(a))
			var/mob/living/L = a
			L.forceMove(dest)
			L.set_dir(get_dir(loc, dest))
			L.anchored = 0
			L.pixel_x = initial(user.pixel_x)
			L.pixel_y = initial(user.pixel_y)
			L.layer = initial(user.layer)
			user_unbuckle_mob(L, L)
		else if(istype(a, /obj))
			var/obj/O = a
			O.forceMove(src.loc)

	humanload = null
	passenger = null
	icon_state = "[initial(icon_state)]_open"
	return 1

/obj/vehicle/droppod/MouseDrop_T(over_object, src_location, over_location)
	return

/obj/vehicle/droppod/attack_hand(mob/user as mob)
	..()
	if(user == humanload || user == passenger)
		if(status != USED)
			launchinterface()
		else
			unload(user)
	else if ((!humanload || !passenger) && status != USED)
		load(user)

/obj/vehicle/droppod/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = default_state)
	var/data[0]
	data["status"] = status

	ui = SSnanoui.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "droppod.tmpl", "Drop Pod", 400, 400, state = state)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/vehicle/droppod/Topic(href, href_list)
	if(..())
		return 1

	if(href_list["fire"])
		var/area/A = null
		var/target = href_list["fire"]
		switch(target)
			if("arrivals")
				var/arrivals_destination_list = list(
					/area/hallway/secondary/entry/fore = 2,
					/area/hallway/secondary/entry/port = 2,
					/area/security/vacantoffice = 1,
					/area/hallway/secondary/entry/departure_lounge = 1
					)
				A = pickweight(arrivals_destination_list)
			if("cargo")
				var/cargo_destination_list = list(
					/area/quartermaster/loading = 4,
					/area/quartermaster/qm = 1,
					/area/janitor/surface = 1,
					/area/storage/tools = 1,
					/area/sconference_room = 1
					)
				A = pickweight(cargo_destination_list)
			if("tcoms")
				var/tcoms_destination_list = list(
					/area/tcommsat/lounge = 1
					)
				A = pickweight(tcoms_destination_list)
			if("commandescape")
				var/commandescape_destination_list = list(
					/area/bridge/levela = 2,
					/area/bridge/levela/research_dock = 2,
					/area/security/bridge_surface_checkpoint = 1,
					/area/maintenance/bridge_elevator/surface = 1
					)
				A = pickweight(commandescape_destination_list)
		if(A)
			status = LAUNCHING
			var/mob/user = usr
			var/datum/nanoui/ui = SSnanoui.get_open_ui(user, src, "main")
			if(ui)
				ui.close()
			if(connected_blastdoor)
				blastdoor_interact()
			fire_at_area(A)

/obj/vehicle/droppod/proc/fire_at_area(var/area/A)

	var/list/area_turfs = get_area_turfs(A, null, 0, FALSE)
	var/list/turf_selection = list()

	for(var/turf/T in area_turfs)
		var/obstacle_found = FALSE
		if(!iswall(T))
			for(var/obj/O in T)
				if(istype(O, /obj/structure/grille) || istype(O, /obj/machinery/door/airlock/external)) //This is to help prevent the pod from landing right on an exterior window or airlock.
					obstacle_found = TRUE
					break
			if(!obstacle_found)
				turf_selection += T
			else
				obstacle_found = FALSE

	var/target_turf = pick(turf_selection)
	if(!target_turf)
		playsound(src, 'sound/machines/buzz-sigh.ogg', 30, 1)
		visible_message(span("warning","\The [src]'s screen displays an error: Targeting module malfunction. Attempt relaunch."))
		status = READY
		if(connected_blastdoor)
			blastdoor_interact(TRUE)
		return
	fire(target_turf)

/obj/vehicle/droppod/proc/fire(var/turf/A)
	if(!isturf(A))
		playsound(src, 'sound/machines/buzz-sigh.ogg', 30, 1)
		visible_message(span("warning","\The [src]'s screen displays an error: Targeting module malfunction. Attempt relaunch."))
		status = READY
		if(connected_blastdoor)
			blastdoor_interact(TRUE)
		return

	if(!(src.z in validfirelocations))
		playsound(src, 'sound/machines/buzz-sigh.ogg', 30, 1)
		visible_message(span("warning","\The [src]'s screen displays an error: Pod cannot be launched from this position."))
		status = READY
		if(connected_blastdoor)
			blastdoor_interact(TRUE)
		return

	var/turf/aboveturf = GetAbove(A)
	if(aboveturf)
		applyfalldamage(aboveturf)
		aboveturf.ChangeTurf(/turf/simulated/floor/foamedmetal)
		for(var/turf/T in range(1, aboveturf))
			if(turf_clear(T))
				new /obj/structure/foamedmetal(T, src)
	applyfalldamage(A)
	explosion(A, 0, 0, 2, 2)
	var/datum/effect/effect/system/smoke_spread/S = new /datum/effect/effect/system/smoke_spread()
	S.set_up(5, 0, A)
	S.start()
	if(humanload)
		var/mob/M = humanload
		shake_camera(M, 5, 1)
	forceMove(A)
	A.visible_message(span("danger","\The [src] crashes through the roof!"))

	var/turf/belowturf = GetBelow(A)
	if(belowturf)
		belowturf.visible_message(span("danger","You hear something crash into the ceiling above!"))

	status = USED

/obj/vehicle/droppod/proc/applyfalldamage(var/turf/A)
	for(var/mob/T in A)
		if(T.simulated)
			T.gib()
			T.visible_message(span("danger","[T] is squished by the drop pod!"))
	for(var/obj/B in A)
		if(B.simulated && B.density)
			qdel(B)
			B.visible_message(span("danger","[B] is destroyed by the drop pod!"))

/obj/vehicle/droppod/proc/blastdoor_interact(var/open)
	var/datum/wifi/sender/door/wifi_sender_blast = new(connected_blastdoor, src)
	if(open)
		wifi_sender_blast.activate("open")
	else
		wifi_sender_blast.activate("close")
		var/turf/T = src.loc
		T.ChangeTurf(/turf/space)

#undef READY
#undef USED
#undef LAUNCHING

