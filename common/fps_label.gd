extends Label

@onready var fpsLabel : Label = self

var timer : float = 0.0
@export var TIMER_LIMIT := 0.1	# fps gui refresh rate in seconds # (float,0.01,1.0)

@onready var fps : int = int(Performance.get_monitor(Performance.TIME_FPS))
var fps_min : int = 9999
var fps_max : int = 0
var fps_sum : int = 0
var fps_average : float = 0.0
var frames : int = -20  # need to wait a bit before starting to track the fps

func _ready():
	if OS.is_debug_build():
		self.visible = true

func _process(delta) -> void:
	timer += delta
	if timer > TIMER_LIMIT:
		frames += 1
		timer = 0.0
		#get_window().set_title(title + " | fps: " + str(Engine.get_frames_per_second()))
		if frames > 0:
			fps = int(Performance.get_monitor(Performance.TIME_FPS))
			if fps < fps_min:
				fps_min = fps
			if fps > fps_max:
				fps_max = fps
			# calc fps avg of last 1 second in 1 second intervals (we only do a division once every second)
			if frames <= 10:
				fps_sum += fps
			else:
				# warning-ignore:integer_division
				fps_average = fps_sum / frames
				frames = 0
				fps_sum = fps
				
			#fps_average = fps_sum / frames
			fpsLabel.text = "fps: " + str(fps) + " // " + "min: " + str(fps_min) + " // " + "max: " + str(fps_max) + " // " + "avg: " + str(fps_average)
