return {
	descriptions = {
		-- For all checkboxes and popups, first var is keybind
		-- Further mentioned vars starts from #2#
		Handy_ConfigCheckbox = {
			-- Vars: version, author
			handy = {
				unlock = { "HandyBalatro v#2#", "por {C:white,E:2,s:1.15}#3#{}" },
				text = {
					"Deseleccionar para deshabilitar {C:attention}TODAS{} las funciones del mod",
					"{C:handy_secondary}(no necesita reinicio){}",
				},
			},
			hide_options_button = {
				unlock = { "Ocultar el botón del mod", "en el menú de opciones" },
				text = {
					"{C:handy_secondary}Solo cuando Steamodded esta instalado{}",
				},
			},
			regular_keybinds = {
				unlock = { "Atajos de teclado comunes" },
				text = {
					"Usar atajos de teclado",
					"para acciones comunes",
				},
			},
			insta_highlight = {
				unlock = {
					"{C:edition}Selección de mano rápida{}",
					"{C:handy_secondary,s:0.75}(Seleccionar, mover, arrastrar){}",
				},
				text = {
					"Mantener {C:chips}#1#{} y",
					"pasa el cursor sobre tu mano para seleccionarlas",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight_OUTSIDE = {
				unlock = {
					"{C:edition}Selección de mano rápida{}",
					"{C:handy_secondary,s:0.75}(Seleccionar, mover, arrastrar){}",
				},
				text = {
					"Mantener {C:chips}#1#{} {C:attention}FUERA{} de las cartas, entonces pasa",
					"el cursor sobre ellas para seleccionarlas",
				},
			},
			-- Vars: [Fast hand selection]
			insta_unhighlight = {
				unlock = {
					"Deselección de",
					"mano rápida",
				},
				text = {
					"También permite usar {C:edition}#2#{}",
					"para deseleccionar las cartas",
				},
			},
			show_deck_preview = {
				unlock = { "Previsualizar mazo" },
				text = {
					"Mantener {C:chips}#1#{} para",
					"mostrar previsualización del mazo",
				},
			},
			-- Vars: [Right Mouse]
			deselect_hand = {
				unlock = { "Deseleccionar mano" },
				text = {
					"Pulsar {C:chips}#1#{} para",
					"desmarcar cartas en mano",
				},
			},
			insta_cash_out = {
				unlock = { "Cobrar rápido" },
				text = {
					"Pulsra/Mantener {C:chips}#1#{} para",
					"acelerar la fase de Cobrar",
				},
			},
			insta_booster_skip = {
				unlock = { "Omitir rápido", "paquete potenciador" },
				text = {
					"Pulsar/mantener {C:chips}#1#{} para",
					"omitir paquetes potenciadores",
				},
			},
			move_highlight = {
				unlock = { "Mover seleccionado" },
				text = {
					"Pulsar {C:chips}#2#{} o {C:chips}#3#{} para",
					"mover la carta seleccionada",
					"Mantener {C:chips}#4#{} para en vez mover la carta.",
					"Mantener {C:chips}#5#{} para mover a primera/última carta",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_or_sell = {
				unlock = { "Comprar/vender", "rápido" },
				text = {
					"Usar {C:chips}#1#{} para",
					"comprar o vender la carta",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_n_sell = {
				unlock = { "Comprar y vender", "rápido" },
				text = {
					"Usar {C:chips}#1#{} para",
					"comprar la carta y",
					"venderla inmediatamente",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_use = {
				unlock = { "Usar rápido" },
				text = {
					"Usar {C:chips}#1#{} para",
					"usar la carta si es posible",
				},
			},
			-- Vars: Buy/Sell/Use mode
			cryptid_code_use_last_interaction = {
				unlock = { "Cryptid: Usar", "entrada anterior" },
				text = {
					"Usar {C:chips}#1#{} en",
					"carta de Código e introducir",
					"el valor anterior",
				},
			},
			not_just_yet_interaction = {
				unlock = { "NotJustYet:", "terminar ronda" },
				text = {
					"Pulsar {C:chips}#1#{} para",
					"terminar la ronda",
				},
			},
			-- Vars: [keybind for Multiply], [keybind for Divide], min value, max value
			speed_multiplier = {
				unlock = { "Multiplicador de velocidad" },
				text = {
					"Mantener {C:chips}#1#{} y",
					"{C:chips}#2#{}/{C:chips}#3#{}",
					"para multiplicar/dividir la velocidad del juego",
				},
			},
			-- Vars: [Speed Multiplier]
			speed_multiplier_no_hold = {
				unlock = { "Multiplicador de velocidad:", "Sin mantener" },
				text = {
					"Disminuye el número de atajos de",
					"teclado necesarios para usar",
					"#2#",
				},
			},
			insta_highlight_entire_f_hand = {
				unlock = { "Seleccionar", "mano completa" },
				text = {
					"Pulsar {C:chips}#1#{} para",
					"seleccionar la mano completa",
				},
			},
			-- Vars: [keybind for Increase], [keybind for Decrease], [Danger zone tab]
			nopeus_interaction = {
				unlock = { "Nopeus:", "'Fast-forward'" },
				text = {
					"Mantener {C:chips}#1#{} y",
					"{C:chips}#2#{}/{C:chips}#3#{}",
					"para aumentar/reducir la opción de 'Fast-forward'",
				},
			},
			-- Vars: [Nopeus: fast-forward]
			nopeus_interaction_no_hold = {
				unlock = { "Nopeus:", "Sin mantener" },
				text = {
					"Disminuye el número de atajos de",
					"teclado necesarios para usar",
					"#2#",
				},
			},
			-- Vars: [keybind for Increase], [keybind for Decrease], [Danger zone tab], None, Messages, Animations, Everything, Unsafe, [Danger zone tab]
			animation_skip = {
				unlock = { "Saltar animaciones" },
				text = {
					"Mantener {C:chips}#1#{} y",
					"{C:chips}#2#{}/{C:chips}#3#{} para usar",
					"aumentar/disminuir 'saltar animaciones'",
				},
			},
			-- Vars: [Animation skip]
			animation_skip_no_hold = {
				unlock = { "Omitir animaciones:", "Sin mantener" },
				text = {
					"Disminuye la cantidad de",
					"atajos de teclado necesarios para",
					"#2#",
				},
			},
			scoring_hold = {
				unlock = { "Detener la animación", "de puntuación" },
				text = {
					"Mantener {C:chips}#1#{} para",
					"detener la animación de puntuación",
					"tras contar el tamaño de la mano",
				},
			},
			scoring_hold_any_moment = {
				unlock = { "Detener puntuación", "en cualquier momento" },
				text = {
					"Permite #2#",
					"detener la animación de",
					"puntuación en cualquier momento",
				},
			},
			dangerous_actions = {
				unlock = { "Acciones peligrosas" },
				text = {
					"Habilitar controles peligrosos",
					"para maximizar la velocidad de juego,",
					"{C:mult}¡Cosa que puede producir bugs o crasheos!{}",
				},
			},
			-- Vars: [keybind for Quick buy/sell], [Quick buy/sell], ["Dangerous" modifier]
			immediate_buy_and_sell = {
				unlock = { "Vender instantaneo" },
				text = {
					"Mantener {C:mult}#1#{},",
					"Mantener {C:chips}#2#{},",
					"y coloca el cursor sobre",
					"una carta para venderla",
				},
			},
			immediate_buy_and_sell_queue = {
				unlock = { "Cola de venta" },
				text = {
					"Empezar a vender cartas solo cuando ",
					"atajo de teclado es dejado de pulsar",
				},
			},
			nopeus_unsafe = {
				unlock = { "Nopeus: peligroso", "'Fast-forward'" },
				text = {
					"Permite aumentar la opción de",
					"'Fast-forward' a {C:mult}niveles peligrosos{}",
				},
			},
			speed_multiplier_uncap = {
				unlock = { "Multiplicador de velocidad:", "Sin límite" },
				text = {
					"Permite aumentar la",
					"velocidad del juego a",
					"valores absurdos",
				},
			},
			-- Vars: [Animation skip]
			animation_skip_unsafe = {
				unlock = { "Omitir animaciones:", "Peligroso" },
				text = {
					"Permite configurar",
					"la opción a {C:mult}#2#{}",
				},
			},
			-- Vars: [keybind for Quick buy/sell], ["Dangerous" modifier], ["All copies" modifier]
			sell_all_same = {
				unlock = { "Vender todas", "las cartas duplicadas" },
				text = {
					"Mantener {C:mult}#2#{}, mantener {C:mult}#1#{},",
					"y hacer click en una carta",
					"para vender todas sus copias",
				},
			},
			-- Vars: ["Dangerous" modifier], ["Sell ALL" modifier]
			sell_all = {
				unlock = { "Vender TODO" },
				text = {
					"Mantener {C:mult}#1#{} para vender {C:attention}TODAS{}",
					"las cartas en el área",
				},
			},
			-- Vars: ["Dangerous" modifier], ["REMOVE" modifier], [Quick buy/sell], ["All copies" modifier], ["ALL" modifier]
			card_remove = {
				unlock = { "ELIMINAR* cartas", "o etiquetas" },
				text = {
					"Mantener {C:mult}#1#{} para {C:attention,E:1}ELIMINAR{} cartas",
					"{C:handy_secondary}(funciona para etiquetas){}",
				},
			},
		},
		Handy_ConfigPopup = {
			regular_keybinds = {
				text = {
					"Jugar mano, Descartar, ordenar mano",
					"Renovar tienda, Salir de la tienda, Seleccionar ciega",
					"Saltar ciega, Ver mazo, Partida Info",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight = {
				text = {
					"Si la tecla es {C:chips}#2#{},",
					"Mantener la tecla {C:attention}FUERA{} de las cartas",
					"y pasa el cursor sobre ellas para destacaras",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight_gamepad = {
				text = {
					"Funciona tanto para el cursor como",
					"para el movimiento a través",
					"de botones de dirección",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight_OUTSIDE = {
				text = {
					"Para cualquier tecla que no sea {C:chips}#2#{},",
					"también funcionará mantener presionado el atajo de teclado",
					"mientras se coloca el cursor sobre una carta",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight_OUTSIDE_gamepad = {
				text = {
					"Funciona tanto para el cursor",
					"como para movimiento",
					"a través de los botones de dirección",
				},
			},
			-- Vars: [Fast hand selection]
			insta_unhighlight = {
				text = {
					"Selecciona cartas si la primera no ha sido seleccionada",
					"Deselecciona cartas si la primera carta ha sido seleccionada",
				},
			},
			-- Vars: [Right Mouse]
			deselect_hand_desktop = {
				text = {
					"Reemplaza el {C:chips}#2#{}",
					"pero funciona igual y puede",
					"ser reasignado a otra tecla",
					" ",
					"Desmarca para usar los controles vanilla",
				},
			},
			insta_cash_out = {
				text = {
					"Manteniendo el atajo de teclado lo",
					"activara tán pronto como sea posible",
				},
			},
			insta_booster_skip = {
				text = {
					"Manteniendo el atajo de teclado lo",
					"activara tán pronto como sea posible",
				},
			},
			move_highlight = {
				text = {
					"Selecciona una carta en el área",
					"y entonces usar los controles en la lista",
				},
			},
			move_highlight_gamepad = {
				text = {
					"{C:mult}No tiene efecto en mandos{}",
				},
			},
			-- Vars: [keybind for Multiply], [keybind for Divide], min value, max value
			speed_multiplier = {
				text = {
					"La velocidad del juego puede estar",
					"entre {C:attention}#4#{} y {C:attention}#5#{}",
				},
			},
			-- Vars: [keybind for Increase], [keybind for Decrease], [Danger zone tab]
			nopeus_interaction = {
				text = {
					"Necesita el mod {C:attention}Nopeus{} para funcionar",
					" ",
					"Opciones {C:mult}peligrosas{} han de estar",
					"activadas en la sección",
					"de {C:attention}#4#{}",
				},
			},
			-- Vars: [keybind for Increase], [keybind for Decrease], [Danger zone tab], None, Messages, Animations, Everything, Unsafe, [Danger zone tab]
			animation_skip = {
				text = {
					"Existen 5 niveles de animación",
					" ",
					"{C:attention}#4#{} - Comportamiento por defecto",
					"{C:attention}#5#{} - Elimina textos como {C:attention}De nuevo!{} and {C:chips}+Fichas{}",
					"{C:attention}#6#{} - Puntuación instantanea, elimina los movimientos de las cartas",
					"{C:attention}#7#{} - Elimina animaciones inecesarias, sacar cartas de forma instantanea y reiniciar",
					"{C:mult}#8#{} - Límite absoluto del juego: todo es instantaneo",
					" ",
					"La opción {C:mult}#8#{} ha de estar activada en la página {C:attention}#9#{}",
				},
			},
			scoring_hold = {
				text = {
					"Útil para mover comodines o",
					"comprobar una puntuación al final de la ronda",
					"cuando la velocidad del juego es muy alta",
					"o se omiten animaciones",
				},
			},
			not_just_yet_interaction = {
				text = {
					"Necesita el mod {C:attention}NotJustYet{} para funcionar",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_or_sell_desktop = {
				text = {
					"Uso determinado por el modo",
					"{C:attention}#2#{}",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_n_sell_desktop = {
				text = {
					"Uso determinado por el modo",
					"{C:attention}#2#{}",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_or_sell_gamepad = {
				text = {
					"Reemplaza el {C:chips}#3#{}",
					"pero funciona igual y puede",
					"ser reasignado a otra tecla",
					" ",
					"Desmarca para usar los controles vanilla",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_use_desktop = {
				text = {
					"Uso determinado por el modo",
					"{C:attention}#2#{}",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_use_gamepad = {
				text = {
					"Reemplaza el {C:chips}#3#{}",
					"pero funciona igual y puede",
					"ser reasignado a otra tecla",
					" ",
					"Desmarca para usar los controles vanilla",
				},
			},
			-- Vars: Buy/Sell/Use mode
			cryptid_code_use_last_interaction = {
				text = {
					"Necesita el mod {C:attention}Cryptid{} para funcionar",
					" ",
					"Atajo de teclado para usar cartas de código y seleccionar",
					"la opcción {C:green}[Introducir valor anterior]{} para:",
					"{C:spectral}://POINTER{}, {C:green}://VARIABLE{}, {C:green}://CLASS{}, {C:green}://EXPLOIT{}",
					" ",
					"Uso determinado por el modo",
					"{C:attention}#2#{}",
				},
			},
			cryptid_code_use_last_interaction_gamepad = {
				text = {
					"Necesita el mod {C:attention}Cryptid{} para funcionar",
					" ",
					"Atajo de teclado para usar cartas de código y seleccionar",
					"la opcción {C:green}[Introducir valor anterior]{} para:",
					"{C:spectral}://POINTER{}, {C:green}://VARIABLE{}, {C:green}://CLASS{}, {C:green}://EXPLOIT{}",
				},
			},
			insta_highlight_entire_f_hand = {
				text = {
					"Seleccionar la cantidad máxima de cartas",
					"en mano, de izquieda a derecha",
				},
			},
			-- Vars: [keybind for Quick buy/sell], [Quick buy/sell], ["Dangerous" modifier]
			immediate_buy_and_sell = {
				text = {
					"Mantener {C:mult}#3#{}, {C:chips}#4#{},",
					"y coloca el cursor sobre ellas para venderlas inmediatamente",
				},
			},
			immediate_buy_and_sell_queue = {
				text = {
					"En véz de venderlas inediatamente, {C:mult}[Vender inmediatamente]{}",
					"pondrás las cartas a las que se les haya pasado el cursor",
					"en una lista y todas se venderán cuando",
					"se suelte el atajo de teclado",
					" ",
					"Permite seleccionar cartas con más precisión, pero es más lento",
				},
			},
			immediate_buy_and_sell_queue_gamepad = {
				text = {
					"En véz de venderlas inediatamente, {C:mult}[Vender inmediatamente]{}",
					"pondrás las cartas a las que se les haya pasado el cursor",
					"en una lista y todas se venderán cuando",
					"se suelte el atajo de teclado",
					" ",
					"Permite seleccionar cartas con más precisión, pero es más lento",
					" ",
					"{C:attention}Siempre activo para mandos{}",
				},
			},
			speed_multiplier_uncap = {
				text = {
					"{C:mult}Impacta muy negativamente al rendimiento{}",
				},
			},
			nopeus_unsafe = {
				text = {
					"Necesita el mod mod {C:attention}Nopeus{} para funcionar",
					" ",
					"Aunque esta {C:mult}Opción peligrosa{} no esté marcada,",
					"se puede poner de forma manual a través",
					"de las opciones del juego",
				},
			},
			-- Vars: [keybind for Quick buy/sell], ["Dangerous" modifier], ["All copies" modifier]
			sell_all_same = {
				text = {
					"Mantener {C:mult}#3#{}, {C:mult}#4#{},",
					"y had click en una carta para vender todas sus copias únicas",
				},
			},
			-- Vars: ["Dangerous" modifier], ["Sell ALL" modifier]
			sell_all = {
				text = {
					"Mantener {C:mult}#2#{}, {C:mult}#3#{},",
					"y haz click en una carta para vender {C:attention}TODAS{} las cartas en el área",
				},
			},
			-- Vars: ["Dangerous" modifier], ["REMOVE" modifier], [Quick buy/sell], ["All copies" modifier], ["ALL" modifier]
			card_remove = {
				text = {
					"Cuando se mantenga pulsado, en vez de vender cartas {C:attention}o etiquetas{}, estas serán {C:attention,E:1}ELIMINADAS{}",
					" ",
					"Mantener {C:mult}#2#{}, {C:mult}#3#{}, {C:chips}#4#{}",
					"y coloca el cursor sobre las cartas para {C:attention,E:1}ELIMINARLAS{} (también se aplica la cola)",
					" ",
					"Mantener {C:mult}#2#{}, {C:mult}#3#{}, {C:mult}#5#{}",
					"y haz click en la carta {C:attention}o etiqueta{} para {C:attention,E:1}ELIMINAR{} todas sus copias",
					" ",
					"Mantener {C:mult}#2#{}, {C:mult}#3#{}, {C:mult}#6#{},",
					"y haz click en la carta {C:attention}o etiqueta{} para {C:attention,E:1}ELIMINARLA{}",
				},
			},
		},
		Handy_Preset = {
			["default"] = {
				name = "Por defecto",
				text = {
					"Los controles por defecto del mod",
				},
			},
			["better_mouse_and_gamepad"] = {
				name = "'Better Mouse and Gamepad'",
				text = {
					"Controles similares a el mod 'Better Mouse and Gamepad'",
				},
			},
		},
	},
	misc = {
		-- You don't need to translate all of them, only necessary ones
		-- I don't care, I'll do ALL of them anyways! -Jogla
		handy_keybinds = {
			-- No button assigned
			["None"] = "Ninguno",
			-- Button which cannot be recognized
			["Unknown"] = "Desconocido",

			-- Mouse
			["Left Mouse"] = "Click izquierdo",
			["Right Mouse"] = "Click derecho",
			["Middle Mouse"] = "Rueda del ratón",
			["Mouse 4"] = "botón 4 del ratón",
			["Mouse 5"] = "Botón 5 del ratón",
			["Wheel Up"] = "Rueda hacia arriba",
			["Wheel Down"] = "Rueda hacia abajo",
			-- Controls
			["Escape"] = "Escape",
			["Shift"] = "Shift",
			["Ctrl"] = "Ctrl",
			["Alt"] = "Alt",
			["GUI"] = "Windows/CMD", -- Windows button, or CMD for Mac
			["Enter"] = "Enter/Entrar",
			["Tab"] = "Tabulador",
			["Backspace"] = "Borrar",
			["Num Lock"] = "Bloqueo Numérico",
			["Caps Lock"] = "Bloqueo de Mayúsculas",
			["Scroll Lock"] = "Scroll Lock",
			-- Arrow keys
			["Left"] = "Izquierda",
			["Right"] = "Derecha",
			["Up"] = "Arriba",
			["Down"] = "abajo",
			-- Symbols
			["Backquote"] = '"`"', -- `
			["Singlequote"] = "'", -- '
			["Quote"] = '"', -- "
			["Left Bracket"] = "Abrir llave", -- [
			["Right Bracket"] = "Cerrar llave", -- ]
			-- Weird buttons
			["Printscreen"] = "Inprimir pantalla",
			["Delete"] = "Eliminar",
			["Home"] = nil,
			["Insert"] = "Insertar",
			["End"] = "Fin",
			["Pause"] = nil,
			["Help"] = nil,
			["Sysreq"] = nil, -- WTF is this
			["Menu"] = nil,
			["Undo"] = nil,
			["Mode"] = nil,
			["Page Up"] = "Subir página",
			["Page Down"] = "Bajar página",
			-- Very weird buttons, did they exist in 21th century?
			["Www"] = nil,
			["Mail"] = nil,
			["Calculator"] = nil,
			["Computer"] = nil,
			-- man who the fuck uses these wtf. Turns out I'll leave some blank
			["Appsearch"] = nil,
			["Apphome"] = nil,
			["Appback"] = nil,
			["Appforward"] = nil,
			["Apprefresh"] = nil,
			["Appbookmarks"] = nil,
			["Currencyunit"] = nil,
			["Application"] = nil,
			["Power"] = "Encender/Apagar", -- What a heck | WHY IS THAT A THING?!

			-- Gamepad: buttons
			["(A)"] = nil,
			["(B)"] = nil,
			["(X)"] = nil,
			["(Y)"] = nil,
			["(Back)"] = "(Volver)",
			["(Guide)"] = "(Guia)",
			["(Start)"] = nil,
			-- Gamepad: directions
			-- In Balatro, Left Stick movement treated as direction buttons
			["(Up)"] = "(Arriba)",
			["(Down)"] = "(Abajo)",
			["(Left)"] = "(Izquierda)",
			["(Right)"] = "(Derecha)",
			-- Gamepad: sticks, triggers, bumpers and paddles
			["Left Stick"] = "Stick izquierdo", -- Click
			["Right Stick"] = "Stick derecho", -- Click
			["Left Bumper"] = "LB", -- LB
			["Right Bumper"] = "RB", -- RB
			["Left Trigger"] = "LT", -- LT
			["Right Trigger"] = "RT", -- RT
			-- Not supported by current LOVE engine version
			["First Paddle"] = nil, -- P1
			["Second Paddle"] = nil, -- P2
			["Third Paddle"] = nil, -- P3
			["Fourth Paddle"] = nil, -- P4
			["(Misc. Button)"] = nil,
			-- Gamepad: touchpad
			["Touchpad Press"] = nil,

			-- Not listed here, but can be added if you ever need:
			-- All english letters uppercase, (Q, W, E, R, T, Y...)
			-- All numbers (1, 2, 3...0)
			-- All F keys (F1, F2, F3...)
			-- All NUM keys (NUM 0 ... NUM 9, NUM Enter, NUM +, NUM -, NUM *, NUM /, NUM .)
			-- Other symbols (. ; / \ - + etc)
		},
		handy_keybind_labels = {
			play_hand = "Jugar mano",
			discard = "Descartar",
			toggle_sort = "Alternar forma de ordenar",
			sort_by_rank = "Ordenar por número",
			sort_by_suit = "Ordenar por palo",
			deselect_hand = "Deseleccionar mano",
			cash_out = "Cobrar",
			not_just_yet_end_round = "NotJustYet: Terminar ronda",
			skip_booster = "Omitir paquete potenciador",
			reroll_shop = "Renovar tienda",
			leave_shop = "Salir de la tienda",
			skip_blind = "Saltar ciega",
			select_blind = "Seleccionar ciega",
			reroll_boss = "Renovar jefe",
			run_info_hands = "Partida Info: manos de poker",
			run_info_blinds = "Partida Info: ciegas",
			view_deck = "Ver mazo",
			deck_preview = "Previsualizar mazo",
			quick_highlight = "Selección de mano rápida",
			quick_buy_or_sell = "Comprar/Vender rápido",
			quick_buy_n_sell = "Comprar y vender rápido",
			quick_use = "Usar rápido",
			highlight_entire_f_hand = "Destacar mano completa",
			cryptid_code_use_last_interaction = "Cryptid: Usar entrada anterior",
			speed_multiplier = "Multiplicador de velocidad",
			speed_multiplier_multiply = "Multiplicar",
			speed_multiplier_divide = "Divide",
			nopeus_interaction = "Nopeus: 'Fast-forward'",
			nopeus_interaction_increase = "Aumentar",
			nopeus_interaction_decrease = "Reducir",
			animation_skip = "Omitir animaciones",
			animation_skip_increase = "Omitir animaciones: Aumentar",
			animation_skip_decrease = "Omitir animaciones: Disminuir",
			move_highlight_one_left = "Mover uno a la izquierda",
			move_highlight_one_right = "Mover uno a la derecha",
			move_highlight_move_card = "Mover carta",
			move_highlight_to_end = "Mover al final",

			dangerous_modifier = "Modificador peligroso",
			dangerous_all_same_modifier = 'Modificador "Todas las copias"',
			dangerous_all_modifier = 'Modificador "TODO"',
			dangerous_remove_modifier = 'Modificador "ELIMINAR"',

			scoring_hold = "Detener animaciones de puntuación",

			presets_load_1 = "Cargar configuración 1",
			presets_load_2 = "Cargar configuración 2",
			presets_load_3 = "Cargar configuración 3",
			presets_load_next = "Cargar la siguiente configuración",

			misc_open_mod_settings = "Abrir opciones del mod",
			misc_crash = "Crashea una partida",
			misc_save_run = "Guardar partida",
			misc_quick_restart = "Reinicio rápido",
		},
		handy_keybind_sections = {
			hand = "Mano",
			round = "Ronda",
			shop = "Tienda",
			blinds = "Ciegas",
			menus = "Menús",
			quick_actions = "Acciones rápidas",
			gamespeed = "Velocidad del juego",
			animations = "Animaciones",
			highlight_movement = "Movimiento del destacado",
			shop_and_blinds = "Tienda y Ciegas",
			gamespeed_and_animations = "Velocidad del juego y Animaciones",
			hand_selection = "Selección de mano",
			presets = "Configuraciones",
			dangerous_actions = "Acciones peligrosas",
			misc = "Otros",
		},
		handy_tabs = {
			["Overall"] = "General",
			["Quick"] = "Acciones rápidas",
			["Keybinds"] = "Atajos comunes",
			["Keybinds 2"] = "Otros atajos",
			["Dangerous"] = "Atajos peligrosos",
			["Presets"] = "Configuraciones",
			["Keybinds Paginated"] = "Aajos de teclado",
			["Search"] = "Buscar",
		},
		v_dictionary = {
			Handy_module_keys_single = "[#1#]",
			Handy_module_keys_or = "[#1#] o [#2#]",
			Handy_items_in_queue = "[#1# en la cola]",
			Handy_gamespeed_multiplier = "Multiplicador de la velocidad del juego: #1#",
			Handy_event_queue_retriggers_amount = "Aceleración de la cola de eventos: #1#x",
			Handy_nopeus_fastforward = "Nopeus acelerar: #1#",
			Handy_animation_skip = "Omitir animaciones: #1#",
			Handy_skip_booster_pack = "Omitir paquete potenciador",

			Handy_scoring_hold = "Detener la animación de puntuación",

			Handy_hand_sorting = "Ordenar mano: #1#",

			Handy_preset_index = "Configuración #1#",
			Handy_preset_loaded = "Configuración #1# [#2#] cargado",
			Handy_preset_empty = "Configuración #1# [#2#] está vacio",
			Handy_preset_disabled = "Configuración #1# [#2#] está desactivado",
			Handy_preset_nothing_to_load = "No hay configuraciones para cargar",

			Handy_overall_guide_button = "A cada control se le puede asignar un botón del ratón, la rueda del ratón, o una tecla en la página #1#",
			Handy_overall_guide_gamepad = "A cada control se le puede asignar cualquier botón del mando en la página #1#",
			Handy_popups_guide = "Coloca el cursor sobre los controles para ver más información sobre ellos.",
			Handy_popups_guide_gamepad = "Muevete entre varios controles para ver más información sobre ellos.",
			Handy_search_guide = 'Usa la página "#1#" para buscar.',
			Handy_keybinds_guide_desktop = "Haz clic en un botón y la próxima tecla se asigna. #1# para desasignar.",
			Handy_keybinds_guide_gamepad = "#2# en un botón y la próxima tecla se asigna. #1# para desasignar.",
			Handy_presets_guide = "Conjunto de configuraciones que pueden ser aplicados cuando quieras",
			Handy_danger_zone_guide = "*ELIMINAR carta/etiqueta - Elimina sin comprobaciones, efectos, activaciones o devoluciones",

			Handy_default_value = "#1#: valor predeterminado",
		},
		dictionary = {
			handy_or = "o",

			ph_handy_premade_presets = "Configuraciones pre-hechas",
			ph_handy_custom_presets = "Configuraciones personalizadas",

			b_handy_preset_save = "Guardar",
			b_handy_preset_load = "Cargar",
			b_handy_preset_clear = "Limpiar",

			handy_preset_name_placeholder = "Nombre configuración",

			b_handy_notif_quick = "Acciones rápidas",
			b_handy_notif_dangerous = "Acciones peligrosas",

			b_handy_search_placeholder = "Buscar...",
			b_handy_search = "Buscar",
			b_handy_clear = "Eliminar",
			ph_handy_search_no_results = 'Usa palabras clave como "Más velocidad", "animaciones", "vender" etc.',

			ph_handy_notif_quick_use = "Usar rápido",
			ph_handy_notif_quick_buy_or_sell = "Comprar o vender rápido",
			ph_handy_notif_quick_buy_n_sell = "Comprar rápido y vender inmediatamente",
			ph_handy_notif_unsafe_disabled = "Acciones pelogrosas desactivadas en las opciones del mod",
			ph_handy_notif_unsafe_disabled_by_other_mod = "Acciones peligrosas desactivadas por otro mod",
			ph_handy_notif_unsafe = "[Peligroso] ¡Pueden ocurrir errores!",
			ph_handy_notif_insta_remove = "ELIMINAR instantaneamente",
			ph_handy_notif_insta_sell = "Vender instantaneamente",
			ph_handy_notif_remove_all = "ELIMINAR TODAS las cartas/etiquetas en el área seleccionable",
			ph_handy_notif_sell_all = "Vender todas las cartas en el área seleccionada",
			ph_handy_notif_remove_all_same = "ELIMINAR todas las copias de la carta/etiqueta seleccionada",
			ph_handy_notif_sell_all_same = "Vender todas las copias de la carta seleccionada",
			ph_handy_notif_nopeus_unsafe_disabled = "Opciones peligrosas deshabilitadas en las opciones del mod",
			ph_handy_notif_animation_skip_unsafe_disabled = "Opciones peligrosas deshabilitadas en las opciones del mod",
			ph_handy_notif_cannot_bind_non_holdable = "No puedes poner la rueda del ratón aquí",
			ph_handy_notif_cannot_bind_non_safe = "No se puede asignar este botón aquí",

			ph_handy_notif_misc_save_run_start = "Comenzando a guardar partida...",
			ph_handy_notif_misc_save_run_saving = "Guardando partida...",
			ph_handy_notif_misc_save_run_saved = "Partida guardada",
			ph_handy_notif_misc_save_run_interrupt = "No puedes guardar ahora mismo",

			handy_animation_skip_levels = {
				[1] = "Ninguno",
				[2] = "Mensajes",
				[3] = "Animaciones",
				[4] = "Todo",
				[5] = "Peligroso",
			},

			b_handy_info_popups_level_select = "Nivel de información de los mensajes",
			handy_info_popups_level_opt = {
				[1] = "Ninguno",
				[2] = "Solo peligrosos",
				[3] = "Solo de características",
				[4] = "Todos",
			},
			b_handy_keybinds_trigger_mode_select = "Modo de activación de los atajos de teclado",
			handy_keybinds_trigger_mode_opt = {
				[1] = "Al pulsar",
				[2] = "Al soltar",
			},
			b_handy_buy_sell_use_mode_select = "Modo Comprar/Vender/Usar",
			handy_buy_sell_use_mode_opt = {
				[1] = "Mantener tecla + Seleccionar carta",
				[2] = "Resaltar carta + Pulsar tecla",
			},

			b_handy_device_select = "Dispositivo de entrada",
			handy_device_opt = {
				[1] = "Automático",
				[2] = "Ratón + Teclado",
				[3] = "Mando",
			},
		},
	},
}
