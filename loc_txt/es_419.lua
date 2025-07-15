return {
	descriptions = {
		-- For all checkboxes and popups, first var is keybind
		-- Further mentioned vars starts from #2#
		Handy_ConfigCheckbox = {
			-- Vars: version, author
			handy = {
				unlock = { "HandyBalatro v#2#", "de {C:white,E:2,s:1.15}#3#{}" },
				text = {
					"Desmarcar para desactivar {C:attention}TODAS{} las funciones del mod",
					"{C:handy_secondary}(no requiere reiniciar){}",
				},
			},
			hide_options_button = {
				unlock = { "Ocultar botón de mod", "en menú de opciones" },
				text = {
					"{C:handy_secondary}Solo cuando Steamodded esté instalado{}",
				},
			},
			debugplus_prevent = {
				unlock = { "DebugPlus:", "bloquear acciones" },
				text = { "Bloquear cualquier acceso rápido de Handy", "cuando se mantenga presionado {C:chips}#2#{}" },
			},
			regular_keybinds = {
				unlock = { "Atajos normales de teclas" },
				text = {
					"Usa combinaciones de teclas",
					"para acciones comunes del juego",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight = {
				unlock = {
					"{C:edition}Selección rápida de la mano{}",
					"{C:handy_secondary,s:0.75}(Arrastrar, mantener, deslizar){}",
				},
				text = {
					"Mantén {C:chips}#1#{} y",
					"arrastra por las cartas de la mano para seleccionarlas",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight_OUTSIDE = {
				unlock = {
					"{C:edition}Selección rápida de la mano{}",
					"{C:handy_secondary,s:0.75}(Arrastrar, mantener, deslizar){}",
				},
				text = {
					"Inicia manteniendo {C:chips}#1#{} {C:attention}FUERA{} de las cartas,",
					"y luego arrastra por las cartas de la mano para seleccionarlas",
				},
			},
			-- Vars: [Fast hand selection]
			insta_unhighlight = {
				unlock = {
					"Deselección rápida",
					"de la mano",
				},
				text = {
					"Permitir {C:edition}#2#{}",
					"para también deseleccionar cartas",
				},
			},
			show_deck_preview = {
				unlock = { "Prever mazo" },
				text = {
					"Mantén {C:chips}#1#{} para",
					"prever el mazo",
				},
			},
			-- Vars: [Right Mouse]
			deselect_hand = {
				unlock = { "Deseleccionar mano" },
				text = {
					"Presiona {C:chips}#1#{} para",
					"deseleccionar las cartas de la mano",
				},
			},
			insta_cash_out = {
				unlock = { "Cobrar rápido" },
				text = {
					"Presiona/Mantén {C:chips}#1#{} para",
					"acelerar la escena de cobrado",
				},
			},
			insta_booster_skip = {
				unlock = { "Omisión rápida", "de paquetes potenciadores" },
				text = {
					"Presiona/Mantén {C:chips}#1#{} para",
					"omitir paquetes potenciadores",
				},
			},
			move_highlight = {
				unlock = { "Mover destacado" },
				text = {
					"Presiona {C:chips}#2#{} o {C:chips}#3#{}",
					"para mover el destacado de la área actual.",
					"Mantén {C:chips}#4#{} para mover la carta actual.",
					"Mantén {C:chips}#5#{} para moverse a la primera/última carta",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_or_sell = {
				unlock = { "Comprar/Vender rápido" },
				text = {
					"Usa {C:chips}#1#{} para",
					"comprar o vender cartas",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_n_sell = {
				unlock = { "Comprar y vender rápido" },
				text = {
					"Usa {C:chips}#1#{} para",
					"inmediatamente comprar",
					"y vender cartas",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_use = {
				unlock = { "Uso rápido" },
				text = {
					"Usa {C:chips}#1#{} para",
					"usar carta, de ser posible",
				},
			},
			-- Vars: Buy/Sell/Use mode
			cryptid_code_use_last_interaction = {
				unlock = { "Cryptid: Usar", "Entrada previa" },
				text = {
					"Usa {C:chips}#1#{} para",
					"usar la carta Código si es posible",
					"con la última entrada ingresada",
				},
			},
			not_just_yet_interaction = {
				unlock = { "NotJustYet:", "Terminar ronda" },
				text = {
					"Presiona {C:chips}#1#{} para",
					"terminar la ronda",
				},
			},
			-- Vars: [keybind for Multiply], [keybind for Divide], min value, max value
			speed_multiplier = {
				unlock = { "Multiplicador de velocidad" },
				text = {
					"Mantén {C:chips}#1#{} y",
					"{C:chips}#2#{}/{C:chips}#3#{} para",
					"multiplicar/dividir la velocidad del juego",
				},
			},
			-- Vars: [Speed Multiplier]
			speed_multiplier_no_hold = {
				unlock = { "Multiplicador de velocidad:", "Sin Sostener" },
				text = {
					"Disminuir la cantidad de",
					"atajos necesarios para usar",
					"#2#",
				},
			},
			insta_highlight_entire_f_hand = {
				unlock = { "Destacar", "mano completa" },
				text = {
					"Presiona {C:chips}#1#{} para",
					"destacar la mano completa",
				},
			},
			-- Vars: [keybind for Increase], [keybind for Decrease], [Danger zone tab]
			nopeus_interaction = {
				unlock = { "Nopeus:", "acelerar" },
				text = {
					"Mantén {C:chips}#1#{} y",
					"{C:chips}#2#{}/{C:chips}#3#{} para",
					"subir/disminuir la configuración de Fast-Forward",
				},
			},
			-- Vars: [Nopeus: fast-forward]
			nopeus_interaction_no_hold = {
				unlock = { "Nopeus:", "Sin Sostener" },
				text = {
					"Disminuir la cantidad de",
					"atajos necesarios para usar",
					"#2#",
				},
			},
			-- Vars: [keybind for Increase], [keybind for Decrease], [Danger zone tab], None, Messages, Animations, Everything, Unsafe, [Danger zone tab]
			animation_skip = {
				unlock = { "Saltar animaciones" },
				text = {
					"Mantén {C:chips}#1#{} y",
					"{C:chips}#2#{}/{C:chips}#3#{} para",
					"aumentar/disminuir el salto de animaciones",
				},
			},
			-- Vars: [Animation skip]
			animation_skip_no_hold = {
				unlock = { "Saltar animaciones:", "Sin Sostener" },
				text = {
					"Disminuir la cantidad de",
					"atajos necesarios para usar",
					"#2#",
				},
			},
			scoring_hold = {
				unlock = { "Pausar animación de", "puntuación" },
				text = {
					"Mantén {C:chips}#1#{} para",
					"pausar la animación de puntuación después de",
					"contar la puntuación total de la mano",
				},
			},
			scoring_hold_any_moment = {
				unlock = { "Pausar puntuación", "en cualquier momento" },
				text = {
					"Permitir #2# para",
					"pausar la animación de puntuación",
					"en cualquier momento",
				},
			},
			dangerous_actions = {
				unlock = { "Acciones peligrosas" },
				text = {
					"Activar controles inseguros. Fueron",
					"diseñados para priorizar velocidad, y",
					"{C:mult}pueden causar bugs y bloqueos!{}",
				},
			},
			-- Vars: [keybind for Quick buy/sell], [Quick buy/sell], ["Dangerous" modifier]
			immediate_buy_and_sell = {
				unlock = { "Vender instantáneo" },
				text = {
					"Mantén {C:mult}#1#{},",
					"mantén {C:chips}#2#{},",
					"y arrastra a la carta para venderla",
				},
			},
			immediate_buy_and_sell_queue = {
				unlock = { "Generar cola de venta" },
				text = {
					"Empezar a vender las cartas solo",
					"cuando la combinación se suelte",
				},
			},
			nopeus_unsafe = {
				unlock = { "Nopeus: Fast-Forward", "Inseguro" },
				text = {
					"Permite aumentar la configuración de",
					"Fast-Forward a {C:mult}Insegura{}",
				},
			},
			speed_multiplier_uncap = {
				unlock = { "Multiplicador de velocidad:", "sin límite" },
				text = {
					"Permite aumentar la velocidad",
					"del juego a valores inseguros",
				},
			},
			-- Vars: [Animation skip]
			animation_skip_unsafe = {
				unlock = { "Saltar animaciones:", "Inseguro" },
				text = {
					"Permite aumentar",
					"la configuración a {C:mult}#2#{}",
				},
			},
			-- Vars: [keybind for Quick buy/sell], ["Dangerous" modifier], ["All copies" modifier]
			sell_all_same = {
				unlock = { "Vender todas las", "copias de carta" },
				text = {
					"Mantén {C:mult}#2#{}, mantén {C:mult}#1#{},",
					"y presiona una carta para vender",
					"todas sus copias",
				},
			},
			-- Vars: ["Dangerous" modifier], ["Sell ALL" modifier]
			sell_all = {
				unlock = { "Vender TODO" },
				text = {
					"Mantén {C:mult}#1#{} para vender {C:attention}TODAS{}",
					"las cartas del área seleccionada",
				},
			},
			-- Vars: ["Dangerous" modifier], ["REMOVE" modifier], [Quick buy/sell], ["All copies" modifier], ["ALL" modifier]
			card_remove = {
				unlock = { "REMOVER* cartas", "o etiquetas" },
				text = {
					"Mantén {C:mult}#1#{} para {C:attention,E:1}REMOVER{} cartas",
					"{C:handy_secondary}(también funciona para etiquetas){}",
				},
			},
		},
		Handy_ConfigPopup = {
			debugplus_prevent = {
				text = {
					"Requiere el mod {C:attention}DebugPlus{} y estar activado",
					"la opción {C:attention}CTRL para accesos directos{} para funcionar",
				},
			},
			regular_keybinds = {
				text = {
					"Jugar mano, Descartar, ordenar mano,",
					"Renovar tienda, Irse de tienda, Seleccionar ciega,",
					"Saltarse ciega, Seleccionar ciega, Ver mazo, Partida Info",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight = {
				text = {
					"Si la tecla seleccionada es {C:chips}#2#{},",
					"empieza a mantener la tecla {C:attention}FUERA{} de las",
					"cartas, y luego arrastrar para seleccionarlas",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight_gamepad = {
				text = {
					"Funciona tanto para el cursos y movimiento",
					"via los botones direccionales",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight_OUTSIDE = {
				text = {
					"Para las teclas distintas a {C:chips}#2#{},",
					"empieza a mantener la tecla mientras deslizas.",
					"Una carta también funcionará",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight_OUTSIDE_gamepad = {
				text = {
					"Funciona tanto para el cursor como para el movimiento",
					"vía los botones direccionales",
				},
			},
			-- Vars: [Fast hand selection]
			insta_unhighlight = {
				text = {
					"Seleccionar cartas si la primera carta no fue seleccionada.",
					"Deseleccionar cartas si la primera carta fue seleccionada.",
				},
			},
			-- Vars: [Right Mouse]
			deselect_hand_desktop = {
				text = {
					"Reemplaza el {C:chips}#2#{} del juego base",
					"pero funciona exactamente igual y",
					"puede asignarse a otro botón",
					" ",
					"Deselecciona para usar el control del juego base",
				},
			},
			insta_cash_out = {
				text = {
					"Mantener la combinación la va a activar",
					"en cuanto sea posible",
				},
			},
			insta_booster_skip = {
				text = {
					"Mantener la combinación la va a activar",
					"en cuanto sea posible",
				},
			},
			move_highlight = {
				text = {
					"Selecciona la carta en el área y",
					"luego usa los controles listados",
				},
			},
			move_highlight_gamepad = {
				text = {
					"{C:mult}No tiene efecto en gamepad{}",
				},
			},
			-- Vars: [keybind for Multiply], [keybind for Divide], min value, max value
			speed_multiplier = {
				text = {
					"La velocidad del juego se puede cambiar en",
					"un rango de {C:attention}#4#{} a {C:attention}#5#{}",
				},
			},
			-- Vars: [keybind for Increase], [keybind for Decrease], [Danger zone tab]
			nopeus_interaction = {
				text = {
					"Se requiere el mod {C:attention}Nopeus{} para que funcione",
					" ",
					"La opción {C:mult}Insegura{} debe ser",
					"activada para la pestaña de {C:attention}#4#{}",
				},
			},
			-- Vars: [keybind for Increase], [keybind for Decrease], [Danger zone tab], None, Messages, Animations, Everything, Unsafe, [Danger zone tab]
			animation_skip = {
				text = {
					"Existen 5 niveles de salto de animación",
					" ",
					"{C:attention}#4#{} - Comportamiento normal del juego",
					"{C:attention}#5#{} - Remueve textos de cartas como {C:attention}¡De nuevo!{} y {C:chips}+Chips{}",
					"{C:attention}#6#{} - Puntuación instantánea, remueve movimiento de las cartas",
					"{C:attention}#7#{} - Remueve animaciones innecesarias, toma de cartas y reinicio",
					"{C:mult}#8#{} - El límite del juego: Todo es instantáneo",
					" ",
					"La opción {C:mult}#8#{} debe ser activada en la pestaña de {C:attention}#9#{}",
				},
			},
			scoring_hold = {
				text = {
					"Útil para barajar comodines o verificar",
					"una puntuación antes del final de la ronda en",
					"alta velocidad de juego o cuando se saltan animaciones",
				},
			},
			not_just_yet_interaction = {
				text = {
					"Se requiere el mod {C:attention}NotJustYet{} para que funcione",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_or_sell_desktop = {
				text = {
					"Uso determinado por {C:attention}#2#{}",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_or_sell_gamepad = {
				text = {
					"Reemplaza el {C:chips}#3#{} del juego base",
					"pero funciona exactamente igual y",
					"puede asignarse a otro botón",
					" ",
					"Deselecciona para usar el control del juego base",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_n_sell_desktop = {
				text = {
					"Uso determinado por {C:attention}#2#{}",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_use_desktop = {
				text = {
					"Uso determinado por {C:attention}#2#{}",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_use_gamepad = {
				text = {
					"Reemplaza el {C:chips}#3#{} del juego base",
					"pero funciona exactamente igual y",
					"puede asignarse a otro botón",
					" ",
					"Deselecciona para usar el control del juego base",
				},
			},
			-- Vars: Buy/Sell/Use mode
			cryptid_code_use_last_interaction = {
				text = {
					"Se requiere el mod {C:attention}Cryptid{} para que funcione",
					" ",
					"Un atajo para usar una carta de código y seleccionar",
					"la opción {C:green}[Usar Entrada previa]{} para:",
					"{C:spectral}://POINTER{}, {C:green}://VARIABLE{}, {C:green}://CLASE{}, {C:green}://EXPLOTAR{}",
					" ",
					"Uso determinado por {C:attention}#2#{}",
				},
			},
			-- Vars: Buy/Sell/Use mode
			cryptid_code_use_last_interaction_gamepad = {
				text = {
					"Se requiere el mod {C:attention}Cryptid{} para que funcione",
					" ",
					"Un atajo para usar una carta de código y seleccionar",
					"{C:green}[Usar Entrada previa]{} opción para:",
					"{C:spectral}://POINTER{}, {C:green}://VARIABLE{}, {C:green}://CLASE{}, {C:green}://EXPLOTAR{}",
				},
			},
			insta_highlight_entire_f_hand = {
				text = {
					"Selecciona la cantidad máxima posible de cartas",
					"en la mano, de izquierda a derecha",
				},
			},
			-- Vars: [keybind for Quick buy/sell], [Quick buy/sell], ["Dangerous" modifier]
			immediate_buy_and_sell = {
				text = {
					"Mantén el {C:mult}#3#{}, {C:chips}#4#{},",
					"y arrastra a las cartas para venderlas inmediatamente",
				},
			},
			immediate_buy_and_sell_queue = {
				text = {
					"En vez de vender inmediatamente, {C:mult}[Vender rápido]{}",
					"guarda todas las cartas seleccionadas a una lista y",
					"estas se venderán al soltar la combinación",
					" ",
					"Permite una selección de cartas más precisa, pero más lenta",
				},
			},
			immediate_buy_and_sell_queue_gamepad = {
				text = {
					"En vez de vender inmediatamente, {C:mult}[Vender rápido]{}",
					"guarda todas las cartas seleccionadas a una lista y",
					"estas se venderán al soltar la combinación",
					" ",
					"Permite una selección de cartas más precisa, pero más lenta",
					" ",
					"{C:attention}Siempre activo en gamepad{}",
				},
			},
			speed_multiplier_uncap = {
				text = {
					"{C:mult}Afecta drásticamente el rendimiento{}",
				},
			},
			nopeus_unsafe = {
				text = {
					"Se requiere el mod {C:attention}Nopeus{} para que funcione",
					" ",
					"Incluso si esto se desactive, la opción {C:mult}Unsafe{}",
					"puede ser seleccionada en las configuraciones del juego",
				},
			},
			-- Vars: [keybind for Quick buy/sell], ["Dangerous" modifier], ["All copies" modifier]
			sell_all_same = {
				text = {
					"Mantén el {C:mult}#3#{}, {C:mult}#4#{},",
					"y presiona una carta para vender todas sus copias",
				},
			},
			-- Vars: ["Dangerous" modifier], ["Sell ALL" modifier]
			sell_all = {
				text = {
					"Mantén el {C:mult}#2#{}, {C:mult}#3#{},",
					"y presiona una carta para vender {C:attention}TODAS{} las cartas en el área",
				},
			},
			-- Vars: ["Dangerous" modifier], ["REMOVE" modifier], [Quick buy/sell], ["All copies" modifier], ["ALL" modifier]
			card_remove = {
				text = {
					"Cuando mantienes, en lugar de vender cartas {C:attention}o etiquetas{} serán {C:attention,E:1}REMOVIDAS{}",
					" ",
					"Mantén el {C:mult}#2#{}, {C:mult}#3#{}, {C:chips}#4#{}",
					"y presiona una carta para {C:attention,E:1}REMOVERLAS{} (también aplica la cola)",
					" ",
					"Mantén el {C:mult}#2#{}, {C:mult}#3#{}, {C:mult}#5#{}",
					"y presiona una carta {C:attention}o etiqueta{} para {C:attention,E:1}REMOVER{} todas las copias",
					" ",
					"Mantén el {C:mult}#2#{}, {C:mult}#3#{}, {C:mult}#6#{},",
					"y presiona una carta {C:attention}o etiqueta{} para {C:attention,E:1}REMOVER{} TODAS",
				},
			},
		},
		Handy_Preset = {
			["default"] = {
				name = "Por defecto",
				text = {
					"Controles por defecto del mod",
				},
			},
			["better_mouse_and_gamepad"] = {
				name = "Better Mouse and Gamepad",
				text = {
					"Controles similares al mod Better Mouse and Gamepad",
				},
			},
		},
	},
	misc = {
		-- You don't need to translate all of them, only necessary ones
		handy_keybinds = {
			-- No button assigned
			["None"] = "Ninguno",
			-- Button which cannot be recognized
			["Unknown"] = "Desconocido",

			-- Mouse
			["Left Mouse"] = "Click Izquierdo",
			["Right Mouse"] = "Click Derecho",
			["Middle Mouse"] = "Click Medio",
			["Mouse 4"] = "Botón 4 del Mouse",
			["Mouse 5"] = "Botón 5 del Mouse",
			["Wheel Up"] = "Rueda para Arriba",
			["Wheel Down"] = "Rueda para Abajo",
			-- Controls
			["Escape"] = nil,
			["Shift"] = nil,
			["Ctrl"] = nil,
			["Alt"] = nil,
			["GUI"] = nil, -- Windows button, or CMD for Mac
			["Enter"] = nil,
			["Tab"] = "Tabular",
			["Backspace"] = "Retroceso",
			["Num Lock"] = "Bloq Num",
			["Caps Lock"] = "Bloq Mayus",
			["Scroll Lock"] = "Block Des",
			-- Arrow keys
			["Left"] = "Izquierda",
			["Right"] = "Derecha",
			["Up"] = "Arriba",
			["Down"] = "Abajo",
			-- Symbols
			["Backquote"] = "Acento grave", -- `
			["Singlequote"] = "Comilla simple", -- '
			["Quote"] = "Comillas altas", -- "
			["Left Bracket"] = "Corchete Izquierdo", -- [
			["Right Bracket"] = "Corchete Derecho", -- ]
			-- Weird buttons
			["Printscreen"] = "Imprimir Pantalla",
			["Delete"] = "Borrar",
			["Home"] = "Inicio",
			["Insert"] = "Insertar",
			["End"] = "Fin",
			["Pause"] = "Pausar",
			["Help"] = "Ayuda",
			["Sysreq"] = "REISU-B",
			["Menu"] = "Menu",
			["Undo"] = "Deshacer",
			["Mode"] = "Modo",
			["Page Up"] = nil,
			["Page Down"] = nil,
			-- Very weird buttons, did they exist in 21th century?
			["Www"] = nil,
			["Mail"] = "Mail",
			["Calculator"] = "Calculadora",
			["Computer"] = nil,
			["Appsearch"] = nil,
			["Apphome"] = nil,
			["Appback"] = nil,
			["Appforward"] = nil,
			["Apprefresh"] = nil,
			["Appbookmarks"] = nil, -- me rindo qué wea son estas
			["Currencyunit"] = "Unidad Monetaria",
			["Application"] = "Aplicación",
			["Power"] = "Poder", -- q xuxa

			-- Gamepad: buttons
			["(A)"] = nil,
			["(B)"] = nil,
			["(X)"] = nil,
			["(Y)"] = nil,
			["(Back)"] = "(Atrás)",
			["(Guide)"] = "(Guías)",
			["(Start)"] = "(Start)",
			-- Gamepad: directions
			-- In Balatro, Left Stick movement treated as direction buttons
			["(Up)"] = "(Arriba)",
			["(Down)"] = "(Abajo)",
			["(Left)"] = "(Izquierda)",
			["(Right)"] = "(Derecha)",
			-- Gamepad: sticks, triggers, bumpers and paddles
			["Left Stick"] = "Stick Izquierdo", -- Click
			["Right Stick"] = "Stick Derecho", -- Click
			["Left Bumper"] = "Bumper Izquierdo", -- LB
			["Right Bumper"] = "Bumper Derecho", -- RB
			["Left Trigger"] = "Trigger Izquierdo", -- LT
			["Right Trigger"] = "Trigger Derecho", -- RT
			-- Not supported by current LOVE engine version
			["First Paddle"] = nil, -- P1
			["Second Paddle"] = nil, -- P2
			["Third Paddle"] = nil, -- P3
			["Fourth Paddle"] = nil, -- P4
			["(Misc. Button)"] = nil,
			-- Gamepad: touchpad
			["Touchpad Press"] = "Presionar Touchpad",

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
			toggle_sort = "(Des)Activar orden",
			sort_by_rank = "Ordenar por categoría",
			sort_by_suit = "Ordenar por pinta",
			deselect_hand = "Deseleccionar mano",
			cash_out = "Cobrar",
			not_just_yet_end_round = "NotJustYet: terminar ronda",
			skip_booster = "Omitir paquete potenciador",
			reroll_shop = "Renovar tienda",
			leave_shop = "Salir de tienda",
			skip_blind = "Omitir ciega",
			select_blind = "Seleccionar ciega",
			reroll_boss = "Renovar jefe",
			run_info_hands = "Partida info: manos de póker",
			run_info_blinds = "Partida info: ciegas",
			view_deck = "Ver mazo",
			deck_preview = "Prever mazo",
			quick_highlight = "Selección rápida de mano",
			quick_buy_or_sell = "Comprar/Vender rápido",
			quick_buy_n_sell = "Comprar y vender rápido",
			quick_use = "Uso rápido",
			highlight_entire_f_hand = "Descartar mano completa",
			cryptid_code_use_last_interaction = "Cryptid: Usar entrada previa",
			speed_multiplier = "Multiplicador de velocidad",
			speed_multiplier_multiply = "Velocidad: Multiplicar",
			speed_multiplier_divide = "Velocidad: Dividir",
			nopeus_interaction = "Nopeus: Fast-Forward",
			nopeus_interaction_increase = "Nopeus: Aumentar",
			nopeus_interaction_decrease = "Nopeus: Disminuir",
			animation_skip = "Saltar animaciones",
			animation_skip_increase = "Saltar animaciones: Aumentar",
			animation_skip_decrease = "Saltar animaciones: Disminuir",
			move_highlight_one_left = "Mover uno a la izquierda",
			move_highlight_one_right = "Mover uno a la derecha",
			move_highlight_move_card = "Mover carta",
			move_highlight_to_end = "Mover al final",

			dangerous_modifier = 'Modificador "peligroso"',
			dangerous_all_same_modifier = 'Modificador "Todas las copias"',
			dangerous_all_modifier = 'Modificador "TODOS"',
			dangerous_remove_modifier = 'Modificador "REMOVER"',

			scoring_hold = "Pausar animación de puntuación",

			presets_load_1 = "Cargar preset 1",
			presets_load_2 = "Cargar preset 2",
			presets_load_3 = "Cargar preset 3",
			presets_load_next = "Cargar siguiente preset",

			misc_open_mod_settings = "Abrir configuración del mod",
			misc_crash = "Hacer que el juego se bloquee",
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
			highlight_movement = "Destacar movimiento",
			shop_and_blinds = "Tienda y Ciegas",
			gamespeed_and_animations = "Velocidad del juego y animaciones",
			hand_selection = "Selección de mano",
			presets = "Presets",
			dangerous_actions = "Acciones peligrosas",
			misc = "Misceláneo",
		},
		handy_tabs = {
			["Overall"] = "General y Juego base",
			["Quick"] = "Acciones rápidas",
			["Keybinds"] = "Atajos de teclado",
			["Keybinds 2"] = "Otros atajos de teclado",
			["Dangerous"] = "Zona peligrosa",
			["Presets"] = "Presets",
			["Keybinds Paginated"] = "Atajos de teclado",
			["Search"] = "Buscar",
		},
		v_dictionary = {
			Handy_module_keys_single = "[#1#]",
			Handy_module_keys_or = "[#1#] o [#2#]",
			Handy_items_in_queue = "[#1# en cola]",
			Handy_gamespeed_multiplier = "Multiplicador de velocidad del juego: #1#",
			Handy_event_queue_retriggers_amount = "Aceleración de la cola de eventos: #1#",
			Handy_nopeus_fastforward = "Nopeus avance rápido: #1#",
			Handy_animation_skip = "Saltar animación: #1#",
			Handy_skip_booster_pack = "Omitir paquete potenciador",

			Handy_scoring_hold = "Pausar animación de puntuación",

			Handy_hand_sorting = "Ordenar mano: #1#",

			Handy_preset_index = "Preset #1#",
			Handy_preset_loaded = "Preset #1# [#2#] cargado",
			Handy_preset_empty = "Preset #1# [#2#] está vacío",
			Handy_preset_disabled = "Preset #1# [#2#] está deshabilitado",
			Handy_preset_nothing_to_load = "No hay presets para cargar",

			Handy_overall_guide_button = 'Cada control puede ser asignado a un botón del ratón, rueda del ratón o tecla del teclado en la pestaña "#1#".',
			Handy_overall_guide_gamepad = 'Cada control puede ser asignado a cualquier botón del gamepad en la pestaña "#1#".',
			Handy_popups_guide = "Desliza sobre los controles para ver más información sobre ellos.",
			Handy_popups_guide_gamepad = "Mueve entre los controles para ver más información sobre ellos.",
			Handy_search_guide = 'Usa la pestaña "#1#" para buscar.',
			Handy_keybinds_guide_desktop = "Haz clic en un botón y la siguiente tecla que ingreses será asignada. #1# para desasignar.",
			Handy_keybinds_guide_gamepad = "#2# un botón y la siguiente tecla que ingreses será asignada. #1# para desasignar.",
			Handy_presets_guide = "Preset - conjunto de configuraciones y atajos de teclado que se pueden aplicar en cualquier momento",
			Handy_danger_zone_guide = "*REMOVER carta/etiqueta - eliminar sin ninguna verificación, efecto, activaciones o dinero.",

			Handy_default_value = "#1#: valor predeterminado",
		},
		dictionary = {
			handy_or = "O",

			ph_handy_premade_presets = "Presets preestablecidos",
			ph_handy_custom_presets = "Presets personalizados",

			b_handy_preset_save = "Guardar",
			b_handy_preset_load = "Cargar",
			b_handy_preset_clear = "Limpiar",

			handy_preset_name_placeholder = "Nombre de preset",

			b_handy_notif_quick = "Acciones rápidas",
			b_handy_notif_dangerous = "Acciones peligrosas",

			b_handy_search_placeholder = "Cargar...",
			b_handy_search = "Buscar",
			b_handy_clear = "Limpiar",
			ph_handy_search_no_results = 'Usa palabras clave tales como "more speed", "animaciones", "vender", etc.',

			ph_handy_notif_quick_use = "Uso rápido",
			ph_handy_notif_quick_buy_or_sell = "Comprar o vender rápido",
			ph_handy_notif_quick_buy_n_sell = "Comprar rápido y vender instantáneo",
			ph_handy_notif_unsafe_disabled = "Acciones inseguras desactivadas en las configuraciones del mod",
			ph_handy_notif_unsafe_disabled_by_other_mod = "Acciones inseguras desactivadas por otro mod",
			ph_handy_notif_unsafe = "[Inseguro] ¡Pueden ocurrir Bugs!",
			ph_handy_notif_insta_remove = "REMOCIÓN instantánea",
			ph_handy_notif_insta_sell = "Venta instantánea",
			ph_handy_notif_remove_all = "REMOVER TODAS las cartas/etiquetas en área seleccionada",
			ph_handy_notif_sell_all = "Vender TODAS las cartas en área seleccionada",
			ph_handy_notif_remove_all_same = "REMOVER todas las copias de carta/etiqueta seleccionada",
			ph_handy_notif_sell_all_same = "Vender todas las copias de carta seleccionada",
			ph_handy_notif_nopeus_unsafe_disabled = "Opción insegura desactivada en las configuraciones del mod",
			ph_handy_notif_animation_skip_unsafe_disabled = "Opción insegura desactivada en las configuraciones del mod",
			ph_handy_notif_cannot_bind_non_holdable = "No se puede asignar la rueda del mouse aquí",
			ph_handy_notif_cannot_bind_non_safe = "No se puede asignar este botón aquí",

			ph_handy_notif_misc_save_run_start = "Iniciando guardado de partida...",
			ph_handy_notif_misc_save_run_saving = "Guardando partida...",
			ph_handy_notif_misc_save_run_saved = "Partida guardada",
			ph_handy_notif_misc_save_run_interrupt = "No se puede guardar ahora",

			handy_animation_skip_levels = {
				[1] = "Ninguna",
				[2] = "Mensajes",
				[3] = "Animaciones",
				[4] = "Todo",
				[5] = "Inseguro",
			},

			b_handy_info_popups_level_select = "Info popups level",
			handy_info_popups_level_opt = {
				[1] = "Ninguna",
				[2] = "Solo peligroso",
				[3] = "Relacionado con características",
				[4] = "Todo",
			},
			b_handy_keybinds_trigger_mode_select = "Modo de activación de combinaciones",
			handy_keybinds_trigger_mode_opt = {
				[1] = "Al presionar la tecla",
				[2] = "Al soltar la tecla",
			},
			b_handy_buy_sell_use_mode_select = "Modo de Comprar/Vender/Usar",
			handy_buy_sell_use_mode_opt = {
				[1] = "Mantener tecla + Presionar carta",
				[2] = "Arrastrar carta + Presionar tecla",
			},

			b_handy_device_select = "Input device",
			handy_device_opt = {
				[1] = "Automatico",
				[2] = "Mouse + Teclado",
				[3] = "Gamepad",
			},
		},
	},
}
