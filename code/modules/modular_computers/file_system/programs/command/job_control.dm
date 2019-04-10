// Need to use for list of jobs

/datum/computer_file/program/job_control
	filename = "jobcontrol"
	filedesc = "Job slots modification program"
	nanomodule_path = /datum/nano_module/program/card_mod
	program_icon_state = "id"
	extended_desc = "Program for modifying job slots and assigning demand."
	required_access_run = access_change_ids
	required_access_download = access_change_ids
	usage_flags = PROGRAM_CONSOLE | PROGRAM_LAPTOP
	requires_ntnet = 1
	size = 8
	color = LIGHT_COLOR_BLUE

/datum/nano_module/program/job_control
	name = "Job slots modification program"
	var/mod_mode = 1
	var/is_centcom = 0
	var/show_assignments = 0

/datum/nano_module/program/job_control/ui_interact(mob/user, ui_key = "main", var/datum/vueui/ui = null, var/force_open = 1, var/datum/topic_state/state = default_state)
	var/list/data = host.initial_data()

	data["src"] = "\ref[src]"
	data["station_name"] = station_name()
	data["manifest"] = data_core.get_manifest()
	data["jobs"] = SSjobs.occupations
	if(program && program.computer)
		data["have_printer"] = !!program.computer.nano_printer
		data["authenticated"] = program.can_run(user)
	else
		data["have_printer"] = 0
		data["authenticated"] = 0
	data["mmode"] = mod_mode
	data["centcom_access"] = is_centcom

	ui = SSvueui.get_open_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "console-hop-identification_computer", 600, 700, name, data)
		ui.open()

/datum/nano_module/program/job_control/proc/format_jobs(list/jobs)
	var/obj/item/weapon/card/id/id_card = program.computer.card_slot.stored_card
	var/list/formatted = list()
	for(var/job in jobs)
		formatted.Add(list(list(
			"display_name" = replacetext(job, " ", "&nbsp"),
			"target_rank" = id_card && id_card.assignment ? id_card.assignment : "Unassigned",
			"job" = job)))

	return formatted

/datum/computer_file/program/job_control/Topic(href, href_list)
	if(..())
		return 1

	var/mob/user = usr
	var/obj/item/weapon/card/id/user_id_card = user.GetIdCard()
	var/obj/item/weapon/card/id/id_card = computer.card_slot.stored_card
	var/datum/nano_module/program/card_mod/module = NM
	switch(href_list["action"])
		if("switchm")
			if(href_list["target"] == "mod")
				module.mod_mode = 1
			else if (href_list["target"] == "manifest")
				module.mod_mode = 0
		if("togglea")
			if(module.show_assignments)
				module.show_assignments = 0
			else
				module.show_assignments = 1
		if("print")
			if(computer && computer.nano_printer) //This option should never be called if there is no printer
				if(module.mod_mode)
					if(can_run(user, 1))
						var/contents = {"<h4>Access Report</h4>
									<u>Prepared By:</u> [user_id_card.registered_name ? user_id_card.registered_name : "Unknown"]<br>
									<u>For:</u> [id_card.registered_name ? id_card.registered_name : "Unregistered"]<br>
									<hr>
									<u>Assignment:</u> [id_card.assignment]<br>
									<u>Account Number:</u> #[id_card.associated_account_number]<br>
									<u>Blood Type:</u> [id_card.blood_type]<br><br>
									<u>Access:</u><br>
								"}

						var/known_access_rights = get_access_ids(ACCESS_TYPE_STATION|ACCESS_TYPE_CENTCOM)
						for(var/A in id_card.access)
							if(A in known_access_rights)
								contents += "  [get_access_desc(A)]"

						if(!computer.nano_printer.print_text(contents,"access report"))
							usr << "<span class='notice'>Hardware error: Printer was unable to print the file. It may be out of paper.</span>"
							return
						else
							computer.visible_message("<span class='notice'>\The [computer] prints out paper.</span>")
				else
					var/contents = {"<h4>Crew Manifest</h4>
									<br>
									[data_core.get_manifest(1)]
									"}
					if(!computer.nano_printer.print_text(contents,text("crew manifest ([])", worldtime2text())))
						usr << "<span class='notice'>Hardware error: Printer was unable to print the file. It may be out of paper.</span>"
						return
					else
						computer.visible_message("<span class='notice'>\The [computer] prints out paper.</span>")
	return 1