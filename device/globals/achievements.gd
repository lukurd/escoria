var GameCenter = null
var iOS = null
var achieves_left = 2

func flush():
	while GameCenter.get_pending_event_count() > 0:
		GameCenter.pop_pending_event()

func award(aid):
	if GameCenter == null:
		return

	flush()

	printt("******** awarding achievement ", aid)
	GameCenter.award_achievement( { "name": aid, "progress": 100, "show_completion_banner": true } )

	if vm.settings.rate_shown:
		return

	achieves_left -= 1
	if achieves_left > 0:
		return

	printt("showing rate screen")
	var url = iOS.get_rate_url(ProjectSettings.get_setting("ios/app_id"))
	vm.show_rate(url)

	vm.settings.rate_shown = true
	vm.save_settings()


func reset():
	if GameCenter == null:
		return

	flush()
	GameCenter.reset_achievements()

func is_ready():
	return true

func start():
	# TODO: This initialization should probably be somewhere else
	# if ProjectSettings.has_setting("GameCenter"):
	# 	GameCenter = ProjectSettings.get_singleton("GameCenter")
	# 	iOS = ProjectSettings.get_singleton("iOS")

	pass

