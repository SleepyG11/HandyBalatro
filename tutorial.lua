Handy.UI.TUTORIAL = {}

local texts = {
	welcome = {
		-- Nothing usual, I'm appearing
		"Hello and Welcome, Balatro player",
		" ",
		"I'm SleepyG11, creator of Handy.",
		"Thank you for using my mod, I appreciating it a lot!",
	},
	explain_tutorial = {
		"I hope you can read. Please. Please!",
		" ",
		"This mod adds a LOT of various controls to a game.",
		"I never counter them, but there's at least 70 of them!",
		" ",
		"To fit them all and make accessible inside a game,",
		"fully custom, big and dense config page is made.",
		"It has multiple tabs and pages, easy to get lost!",
	},
	ask_for_tutorial = {
		"To help you with navigating inside",
		"I have a tutorial for you.",
		" ",
		"I'll explain everything you need to look at",
		"and know to efficiently utilize all features",
		"Handy provides to you!",
		" ",
		"You may skip it, but you better don't. You need it.",
	},

	tutorial_skipped = {
		"Okay. Not holding you anymore.",
		"If you get lost in config, blame yourself.",
		" ",
		"You can start tutorial again by pressing",
		"corresponding button inside main page.",
		" ",
		"Again, thank you for using Handy! See you inside!",
	},

	line_example_1 = {
		-- Here, I'll render some examples of elements which you may expect in config
		-- Some checkboxes, progress, option cycles
		"Cool! Let's begin.",
		" ",
		"In Balatro and mods for it, configs pretty straightforward.",
		"Big buttons, big toggles and easily visible descriptions...",
		" ",
		"...Like this. Hard to miss.",
	},
	line_example_2 = {
		-- Here, replace them with dictionary ones
		"But, most mods doesnt have 70+ configs to work with.",
		"So, in Handy, all of them are condensed and standartized...",
		" ",
		"...Like this. Let's break it down.",
	},
	line_example_3 = {
		-- Some dictionary items, some with descriptions, some is dangerous
		"Obviously, each config has own name.",
		" ",
		"Sometimes, small additional description.",
		" ",
		"Some of them is red, which means this is something Dangerous!",
		"be careful with this ones.",
	},
	line_example_4 = {
		-- Some lines with additional info in popups
		"Decent part of configs have extended descriptions.",
		"They contain some useful info such as: what they do,",
		"how to use them, and possible quirks with them.",
		" ",
		"To see them, you need either hover config name, or (?) thing on a right.",
		" ",
		"I know reading is hard, but please, please, check them!",
	},
	line_example_5 = {
		-- Add checkboxes to them
		"Most of controls can be enabled/disabled.",
		"Use toggle (also known as checkbox) on a right to do so.",
		" ",
		"Any control can be enabled/disabled in any moment",
		"without run or game restart!",
		" ",
		"Sometimes, control can't work on certain conditions.",
		"In this case, you'll see (!) alert on toggle. Hover it to see more info.",
	},
	line_example_6 = {
		-- Some dictionary items with progress, option cycle
		"This one should be easy: some configs have familiar to you inputs.",
		" ",
		"Pretty straightforward, nothing unusual.",
	},
	line_examle_7 = {
		-- keybind moment
		"This one is important. This is a Keybind.",
		" ",
		"Here, you can assign which buttons to press to execute control.",
		"Mouse buttons and wheel works too!",
		"Each control can have up to 2 combinations to trigger it.",
		" ",
		"To assign combination:",
		"1. Click on a keybind (blue button)",
		"2. Press all keys you want add to combination, or nothing if you want unbind",
		"3. Press [Escape] to finish",
		" ",
		"Try it!",
	},

	lines_complete = {
		-- We did it, cleanup
		"Phew, that was a lot, but you did it!",
		"Congratulations to be not part of 98% Balatro players!",
		" ",
		"Now, quick explanations on what to look at.",
	},

	menus_info_1 = {
		-- Show buttons from main menu
		"In main config page, there's multiple buttons which leads",
		"to pages where controls are grouped for easier navigation.",
		"Check all of them!",
		" ",
		"in Mod Update page, you can find things for automatic mod updating.",
		"I'll downloadand install latest version for you. Handy, isn't it?",
	},
	menus_info_2 = {
		-- Show buttons which supposed to change tabs (on top)
		"Also, there's few tabs to look around.",
		" ",
		"In Presets, you can save/load your config",
		"and even switch between them in-game by using keybinds",
		" ",
		"In Search, you can find full list of all controls",
		"added by Handy, with a search input for easier",
		"finding specific controls you may need.",
	},
	-- If I'll add more tabs, I'll add explanation for them too

	tutorial_complete = {
		-- We did it
		"Now, you're ready.",
		" ",
		"Again, thank you for using Handy! See you inside!",
	},
}

