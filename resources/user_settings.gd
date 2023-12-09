class_name UserSettings extends Resource

@export var action_events: Dictionary = {}

func save() -> void:
	ResourceSaver.save(self, "user://user_settings.tres")

static func load_or_create() -> UserSettings:
	var res: UserSettings = load("user://user_settings.tres") as UserSettings
	if !res:
		res = UserSettings.new()
	return res
