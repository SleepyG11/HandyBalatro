return {
	descriptions = {
		Handy_ConfigDictionary = {
			-- [Version, Author]
			general = {
				name = "Handy v#1# от #2#",
				text = {},
			},

			-- []
			handy = {
				name = "Глобальный переключатель мода",
				text = {
					"Снимите флажок, чтобы отключить ВСЕ функции мода",
				},
				unlock = {
					"Любое управление можно включать/отключать",
					"в {C:attention}любой момент{} без",
					"перезапуска игры или перезагрузки забега",
				},
			},

			-- []
			keybinds_trigger_mode = {
				name = "Режим срабатывания биндов",
				text = {},
			},
			-- [Auto]
			current_device = {
				name = "Устройство ввода",
				text = { "Мышь + клавиатура или геймпад" },
				unlock = {
					"Мод использует отдельные раскладки биндов",
					"для {C:attention}мыши + клавиатуры{} и {C:attention}геймпада{}",
					"и переключается между ними в зависимости",
					"от того, каким устройством вы пользуетесь сейчас",
					"{C:inactive}(если выбран мод «#1#»){}",
				},
			},
			-- [Ctrl]
			prevent_if_debugplus = {
				name = "DebugPlus: предотвращать пересечения",
				text = {},
				unlock = {
					"Не выполнять действия, пока удерживается {C:chips}#1#{}",
					"чтобы избежать пересечений с",
					"управлением {C:attention}DebugPlus{}",
					" ",
					'Требует, чтобы {C:attention}"CTRL for Keybinds"{} был',
					"включён в настройках мода",
					" ",
					"Побочный эффект: бинды",
					"с кнопкой {C:chips}#1#{} станут {C:mult}недоступны{}",
				},
			},

			-- []
			gamepad = {
				name = "Настройки геймпада",
				text = {},
			},
			-- [Right stick, Left stick]
			swap_controller_cursor_stick = {
				name = "Геймпад: поменять стик курсора",
				text = {},
				unlock = {
					"По умолчанию {C:chips}#1#{} активирует",
					"встроенный игровой курсор.",
					" ",
					"Эта настройка переключает его на {C:chips}#2#{}",
				},
			},
			-- []
			controller_sensitivity = {
				name = "Геймпад: чувствительность курсора",
				text = {},
			},

			-- []
			appearance = {
				name = "Внешний вид",
				text = {},
			},
			-- []
			hide_options_button = {
				name = "Скрыть кнопку мода в настройках",
				text = {},
			},
			-- []
			notifications_level = {
				name = "Уведомления",
				text = {},
			},
			-- []
			speed_multiplier_settings_toggle = {
				name = "Множитель скорости: переключатель в настройках",
				text = {},
				unlock = {
					"Размещено рядом с ванильной настройкой {C:attention}Скорость игры{}",
				},
			},
			-- []
			animation_skip_settings_toggle = {
				name = "Пропуск анимаций: переключатель в настройках",
				text = {},
				unlock = {
					"Размещено рядом с ванильной настройкой {C:attention}Скорость игры{}",
				},
			},
			-- []
			show_custom_pip = {
				name = "Показывать бинды на кнопках",
				text = {},
				unlock = {
					"Визуально показывать бинды на",
					"кнопках, которые они активируют",
					"{C:inactive}(Сыграть руку, Сбросить, Инфо забега, Реролл и т. д.){}",
				},
			},

			-- []
			updater = {
				name = "Автообновление мода",
				text = { "Я знаю, что тебе лень" },
			},
			-- []
			updater_target_release_type = {
				name = "Целевой релиз",
				text = {},
			},
			-- []
			updater_notify_about_new_update = {
				name = "Уведомлять о новом обновлении",
				text = {},
				unlock = {
					"Вы увидите уведомление при {C:attention}запуске игры{}",
				},
			},
			-- []
			updater_auto_install_new_update = {
				name = "Автоматически устанавливать обновление",
				text = {},
				unlock = {
					"Обновление будет установлено при {C:attention}запуске игры{}",
				},
			},
			-- []
			updater_auto_restart_game_after_update = {
				name = "Автоматически перезапускать игру после обновления",
				text = {},
			},

			-- [@lord.ruby]
			me = {
				name = "Привет, это Я! Я буду следовать за тобой...",
				text = {
					"Арт: {C:mult}#1#{}",
				},
			},
			-- []
			me_in_mod_config = {
				name = "...в настройках мода",
				text = {},
			},
			-- []
			me_in_game_over = {
				name = "...на экране проигрыша",
				text = {},
			},
			-- []
			me_in_game_win = {
				name = "...на экране победы",
				text = {},
			},
			-- []
			me_in_screenswipe = {
				name = "...на карте перехода экрана",
				text = {},
			},

			-- []
			hand_selection = {
				name = "Выбор и снятие выбора карт",
				text = {
					"Выбор свайпом и многое другое",
				},
			},
			-- [Left Mouse, Hand deselection]
			hand_selection_mode = {
				name = "Реализация выбора руки",
				text = {
					"Выберите мод, которым пользовались раньше",
				},
				unlock = {
					"Влияет на некоторые нюансы того, как",
					"работают {C:attention}выбор{} и {C:attention}снятие выбора{} карт в руке",
					"при использовании клавиши, отличной от {C:chips}#1#{}",
					"и/или если {C:chips}#2#{} имеет тот же бинд:",
					" ",
					"{C:attention}Handy{} — выбирать сразу, нельзя снять выбор",
					"{C:attention}BMaG{} — выбирать после движения, снимать выбор при отпускании",
				},
			},
			-- [Left mouse]
			hand_selection_insta_highlight = {
				name = { "Быстрый выбор карт в руке" },
				text = {
					"Тяните, наведите, свайпайте или скользите, чтобы выбрать",
				},
				unlock = {
					"Если назначено на {C:chips}#1#{},",
					"начните удерживание {C:attention}ВНЕ{} карт",
					"а затем наведите на них, чтобы выбрать",
					"{C:inactive}(иначе вы схватите карту){}",
				},
			},
			-- []
			hand_selection_insta_highlight_allow_deselect = {
				name = { "Быстрое снятие выбора карт" },
				text = {},
				unlock = {
					"{C:inactive}Когда вы наводите на карты:{}",
					"Если {C:attention}первая{} карта {C:mult}не была{} выбрана — {C:chips}выбирать{} карты",
					"Если {C:attention}первая{} карта {C:chips}была{} выбрана — {C:mult}снимать выбор{} с карт",
				},
			},
			-- []
			hand_selection_combine_select_deselect = {
				name = { "Совмещённый выбор и снятие выбора" },
				text = {},
				unlock = {
					"{C:inactive}Когда вы наводите на карты:{}",
					"Если карта {C:mult}не{} выбрана — {C:chips}выбрать{} её",
					"Если карта {C:chips}выбрана{} — {C:mult}снять выбор{}",
				},
			},
			-- [Right mouse]
			hand_selection_deselect_hand = {
				name = { "Снять выбор с руки" },
				text = {
					"Ванильный #1#",
				},
			},
			-- []
			hand_selection_entire_f_hand = {
				name = { "Выбрать всю руку" },
				text = {},
				unlock = {
					"Выбрать {C:attention}максимально возможное{} количество",
					"карт слева направо",
				},
			},

			-- [None, Messages, Animations, Everything]
			animation_skip = {
				name = "Пропуск анимаций",
				text = {
					"Убрать анимации подсчёта и другие игровые анимации",
				},
				unlock = {
					"Прямая замена такой же функции",
					"из модов вроде {C:attention}Talisman{}, {C:attention}Saturn{} или {C:attention}Nopeus{}",
					" ",
					"Имеет 4 уровня:",
					"{C:chips}#1#{} — без изменений",
					"{C:chips}#2#{} — без {C:mult}XMult{}, {C:attention}Ещё раз!{} и других сообщений срабатывания",
					"{C:attention}#3#{} — мгновенный подсчёт",
					"{C:attention}#4#{} — большинство анимаций убрано; мгновенная доборка карт",
				},
				handy_override_align = {
					unlock = {
						[5] = "cl",
						[6] = "cl",
						[7] = "cl",
						[8] = "cl",
					},
				},
			},
			-- []
			animation_skip_current_value = {
				name = "Пропуск анимаций: текущее значение",
				text = {},
			},
			-- []
			animation_skip_default_value = {
				name = "Пропуск анимаций: значение при запуске игры",
				text = {},
			},
			-- []
			animation_skip_increase = {
				name = { "Пропуск анимаций: увеличить" },
				text = {},
			},
			-- []
			animation_skip_decrease = {
				name = { "Пропуск анимаций: уменьшить" },
				text = {},
			},
			-- []
			animation_skip_toggle_temp_disabled = {
				name = { "Пропуск анимаций: вкл/выкл" },
				text = {},
			},
			-- [Unsafe]
			dangerous_actions_animation_skip_unsafe = {
				name = { "Пропуск анимаций: небезопасно" },
				text = {},
				unlock = {
					"Разрешить увеличение до уровня {C:mult}#1#{}",
					" ",
					"{C:mult}Абсолютный предел игры: всё моментальное{}",
				},
			},

			-- [x128]
			speed_multiplier = {
				name = "Множитель скорости",
				text = {
					"Увеличить скорость игры",
				},
				unlock = {
					"Как следует из названия, {C:attention}умножает{} скорость игры,",
					"поэтому значение по умолчанию всегда {C:attention}1x{}",
					" ",
					"Начиная с {C:attention}#1#{}, ускоряет",
					"{C:attention}очередь анимаций{}, чтобы обойти лимит",
					"в 60 действий в секунду",
				},
			},
			-- []
			speed_multiplier_current_value = {
				name = "Множитель скорости: текущее значение",
				text = {},
			},
			-- []
			speed_multiplier_default_value = {
				name = "Множитель скорости: значение при запуске игры",
				text = {},
			},
			-- []
			speed_multiplier_multiply = {
				name = { "Множитель скорости: увеличить" },
				text = {},
			},
			-- []
			speed_multiplier_divide = {
				name = { "Множитель скорости: уменьшить" },
				text = {},
			},
			-- []
			speed_multiplier_toggle_temp_disabled = {
				name = { "Множитель скорости: переключить" },
				text = {},
			},
			-- [x200k]
			dangerous_actions_speed_multiplier_uncap = {
				name = { "Множитель скорости: снять лимит" },
				text = {},
				unlock = {
					"Повышает максимальный лимит скорости до {C:mult}#1#{}",
					" ",
					"{C:mult}Сильно влияет на производительность на очень больших значениях{}",
				},
			},

			-- []
			move_highlight = {
				name = "Точный выбор",
				text = {
					"Точный выбор и перемещение карт",
				},
				unlock = {
					"Полезно для управления картами, когда",
					"их много в одной области",
					" ",
					"{C:attention}Выберите{} карту в области",
					"а затем используйте перечисленные действия",
				},
			},
			-- []
			move_highlight_one_left = {
				name = { "Точный выбор: на одну влево" },
				text = {},
				unlock = {
					"Можно {C:attention}удерживать{} этот бинд",
					"чтобы перемещаться быстрее",
				},
			},
			-- []
			move_highlight_one_right = {
				name = { "Точный выбор: на одну вправо" },
				text = {},
				unlock = {
					"Можно {C:attention}удерживать{} этот бинд",
					"чтобы перемещаться быстрее",
				},
			},
			-- []
			move_highlight_swap = {
				name = { "Точный выбор: переместить карту" },
				text = {},
				unlock = {
					"{C:attention}Пока удерживается{}, сама карта",
					"будет перемещаться вместо выделения",
				},
			},
			-- []
			move_highlight_to_end = {
				name = { "Точный выбор: переместить в конец" },
				text = {},
				unlock = {
					"Пока {C:attention}удерживается{}, вместо перемещения выделения/карты",
					"{C:attention}на одну влево/вправо{} будет перемещение к",
					"соответственно {C:attention}самой левой/самой правой{} позиции",
				},
			},

			-- []
			presets = {
				name = "Пресеты конфигурации",
				text = {
					"Конфигурации, между которыми легко переключаться",
				},
			},
			-- []
			presets_load_1 = {
				name = { "Пресеты: загрузить пресет 1" },
				text = {},
			},
			-- []
			presets_load_2 = {
				name = { "Пресеты: загрузить пресет 2" },
				text = {},
			},
			-- []
			presets_load_3 = {
				name = { "Пресеты: загрузить пресет 3" },
				text = {},
			},
			-- []
			presets_load_next = {
				name = { "Пресеты: загрузить следующий пресет" },
				text = { "1 -> 2 -> 3 -> 1" },
				unlock = {
					"Пропускает пустые или отключённые пресеты",
				},
			},

			-- []
			insta_actions = {
				name = "Быстро купить/продать/использовать",
				text = {
					"Экономьте клики и используйте карты быстрее",
				},
			},
			-- []
			insta_actions_trigger_mode = {
				name = "Режим купить/продать/использовать",
				text = {},
			},
			-- [Buy/Sell/Use mode]
			insta_actions_buy_or_sell = {
				name = { "Быстро купить/продать карту" },
				text = {},
				unlock = {
					"{C:attention}#1#{} определяет использование",
					" ",
					"{C:attention}Удерживайте{} бинд и {C:attention}кликните{} по карте",
					"чтобы купить {C:inactive}(из магазина){} или выбрать {C:inactive}(из бустер-пака){}",
					"или продать {C:inactive}(из слотов джокеров/расходников){}",
				},
			},
			-- [Buy/Sell/Use mode]
			insta_actions_buy_or_sell_alt = {
				name = { "Быстро купить/продать карту" },
				text = {},
				unlock = {
					"{C:attention}#1#{} определяет использование",
					" ",
					"{C:attention}Наведите/схватите{} карту и {C:attention}нажмите{} бинд",
					"чтобы купить {C:inactive}(из магазина){} или выбрать {C:inactive}(из бустер-пака){}",
					"или продать {C:inactive}(из слотов джокеров/расходников){}",
				},
			},
			-- [Buy/Sell/Use mode]
			insta_actions_buy_n_sell = {
				name = { "Быстро купить и продать карту" },
				text = { "Купить и сразу же продать" },
				unlock = {
					"{C:attention}#1#{} определяет использование",
					" ",
					"{C:attention}Удерживайте{} бинд и {C:attention}кликните{} по карте",
					"чтобы купить {C:inactive}(из магазина){} или выбрать {C:inactive}(из бустер-пака){}",
					"и {C:attention}сразу продать{} после этого",
				},
			},
			-- [Buy/Sell/Use mode]
			insta_actions_buy_n_sell_alt = {
				name = { "Быстро купить и продать карту" },
				text = { "Купить и сразу после этого продать" },
				unlock = {
					"{C:attention}#1#{} определяет использование",
					" ",
					"{C:attention}Наведите/схватите{} карту и {C:attention}нажмите{} бинд",
					"чтобы купить {C:inactive}(из магазина){} или выбрать {C:inactive}(из бустер-пака){}",
					"и {C:attention}сразу продать{} после этого",
				},
			},
			-- [Buy/Sell/Use mode]
			insta_actions_use = {
				name = { "Быстро использовать карту" },
				text = {},
				unlock = {
					"{C:attention}#1#{} определяет использование",
					" ",
					"{C:attention}Удерживайте{} бинд и {C:attention}кликните{} карту",
					"чтобы использовать её {C:inactive}(если возможно){}",
				},
			},
			-- [Buy/Sell/Use mode]
			insta_actions_use_alt = {
				name = { "Быстро использовать карту" },
				text = {},
				unlock = {
					"{C:attention}#1#{} определяет использование",
					" ",
					"{C:attention}Наведите/схватите{} карту и {C:attention}нажмите{} бинд",
					"чтобы использовать её {C:inactive}(если возможно){}",
				},
			},
			-- insta_actions_cryptid_code_use_last_interaction = {
			-- 	name = { 'Cryptid: Code card\'s "Use previous"' },
			-- 	text = {},
			-- 	unlock = {
			-- 		"Applicable only for cards from {C:attention}Cryptid{}:",
			-- 		"{C:green}://VARIABLE{}, {C:green}://CLASS{}, {C:green}://EXPLOIT{}",
			-- 		" ",
			-- 		"Usage determined by {C:attention}#1#{}",
			-- 		" ",
			-- 		"{C:attention}Hold{} keybind and {C:attention}click{} card",
			-- 		'to execute "Use previous" option',
			-- 	},
			-- },
			-- insta_actions_cryptid_code_use_last_interaction_alt = {
			-- 	name = { 'Cryptid: Code card\'s "Use previous"' },
			-- 	text = {},
			-- 	unlock = {
			-- 		"Applicable only for cards from {C:attention}Cryptid{}:",
			-- 		"{C:green}://VARIABLE{}, {C:green}://CLASS{}, {C:green}://EXPLOIT{}",
			-- 		" ",
			-- 		"Usage determined by {C:attention}#1#{}",
			-- 		" ",
			-- 		"{C:attention}Hover/grab{} card and {C:attention}press{} keybind",
			-- 		'to execute "Use previous" option',
			-- 	},
			-- },

			-- []
			scoring_hold = {
				name = { "Удержание анимации подсчёта" },
				text = {},
				unlock = {
					"{C:attention}Удерживайте{}, чтобы поставить анимации подсчёта на паузу",
					"{C:attention}до{} расчёта итоговых очков руки",
					" ",
					"Полезно для перестановки джокеров перед концом раунда",
				},
			},
			-- []
			scoring_hold_any_moment = {
				name = { "Удержание анимации подсчёта: любой момент" },
				text = {},
				unlock = {
					"{C:attention}Удерживайте{}, чтобы поставить анимации подсчёта на паузу",
					"в {C:attention}любой момент{} подсчёта",
				},
			},

			-- []
			regular_keybinds = {
				name = "Стандартные и ванильные бинды",
				text = {
					"Все действия из базовой игры и не только",
				},
			},

			-- []
			regular_keybinds_group_game = {
				name = "Забег",
				text = {},
			},
			-- [R]
			regular_keybinds_restart = {
				name = { "Перезапустить забег" },
				text = { "Ванильный #1#" },
			},
			-- [R]
			regular_keybinds_quick_restart = {
				name = { "Мгновенный перезапуск забега" },
				text = { "Ванильный #1#, но мгновенно" },
				unlock = {
					"Работает также с экрана {C:attention}Проигрыша{}",
				},
			},
			-- []
			regular_keybinds_save_run = {
				name = { "Сохранить забег" },
				text = {
					"Автосохранение, но вручную",
				},
				unlock = {
					"Игра автоматически сохраняет забег после некоторых действий",
					"{C:inactive}(например: сыграть руку, сбросить, реролл магазина){}",
					" ",
					"Этот бинд позволяет сделать это вручную",
				},
			},
			-- []
			regular_keybinds_reload_run = {
				name = { "Загрузить забег" },
				text = {
					"Главное меню -> Продолжить забег",
				},
				unlock = {
					"Имитирует выход в главное меню",
					"а затем продолжение забега",
					"с {C:attention}пропущенной анимацией{}",
				},
			},
			-- []
			regular_keybinds_restart_game = {
				name = "Перезапустить Balatro",
				text = {},
			},
			-- []
			regular_keybinds_copy_log_file = {
				name = { "Скопировать лог Lovely" },
				text = {},
				unlock = {
					"Из-за технических ограничений лог",
					"копируется {C:attention}как текст{}, а не как файл",
				},
			},

			-- []
			regular_keybinds_group_hand = {
				name = "Рука",
				text = {},
			},
			-- []
			regular_keybinds_play = {
				name = { "Сыграть руку" },
				text = {},
			},
			-- []
			regular_keybinds_discard = {
				name = { "Сбросить руку" },
				text = {},
			},
			-- []
			regular_keybinds_change_sort_rank = {
				name = { "Сортировать руку по рангу" },
				text = {},
			},
			-- []
			regular_keybinds_change_sort_suit = {
				name = { "Сортировать руку по масти" },
				text = {},
			},
			-- []
			regular_keybinds_toggle_sort = {
				name = { "Переключить сортировку руки" },
				text = { "Масть > Ранг > Масть..." },
			},

			-- []
			regular_keybinds_group_round = {
				name = "Раунд",
				text = {},
			},
			-- []
			regular_keybinds_start_fantoms_preview = {
				name = { "Fantom's Preview: рассчитать очки руки" },
				text = {},
			},
			-- []
			regular_keybinds_cash_out = {
				name = { "Обналичить" },
				text = {},
				unlock = {
					"{C:attention}Удерживайте{} бинд, чтобы пропустить",
					"как только это станет доступно",
				},
			},
			-- []
			regular_keybinds_not_just_yet_interaction = {
				name = { "NotJustYet: завершить раунд" },
				text = {},
			},

			-- []
			regular_keybinds_group_shop = {
				name = "Магазин",
				text = {},
			},
			-- []
			regular_keybinds_skip_booster = {
				name = { "Пропустить бустер-пак" },
				text = {},
				unlock = {
					"{C:attention}Удерживайте{} бинд, чтобы пропустить бустер-пак",
					"как только это станет доступно",
					" ",
					"{C:attention}Продолжайте удерживать{} бинд, чтобы пропустить несколько",
					"бустер-паков {C:attention}подряд{}",
				},
			},
			-- []
			regular_keybinds_reroll_shop = {
				name = { "Реролл магазина" },
				text = {},
			},
			-- []
			regular_keybinds_leave_shop = {
				name = { "Покинуть магазин" },
				text = {},
			},
			-- []
			regular_keybinds_group_blind_select = {
				name = "Выбор блайнда",
				text = {},
			},

			-- []
			regular_keybinds_skip_blind = {
				name = { "Пропустить блайнд" },
				text = {},
			},
			-- []
			regular_keybinds_select_blind = {
				name = { "Выбрать блайнд" },
				text = {},
			},
			-- []
			regular_keybinds_reroll_boss = {
				name = { "Реролл босс-блайнда" },
				text = {},
			},

			-- []
			regular_keybinds_group_menus = {
				name = "Меню",
				text = {},
			},
			-- []
			regular_keybinds_mod_settings = {
				name = { "Handy: настройки мода" },
				text = {},
			},
			-- []
			regular_keybinds_show_deck_preview = {
				name = { "Предпросмотр колоды" },
				text = { "Тоже самое что и при наведении на колоду" },
			},
			-- [Escape]
			regular_keybinds_options = {
				name = { "Настройки" },
				text = { "То же, что #1#" },
			},
			-- []
			regular_keybinds_collection = {
				name = { "Коллекция" },
				text = {},
			},

			-- []
			regular_keybinds_group_swappable_menus = {
				name = "Внутриигровые меню",
				text = {},
				unlock = {
					"Можно перемещаться между меню с помощью",
					"биндов {C:attention}не закрывая{} их",
				},
			},
			-- []
			regular_keybinds_swappable_overlays_mode = {
				name = "Режим внутриигровых меню",
				text = {},
			},
			-- []
			regular_keybinds_run_info = {
				name = { "Инфо забега: покерные руки" },
				text = {},
			},
			-- []
			regular_keybinds_run_info_blinds = {
				name = { "Инфо забега: блайнды" },
				text = {},
			},
			-- []
			regular_keybinds_view_deck = {
				name = { "Открыть колоду" },
				text = {},
			},
			-- []
			regular_keybinds_view_lobby_info = {
				name = { "Multiplayer: информация лобби" },
				text = {},
			},

			-- []
			dangerous_actions = {
				name = "Опасные действия",
				text = {
					"Когда в забеге полный завал",
				},
			},
			-- []
			dangerous_actions_sell_one = {
				name = { "Мгновенная продажа" },
				text = {},
				unlock = {
					"{C:attention}Удерживайте{} бинд и начните {C:attention}наводить{}",
					"на карты, которые хотите продать",
					" ",
					"Пока {C:attention}удерживаете{}, объекты под курсором добавляются в список",
					"При {C:attention}отпускании{} все они будут проданы",
				},
			},
			-- []
			dangerous_actions_remove_one = {
				name = { "Мгновенное удаление" },
				text = { "Также работает с тегами" },
				unlock = {
					"{C:attention}Удерживайте{} бинд и начните {C:attention}наводить{}",
					"на карты/теги, которые хотите {C:mult}удалить{}",
					" ",
					"Пока {C:attention}удерживаете{}, объекты под курсором добавляются в список",
					"При {C:attention}отпускании{} все они будут {C:mult}удалены{}",
					"{C:inactive}(обходит все проверки, без возврата средств){}",
				},
			},
			-- [Instant sell all same, Instant REMOVE all same, Instant sell all, Instant REMOVE ALL]
			dangerous_actions_mass_sell_remove_mode = {
				name = "Режим массовой продажи/удаления",
				text = {},
				unlock = {
					"Применяется к действиям:",
					"{C:mult}#1#{}",
					"{C:mult}#2#{}",
					"{C:mult}#3#{}",
					"{C:mult}#4#{}",
				},
			},
			-- []
			dangerous_actions_sell_all_same = {
				name = { "Мгновенно продать все такие же" },
				text = {},
				unlock = {
					"{C:attention}Удерживайте{} бинд и {C:attention}кликните{} карту",
					"которую хотите продать",
				},
			},
			-- []
			dangerous_actions_remove_all_same = {
				name = { "Мгновенно удалить все такие же" },
				text = { "Также работает с тегами пропуска" },
				unlock = {
					"{C:attention}Удерживайте{} бинд и {C:attention}кликните{} карту/тег",
					"которые хотите {C:mult}удалить{}",
					"{C:inactive}(обходит все проверки, без возврата средств){}",
				},
			},
			-- []
			dangerous_actions_sell_all = {
				name = { "Мгновенно продать ВСЁ" },
				text = {},
				unlock = {
					"{C:attention}Удерживайте{} бинд и {C:attention}кликните{} карту",
					"которую хотите продать",
				},
			},
			-- []
			dangerous_actions_remove_all = {
				name = { "Мгновенно удалить ВСЁ" },
				text = { "Также работает с тегами пропуска" },
				unlock = {
					"{C:attention}Удерживайте{} бинд и {C:attention}кликните{} карту/тег",
					"которые хотите {C:mult}удалить{}",
					"{C:inactive}(обходит все проверки, без возврата средств){}",
				},
			},
			-- []
			dangerous_actions_crash = {
				name = { "Крашнуть игру" },
				text = {},
				unlock = {
					"{C:mult}Буквально{}",
				},
			},
			-- []
			dangerous_actions_stack_overflow = {
				name = { "Крашнуть игру: Stack Overflow" },
				text = {},
				unlock = {
					"{C:mult}Буквально{}",
					"{C:mult}Игра зависнет и/или закроется сама{}",
				},
			},

			-- []
			misc = {
				name = "Разное",
				text = {},
			},

			-- []
			mp_extension = {
				name = { "Multiplayer Аддон" },
				text = { "Функции, специфичные для мультиплеера" },
			},

			-- []
			mp_extension_current_lobby = {
				name = { "MP Аддон: текущие настройки лобби" },
				text = {},
			},
			-- [Speed multiplier, Animations skip]
			mp_extension_enabled = {
				name = "Разрешить MP Аддон",
				text = {},
				unlock = {
					"Включая этот флажок, {C:attention}ВЫ{} разрешаете",
					"включить {C:mult}MP Аддон{} в этом лобби",
					" ",
					"Только если у {C:attention}ВСЕХ{} игроков в лобби оно включено,",
					"действия вроде {C:chips}#1#{} и {C:attention}#2#{}",
					"станут доступны для {C:attention}ВСЕХ{} игроков в лобби",
				},
			},
			-- []
			mp_extension_speed_multiplier_mode = {
				name = "Множитель скорости: максимум в лобби",
				text = {},
			},
			-- []
			mp_extension_animation_skip_mode = {
				name = "Пропуск анимаций: максимум в лобби",
				text = {},
			},
			-- []
			mp_extension_dangerous_actions_mode = {
				name = "Опасные действия: режим лобби",
				text = {},
				unlock = {
					"Разрешает включать некоторые {C:mult}опасные действия{}",
					"для массовой продажи",
				},
			},

			-- []
			mp_extension_default_values = {
				name = { "MP Аддон: настройки лобби по умолчанию" },
				text = {},
			},
			-- []
			mp_extension_speed_multiplier_mode_default_value = {
				name = "Множитель скорости: стандартный максимум лобби",
				text = {},
				unlock = {
					"Когда вы {C:attention}создаёте лобби{},",
					"это значение будет установлено по умолчанию",
				},
			},
			-- []
			mp_extension_animation_skip_mode_default_value = {
				name = "Пропуск анимаций: стандартный максимум лобби",
				text = {},
				unlock = {
					"Когда вы {C:attention}создаёте лобби{},",
					"это значение будет установлено по умолчанию",
				},
			},
			-- []
			mp_extension_dangerous_actions_mode_default_value = {
				name = "Опасные действия: стандартный режим лобби",
				text = {},
				unlock = {
					"Когда вы {C:attention}создаёте лобби{},",
					"это значение будет установлено по умолчанию",
				},
			},
			-- []
			mp_extension_enabled_default_value = {
				name = "Разрешить MP Аддон: значение по умолчанию",
				text = {},
				unlock = {
					"Когда вы {C:attention}создаёте лобби или присоединяетесь к нему{},",
					"это значение будет установлено по умолчанию",
				},
			},
		},

		Handy_Preset = {
			["default"] = {
				name = "По умолчанию",
				text = {
					"Управление мода по умолчанию",
				},
			},
			["better_mouse_and_gamepad"] = {
				name = "Better Mouse and Gamepad",
				text = {
					"Управление, похожее на мод Better Mouse and Gamepad",
				},
			},
			["full_default"] = {
				name = "Сбросить по умолчанию",
				text = {
					"Полный сброс конфигурации по умолчанию",
				},
			},
		},
		Handy_Other = {
			overall_title = {
				text = {
					"- Свайпайте, чтобы выделять карты",
					"- Внутриигровые бинды",
					"- Увеличенная скорость игры",
					"- Удаление анимаций",
					"- Поддержка геймпада",
					" ",
					"- Управление можно назначить на {C:chips}любую комбинацию{}",
					"  клавиш клавиатуры, мыши или кнопок геймпада",
					"  и включать/отключать в {C:chips}любой момент{}",
					"  без перезапуска игры или перезагрузки забега",
					"- {C:chips}Не{} отключает достижения",
				},
			},
			missing_deps = {
				text = {
					"Это действие неактивно, пока перечисленные",
					"настройки не включены:",
				},
			},
			cant_use_in_mp = {
				text = {
					"Это действие отключено в {C:mult}мультиплеере{}",
				},
			},
			cant_use_with_gamepad = {
				text = {
					"Это действие отключено на {C:attention}геймпаде{}",
				},
			},
			missing_req_mods = {
				text = {
					"Для работы этого действия требуются другие моды:",
				},
			},
			conflict_mods = {
				text = {
					"Это действие неактивно из-за других модов:",
				},
			},
			mp_lobby_require_all_hint = {
				text = {
					"Все перечисленные настройки лобби действуют только когда",
					"у {C:attention}ВСЕХ{} участников лобби установлен {C:chips}Handy v2.0{} или новее",
				},
			},
			better_mouse_and_gamepad_in_hand_selection = {
				text = {
					"{C:mult,s:1.5}Упс...{}",
					" ",
					"Похоже, установлен {C:attention}Better Mouse and Gamepad{}.",
					"У меня для вас 2 новости: {C:mult}плохая{} и {C:green}хорошая{}.",
					" ",
					"{C:mult}Плохая новость{}: {C:attention}BMaG{} полностью переопределяет выделение карт в руке",
					"от {C:chips}Handy{} и ломает ввод для кнопок вроде",
					"{C:chips}[Wheel Up/Down]{}, {C:chips}[Mouse 3]{}, {C:chips}[Right Mouse]{} и других.",
					" ",
					"{C:green}Хорошая новость{}: в {C:chips}Handy{} реализованы {C:inactive,s:0.75}почти{} все его действия",
					"поэтому можно удалить {C:attention}BMaG{} и ничего не потерять.",
					" ",
					"Или можно продолжить использовать {C:attention}оба мода{}, и в основном всё будет нормально.",
					"{s:0.8}Хоть мне это и не нравится, кто я такой, чтобы указывать, какими модами пользоваться?{}",
				},
			},
		},
	},
	misc = {
		-- You don't need to translate all of them, only necessary ones
		handy_keybinds = {
			-- No button assigned
			["None"] = "Нет",
			-- Button which cannot be recognized
			["Unknown"] = "Неизвестно",

			-- Mouse
			["Left Mouse"] = "Левая кнопка мыши",
			["Right Mouse"] = "Правая кнопка мыши",
			["Middle Mouse"] = "Средняя кнопка мыши",
			["Mouse 4"] = "Кнопка мыши 4",
			["Mouse 5"] = "Кнопка мыши 5",
			["Wheel Up"] = "Колесо вверх",
			["Wheel Down"] = "Колесо вниз",
			-- Controls
			["Escape"] = "Escape",
			["Shift"] = "Shift",
			["Ctrl"] = "Ctrl",
			["Alt"] = "Alt",
			["GUI"] = "GUI", -- Windows button, or CMD for Mac
			["Enter"] = "Enter",
			["Tab"] = "Tab",
			["Backspace"] = "Backspace",
			["Num Lock"] = "Num Lock",
			["Caps Lock"] = "Caps Lock",
			["Scroll Lock"] = "Scroll Lock",
			-- Arrow keys
			["Left"] = "Влево",
			["Right"] = "Вправо",
			["Up"] = "Вверх",
			["Down"] = "Вниз",
			-- Symbols
			["Backquote"] = "Обратная кавычка", -- `
			["Singlequote"] = "Апостроф", -- '
			["Quote"] = "Кавычка", -- "
			["Left Bracket"] = "Левая скобка", -- [
			["Right Bracket"] = "Правая скобка", -- ]
			-- Weird buttons
			["Printscreen"] = "Print Screen",
			["Delete"] = "Delete",
			["Home"] = "Home",
			["Insert"] = "Insert",
			["End"] = "End",
			["Pause"] = "Pause",
			["Help"] = "Help",
			["Sysreq"] = "SysRq",
			["Menu"] = "Menu",
			["Undo"] = "Undo",
			["Mode"] = "Mode",
			["Page Up"] = "Page Up",
			["Page Down"] = "Page Down",
			-- Very weird buttons, did they exist in 21th century?
			["Www"] = "WWW",
			["Mail"] = "Почта",
			["Calculator"] = "Калькулятор",
			["Computer"] = "Компьютер",
			["Appsearch"] = "Поиск приложения",
			["Apphome"] = "Домой приложения",
			["Appback"] = "Назад приложения",
			["Appforward"] = "Вперёд приложения",
			["Apprefresh"] = "Обновить приложение",
			["Appbookmarks"] = "Закладки приложения",
			["Currencyunit"] = "Единица валюты",
			["Application"] = "Приложение",
			["Power"] = "Питание", -- What a heck

			-- Gamepad: buttons
			["(A)"] = "(A)",
			["(B)"] = "(B)",
			["(X)"] = "(X)",
			["(Y)"] = "(Y)",
			["(Back)"] = "(Назад)",
			["(Guide)"] = "(Меню)",
			["(Start)"] = "(Старт)",
			-- Gamepad: directions
			-- In Balatro, Left Stick movement treated as direction buttons
			["(Up)"] = "(Вверх)",
			["(Down)"] = "(Вниз)",
			["(Left)"] = "(Влево)",
			["(Right)"] = "(Вправо)",
			-- Gamepad: sticks, triggers, bumpers and paddles
			["Left Stick"] = "Левый стик", -- Click
			["Right Stick"] = "Правый стик", -- Click
			["Left Bumper"] = "Левый бампер", -- LB
			["Right Bumper"] = "Правый бампер", -- RB
			["Left Trigger"] = "Левый триггер", -- LT
			["Right Trigger"] = "Правый триггер", -- RT
			-- Not supported by current LOVE engine version
			["First Paddle"] = "Первый лепесток", -- P1
			["Second Paddle"] = "Второй лепесток", -- P2
			["Third Paddle"] = "Третий лепесток", -- P3
			["Fourth Paddle"] = "Четвёртый лепесток", -- P4
			["(Misc. Button)"] = "(Доп. кнопка)",
			-- Gamepad: touchpad
			["Touchpad Press"] = "Нажатие тачпада",

			-- Not listed here, but can be added if you ever need:
			-- All english letters uppercase, (Q, W, E, R, T, Y...)
			-- All numbers (1, 2, 3...0)
			-- All F keys (F1, F2, F3...)
			-- All NUM keys (NUM 0 ... NUM 9, NUM Enter, NUM +, NUM -, NUM *, NUM /, NUM .)
			-- Other symbols (. ; / \ - + etc)
		},
		handy_tabs = {
			["Overall"] = "Общее",
			["Presets"] = "Пресеты",
			["Search"] = "Поиск",

			["General"] = "Общее",
			["Fast hand selection"] = "Выделение руки",
			["Speed & Animations"] = "Скорость и анимации",
			["Vanilla keybinds"] = "Бинды",
			["Quick buy/sell/use"] = "Купить, продать и использовать",
			["Highlight movement"] = "Точный выбор",
			["Misc"] = "Разное",
			["Dangerous"] = "Опасная зона",

			["Speed"] = "Скорость",
			["Animations"] = "Анимации",
			["Hold"] = "Удержание",
			["Round"] = "Раунд",
			["Hand & Round"] = "Рука/раунд",
			["Shop & Blind Select"] = "Магазин/блайнды",
			["Game"] = "Игра",
			["Menus"] = "Меню",
			["MP Extension"] = "Мультиплеер",

			["Updater"] = "Обновления мода",
			["Updater Settings"] = "Настройки",
		},
		v_dictionary = {
			Handy_version_by = "v#1# от #2#",
			Handy_module_keys_single = "[#1#]",
			Handy_module_keys_or = "[#1#] или [#2#]",
			Handy_items_in_queue = "[#1# в очереди]",
			Handy_temp_disabled = "[отключено]",
			Handy_disabled_in_mp = "[отключено мультиплеером]",

			Handy_gamespeed_multiplier = "Множитель скорости игры: #1#",
			Handy_event_queue_retriggers_amount = "Ускорение очереди анимаций: #1#",
			Handy_animation_skip = "Пропуск анимаций: #1#",

			Handy_skip_booster_pack = "Пропустить бустер-пак",

			Handy_scoring_hold = "Пауза анимации подсчёта",
			Handy_scoring_hold_hand_score = "Очки руки: [#1#]",

			Handy_hand_sorting = "Сортировка руки: #1#",

			Handy_preset_index = "Пресет #1#",
			Handy_preset_saved = "Пресет #1# [#2#] сохранён",
			Handy_preset_loaded = "Пресет #1# [#2#] загружен",
			Handy_preset_empty = "Пресет #1# [#2#] пуст",
			Handy_preset_disabled = "Пресет #1# [#2#] отключён",
			Handy_preset_example_loaded = "Готовый пресет [#1#] загружен",
			Handy_preset_nothing_to_load = "Нет пресетов для загрузки",

			Handy_binding_canceled = "Назначение отменено",
			Handy_binding_cancel_reason_no_safe = "Нельзя назначить #1# здесь, чтобы избежать софтлока",
			Handy_binding_cancel_reason_no_hold = "Нельзя назначить #1# здесь, так как эту клавишу нельзя удерживать",
			Handy_binding_cancel_reason_multiple_no_hold = "Комбинация не может содержать несколько неудерживаемых клавиш",
			Handy_binding_finished = "Назначение завершено: #1#",
			Handy_binding_progress = "Назначение: #1#",
			Handy_binding_esc_hint = "Нажмите #1#, чтобы сохранить",
			Handy_binding_guide = "Нажимайте клавиши, чтобы добавить их в комбинацию",

			Handy_reload_run_done = "Забег перезагружен",
			Handy_reload_run_nothing_to_load = "Нет забега для перезагрузки",
			Handy_load_run_done = "Забег загружен",
			Handy_load_run_nothing_to_load = "Нет забега для загрузки",

			Handy_prevented_by_debugplus = "Предотвращено DebugPlus",
			Handy_log_file_copied = "Файл лога Lovely скопирован в буфер обмена",

			Handy_updater_finish_success = "Релиз успешно установлен",
			Handy_updater_finish_no_fetcher = "Нет доступного API для запросов",
			Handy_updater_finish_no_connection = "Нет подключения к интернету",
			Handy_updater_finish_invalid_server_response = "Некорректный ответ сервера",
			Handy_updater_finish_no_release = "Релиз не найден",
			Handy_updater_finish_check_request_failed = "Не удалось проверить доступные релизы",
			Handy_updater_finish_cannot_write_zip = "Не удалось сохранить файлы релиза",
			Handy_updater_finish_download_request_failed = "Не удалось скачать релиз",
			Handy_updater_finish_cannot_unzip = "Не удалось распаковать файлы релиза",
			Handy_updater_finish_cannot_move_files = "Не удалось установить файлы релиза",
			Handy_updater_finish_no_data_to_replace = "Нет файлов релиза для установки",
			Handy_updater_finish_description = "Перезапустите игру, чтобы применить изменения",

			Handy_updater_progress_getting_releases = "Получение релизов...",
			Handy_updater_progress_downloading_release = "Скачивание релиза...",
			Handy_updater_progress_unzipping_archive = "Распаковка релиза...",
			Handy_updater_progress_installing_files = "Установка релиза...",

			Handy_new_pre_release_available = "Доступен новый предрелиз",
			Handy_new_stable_available = "Доступен новый стабильный релиз",
			Handy_new_release_description = "Откройте настройки мода для подробностей и скачивания",
			Handy_updater_auto_restart = "Перезапуск игры для применения изменений...",
		},
		dictionary = {
			handy_or = "или",
			handy_disabled = "Отключено",
			handy_mod_enabled = "Мод включён",
			handy_mod_disabled = "Мод отключён",

			handy_example_state_panel = "Здесь отображаются разные уведомления",

			ph_handy_premade_presets = "Готовые пресеты конфигурации",
			ph_handy_custom_presets = "Пользовательские пресеты конфигурации",

			b_handy_mp_extension = "Multiplayer Аддон",

			b_handy_preset_save = "Сохранить",
			b_handy_preset_load = "Загрузить",
			b_handy_preset_clear = "Очистить",

			handy_preset_name_placeholder = "Название пресета",

			b_handy_notif_quick = "Действия Handy",
			b_handy_notif_dangerous = "Опасные действия",

			b_handy_search_placeholder = "Поиск...",
			b_handy_search = "Поиск",
			b_handy_clear = "Очистить",
			b_handy_open_github = "Открыть на GitHub",

			ph_handy_notif_quick_use = "Быстро использовать",
			ph_handy_notif_quick_buy_or_sell = "Быстро купить или продать",
			ph_handy_notif_quick_buy_n_sell = "Быстро купить и сразу продать",
			ph_handy_notif_unsafe_disabled = "Небезопасные действия отключены в настройках мода",
			ph_handy_notif_unsafe_disabled_by_other_mod = "Небезопасные действия отключены другим модом",
			ph_handy_notif_unsafe = "[Небезопасно]",
			ph_handy_notif_insta_remove = "Мгновенно УДАЛИТЬ",
			ph_handy_notif_insta_sell = "Мгновенная продажа",
			ph_handy_notif_remove_all = "УДАЛИТЬ ВСЕ карты/теги в выбранной области",
			ph_handy_notif_sell_all = "Продать ВСЕ карты в выбранной области",
			ph_handy_notif_remove_all_same = "УДАЛИТЬ все копии выбранной карты/тега",
			ph_handy_notif_sell_all_same = "Продать все копии выбранной карты",
			ph_handy_notif_animation_skip_unsafe_disabled = "Небезопасная опция отключена в настройках мода",

			ph_handy_notif_misc_save_run_start = "Начинаю сохранение забега...",
			ph_handy_notif_misc_save_run_saving = "Сохранение забега...",
			ph_handy_notif_misc_save_run_saved = "Забег сохранён",
			ph_handy_notif_misc_save_run_interrupt = "Сейчас нельзя сохранить забег",

			handy_animation_skip_levels = {
				[1] = "Нет",
				[2] = "Сообщения",
				[3] = "Анимации",
				[4] = "Все",
				[5] = "Небезопасно",
			},

			handy_modals_start_calculation = {
				"Начать",
				"расчёт",
			},
			handy_modals_stop_calculation = {
				"Остановить",
				"расчёт",
			},
			handy_modals_preview_description = "Используйте предпросмотр, чтобы увидеть эффект настроек",
			handy_modals_move_highlight_preview_description = "Используйте предпросмотр, чтобы проверить управление",

			ph_handy_dangerous_actions_sell_one = "Продать одну",
			ph_handy_dangerous_actions_remove_one = "Удалить одну",
			ph_handy_dangerous_actions_sell_all_same = "Продать все такие же",
			ph_handy_dangerous_actions_remove_all_same = "Удалить все такие же",
			ph_handy_dangerous_actions_sell_all = "Продать ВСЁ",
			ph_handy_dangerous_actions_remove_all = "Удалить ВСЁ",

			handy_keybinds_trigger_mode_press = "При нажатии клавиши",
			handy_keybinds_trigger_mode_release = "При отпускании клавиши",

			handy_current_device_auto = "Авто",
			handy_current_device_keyboard = "Мышь + клавиатура",
			handy_current_device_gamepad = "Геймпад",

			handy_notification_level_none = "Нет",
			handy_notification_level_dangerous = "Только опасные",
			handy_notification_level_essential = "Основные",
			handy_notification_level_all = "Все",

			handy_buy_sell_use_mode_hold_n_click = "Удерживать клавишу + кликнуть карту",
			handy_buy_sell_use_mode_hover_n_press = "Навести или схватить карту + нажать клавишу",

			handy_advanced_mode = "Расширенный режим",
			handy_advanced_mode_description = "Больше контроля и информации",

			k_handy_preview_sell = "Продать",
			k_handy_preview_buy = "Купить",
			k_handy_preview_use = "Использовать",
			k_handy_preview_buy_n_use = "Купить и использовать",
			k_handy_preview_buy_n_sell = "Купить и продать",
			k_handy_preview_remove = "УДАЛИТЬ",

			handy_mp_speed_multiplier_mode = "Множитель скорости: максимум в лобби",
			handy_mp_animation_skip_mode = "Пропуск анимаций: максимум в лобби",
			handy_mp_dangerous_actions_mode = "Опасные действия: режим лобби",
			handy_mp_dangerous_actions_modes = {
				"Отключено",
				"Массовая продажа",
				"Массовая продажа и удаление",
			},

			handy_regular_keybinds_swappable_overlays_mode = {
				"Нажать, чтобы открыть",
				"Нажать, чтобы открыть / нажать снова, чтобы закрыть",
				"Удерживать, чтобы открыть / отпустить, чтобы закрыть",
			},

			handy_dangerous_actions_mass_sell_remove_mode = {
				"Затрагивать все карты",
				"Затрагивать все, кроме целевой карты",
			},

			handy_show_custom_pip_mode = {
				"Нет",
				"Только геймпад",
				"Всегда",
			},

			handy_mp_extension_status_not_initialized = "Расширение мультиплеера НЕ ЗАГРУЖЕНО в этом лобби",
			handy_mp_extension_status_disabled = "Расширение мультиплеера в этом лобби ОТКЛЮЧЕНО ВАМИ",
			handy_mp_extension_status_disabled_by_ruleset = "Расширение мультиплеера в этом лобби ОТКЛЮЧЕНО НАБОРОМ ПРАВИЛ",
			handy_mp_extension_status_disabled_by_other_player = "Расширение мультиплеера в этом лобби ОТКЛЮЧЕНО ДРУГИМИ игроками",
			handy_mp_extension_status_enabled = "Расширение мультиплеера в этом лобби ВКЛЮЧЕНО",

			handy_updater_no_release_found = "Данные релиза не найдены",
			handy_updater_status_no_data = "Нет данных релиза",
			handy_updater_status_current_version = "Текущая версия",
			handy_updater_status_already_installed = "Установлено — перезапустите игру",
			handy_updater_status_busy = "Пожалуйста, подождите...",
			handy_updater_status_ready_for_installation = "Готово к установке",
			handy_updater_status_new_version_available = "Доступна новая версия",
			b_handy_install = "Установить",
			b_handy_restart_game = "Перезапустить игру",

			handy_release_type_stable = "Стабильный",
			handy_release_type_pre_release = "Предрелиз",

			handy_smods_compat_mode = "Режим совместимости: загрузка из .zip-архива требует обновлённый SMODS!",

			handy_gamepad_2step_select = "для выбора",
			handy_gamepad_2step_adjust = "для настройки",
			handy_gamepad_2step_deselect = "для снятия выбора",
		},
	},
}
