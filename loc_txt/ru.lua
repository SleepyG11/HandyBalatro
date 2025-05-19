return {
	descriptions = {
		Handy_ConfigCheckbox = {
			handy = {
				unlock = { "HandyBalatro v#2#", "от {C:white,E:2,s:1.15}#3#{}" },
				text = {
					"Снимите галочку чтобы выключить {C:attention}ВСЕ{} функции мода",
					"{C:handy_secondary}(без необходимости перезапускать игру){}",
				},
			},
			regular_keybinds = {
				unlock = { "Основные", "назначения" },
				text = {
					"Используйте назначения для",
					"основных игровых действий",
				},
			},
			insta_highlight = {
				unlock = { "Быстрое", "выделение" },
				text = {
					"Удерж. {C:chips}#1#{} и",
					"наводитесь на карты чтобы выделить их",
				},
			},
			insta_highlight_OUTSIDE = {
				unlock = {
					"{C:edition}Быстрое выделение руки{}",
					"{C:handy_secondary}(свайп, наведение, перетаскивание){}",
				},
				text = {
					"Начните удерж. {C:chips}#1#{} {C:attention}НА ПУСТОМ МЕСТЕ{},",
					"а затем наводитесь на карты чтобы выделить их",
				},
			},
			insta_unhighlight = {
				unlock = {
					"Быстрое снятие",
					"выделения",
				},
				text = {
					"Разрешить {C:edition}[Быстрое выделение руки]{}",
					"также и снимать выделение с карт",
				},
			},
			show_deck_preview = {
				unlock = { "Превью колоды" },
				text = {
					"Удерж. {C:chips}#1#{} чтобы",
					"показать превью колоды",
				},
			},
			deselect_hand = {
				unlock = { "Снять выделение руки" },
				text = {
					"Нажмите {C:chips}#1#{} чтобы",
					"снять выделение со всех карт в руке",
				},
			},
			insta_cash_out = {
				unlock = { "Быстрый кэшаут" },
				text = {
					"Нажмите/удерж. {C:chips}#1#{} чтобы",
					"ускорить кэшаут (переход в магазин)",
				},
			},
			insta_booster_skip = {
				unlock = { "Быстрый пропуск", "бустерных наборов" },
				text = {
					"Нажмите/удерж. {C:chips}#1#{} чтобы",
					"пропустить бустерный набор",
				},
			},
			move_highlight = {
				unlock = { "Передвижение", "выделения" },
				text = {
					"Нажмите {C:chips}#2#{} или {C:chips}#3#{}",
					"чтоб передвигать выделение в области.",
					"Удерж. {C:chips}#4#{} чтобы двигать карту.",
					"Удерж. {C:chips}#5#{} чтобы передвинуть к первой/последней карте",
				},
			},
			insta_buy_or_sell = {
				unlock = { "Быстрая покупка", "или продажа" },
				text = {
					"Используйте {C:chips}#1#{} чтобы",
					"купить или продать карту",
				},
			},
			insta_buy_n_sell = {
				unlock = { "Быстрая", "покупка-и-продажа" },
				text = {
					"Используйте {C:chips}#1#{} чтобы",
					"купить карту и сразу же",
					"её продать",
				},
			},
			insta_use = {
				unlock = { "Быстрое", "использование" },
				text = {
					"Используйте {C:chips}#1#{} чтобы",
					"использовать карту, если возможно",
					"{C:handy_secondary}(в приоритете над покупкой/продажей){}",
				},
			},
			cryptid_code_use_last_interaction = {
				unlock = { "Cryptid: использовать", "предыдущее значение" },
				text = {
					"Используйте {C:chips}#1#{} чтобы",
					"использовать Код-карту, если возможно,",
					"с предыдущим введённым значением",
				},
			},
			not_just_yet_interaction = {
				unlock = { "NotJustYet:", "закончить раунд" },
				text = {
					"Нажмите {C:chips}#1#{} чтобы",
					"закончить раунд",
				},
			},
			speed_multiplier = {
				unlock = { "Множитель скорость" },
				text = {
					"Нажмите {C:chips}#1#{} и",
					"{C:chips}#2#{} или {C:chips}#3#{} чтобы",
					"умножить/поделить скорость игры",
				},
			},
			insta_highlight_entire_f_hand = {
				unlock = { "Выделить", "всю руку" },
				text = {
					"Нажмите {C:chips}#1#{} чтобы",
					"выделить всю руку",
				},
			},
			nopeus_interaction = {
				unlock = { "Nopeus:", "fast-forward" },
				text = {
					"Удерж. {C:chips}#1#{} и",
					"{C:chips}#2#{} или {C:chips}#3#{} чтобы",
					"увеличить/уменьшить значение",
					"настройки fast-forward",
				},
			},
			dangerous_actions = {
				unlock = { "Небезопасные действия" },
				text = {
					"Включить опасные функции. Они созданы",
					"с приоритетом на скорость, что",
					"{C:mult}может вызывать баги или краши!{}",
				},
			},
			immediate_buy_and_sell = {
				unlock = { "Моментальная", "продажа" },
				text = {
					"Удерж. {C:mult}#1#{},",
					"удерж. {C:chips}#2#{},",
					"и наводитесь на карты чтобы",
					"продать их",
				},
			},
			immediate_buy_and_sell_queue = {
				unlock = { "Очередь продажи" },
				text = {
					"Начинать продавать карты только",
					"после отпускания клавиши",
				},
			},
			nopeus_unsafe = {
				unlock = { "Nopeus: unsafe", "fast-forward" },
				text = {
					"Позволять увеличивать fast-forward",
					"настройку до {C:mult}Unsafe{}",
				},
			},
			sell_all_same = {
				unlock = { "Продать все", "копии карты" },
				text = {
					"Удерж. {C:mult}#2#{},",
					"удерж. {C:mult}#1#{},",
					"и кликните на карту чтобы",
					"продать все её копии",
				},
			},
			sell_all = {
				unlock = { "Продать ВСЕ" },
				text = {
					"Удерж. {C:mult}#1#{} чтобы",
					"продать {C:attention}ВСЕ{} карты в области",
				},
			},
			card_remove = {
				unlock = { "УДАЛИТЬ* карты", "или тэги" },
				text = {
					"Удерж. {C:mult}#1#{} чтобы",
					"{C:attention,E:1}УДАЛИТЬ{} карты {C:handy_secondary}(или тэги){}",
				},
			},
		},
		Handy_ConfigPopup = {
			regular_keybinds = {
				text = {
					"Сыграть или сбросить руку, сортировка руки",
					"Обновить или покинуть магазин, Информация о забеге",
					"Пропустить или выбрать блайнд, Просмотр колоды",
				},
			},
			insta_highlight = {
				text = {
					"Если назначено на {C:chips}[ЛКМ]{},",
					"начните удерж. {C:attention}НА ПУСТОМ МЕСТЕ{}",
					"а затем наводитесь на карты чтобы выделить их",
				},
			},
			insta_highlight_gamepad = {
				text = {
					"Работает и для курсора, и для выделения",
					"с помощью кнопок движения",
				},
			},
			insta_unhighlight = {
				text = {
					"Выделять карты, если первая не была выделена.",
					"Снимать выделение, если первая карта была выделена.",
				},
			},
			deselect_hand_desktop = {
				text = {
					"Заменяет ванильный {C:chips}[ПКМ]{}",
					"но работает идентично и может",
					"быть переназначен на другую кнопку",
					" ",
					"Снимите галочку чтобы использовать",
					"ванильное управление",
				},
			},
			insta_cash_out = {
				text = {
					"Удерживание кнопки активирует функцию",
					"сразу же как она станет доступна",
				},
			},
			insta_booster_skip = {
				text = {
					"Удерживание кнопки активирует функцию",
					"сразу же как она станет доступна",
				},
			},
			move_highlight = {
				text = {
					"Сначала выделите карту, с которой",
					"хотите взаимодействовать",
				},
			},
			speed_multiplier = {
				text = {
					"Скорость игры может быть изменена",
					"от {C:attention}x1/512{} до {C:attention}x512{}",
				},
			},
			nopeus_interaction = {
				text = {
					"Требуется мод {C:attention}Nopeus{}",
					" ",
					"{C:mult}Unsafe{} значение должно быть",
					"включено во вкладке {C:attention}Опасная зона{}",
				},
			},
			not_just_yet_interaction = {
				text = {
					"Требуется мод {C:attention}NotJustYet{}",
				},
			},
			insta_buy_or_sell_desktop = {
				text = {
					"Использование определяется",
					"{C:attention}Режимом покупки/продажи/использования{}",
				},
			},
			insta_buy_n_sell_desktop = {
				text = {
					"Использование определяется",
					"{C:attention}Режимом покупки/продажи/использования{}",
				},
			},
			insta_use_desktop = {
				text = {
					"Использование определяется",
					"{C:attention}Режимом покупки/продажи/использования{}",
				},
			},
			cryptid_code_use_last_interaction = {
				text = {
					"Требуется мод {C:attention}Cryptid{}",
					" ",
					"Использует Код-карту и выбирает вариант",
					"{C:green}[Input previous value]{} для таких карт как:",
					"{C:spectral}://POINTER{}, {C:green}://VARIABLE{}, {C:green}://CLASS{}, {C:green}://EXPLOIT{}",
					" ",
					"Использование определяется",
					"{C:attention}Режимом покупки/продажи/использования{}",
				},
			},
			cryptid_code_use_last_interaction_gamepad = {
				text = {
					"Требуется мод {C:attention}Cryptid{}",
					" ",
					"Использует Код-карту и выбирает вариант",
					"{C:green}[Input previous value]{} для таких карт как:",
					"{C:spectral}://POINTER{}, {C:green}://VARIABLE{}, {C:green}://CLASS{}, {C:green}://EXPLOIT{}",
				},
			},
			insta_highlight_entire_f_hand = {
				text = {
					"Выбирает максимальное количество",
					"карт в руке, слева направо",
				},
			},
			immediate_buy_and_sell = {
				text = {
					'Удерж. {C:mult}["Опасный" модификатор]{}, {C:chips}[Быстрая покупка/продажа]{},',
					"и наводитесь на карты чтобы сразу же их продать",
				},
			},
			immediate_buy_and_sell_queue = {
				text = {
					"{C:mult}[Моментальная продажа]{} будет продавать не сразу же;",
					"наведённые карты будут добавлены в список, и все",
					"они будут проданы только когда отпустится кнопка",
					" ",
					"Более удобное, но менее быстрое",
				},
			},
			immediate_buy_and_sell_queue_gamepad = {
				text = {
					"{C:mult}[Моментальная продажа]{} будет продавать не сразу же;",
					"наведённые карты будут добавлены в список, и все",
					"они будут проданы только когда отпустится кнопка",
					" ",
					"Более удобное, но менее быстрое",
					" ",
					"{C:attention}Всегда активно для геймпада{}",
				},
			},
			nopeus_unsafe = {
				text = {
					"Требуется мод {C:attention}Nopeus{}",
					" ",
					"Даже если галочка снята, {C:mult}Unsafe{} опция",
					"может быть включена нормально через настройки",
				},
			},
			sell_all_same = {
				text = {
					'Удерж. {C:mult}["Опасный" модификатор]{}, {C:mult}["Все копии" модификатор]{},',
					"и нажмите на карту чтобы продать все её копии",
				},
			},
			sell_all = {
				text = {
					'Удерж. {C:mult}["Опасный" модификатор]{}, {C:mult}["ВСЕ" модификатор]{},',
					"и нажмите на карту чтобы продать {C:attention}ВСЕ{} карты в области",
				},
			},
			card_remove = {
				text = {
					"При удерж. карты {C:attention}или тэги{} будут {C:attention,E:1}УДАЛЕНЫ{}",
					" ",
					'Удерж. {C:mult}["Опасный" модификатор]{}, {C:mult}["УДАЛИТЬ" модификатор]{},',
					"{C:chips}[Быстрая покупка/продажа]{} и наводитесь на карты",
					"чтобы {C:attention,E:1}УДАЛИТЬ{} их (очередь тоже работает)",
					" ",
					'Удерж. {C:mult}["Опасный" модификатор]{}, {C:mult}["УДАЛИТЬ" модификатор]{},',
					'{C:mult}["Все копии" модификатор]{} и нажмите на карту {C:attention}или тэг{}',
					"чтобы {C:attention,E:1}УДАЛИТЬ{} все их копии",
					" ",
					'Удерж. {C:mult}["Опасный" модификатор]{}, {C:mult}["УДАЛИТЬ" модификатор]{},',
					'{C:mult}["ВСЕ" модификатор]{}, и нажмите на карту {C:attention}или тэг{}',
					"чтобы {C:attention,E:1}УДАЛИТЬ{} их {C:attention}ВСЕ{}",
				},
			},
		},
		Handy_Preset = {
			["default"] = {
				name = "По умолчанию",
				text = {
					"Назначения мода по умолчанию",
				},
			},
			["better_mouse_and_gamepad"] = {
				name = "Better Mouse and Gamepad",
				text = {
					"Управления подобны моду Better Mouse and Gamepad",
				},
			},
		},
	},
	misc = {
		handy_keybinds = {
			["Left"] = "Влево",
			["Right"] = "Вправо",
			["Up"] = "Вверх",
			["Down"] = "Сниз",
			["Left Mouse"] = "ЛКМ",
			["Right Mouse"] = "ПКМ",
			["Middle Mouse"] = "СКМ",
			["Wheel Up"] = "Колёсико Вверх",
			["Wheel Down"] = "Колёсико Вниз",
			["Space"] = "Пробел",
		},
		handy_keybind_labels = {
			play_hand = "Сыграть руку",
			discard = "Сбросить руку",
			sort_by_rank = "Сортировать по старшинству",
			sort_by_suit = "Сортировать по масти",
			deselect_hand = "Убрать выделение руки",
			cash_out = "Кэшаут (перейти в магазин)",
			not_just_yet_end_round = "NotJustYet: закончить раунд",
			skip_booster = "Пропустить бустерный набор",
			reroll_shop = "Обновить магазин",
			leave_shop = "Покинуть магазин",
			skip_blind = "Пропустить блайнд",
			select_blind = "Выбрать блайнд",
			run_info_hands = "Информация о забеге: покерные руки",
			run_info_blinds = "Информация о забеге: блайнды",
			view_deck = "Открыть колоду",
			deck_preview = "Превью колоды",
			quick_highlight = "Быстрое выделение",
			quick_buy_or_sell = "Быстрая покупка/продажа",
			quick_buy_n_sell = "Быстрая покупка-и-продажа",
			quick_use = "Быстрое использование",
			highlight_entire_f_hand = "Выделить всю руку",
			cryptid_code_use_last_interaction = "Cryptid: использовать предыдущий ввод",
			speed_multiplier = "Множитель скорости",
			speed_multiplier_multiply = "Умножить",
			speed_multiplier_divide = "Поделить",
			nopeus_interaction = "Nopeus: fast-forward",
			nopeus_interaction_increase = "Увеличить",
			nopeus_interaction_decrease = "Уменьшить",
			move_highlight_one_left = "Передвинуть один налево",
			move_highlight_one_right = "Передвинуть один направо",
			move_highlight_move_card = "Передвигать карту",
			move_highlight_to_end = "Передвинуть на край области",

			dangerous_modifier = '"Опасный" модификатор',
			dangerous_all_same_modifier = '"Все копии" модификатор',
			dangerous_all_modifier = '"ВСЕ" модификатор',
			dangerous_remove_modifier = '"УДАЛИТЬ" модификатор',

			presets_load_1 = "Загрузить профиль 1",
			presets_load_2 = "Загрузить профиль 2",
			presets_load_3 = "Загрузить профиль 3",
			presets_load_next = "Загрузить след. профиль",
		},
		handy_keybind_sections = {
			round = "Раунд",
			shop = "Магазин",
			blinds = "Блайнды",
			menus = "Меню",
			quick_actions = "Быстрые действия",
			gamespeed = "Скорость игры",
			animations = "Анимации",
			highlight_movement = "Движение выделения",
			shop_and_blinds = "Магазин и блайнды",
			gamespeed_and_animations = "Скорость игры и анимации",
			hand_selection = "Выделение руки",
			presets = "Профили",
			dangerous_actions = "Опасные действия",
		},
		handy_tabs = {
			["Overall"] = "Основные & Ванилла",
			["Quick"] = "Быстрые действия",
			["Keybinds"] = "Основные назначения",
			["Keybinds 2"] = "Другие назначения",
			["Dangerous"] = "Опасная зона",
			["Presets"] = "Профили",
			["Keybinds Paginated"] = "Назначения",
		},
		v_dictionary = {
			Handy_module_keys_single = "[#1#]",
			Handy_module_keys_or = "[#1#] или [#2#]",
			Handy_items_in_queue = "[#1# в очереди]",
			Handy_gamespeed_multiplier = "Множитель скорости: #1#",
			Handy_nopeus_fastforward = "Nopeus fast-forward: #1#",

			Handy_preset_index = "Профиль #1#",
			Handy_preset_loaded = "Профиль #1# [#2#] загружен",
			Handy_preset_empty = "Профиль #1# [#2#] пуст",
			Handy_preset_disabled = "Профиль #1# [#2#] выключен",
			Handy_preset_nothing_to_load = "Нет профилей для загрузки",
		},
		dictionary = {
			handy_or = "или",

			ph_handy_premade_presets = "Пре-созданные профили",
			ph_handy_custom_presets = "Пользовательские профили",
			ph_handy_presets_description = "Профиль - набор настроек и назначений, которые могут быть загружены в любой момент",
			b_handy_preset_save = "Сохранить",
			b_handy_preset_load = "Загрузить",
			b_handy_preset_clear = "Очистить",

			handy_preset_name_placeholder = "Название профиля",

			b_handy_hide_mod_button_1 = "Спрятать кнопку",
			b_handy_hide_mod_button_2 = "в меню настроек",

			b_handy_notif_quick = "Быстрые действия",
			b_handy_notif_dangerous = "Опасные действия",

			ph_handy_any_button_hint = 'Каждая настройка может быть назначена на мышь, колёсико мыши или клавиатуру во вкладках "Назначения"',
			ph_handy_any_gamepad_hint = 'Каждая настройка может быть назначена на любую кнопку геймпада во вкладках "Назначения"',
			ph_handy_remove_hint = "*УДАЛИТЬ карту/тэг - убрать без каких-либо проверок, эффектов, триггеров или возврата денег.",
			ph_handy_keybinds_guide_desktop = "Нажмите на кнопку и следующее введённое нажатие будет назначено. [Escape] чтобы убрать.",
			ph_handy_keybinds_guide_gamepad = "Нажмите на кнопку и следующее введённое нажатие будет назначено. [(Back)] чтобы убрать.",

			ph_handy_notif_quick_use = "Быстрое использование",
			ph_handy_notif_quick_buy_or_sell = "Быстрая покупка или продажа",
			ph_handy_notif_quick_buy_n_sell = "Быстрая покупка и моментальная продажа",
			ph_handy_notif_unsafe_disabled = "Небезопасные функции выключены в настройках мода",
			ph_handy_notif_unsafe_disabled_by_other_mod = "Небезопасные функции выключены другим модом",
			ph_handy_notif_unsafe = "[Небезопасно] Возможны баги!",
			ph_handy_notif_insta_remove = "Моментальное УДАЛЕНИЕ",
			ph_handy_notif_insta_sell = "Моментальная продажа",
			ph_handy_notif_remove_all = "УДАЛИТЬ ВСЕ карты/тэги в кликнутой зоне",
			ph_handy_notif_sell_all = "Продать ВСЕ карты в кликнутой зоне",
			ph_handy_notif_remove_all_same = "УДАЛИТЬ все копии кликнутой карты/тэга",
			ph_handy_notif_sell_all_same = "Продать все копии кликнутой карты",
			ph_handy_notif_nopeus_unsafe_disabled = "Unsafe вариант выключен в настройках мода",
			ph_handy_notif_cannot_bind_non_holdable = "Нельзя назначить колёсико мыши здесь",

			b_handy_info_popups_level_select = "Уровень нотификаций",
			handy_info_popups_level_opt = {
				[1] = "Выкл.",
				[2] = "Только небезопасные",
				[3] = "Основные",
				[4] = "Все",
			},
			b_handy_keybinds_trigger_mode_select = "Режим триггера кнопок",
			handy_keybinds_trigger_mode_opt = {
				[1] = "При нажатии",
				[2] = "При отпускании",
			},
			b_handy_buy_sell_use_mode_select = "Режим покупки/продажи/использования",
			handy_buy_sell_use_mode_opt = {
				[1] = "Удерж. кнопку + Нажать карту",
				[2] = "Навести карту + Нажать кнопку",
			},
		},
	},
}
