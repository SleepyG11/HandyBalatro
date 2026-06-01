local input_layer = {
	layer = true,
	global = true,
	key = "input",
	order = 0,
	operator = "until",
}
local card_layer = {
	layer = true,
	global = true,
	key = "card",
	order = -0,
	operator = "until",
}
local tag_layer = {
	layer = true,
	global = true,
	key = "tag",
	order = 0,
	operator = "until",
}
local hold_layer = {
	layer = true,
	global = true,
	key = "hold",
	order = 0,
	operator = "until",
}
local move_layer = {
	layer = true,
	global = true,
	key = "move",
	order = 0,
	operator = "until",

	stack = {},
	dictionary = {},
}

Handy.stack.register_layer(input_layer)
Handy.stack.register_layer(card_layer)
Handy.stack.register_layer(tag_layer)
Handy.stack.register_layer(hold_layer)
Handy.stack.register_layer(move_layer)
