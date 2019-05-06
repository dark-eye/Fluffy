extends Control

func gravity_toggled():
	var currentGrav = Physics2DServer.area_get_param(get_world_2d().get_space(), Physics2DServer.AREA_PARAM_GRAVITY)
	Physics2DServer.area_set_param(get_world_2d().get_space(), Physics2DServer.AREA_PARAM_GRAVITY, ( 98 if currentGrav < 0  else -98))
