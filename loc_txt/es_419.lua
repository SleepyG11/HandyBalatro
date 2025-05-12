return {
	descriptions = {
		Handy_ConfigCheckbox = {
			handy = {
				unlock = { "HandyBalatro v#2#", "de {C:white,E:2,s:1.15}#3#{}" },
				text = {
					"Desmarcar para desactivar {C:attention}TODAS{} las funciones del mod",
					"{C:handy_secondary}(no requiere reiniciar){}",
				},
			},
			regular_keybinds = {
				unlock = { "Atajos normales de teclas" },
				text = {
					"Usa combinaciones de teclas",
					"para acciones comunes del juego",
				},
			},
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
			show_deck_preview = {
				unlock = { "Prever mazo" },
				text = {
					"Mantén {C:chips}#1#{} para",
					"prever el mazo",
				},
			},
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
			insta_buy_or_sell = {
				unlock = { "Comprar/Vender rápido" },
				text = {
					"Usa {C:chips}#1#{} para",
					"comprar o vender cartas",
				},
			},
			insta_buy_n_sell = {
				unlock = { "Comprar y vender rápido" },
				text = {
					"Usa {C:chips}#1#{} para",
					"inmediatamente comprar",
					"y vender cartas",
				},
			},
			insta_use = {
				unlock = { "Uso rápido" },
				text = {
					"Usa {C:chips}#1#{} para",
					"usar carta, de ser posible",
					"{C:handy_secondary}(Anula Comprar/Vender rápido){}",
				},
			},
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
			speed_multiplier = {
				unlock = { "Multiplicador de velocidad" },
				text = {
					"Mantén {C:chips}#1#{} y",
					"{C:chips}#2#{} para multiplicar o",
					"{C:chips}#3#{} para dividir la velocidad del juego",
				},
			},
			insta_highlight_entire_f_hand = {
				unlock = { "Destaca", "mano completa" },
				text = {
					"Presiona {C:chips}#1#{} para",
					"destacar la mano completa",
				},
			},
			nopeus_interaction = {
				unlock = { "Nopeus:", "acelerar" },
				text = {
					"Mantén {C:chips}#1#{} y",
					"{C:chips}#2#{} para subir o",
					"{C:chips}#3#{} para disminuir",
					"la configuración de Fast-Forward",
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
			sell_all_same = {
				unlock = { "Vender todas las", "copias de carta" },
				text = {
					"Mantén {C:mult}#2#{}, mantén {C:mult}#1#{},",
					"y presiona una carta para vender",
					"todas sus copias",
				},
			},
			sell_all = {
				unlock = { "Vender TODO" },
				text = {
					"Mantén {C:mult}#1#{} para vender {C:attention}TODAS{}",
					"las cartas del área seleccionada",
				},
			},
			card_remove = {
				unlock = { "REMOVER* cartas", "o etiquetas" },
				text = {
					"Mantén {C:mult}#1#{} para {C:attention,E:1}REMOVER{} cartas",
					"{C:handy_secondary}(también funciona para etiquetas){}",
				},
			},
		},
		Handy_ConfigPopup = {
			regular_keybinds = {
				text = {
					"Jugar mano, Descartar, ordenar mano,",
					"Renovar tienda, Irse de tienda, Seleccionar ciega,",
					"Saltarse ciega, Seleccionar ciega, Ver mazo, Partida Info",
				},
			},
			insta_highlight = {
				text = {
					"Si la tecla seleccionada es {C:chips}[Click Izquierdo]{},",
					"empieza a mantener la tecla {C:attention}FUERA{} de las",
					"cartas, y luego arrastrar para seleccionarlas",
				},
			},
			insta_highlight_gamepad = {
				text = {
					"Funciona tanto para el cursos y movimiento",
					"via los botones direccionales",
				},
			},
			deselect_hand_desktop = {
				text = {
					"Reemplaza el {C:chips}[Click Derecho]{} del juego base",
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
					"Selecciona la carta del área y",
					"luego usa los controles listados",
				},
			},
			speed_multiplier = {
				text = {
					"La velocidad del juego puede ser cambiada",
					"en el rango de {C:attention}x1/512{} a {C:attention}x512{}",
				},
			},
			nopeus_interaction = {
				text = {
					"Se requiere el mod {C:attention}Nopeus{} para que funcione",
					" ",
					"La opción {C:mult}Insegura{} debe ser",
					"activada para la pestaña de {C:attention}Zona de Peligro{}",
				},
			},
			not_just_yet_interaction = {
				text = {
					"Se requiere el mod {C:attention}NotJustYet{} para que funcione",
				},
			},
			insta_buy_or_sell_desktop = {
				text = {
					"El uso se determina en el {C:attention}modo de Comprar/Vender/Usar{}",
				},
			},
			insta_buy_n_sell_desktop = {
				text = {
					"El uso se determina en el {C:attention}modo de Comprar/Vender/Usar{}",
				},
			},
			insta_use_desktop = {
				text = {
					"El uso se determina en el {C:attention}modo de Comprar/Vender/Usar{}",
				},
			},
			cryptid_code_use_last_interaction = {
				text = {
					"Se requiere el mod {C:attention}Cryptid{} para que funcione",
					" ",
					"Un atajo para usar una carta de código y seleccionar",
					"la opción {C:green}[Usar Entrada previa]{} para:",
					"{C:spectral}://POINTER{}, {C:green}://VARIABLE{}, {C:green}://CLASE{}, {C:green}://EXPLOTAR{}",
					" ",
					"El uso se determina en el {C:attention}modo de Comprar/Vender/Usar{}",
				},
			},
			cryptid_code_use_last_interaction_gamepad = {
				text = {
					"Se requiere el mod {C:attention}Cryptid{} para que funcione",
					" ",
					"Atajo para usar una carta de código y seleccionar",
					"la opción {C:green}[Usar Entrada previa]{} para:",
					"{C:spectral}://POINTER{}, {C:green}://VARIABLE{}, {C:green}://CLASE{}, {C:green}://EXPLOTAR{}",
				},
			},
			insta_highlight_entire_f_hand = {
				text = {
					"Selecciona la cantidad máxima posible de cartas",
					"en la mano, de izquierda a derecha",
				},
			},
			immediate_buy_and_sell = {
				text = {
					'Mantén el {C:mult}[modificador "Peligroso"]{}, {C:chips}[Comprar/Vender rápido]{},',
					"y arrastra a las cartas para venderlas inmediamante",
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
					"{C:attention}Siempre activo al usar un mando{}",
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
			sell_all_same = {
				text = {
					'Mantén el {C:mult}[modificador "Peligroso"]{},',
					'el {C:mult}[modificador de "Todas las copias"]{},',
					"y presiona una carta para vender todas sus copias",
				},
			},
			sell_all = {
				text = {
					'Mantén el {C:mult}[modificador "Peligroso"]{},',
					'{C:mult}[modificador de "TODOS"]{},',
					"y presiona una carta para vender {C:attention}TODAS{} las cartas del área",
				},
			},
			card_remove = {
				text = {
					"Mientras se mantiene, en vez de vender cartas {C:attention}o etiquetas{}, estas serán {C:attention,E:1}REMOVIDAS{}",
					" ",
					'Mantén el {C:mult}[Modificador de "Peligroso"]{}, {C:mult}[Modificador de "REMOVER"]{}, {C:chips}[Comprar/Vender rápido]{}',
					"y presiona una carta para {C:attention,E:1}REMOVERLAS{} (también aplica la cola)",
					" ",
					'Mantén el {C:mult}[modificador "Peligroso"]{}, {C:mult}[Modificador de "REMOVER"]{}, {C:mult}[modificador de "Todas las copias"]{}',
					"y presiona una carta {C:attention}o etiquetas{} para {C:attention,E:1}REMOVER{} todas las copias",
					" ",
					'Mantén el {C:mult}[modificador "Peligroso"]{}, {C:mult}[Modificador de "REMOVER"]{}, {C:mult}[Modificador de "TODAS"]{},',
					"y presiona una carta {C:attention}o etiquetas{} para {C:attention,E:1}REMOVER{} {C:attention}TODOS{}",
				},
			},
		},
	},
	misc = {
		handy_keybinds = {
			["Left"] = "Izquierda",
			["(A)"] = "(A)",
		},
		handy_keybind_labels = {
			play_hand = "Jugar mano",
			discard = "Descartar",
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
			speed_multiplier_multiply = "Multiplicar",
			speed_multiplier_divide = "Dividir",
			nopeus_interaction = "Nopeus: Fast-Forward",
			nopeus_interaction_increase = "Aumentar",
			nopeus_interaction_decrease = "Disminuir",
			move_highlight_one_left = "Mover uno a la izquierda",
			move_highlight_one_right = "Mover uno a la derecha",
			move_highlight_move_card = "Mover carta",
			move_highlight_to_end = "Mover al final",

			dangerous_modifier = 'Modificador "peligroso"',
			dangerous_all_same_modifier = 'Modificador "Todas las copias"',
			dangerous_all_modifier = 'Modificador "TODOS"',
			dangerous_remove_modifier = 'Modificador "REMOVER"',
		},
		handy_keybind_sections = {
			round = "Ronda",
			shop = "Tienda",
			blinds = "Ciega",
			menus = "Menus",
			quick_actions = "Acciones breves",
			gamespeed = "Velocidad de juego",
			animations = "Animaciones",
			highlight_movement = "Destacar movimiento",
			shop_and_blinds = "Tienda y ciegas",
			gamespeed_and_animations = "Velocidad de juego y animaciones",
		},
		handy_tabs = {
			["Overall"] = "General & Base",
			["Quick"] = "Acciones rápidas",
			["Keybinds"] = "Combinaciones regulares",
			["Keybinds 2"] = "Otras combinaciones",
			["Dangerous"] = "Zona de Peligro",
		},
		v_dictionary = {
			Handy_module_keys_single = "[#1#]",
			Handy_module_keys_or = "[#1#] or [#2#]",
			Handy_items_in_queue = "[#1# en cola]",
			Handy_gamespeed_multiplier = "Multiplicador de velocidad de juego: #1#",
			Handy_nopeus_fastforward = "Nopeus Fast-Forward: #1#",
		},
		dictionary = {
			handy_or = "O",

			b_handy_hide_mod_button_1 = "Ocultar botón de mod",
			b_handy_hide_mod_button_2 = "en menú de opciones",

			b_handy_notif_quick = "Opciones breves",
			b_handy_notif_dangerous = "Acciones peligrosas",

			ph_handy_any_button_hint = 'Cada control puede ser asignado a cualquier botón o rueda del ratón, o una tecla del teclado en las pestañas de "Combinaciones".',
			ph_handy_any_gamepad_hint = 'Cada control puede ser asignado a cualquier botón del mando en las pestañas de "Combinaciones".',
			ph_handy_remove_hint = "*REMOVER carta/etiqueta - borrar sin ninguna verificación, efecto, activaciones o devolución de dinero.",
			ph_handy_keybinds_guide_desktop = "Presiona un botón y la siguiente tecla ingresada será asignada. [Escape] para desasignar.",
			ph_handy_keybinds_guide_gamepad = "Presiona un botón y la siguiente tecla ingresada será asignada. [(Atrás)] para desasignar.",

			ph_handy_notif_quick_use = "Uso rápido",
			ph_handy_notif_quick_buy_or_sell = "Comprar o vender rápido",
			ph_handy_notif_quick_buy_n_sell = "Comprar rápido y vender instantáneo",
			ph_handy_notif_unsafe_disabled = "Acciones inseguras desactivadas en las configuraciones del mod",
			ph_handy_notif_unsafe_disabled_by_other_mod = "Acciones inseguras desactivadas por otro mod",
			ph_handy_notif_unsafe = "[Inseguro] Pueden ocurrir Bugs!",
			ph_handy_notif_insta_remove = "REMOCIÓN instantánea",
			ph_handy_notif_insta_sell = "Venta instantánea",
			ph_handy_notif_remove_all = "REMOVER TODAS las cartas/etiquetas en área seleccionada",
			ph_handy_notif_sell_all = "Vender TODAS las cartas en área seleccionada",
			ph_handy_notif_remove_all_same = "REMOVER todas las copias de carta/etiqueda seleccionada",
			ph_handy_notif_sell_all_same = "Vender todas las copias de carta seleccionada",
			ph_handy_notif_nopeus_unsafe_disabled = "Opción insegura desactivada en las configuraciones del mod",

			b_handy_info_popups_level_select = "Nivel de ventanas informativas",
			handy_info_popups_level_opt = {
				[1] = "Ninguna",
				[2] = "Solo peligrosos",
				[3] = "Relacionado a características",
				[4] = "Todas",
			},
			b_handy_keybinds_trigger_mode_select = "Modo de activación de combinaciones",
			handy_keybinds_trigger_mode_opt = {
				[1] = "Al presionar tecla",
				[2] = "Al soltar tecla",
			},
			b_handy_buy_sell_use_mode_select = "Modo Comprar/Vender/Usar",
			handy_buy_sell_use_mode_opt = {
				[1] = "Mantener tecla + Presionar carta",
				[2] = "Arrastrar carta + Presionar tecla",
			},
		},
	},
}
