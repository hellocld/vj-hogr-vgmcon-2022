extends Spatial


func _ready() -> void:
	OS.open_midi_inputs()
	print(OS.get_connected_midi_inputs())


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMIDI:
		var msg = "CH: %d | Control Num: %d | Control Val: %d | Inst: %d | Msg: %d | Pitch: %d | Press: %d | Vel: %d"
		print(msg % [event.channel, event.controller_number, event.controller_value, event.instrument, event.message, event.pitch, event.pressure, event.velocity])
