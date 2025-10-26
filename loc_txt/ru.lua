return {
	descriptions = {
		-- For all checkboxes and popups, first var is keybind
		-- Further mentioned vars starts from #2#
		Handy_ConfigCheckbox = {
			-- Vars: version, author
			handy = {
				unlock = { "HandyBalatro v#2#", "от {C:white,E:2,s:1.15}#3#{}" },
				text = {
					"Снимите галочку чтобы выключить {C:attention}ВСЕ{} функции мода",
					"{C:handy_secondary}(без необходимости перезапускать игру){}",
				},
			},
			hide_options_button = {
				unlock = { "Спрятать кнопку", "в меню настроек" },
				text = {
					"{C:handy_secondary}Только если установлен Steamodded{}",
				},
			},
			debugplus_prevent = {
				unlock = { "DebugPlus:", "перехват управления" },
				text = {
					"Не использовать назнчения Handy",
					"пока удерж. {C:chips}#2#{}",
				},
			},
			regular_keybinds = {
				unlock = { "Основные", "назначения" },
				text = {
					"Используйте назначения для",
					"основных игровых действий",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight = {
				unlock = {
					"{C:edition}Быстрое выделение руки{}",
					"{C:handy_secondary}(свайп, наведение, перетаскивание){}",
				},
				text = {
					"Удерж. {C:chips}#1#{} и",
					"наводитесь на карты чтобы выделить их",
				},
			},
			-- Vars: [Left Mouse]
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
			-- Vars: [Fast hand selection]
			insta_unhighlight = {
				unlock = {
					"Быстрое снятие",
					"выделения",
				},
				text = {
					"{C:edition}#2#{} также",
					"будет и снимать выделение с карт",
				},
			},
			show_deck_preview = {
				unlock = { "Предпросмотр колоды" },
				text = {
					"Удерж. {C:chips}#1#{} чтобы",
					"показать предпросмотр колоды",
				},
			},
			-- Vars: [Right Mouse]
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
			-- Vars: Buy/Sell/Use mode
			insta_buy_or_sell = {
				unlock = { "Быстрая покупка", "или продажа" },
				text = {
					"Используйте {C:chips}#1#{} чтобы",
					"купить или продать карту",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_n_sell = {
				unlock = { "Быстрая", "покупка-и-продажа" },
				text = {
					"Используйте {C:chips}#1#{} чтобы",
					"купить карту и сразу же",
					"её продать",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_use = {
				unlock = { "Быстрое", "использование" },
				text = {
					"Используйте {C:chips}#1#{} чтобы",
					"использовать карту, если возможно",
				},
			},
			-- Vars: Buy/Sell/Use mode
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
			-- Vars: [keybind for Multiply], [keybind for Divide], min value, max value
			speed_multiplier = {
				unlock = { "Множитель скорости" },
				text = {
					"Нажмите {C:chips}#1#{} и",
					"{C:chips}#2#{}/{C:chips}#3#{} чтобы",
					"умножить/поделить скорость игры",
				},
			},
			-- Vars: [Speed Multiplier]
			speed_multiplier_no_hold = {
				unlock = { "Множитель скорость:", "без удержания" },
				text = {
					"Уменьшает кол-во",
					"необходимых клавиш для",
					"#2#",
				},
			},
			insta_highlight_entire_f_hand = {
				unlock = { "Выделить", "всю руку" },
				text = {
					"Нажмите {C:chips}#1#{} чтобы",
					"выделить всю руку",
				},
			},
			-- Vars: [keybind for Increase], [keybind for Decrease], [Danger zone tab]
			nopeus_interaction = {
				unlock = { "Nopeus:", "fast-forward" },
				text = {
					"Удерж. {C:chips}#1#{} и",
					"{C:chips}#2#{}/{C:chips}#3#{} чтобы",
					"увеличить/уменьшить настройку fast-forward",
				},
			},
			-- Vars: [Nopeus: fast-forward]
			nopeus_interaction_no_hold = {
				unlock = { "Nopeus:", "без удержания" },
				text = {
					"Уменьшает кол-во",
					"необходимых клавиш для",
					"#2#",
				},
			},
			-- Vars: [keybind for Increase], [keybind for Decrease], [Danger zone tab], None, Messages, Animations, Everything, Unsafe, [Danger zone tab]
			animation_skip = {
				unlock = { "Пропуск анимаций" },
				text = {
					"Удерж. {C:chips}#1#{} и",
					"{C:chips}#2#{}/{C:chips}#3#{} чтобы",
					"увеличить/уменьшить пропуск анимаций",
				},
			},
			-- Vars: [Animation skip]
			animation_skip_no_hold = {
				unlock = { "Пропуск анимаций:", "без удержания" },
				text = {
					"Уменьшает кол-во",
					"необходимых клавиш для",
					"#2#",
				},
			},
			scoring_hold = {
				unlock = { "Пауза анимации", "подсчёта" },
				text = {
					"Удерж. {C:chips}#1#{} чтобы",
					"приостановить анимацию подсчёта",
					"после подсчёта фишек руки",
				},
			},
			scoring_hold_any_moment = {
				unlock = { "Пауза подсчёта", "в любой момент" },
				text = {
					"Позволяет #2#",
					"приостанавливать в любой",
					"момент анимации подсчёта",
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
			-- Vars: [keybind for Quick buy/sell], [Quick buy/sell], ["Dangerous" modifier]
			immediate_buy_and_sell = {
				unlock = { "Моментальная", "продажа" },
				text = {
					"Удерж. {C:mult}#1#{},",
					"удерж. {C:chips}#2#{},",
					"и наводитесь на карты",
					"чтобы продать их",
				},
			},
			speed_multiplier_uncap = {
				unlock = { "Множитель скорости:", "убрать лимит" },
				text = {
					"Позволяет увеличиват скорость игры",
					"до огромных значений",
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
			-- Vars: [Animation skip]
			animation_skip_unsafe = {
				unlock = { "Пропуск анимаций:", "небезопасно" },
				text = {
					"Позволяет увеличивать пропуск",
					"анимаций до {C:mult}#2#{}",
				},
			},
			-- Vars: [keybind for Quick buy/sell], ["Dangerous" modifier], ["All copies" modifier]
			sell_all_same = {
				unlock = { "Продать все", "копии карты" },
				text = {
					"Удерж. {C:mult}#2#{},",
					"удерж. {C:mult}#1#{},",
					"и кликните на карту чтобы",
					"продать все её копии",
				},
			},
			-- Vars: ["Dangerous" modifier], ["Sell ALL" modifier]
			sell_all = {
				unlock = { "Продать ВСЕ" },
				text = {
					"Удерж. {C:mult}#1#{} чтобы",
					"продать {C:attention}ВСЕ{} карты в области",
				},
			},
			-- Vars: ["Dangerous" modifier], ["REMOVE" modifier], [Quick buy/sell], ["All copies" modifier], ["ALL" modifier]
			card_remove = {
				unlock = { "УДАЛИТЬ* карты", "или тэги" },
				text = {
					"Удерж. {C:mult}#1#{} чтобы",
					"{C:attention,E:1}УДАЛИТЬ{} карты {C:handy_secondary}(или тэги){}",
				},
			},
			controller_swap_cursor_stick = {
				unlock = { "Контроллер: поменять", "поведение стиков" },
				text = {
					"Поменять местами поведение",
					"Левого и Правого стиков",
				},
			},
			controller_sensivity = {
				unlock = { "Контроллер:", "чувствительность курсора" },
				text = {
					"Разрешить настраивать",
					"чувствительность курсора контроллера",
				},
			},
		},
		Handy_ConfigPopup = {
			debugplus_prevent = {
				text = {
					"Требуется мод {C:attention}DebugPlus{} и включённая",
					"настройка {C:attention}CTRL for Keybinds{}",
				},
			},
			regular_keybinds = {
				text = {
					"Сыграть или сбросить руку, сортировка руки",
					"Обновить или покинуть магазин, Информация о забеге",
					"Пропустить или выбрать блайнд, Просмотр колоды",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight = {
				text = {
					"Если назначено на {C:chips}#1#{},",
					"начните удерж. {C:attention}НА ПУСТОМ МЕСТЕ{}",
					"а затем наводитесь на карты чтобы выделить их",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight_gamepad = {
				text = {
					"Работает и для курсора, и для выделения",
					"с помощью кнопок движения",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight_OUTSIDE = {
				text = {
					"Для назначений кроме {C:chips}#2#{},",
					"можно начинать удерживать клавишу",
					"пока наводишься на карту тоже",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight_OUTSIDE_gamepad = {
				text = {
					"Работает и для курсора, и для выделения",
					"с помощью кнопок движения",
				},
			},
			-- Vars: [Fast hand selection]
			insta_unhighlight = {
				text = {
					"Выделять карты, если первая не была выделена.",
					"Снимать выделение, если первая карта была выделена.",
				},
			},
			-- Vars: [Right Mouse]
			deselect_hand_desktop = {
				text = {
					"Заменяет ванильный {C:chips}#2#{}",
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
			move_highlight_gamepad = {
				text = {
					"{C:mult}Не действует на геймпаде{}",
				},
			},
			-- Vars: [keybind for Multiply], [keybind for Divide], min value, max value
			speed_multiplier = {
				text = {
					"Скорость игры может быть изменена",
					"от {C:attention}#4#{} до {C:attention}#5#{}",
				},
			},
			-- Vars: [keybind for Increase], [keybind for Decrease], [Danger zone tab]
			nopeus_interaction = {
				text = {
					"Требуется мод {C:attention}Nopeus{}",
					" ",
					"{C:mult}Unsafe{} значение должно быть",
					"включено во вкладке {C:attention}#4#{}",
				},
			},
			-- Vars: [keybind for Increase], [keybind for Decrease], [Danger zone tab], None, Messages, Animations, Everything, Unsafe, [Danger zone tab]
			animation_skip = {
				text = {
					"5 уровней пропуска анимации",
					" ",
					"{C:attention}#4#{} - стандартное поведение гры",
					"{C:attention}#5#{} - убраны тексты над картами ({C:attention}Ещё раз!{} and {C:chips}+Фишки{})",
					"{C:attention}#6#{} - моментальный подсчёт, убраны анимации карт",
					"{C:attention}#7#{} - убраны ненужные анимации, моментальное доставание карт и рестарт",
					"{C:mult}#8#{} - абсолютный лимит игры: всё моментально",
					" ",
					"{C:mult}#8#{} значение должно быть включено во вкладке {C:attention}#9#{}",
				},
			},
			scoring_hold = {
				text = {
					"Полезно для перемещения джокеров или",
					"просмотра очков перед концом раунда",
					"на высокой скорости игры или с",
					"выключенными анимациями",
				},
			},
			not_just_yet_interaction = {
				text = {
					"Требуется мод {C:attention}NotJustYet{}",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_or_sell_desktop = {
				text = {
					"Использование определяет",
					"{C:attention}#2#{}",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_or_sell_gamepad = {
				text = {
					"Заменяет ванильный {C:chips}#3#{}",
					"но работает идентично и может",
					"быть переназначен на другую кнопку",
					" ",
					"Снимите галочку чтобы использовать",
					"ванильное управление",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_n_sell_desktop = {
				text = {
					"Использование определяет",
					"{C:attention}#2#{}",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_use_desktop = {
				text = {
					"Использование определяет",
					"{C:attention}#2#{}",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_use_gamepad = {
				text = {
					"Заменяет ванильный {C:chips}#3#{}",
					"но работает идентично и может",
					"быть переназначен на другую кнопку",
					" ",
					"Снимите галочку чтобы использовать",
					"ванильное управление",
				},
			},
			-- Vars: Buy/Sell/Use mode
			cryptid_code_use_last_interaction = {
				text = {
					"Требуется мод {C:attention}Cryptid{}",
					" ",
					"Использует Код-карту и выбирает вариант",
					"{C:green}[Input previous value]{} для таких карт как:",
					"{C:green}://VARIABLE{}, {C:green}://CLASS{}, {C:green}://EXPLOIT{}",
					" ",
					"Использование определяет",
					"{C:attention}#2#{}",
				},
			},
			-- Vars: Buy/Sell/Use mode
			cryptid_code_use_last_interaction_gamepad = {
				text = {
					"Требуется мод {C:attention}Cryptid{}",
					" ",
					"Использует Код-карту и выбирает вариант",
					"{C:green}[Input previous value]{} для таких карт как:",
					"{C:green}://VARIABLE{}, {C:green}://CLASS{}, {C:green}://EXPLOIT{}",
				},
			},
			insta_highlight_entire_f_hand = {
				text = {
					"Выбирает максимальное количество",
					"карт в руке, слева направо",
				},
			},
			-- Vars: [keybind for Quick buy/sell], [Quick buy/sell], ["Dangerous" modifier]
			immediate_buy_and_sell = {
				text = {
					"Удерж. {C:mult}#3#{}, {C:chips}#4#{},",
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
					"{C:attention}Всегда активно на геймпаде{}",
				},
			},
			speed_multiplier_uncap = {
				text = {
					"{C:mult}Очень сильно влияет на производительность{}",
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
			-- Vars: [keybind for Quick buy/sell], ["Dangerous" modifier], ["All copies" modifier]
			sell_all_same = {
				text = {
					"Удерж. {C:mult}#3#{}, {C:mult}#4#{},",
					"и нажмите на карту чтобы продать все её копии",
				},
			},
			-- Vars: ["Dangerous" modifier], ["Sell ALL" modifier]
			sell_all = {
				text = {
					"Удерж. {C:mult}#2#{}, {C:mult}#3#{},",
					"и нажмите на карту чтобы продать {C:attention}ВСЕ{} карты в области",
				},
			},
			-- Vars: ["Dangerous" modifier], ["REMOVE" modifier], [Quick buy/sell], ["All copies" modifier], ["ALL" modifier]
			card_remove = {
				text = {
					"При удерж. карты {C:attention}или тэги{} будут {C:attention,E:1}УДАЛЕНЫ{}",
					" ",
					"Удерж. {C:mult}#2#{}, {C:mult}#3#{},",
					"{C:chips}#4#{} и наводитесь на карты",
					"чтобы {C:attention,E:1}УДАЛИТЬ{} их (очередь тоже работает)",
					" ",
					"Удерж. {C:mult}#2#{}, {C:mult}#3#{},",
					"{C:mult}#5#{} и нажмите на карту {C:attention}или тэг{}",
					"чтобы {C:attention,E:1}УДАЛИТЬ{} все их копии",
					" ",
					"Удерж. {C:mult}#2#{}, {C:mult}#3#{},",
					"{C:mult}#6#{}, и нажмите на карту {C:attention}или тэг{}",
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
			["None"] = "Нет",
			["Unknown"] = "Неизв.",
		},
		handy_keybind_labels = {
			play_hand = "Сыграть руку",
			discard = "Сбросить руку",
			toggle_sort = "Переключить сортировку",
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
			reroll_boss = "Переброс босс-блайнда",
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
			speed_multiplier_multiply = "Множитель скорости: Умножить",
			speed_multiplier_divide = "Множитель скорости: Поделить",
			nopeus_interaction = "Nopeus: fast-forward",
			nopeus_interaction_increase = "Nopeus: Увеличить",
			nopeus_interaction_decrease = "Nopeus: Уменьшить",
			animation_skip = "Пропуск анимаций",
			animation_skip_increase = "Пропуск анимаций: Увеличить",
			animation_skip_decrease = "Пропуск анимаций: Уменьшить",
			move_highlight_one_left = "Передвинуть один налево",
			move_highlight_one_right = "Передвинуть один направо",
			move_highlight_move_card = "Передвигать карту",
			move_highlight_to_end = "Передвинуть на край области",
			scoring_hold = "Пауза анимации подсчёта",

			dangerous_modifier = '"Опасный" модификатор',
			dangerous_all_same_modifier = '"Все копии" модификатор',
			dangerous_all_modifier = '"ВСЕ" модификатор',
			dangerous_remove_modifier = '"УДАЛИТЬ" модификатор',

			presets_load_1 = "Загрузить профиль 1",
			presets_load_2 = "Загрузить профиль 2",
			presets_load_3 = "Загрузить профиль 3",
			presets_load_next = "Загрузить след. профиль",

			misc_open_mod_settings = "Открыть настройки мода",
			misc_crash = "Крашнуть игру",
			misc_save_run = "Сохранить игру",
			misc_quick_restart = "Быстрый рестарт",
			misc_start_fantoms_preview = "Fantom's Preview: Расчёт",
		},
		handy_keybind_sections = {
			hand = "Рука",
			round = "Раунд",
			shop = "Магазин",
			blinds = "Блайнды",
			menus = "Меню",
			quick_actions = "Быстрые действия",
			gamespeed = "Скорость игры",
			animations = "Анимации",
			highlight_movement = "Передвижение выделения",
			shop_and_blinds = "Магазин и блайнды",
			gamespeed_and_animations = "Скорость игры и анимации",
			hand_selection = "Выделение руки",
			presets = "Профили",
			dangerous_actions = "Опасные действия",
			misc = "Прочее",
		},
		handy_tabs = {
			["Overall"] = "Основные & Ванилла",
			["Quick"] = "Быстрые действия",
			["Keybinds"] = "Основные назначения",
			["Keybinds 2"] = "Другие назначения",
			["Dangerous"] = "Опасная зона",
			["Presets"] = "Профили",
			["Keybinds Paginated"] = "Назначения",
			["Search"] = "Поиск",
		},
		v_dictionary = {
			Handy_module_keys_single = "[#1#]",
			Handy_module_keys_or = "[#1#] или [#2#]",
			Handy_items_in_queue = "[#1# в очереди]",
			Handy_gamespeed_multiplier = "Множитель скорости: #1#",
			Handy_event_queue_retriggers_amount = "Множитель игровых действий: #1#",
			Handy_nopeus_fastforward = "Nopeus fast-forward: #1#",
			Handy_animation_skip = "Пропуск анимаций: #1#",
			Handy_skip_booster_pack = "Пропустить бустерный набор",

			Handy_scoring_hold = "Пауза анимации подсчёта",

			Handy_hand_sorting = "Сортировка руки: #1#",

			Handy_preset_index = "Профиль #1#",
			Handy_preset_loaded = "Профиль #1# [#2#] загружен",
			Handy_preset_empty = "Профиль #1# [#2#] пуст",
			Handy_preset_disabled = "Профиль #1# [#2#] выключен",
			Handy_preset_nothing_to_load = "Нет профилей для загрузки",

			Handy_overall_guide_button = 'Каждая настройка может быть назначена на мышь, колёсико мыши или клавиатуру во вкладке "#1#".',
			Handy_overall_guide_gamepad = 'Каждая настройка может быть назначена на любую кнопку геймпада во вкладке "#1#".',
			Handy_popups_guide = "Наводитесь на настройки чтобы узнать о них больше.",
			Handy_popups_guide_gamepad = "Перемещайтесь между настройками чтобы узнать о них больше.",
			Handy_search_guide = 'Используйте вкладку "#1#" для поиска.',
			Handy_keybinds_guide_desktop = "Нажмите на кнопку и следующее введённое нажатие будет назначено. #1# чтобы убрать.",
			Handy_keybinds_guide_gamepad = "#2# и следующее введённое нажатие будет назначено. #1# чтобы убрать.",
			Handy_presets_guide = "Профиль - набор настроек и назначений, которые могут быть загружены в любой момент",
			Handy_danger_zone_guide = "*УДАЛИТЬ карту/тэг - убрать без каких-либо проверок, эффектов, триггеров или возврата денег..",

			Handy_default_value = "#1#: значение по старте игры",
		},
		dictionary = {
			handy_or = "или",

			ph_handy_premade_presets = "Пре-созданные профили",
			ph_handy_custom_presets = "Пользовательские профили",

			b_handy_preset_save = "Сохранить",
			b_handy_preset_load = "Загрузить",
			b_handy_preset_clear = "Очистить",

			handy_preset_name_placeholder = "Название профиля",

			b_handy_notif_quick = "Быстрые действия",
			b_handy_notif_dangerous = "Опасные действия",

			b_handy_search_placeholder = "Поиск...",
			b_handy_search = "Искать",
			b_handy_clear = "Очистить",
			ph_handy_search_no_results = 'Используйте ключевые слова (на английском), такие как "more speed", "animations", "sell" и др.',

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
			ph_handy_notif_animation_skip_unsafe_disabled = "Небезопасное значение выключено в настройках мода",
			ph_handy_notif_cannot_bind_non_holdable = "Нельзя назначить колёсико мыши здесь",
			ph_handy_notif_cannot_bind_non_safe = "Нельзя назначить эту кнопку здесь",

			ph_handy_notif_misc_save_run_start = "Старт сохранения...",
			ph_handy_notif_misc_save_run_saving = "Сохранение...",
			ph_handy_notif_misc_save_run_saved = "Сохранено",
			ph_handy_notif_misc_save_run_interrupt = "Нельзя сохраниться сейчас",

			handy_animation_skip_levels = {
				[1] = "Нет",
				[2] = "Надписи карт",
				[3] = "Анимации",
				[4] = "Все",
				[5] = "Небезопасно",
			},

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

			b_handy_device_select = "Устройство ввода",
			handy_device_opt = {
				[1] = "Автоматически",
				[2] = "Мышь + Клавиатура",
				[3] = "Геймпад",
			},
		},
	},
}
