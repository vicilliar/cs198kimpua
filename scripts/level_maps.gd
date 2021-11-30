class_name Level_maps

const levels = {
	1: {
		"name": "easy",
		"bg_music": "res://assets/audio/bgm/bgm_level_1",
		"level_time": 138, 									# time before level ends
		"start_time_offset": 5,								# offset between written start times and actual start times
		# Required scores to get star ratings
		# TODO: Change to actual star ranges
		"star_scores": {"3_0":300, "2_5":250, "2_0":200, "1_5":150, "1_0":100},
		"notes":
			[
				{"name": "C4",	"hold": false, "start": 0.02, "length": 0},
				{"name": "G4",	"hold": false, "start": 2, "length": 0},
				{"name": "A4",	"hold": false, "start": 4, "length": 0}
			]
	},
	
	2: {
		"name": "medium",
		"bg_music": "res://???",
		# Required scores to get star ratings
		# TODO: Change to actual star ranges
		"star_scores": {"3_0":300, "2_5":250, "2_0":200, "1_5":150, "1_0":100},
		"notes":
			[
				{"name": "C4",	"hold": false, "start": 0.02, "length": 0},
				{"name": "G4",	"hold": false, "start": 2, "length": 0},
				{"name": "A4",	"hold": false, "start": 4, "length": 0}
			]
	},
	
	3: {
		"name": "hard",
		"bg_music": "res://???",
		# Required scores to get star ratings
		# TODO: Change to actual star ranges
		"star_scores": {"3_0":300, "2_5":250, "2_0":200, "1_5":150, "1_0":100},
		"notes":
			[
				{"name": "C4",	"hold": false, "start": 0.02, "length": 0},
				{"name": "G4",	"hold": false, "start": 2, "length": 0},
				{"name": "A4",	"hold": false, "start": 4, "length": 0}
			]
	}
}








