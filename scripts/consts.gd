class_name Consts
const notes = ['C4', 'D4', 'E4', 'F4', 'G4', 'A4', 'B4', 'C5']
const black_keys = ['Db4', 'Eb4', 'Gb4', 'Ab4', 'Bb4']
const chroma_notes = ['C4', 'Db4', 'D4', 'Eb4', 'E4', 'F4', 'Gb4',
					'G4', 'Ab4', 'A4', 'Bb4', 'B4', 'C5']

const intervals = {
					2: {'name': 'major_second', 	'folder': 2},
					4: {'name': 'major_third', 		'folder': 3}, 
					5: {'name': 'perfect_fourth', 	'folder': 4},
					7: {'name': 'perfect_fifth', 	'folder': 5},
					9: {'name': 'major_sixth', 		'folder': 6},
					11: {'name': 'major_seventh', 	'folder': 7},
					12: {'name': 'octave', 			'folder': 8}
				}

const C4_click_position = 120
const click_y = 980
const key_width = 240

const click_timer_length = 2
const correct_click_window = 0.8
