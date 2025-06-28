class_name Game


enum State {
	START,  # start menu
	INTRO,  # opening cinematic
	SETUP,  # initial setup
	PLAY,   # active playing
	PAUSE,  # pause menu
	DEATH,  # death animations
	FINALE, # final sequence
	OUTRO,  # exiting cinematic?
	END,    # fin, credits
}

static var state: State
