/spell/noclothes
	name = "No Clothes"
	desc = "Learn the ways of robeless spell casting."
	feedback = "NC"
	spell_flags = NO_BUTTON


/spell/wizard_digitalcamo
	name = "Digital Camouflage"
	desc = "The AI can no longer track you, but you will look uncanny if examined."

/spell/wizard_digitalcamo/cast(mob/target, mob/user)
	var/mob/living/carbon/human/C = user
	if(!C)
		return

	to_chat(C, "<span class='notice'>AI can [C.digitalcamo ? "no longer" : ""] now track you.</span>")
	C.digitalcamo = !C.digitalcamo

	feedback_add_details("wizard_power", "CAM")