local scenario = {
	welcome = {
		loc_txt = {
			main = {},
		},
		render = function(self)
			local area = CardArea(0, 0, G.CARD_W, G.CARD_H, {
				type = "title",
			})
			local card = Card(
				0,
				0,
				G.CARD_W,
				G.CARD_H,
				nil,
				G.P_CENTERS.j_joker,
				{ bypass_discovery_center = true, bypass_discovery_ui = true }
			)
			area:emplace(card)
			card.no_ui = true
			card.children.center.atlas = G.ASSET_ATLAS["handy_me_joker"]
			card.children.center:set_sprite_pos({ x = 0, y = 0 })
			card:start_materialize()
			card:juice_up()
			card.states.collide.can = false

			Handy.UI.TUTORIAL.me = card

			local r = {
				n = G.UIT.R,
				config = { padding = 0.1 },
				nodes = {
					{
						n = G.UIT.R,
						config = {
							align = "cm",
							padding = 0.25,
							colour = { 0, 0, 0, 0.1 },
							r = 0.25,
						},
						nodes = {
							{
								n = G.UIT.C,
								config = { align = "cm" },
								nodes = {
									{
										n = G.UIT.O,
										config = {
											object = area,
										},
									},
								},
							},
							{
								n = G.UIT.C,
								config = { align = "cm" },
								nodes = {
									Handy.L.parse_lines(self.loc_txt.main, { default_col = G.C.UI.TEXT_LIGHT }),
								},
							},
						},
					},
					{
						n = G.UIT.R,
						config = {
							align = "cm",
							padding = 0.25,
							colour = { 0, 0, 0, 0.1 },
							r = 0.25,
						},
						nodes = {
							UIBox_button({
								label = { "Continue" },
								-- scale = 0.3,
								colour = G.C.CHIPS,
								col = true,
								button = "handy_tutorial_step",
								ref_table = {
									step_key = "tutorial_ask",
								},
							}),
						},
					},
				},
			}

			return {
				n = G.UIT.ROOT,
				config = { colour = G.C.CLEAR },
				nodes = { r },
			}
		end,
	},
	tutorial_ask = {
		loc_txt = {
			main = {
				"I want make sure that you will not get lost",
				"in all features added in Handy, because there's A LOT of them.",
				"So, I prepared a tutorial for you!",
				" ",
				"Or, if you already know all of this, you may skip it.",
				"(I'm pretty sure you don't, I suggest stay for a bit with me)",
			},
		},
		render = function(self)
			local card = Handy.UI.TUTORIAL.me
			card.area:remove_card(card)
			local area = CardArea(0, 0, G.CARD_W, G.CARD_H, {
				type = "title",
			})
			area:emplace(card)
			card.states.collide.can = false

			local r = {
				n = G.UIT.R,
				config = { padding = 0.1 },
				nodes = {
					{
						n = G.UIT.R,
						config = {
							align = "cm",
							padding = 0.25,
							colour = { 0, 0, 0, 0.1 },
							r = 0.25,
						},
						nodes = {
							{
								n = G.UIT.C,
								config = { align = "cm" },
								nodes = {
									{
										n = G.UIT.O,
										config = {
											object = area,
										},
									},
								},
							},
							{
								n = G.UIT.C,
								config = { align = "cm" },
								nodes = {
									Handy.L.parse_lines(self.loc_txt.main, { default_col = G.C.UI.TEXT_LIGHT }),
								},
							},
						},
					},
					{
						n = G.UIT.R,
						config = {
							align = "cm",
							padding = 0.25,
							colour = { 0, 0, 0, 0.1 },
							r = 0.25,
						},
						nodes = {
							UIBox_button({
								label = { "Okay" },
								-- scale = 0.3,
								colour = G.C.CHIPS,
								col = true,
								button = "handy_tutorial_step",
								ref_table = {
									step_key = "tutorial_start",
								},
							}),
							UIBox_button({
								label = { "Continue" },
								-- scale = 0.3,
								colour = G.C.MULT,
								col = true,
								button = "handy_tutorial_step",
								ref_table = {
									step_key = "tutorial_skip",
								},
							}),
						},
					},
				},
			}
			return {
				n = G.UIT.ROOT,
				config = { colour = G.C.CLEAR },
				nodes = { r },
			}
		end,
	},
}

function Handy.UI.TUTORIAL.test()
	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR },
		nodes = {
			{
				n = G.UIT.O,
				config = {
					id = "handy_tutorial",
					object = UIBox({
						definition = scenario.welcome:render(),
						config = {},
					}),
				},
			},
		},
	}
end

function Handy.UI.TUTORIAL.render_step(key)
	local container = G.OVERLAY_MENU:get_UIE_by_ID("handy_tutorial")
	if container then
		local new_content = UIBox({
			definition = scenario[key]:render(),
			config = { parent = container },
		})
		container.config.object:remove()
		container.config.object = new_content
		container.config.object:recalculate()
		container.UIBox:recalculate()
		G.OVERLAY_MENU:recalculate()
	end
end

function G.FUNCS.handy_tutorial_step(e)
	local step = e.config.ref_table.step_key
	Handy.UI.TUTORIAL.render_step(step)
end

return Handy.UI.TUTORIAL.test()
