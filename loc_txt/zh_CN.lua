return {
	descriptions = {
		-- For all checkboxes and popups, first var is keybind
		-- Further mentioned vars starts from #2#
		Handy_ConfigCheckbox = {
			-- Vars: version, author
			handy = {
				unlock = { "HandyBalatro v#2#", "作者 {C:white,E:2,s:1.15}#3#{}" },
				text = {
					"取消勾选以禁用{C:attention}所有{}模组功能",
					"{C:handy_secondary}(无需重启游戏){}",
				},
			},
			hide_options_button = {
				unlock = { "在选项菜单中", "隐藏模组按钮" },
				text = {
					"{C:handy_secondary}仅在安装 Steamodded 时生效{}",
				},
			},
			debugplus_prevent = {
				unlock = { "DebugPlus：", "阻止操作" },
				text = { "按住{C:chips}#2#{}时", "阻止任何 Handy 快捷键触发" },
			},
			regular_keybinds = {
				unlock = { "常用快捷键" },
				text = {
					"为常用操作",
					"设置快捷键",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight = {
				unlock = {
					"{C:edition}快速选手牌{}",
					"{C:handy_secondary,s:0.75}(拖拽、悬停、滑动){}",
				},
				text = {
					"按住{C:chips}#1#{}并",
					"悬停手牌即可选中",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight_OUTSIDE = {
				unlock = {
					"{C:edition}快速选手牌{}",
					"{C:handy_secondary,s:0.75}(拖拽、悬停、滑动){}",
				},
				text = {
					"先在{C:attention}牌外{}按住{C:chips}#1#{}，",
					"再悬停手牌即可选中",
				},
			},
			-- Vars: [Fast hand selection]
			insta_unhighlight = {
				unlock = {
					"快速取消",
					"手牌选择",
				},
				text = {
					"允许{C:edition}#2#{}",
					"同时取消选择已选牌",
				},
			},
			show_deck_preview = {
				unlock = { "牌组预览" },
				text = {
					"按住{C:chips}#1#{}以",
					"显示牌组预览",
				},
			},
			-- Vars: [Right Mouse]
			deselect_hand = {
				unlock = { "取消选择手牌" },
				text = {
					"按{C:chips}#1#{}以",
					"取消已选手牌",
				},
			},
			insta_cash_out = {
				unlock = { "快速结算" },
				text = {
					"按住/连击{C:chips}#1#{}以",
					"加速结算阶段",
				},
			},
			insta_booster_skip = {
				unlock = { "快速跳过", "补充包" },
				text = {
					"按住/连击{C:chips}#1#{}以",
					"跳过补充包",
				},
			},
			move_highlight = {
				unlock = { "移动高亮" },
				text = {
					"按{C:chips}#2#{}或{C:chips}#3#}在牌区移动高亮。",
					"按住{C:chips}#4#}改为移动整牌。",
					"按住{C:chips}#5#}移至首张/末张",
					"",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_or_sell = {
				unlock = { "快速买/卖" },
				text = {
					"使用{C:chips}#1#{}以",
					"购买或出售卡牌",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_n_sell = {
				unlock = { "快速先买后卖" },
				text = {
					"使用{C:chips}#1#{}以",
					"先购买再立即",
					"出售该卡",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_use = {
				unlock = { "快速使用" },
				text = {
					"使用{C:chips}#1#{}以",
					"在可用时立即使用卡牌",
				},
			},
			-- Vars: Buy/Sell/Use mode
			cryptid_code_use_last_interaction = {
				unlock = { "Cryptid：使用", "上一次输入" },
				text = {
					"使用{C:chips}#1#{}以",
					"在可用时以之前输入的值",
					"使用代码卡",
				},
			},
			not_just_yet_interaction = {
				unlock = { "NotJustYet：", "结束回合" },
				text = {
					"按{C:chips}#1#{}以",
					"立即结束本回合",
				},
			},
			-- Vars: [keybind for Multiply], [keybind for Divide], min value, max value
			speed_multiplier = {
				unlock = { "游戏速度倍率" },
				text = {
					"按住{C:chips}#1#{}并使用",
					"{C:chips}#2#{}/{C:chips}#3#{}以",
					"放大/缩小游戏速度",
				},
			},
			-- Vars: [Speed Multiplier]
			speed_multiplier_no_hold = {
				unlock = { "速度倍率：", "无需长按" },
				text = {
					"减少使用",
					"#2#",
					"所需的按键数量",
				},
			},
			insta_highlight_entire_f_hand = {
				unlock = { "高亮", "整手牌" },
				text = {
					"按{C:chips}#1#{}以",
					"从左到右高亮所有手牌",
				},
			},
			-- Vars: [keybind for Increase], [keybind for Decrease], [Danger zone tab]
			nopeus_interaction = {
				unlock = { "Nopeus：", "快进" },
				text = {
					"按住{C:chips}#1#{}并使用",
					"{C:chips}#2#{}/{C:chips}#3#{}以",
					"增减快进设置",
				},
			},
			-- Vars: [Nopeus: fast-forward]
			nopeus_interaction_no_hold = {
				unlock = { "Nopeus：", "无需长按" },
				text = {
					"减少使用",
					"#2#",
					"所需的按键数量",
				},
			},
			-- Vars: [keybind for Increase], [keybind for Decrease], [Danger zone tab], None, Messages, Animations, Everything, Unsafe, [Danger zone tab]
			animation_skip = {
				unlock = { "动画跳过" },
				text = {
					"按住{C:chips}#1#{}并使用",
					"{C:chips}#2#{}/{C:chips}#3#{}以",
					"增减动画跳过级别",
				},
			},
			-- Vars: [Animation skip]
			animation_skip_no_hold = {
				unlock = { "动画跳过：", "无需长按" },
				text = {
					"减少使用",
					"#2#",
					"所需的按键数量",
				},
			},
			scoring_hold = {
				unlock = { "暂停计分", "动画" },
				text = {
					"按住{C:chips}#1#}以",
					"在计算完手牌总分后",
					"暂停计分动画",
				},
			},
			scoring_hold_any_moment = {
				unlock = { "暂停计分", "任意时刻" },
				text = {
					"允许#2#在",
					"计分动画的",
					"任意时刻暂停",
				},
			},
			dangerous_actions = {
				unlock = { "危险操作" },
				text = {
					"启用不安全控制。它们以速度优先，",
					"{C:mult}可能导致 bug 或崩溃！{}",
					"",
				},
			},
			-- Vars: [keybind for Quick buy/sell], [Quick buy/sell], ["Dangerous" modifier]
			immediate_buy_and_sell = {
				unlock = { "快速出售" },
				text = {
					"按住{C:mult}#1#{}，",
					"再按住{C:chips}#2#{}，",
					"并悬停卡牌即可立即出售",
				},
			},
			immediate_buy_and_sell_queue = {
				unlock = { "出售队列" },
				text = {
					"仅在松开快捷键后",
					"开始统一出售",
				},
			},
			nopeus_unsafe = {
				unlock = { "Nopeus：不安全", "快进" },
				text = {
					"允许将快进设置",
					"提高到{C:mult}不安全{}级别",
				},
			},
			speed_multiplier_uncap = {
				unlock = { "速度倍率：", "无上限" },
				text = {
					"允许将游戏速度",
					"提高到极端值",
				},
			},
			-- Vars: [Animation skip]
			animation_skip_unsafe = {
				unlock = { "动画跳过：", "不安全" },
				text = {
					"允许将设置",
					"提高到{C:mult}#2#{}",
				},
			},
			-- Vars: [keybind for Quick buy/sell], ["Dangerous" modifier], ["All copies" modifier]
			sell_all_same = {
				unlock = { "出售所有", "相同卡牌" },
				text = {
					"按住{C:mult}#2#{}与{C:mult}#1#{}，",
					"并点击卡牌以出售",
					"其所有副本",
				},
			},
			-- Vars: ["Dangerous" modifier], ["Sell ALL" modifier]
			sell_all = {
				unlock = { "出售全部" },
				text = {
					"按住{C:mult}#1#{}以出售区域内{C:attention}所有{}",
					"卡牌",
				},
			},
			-- Vars: ["Dangerous" modifier], ["REMOVE" modifier], [Quick buy/sell], ["All copies" modifier], ["ALL" modifier]
			card_remove = {
				unlock = { "移除*卡牌", "或跳过标签" },
				text = {
					"按住{C:mult}#1#{}以{C:attention,E:1}移除{}卡牌",
					"{C:handy_secondary}(对跳过标签也生效){}",
				},
			},
			controller_swap_cursor_stick = {
				unlock = { "手柄：交换", "光标摇杆" },
				text = {
					"交换左右摇杆的",
					"光标控制行为",
				},
			},
			controller_sensivity = {
				unlock = { "手柄：调整", "光标灵敏度" },
				text = {
					"允许更改手柄",
					"光标的灵敏度",
				},
			},
		},
		Handy_ConfigPopup = {
			debugplus_prevent = {
				text = {
					"需要安装{C:attention}DebugPlus{}并启用",
					"{C:attention}CTRL for Keybinds{}选项才生效",
				},
			},
			regular_keybinds = {
				text = {
					"出牌、弃牌、手牌排序、",
					"商店刷新、离开商店、选择盲注、",
					"跳过盲注、查看牌组、对局信息",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight = {
				text = {
					"若设置为{C:chips}#2#{}，",
					"先在牌外开始长按，",
					"再悬停即可高亮",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight_gamepad = {
				text = {
					"对光标与移动方向键",
					"均生效",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight_OUTSIDE = {
				text = {
					"若非{C:chips}#2#{}键，",
					"悬停牌时长按",
					"同样可高亮",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight_OUTSIDE_gamepad = {
				text = {
					"对光标与移动方向键",
					"均生效",
				},
			},
			-- Vars: [Fast hand selection]
			insta_unhighlight = {
				text = {
					"若首张未选中则执行选择，",
					"若首张已选中则执行取消。",
				},
			},
			-- Vars: [Right Mouse]
			deselect_hand_desktop = {
				text = {
					"替换原版{C:chips}#2#{}",
					"功能相同并可",
					"重新绑定其他按键",
					" ",
					"取消勾选以使用原版",
				},
			},
			insta_cash_out = {
				text = {
					"长按将在可用时",
					"立即触发",
				},
			},
			insta_booster_skip = {
				text = {
					"长按将在可用时",
					"立即触发",
				},
			},
			move_highlight = {
				text = {
					"先选中区域内卡牌，",
					"再使用所列控制",
				},
			},
			move_highlight_gamepad = {
				text = {
					"{C:mult}对手柄无效{}",
				},
			},
			-- Vars: [keybind for Multiply], [keybind for Divide], min value, max value
			speed_multiplier = {
				text = {
					"游戏速度可在",
					"{C:attention}#4#{}至{C:attention}#5#{}范围内调整",
				},
			},
			-- Vars: [keybind for Increase], [keybind for Decrease], [Danger zone tab]
			nopeus_interaction = {
				text = {
					"需要{C:attention}Nopeus{}模组支持",
					" ",
					"需在{C:attention}#4#{}页中",
					"启用{C:mult}不安全{}选项",
				},
			},
			-- Vars: [keybind for Increase], [keybind for Decrease], [Danger zone tab], None, Messages, Animations, Everything, Unsafe, [Danger zone tab]
			animation_skip = {
				text = {
					"共 5 级动画跳过",
					" ",
					"{C:attention}#4#{} - 默认行为",
					"{C:attention}#5#{} - 隐藏“再来！”等文字与筹码提示",
					"{C:attention}#6#{} - 瞬间计分，去除牌抖动",
					"{C:attention}#7#{} - 移除多余动画，瞬间抽牌与重开",
					"{C:mult}#8#{} - 极限：全部瞬间完成",
					" ",
					"需在{C:attention}#9#{}页中启用{C:mult}#8#{}",
				},
			},
			scoring_hold = {
				text = {
					"在高倍速或跳过动画时",
					"方便洗牌或查看",
					"回合最终得分",
				},
			},
			not_just_yet_interaction = {
				text = {
					"需要{C:attention}NotJustYet{}模组支持",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_or_sell_desktop = {
				text = {
					"由{C:attention}#2#{}决定具体行为",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_or_sell_gamepad = {
				text = {
					"替换原版{C:chips}#3#{}",
					"功能相同并可",
					"重新绑定其他按键",
					" ",
					"取消勾选以使用原版",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_n_sell_desktop = {
				text = {
					"由{C:attention}#2#{}决定具体行为",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_use_desktop = {
				text = {
					"由{C:attention}#2#{}决定具体行为",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_use_gamepad = {
				text = {
					"替换原版{C:chips}#3#{}",
					"功能相同并可",
					"重新绑定其他按键",
					" ",
					"取消勾选以使用原版",
				},
			},
			-- Vars: Buy/Sell/Use mode
			cryptid_code_use_last_interaction = {
				text = {
					"需要{C:attention}Cryptid{}模组支持",
					" ",
					"快捷使用代码卡并选择",
					"{C:green}[输入上一次数值]{}的选项：",
					"{C:green}://VARIABLE{}、{C:green}://CLASS{}、{C:green}://EXPLOIT{}",
					" ",
					"由{C:attention}#2#{}决定具体行为",
				},
			},
			-- Vars: Buy/Sell/Use mode
			cryptid_code_use_last_interaction_gamepad = {
				text = {
					"需要{C:attention}Cryptid{}模组支持",
					" ",
					"快捷使用代码卡并选择",
					"{C:green}[输入上一次数值]{}的选项：",
					"{C:green}://VARIABLE{}、{C:green}://CLASS{}、{C:green}://EXPLOIT{}",
				},
			},
			insta_highlight_entire_f_hand = {
				text = {
					"从左到右选中",
					"最大数量的手牌",
				},
			},
			-- Vars: [keybind for Quick buy/sell], [Quick buy/sell], ["Dangerous" modifier]
			immediate_buy_and_sell = {
				text = {
					"按住{C:mult}#3#{}与{C:chips}#4#{}，",
					"并悬停卡牌即可立即出售",
				},
			},
			immediate_buy_and_sell_queue = {
				text = {
					"松开后才统一出售，{C:mult}[即时出售]{}",
					"选牌更精准但稍慢",
					"",
					"",
					"",
				},
			},
			immediate_buy_and_sell_queue_gamepad = {
				text = {
					"松开后才统一出售，{C:mult}[即时出售]{}",
					"选牌更精准但稍慢",
					"",
					"",
					"",
					" ",
					"{C:attention}手柄下始终启用{}",
				},
			},
			speed_multiplier_uncap = {
				text = {
					"{C:mult}会严重影响性能{}",
				},
			},
			nopeus_unsafe = {
				text = {
					"需要{C:attention}Nopeus{}模组支持",
					" ",
					"即使未勾选，也可在游戏设置中",
					"正常开启{C:mult}不安全{}选项",
				},
			},
			-- Vars: [keybind for Quick buy/sell], ["Dangerous" modifier], ["All copies" modifier]
			sell_all_same = {
				text = {
					"按住{C:mult}#3#{}与{C:mult}#4#{}，",
					"并点击卡牌以出售其所有副本",
				},
			},
			-- Vars: ["Dangerous" modifier], ["Sell ALL" modifier]
			sell_all = {
				text = {
					"按住{C:mult}#2#{}与{C:mult}#3#{}，",
					"并点击卡牌以出售区域内{C:attention}所有{}卡牌",
				},
			},
			-- Vars: ["Dangerous" modifier], ["REMOVE" modifier], [Quick buy/sell], ["All copies" modifier], ["ALL" modifier]
			card_remove = {
				text = {
					"按住时点击卡牌或跳过标签将{C:attention,E:1}移除{}而非出售",
					" ",
					"按住{C:mult}#2#{}、{C:mult}#3#{}与{C:chips}#4#{}",
					"并悬停卡牌以{C:attention,E:1}移除{}（同样进入队列）",
					" ",
					"按住{C:mult}#2#{}、{C:mult}#3#{}与{C:mult}#5#{}",
					"并点击卡牌或跳过标签以{C:attention,E:1}移除{}其所有副本",
					" ",
					"按住{C:mult}#2#{}、{C:mult}#3#{}与{C:mult}#6#{}，",
					"并点击卡牌或跳过标签以{C:attention,E:1}移除{C:attention}全部{}",
				},
			},
		},
		Handy_Preset = {
			["default"] = {
				name = "默认",
				text = {
					"模组默认控制方案",
				},
			},
			["better_mouse_and_gamepad"] = {
				name = "增强鼠标与手柄",
				text = {
					"类似 Better Mouse and Gamepad 模组的控制方案",
				},
			},
		},
	},
	misc = {
		handy_keybinds = {
			-- 未绑定按键
			["None"] = "无",
			-- 无法识别的按键
			["Unknown"] = "未知",

			-- 鼠标
			["Left Mouse"] = "鼠标左键",
			["Right Mouse"] = "鼠标右键",
			["Middle Mouse"] = "鼠标中键",
			["Mouse 4"] = "鼠标侧键1",
			["Mouse 5"] = "鼠标侧键2",
			["Wheel Up"] = "滚轮上",
			["Wheel Down"] = "滚轮下",

			-- 控制键
			["Escape"] = "Esc",
			["Shift"] = "Shift",
			["Ctrl"] = "Ctrl",
			["Alt"] = "Alt",
			["GUI"] = "Win/Cmd",
			["Enter"] = "回车",
			["Tab"] = "Tab",
			["Backspace"] = "退格",
			["Num Lock"] = "数字锁",
			["Caps Lock"] = "大写锁",
			["Scroll Lock"] = "滚动锁",

			-- 方向键
			["Left"] = "←",
			["Right"] = "→",
			["Up"] = "↑",
			["Down"] = "↓",

			-- 符号键
			["Backquote"] = "`",
			["Singlequote"] = "'",
			["Quote"] = '"',
			["Left Bracket"] = "[",
			["Right Bracket"] = "]",

			-- 功能键
			["Printscreen"] = "PrintScreen",
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
			["Page Up"] = "PgUp",
			["Page Down"] = "PgDn",

			-- 冷门多媒体键
			["Www"] = "WWW",
			["Mail"] = "邮件",
			["Calculator"] = "计算器",
			["Computer"] = "电脑",
			["Appsearch"] = "应用搜索",
			["Apphome"] = "应用首页",
			["Appback"] = "应用后退",
			["Appforward"] = "应用前进",
			["Apprefresh"] = "应用刷新",
			["Appbookmarks"] = "应用书签",
			["Currencyunit"] = "货币符号",
			["Application"] = "应用",
			["Power"] = "电源",

			-- 手柄按键
			["(A)"] = "(A)",
			["(B)"] = "(B)",
			["(X)"] = "(X)",
			["(Y)"] = "(Y)",
			["(Back)"] = "(返回)",
			["(Guide)"] = "(导航)",
			["(Start)"] = "(开始)",

			-- 手柄方向（左摇杆当方向键）
			["(Up)"] = "(上)",
			["(Down)"] = "(下)",
			["(Left)"] = "(左)",
			["(Right)"] = "(右)",

			-- 摇杆、扳机、肩键
			["Left Stick"] = "左摇杆按下",
			["Right Stick"] = "右摇杆按下",
			["Left Bumper"] = "LB",
			["Right Bumper"] = "RB",
			["Left Trigger"] = "LT",
			["Right Trigger"] = "RT",

			-- 未支持的手柄拨片
			["First Paddle"] = "拨片1",
			["Second Paddle"] = "拨片2",
			["Third Paddle"] = "拨片3",
			["Fourth Paddle"] = "拨片4",
			["(Misc. Button)"] = "杂项键",
			["Touchpad Press"] = "触摸板点击",
		},

		handy_keybind_labels = {
			play_hand = "出牌",
			discard = "弃牌",
			toggle_sort = "切换排序",
			sort_by_rank = "按点数排序",
			sort_by_suit = "按花色排序",
			deselect_hand = "取消选择",
			cash_out = "兑现",
			not_just_yet_end_round = "NotJustYet：结束回合",
			skip_booster = "跳过补充包",
			reroll_shop = "商店刷新",
			leave_shop = "离开商店",
			skip_blind = "跳过盲注",
			select_blind = "选择盲注",
			reroll_boss = "Roll Boss",
			run_info_hands = "对局信息：牌型",
			run_info_blinds = "对局信息：盲注",
			view_deck = "查看牌组",
			deck_preview = "牌组预览",
			quick_highlight = "快速选牌",
			quick_buy_or_sell = "快速买/卖",
			quick_buy_n_sell = "快速先买后卖",
			quick_use = "快速使用",
			highlight_entire_f_hand = "高亮整手牌",
			cryptid_code_use_last_interaction = "Cryptid：使用上次输入",
			speed_multiplier = "速度倍率",
			speed_multiplier_multiply = "速度倍率：乘",
			speed_multiplier_divide = "速度倍率：除",
			nopeus_interaction = "Nopeus：快进",
			nopeus_interaction_increase = "Nopeus：增加",
			nopeus_interaction_decrease = "Nopeus：减少",
			animation_skip = "动画跳过",
			animation_skip_increase = "动画跳过：增加",
			animation_skip_decrease = "动画跳过：减少",
			move_highlight_one_left = "高亮左移1",
			move_highlight_one_right = "高亮右移1",
			move_highlight_move_card = "移动卡牌",
			move_highlight_to_end = "移至首/末",

			dangerous_modifier = "“危险”修饰键",
			dangerous_all_same_modifier = "“所有副本”修饰键",
			dangerous_all_modifier = "“全部”修饰键",
			dangerous_remove_modifier = "“移除”修饰键",

			scoring_hold = "暂停计分动画",

			presets_load_1 = "加载预设1",
			presets_load_2 = "加载预设2",
			presets_load_3 = "加载预设3",
			presets_load_next = "加载下一预设",

			misc_open_mod_settings = "打开模组设置",
			misc_crash = "故意崩溃游戏",
			misc_save_run = "保存对局",
			misc_quick_restart = "快速重开",
			misc_start_fantoms_preview = "Fantom 预览：计算",
		},

		handy_keybind_sections = {
			hand = "手牌",
			round = "回合",
			shop = "商店",
			blinds = "盲注",
			menus = "菜单",
			quick_actions = "快速操作",
			gamespeed = "游戏速度",
			animations = "动画",
			highlight_movement = "高亮移动",
			shop_and_blinds = "商店与盲注",
			gamespeed_and_animations = "速度与动画",
			hand_selection = "选牌",
			presets = "预设",
			dangerous_actions = "危险操作",
			misc = "杂项",
		},

		handy_tabs = {
			["Overall"] = "通用与原键",
			["Quick"] = "快速操作",
			["Keybinds"] = "常用快捷键",
			["Keybinds 2"] = "其它快捷键",
			["Dangerous"] = "危险区域",
			["Presets"] = "预设",
			["Keybinds Paginated"] = "快捷键",
			["Search"] = "搜索",
		},

		v_dictionary = {
			Handy_module_keys_single = "[#1#]",
			Handy_module_keys_or = "[#1#] 或 [#2#]",
			Handy_items_in_queue = "[队列中 #1#]",
			Handy_gamespeed_multiplier = "游戏速度倍率：#1#",
			Handy_event_queue_retriggers_amount = "事件队列加速：#1#",
			Handy_nopeus_fastforward = "Nopeus 快进：#1#",
			Handy_animation_skip = "动画跳过：#1#",
			Handy_skip_booster_pack = "跳过补充包",

			Handy_scoring_hold = "暂停计分动画",

			Handy_hand_sorting = "手牌排序：#1#",

			Handy_preset_index = "预设 #1#",
			Handy_preset_loaded = "已加载预设 #1# [#2#]",
			Handy_preset_empty = "预设 #1# [#2#] 为空",
			Handy_preset_disabled = "预设 #1# [#2#] 已禁用",
			Handy_preset_nothing_to_load = "没有可加载的预设",

			Handy_overall_guide_button = "可在“#1#”页为每个操作绑定鼠标、滚轮或键盘。",
			Handy_overall_guide_gamepad = "可在“#1#”页为每个操作绑定手柄按键。",
			Handy_popups_guide = "悬停控件可查看更多信息。",
			Handy_popups_guide_gamepad = "在控件之间移动可查看更多信息。",
			Handy_search_guide = "使用“#1#”页进行搜索。",
			Handy_keybinds_guide_desktop = "点击按钮后按下任意键即可绑定；#1# 清除绑定。",
			Handy_keybinds_guide_gamepad = "在按钮上 #2# 后按下任意键即可绑定；#1# 清除绑定。",
			Handy_presets_guide = "预设——可随时应用的配置与键位集合。",
			Handy_danger_zone_guide = "*移除卡牌/标签——不经检查、效果、触发或退款直接删除。",

			Handy_default_value = "#1#: 游戏启动值",
		},

		dictionary = {
			handy_or = "或",

			ph_handy_premade_presets = "官方预设",
			ph_handy_custom_presets = "自定义预设",

			b_handy_preset_save = "保存",
			b_handy_preset_load = "加载",
			b_handy_preset_clear = "清空",

			handy_preset_name_placeholder = "预设名称",

			b_handy_notif_quick = "快速操作",
			b_handy_notif_dangerous = "危险操作",

			b_handy_search_placeholder = "搜索…",
			b_handy_search = "搜索",
			b_handy_clear = "清除",
			ph_handy_search_no_results = "试试关键词：“speed”“动画”“sale”等。不支持输入中文",

			ph_handy_notif_quick_use = "快速使用",
			ph_handy_notif_quick_buy_or_sell = "快速买/卖",
			ph_handy_notif_quick_buy_n_sell = "快速先买后卖",
			ph_handy_notif_unsafe_disabled = "模组设置中已关闭不安全选项",
			ph_handy_notif_unsafe_disabled_by_other_mod = "被其他模组禁用不安全选项",
			ph_handy_notif_unsafe = "[不安全] 可能出现 bug！",
			ph_handy_notif_insta_remove = "瞬间 移除",
			ph_handy_notif_insta_sell = "瞬间出售",
			ph_handy_notif_remove_all = "移除区域内 全部 卡牌/标签",
			ph_handy_notif_sell_all = "出售区域内 全部 卡牌",
			ph_handy_notif_remove_all_same = "移除点击卡牌/标签的 所有副本",
			ph_handy_notif_sell_all_same = "出售点击卡牌的 所有副本",
			ph_handy_notif_nopeus_unsafe_disabled = "模组设置中已关闭不安全选项",
			ph_handy_notif_animation_skip_unsafe_disabled = "模组设置中已关闭不安全选项",
			ph_handy_notif_cannot_bind_non_holdable = "此处无法绑定滚轮",
			ph_handy_notif_cannot_bind_non_safe = "此处无法绑定该按键",

			ph_handy_notif_misc_save_run_start = "开始保存对局…",
			ph_handy_notif_misc_save_run_saving = "正在保存对局…",
			ph_handy_notif_misc_save_run_saved = "对局已保存",
			ph_handy_notif_misc_save_run_interrupt = "当前无法保存对局",

			handy_animation_skip_levels = {
				[1] = "无",
				[2] = "消息",
				[3] = "动画",
				[4] = "所有",
				[5] = "不安全",
			},

			b_handy_info_popups_level_select = "信息弹窗级别",
			handy_info_popups_level_opt = {
				[1] = "无",
				[2] = "仅危险",
				[3] = "功能相关",
				[4] = "全部",
			},

			b_handy_keybinds_trigger_mode_select = "快捷键触发模式",
			handy_keybinds_trigger_mode_opt = {
				[1] = "按下触发",
				[2] = "松开触发",
			},

			b_handy_buy_sell_use_mode_select = "买/卖/用模式",
			handy_buy_sell_use_mode_opt = {
				[1] = "长按+点击卡牌",
				[2] = "悬停卡牌+按键",
			},

			b_handy_device_select = "输入设备",
			handy_device_opt = {
				[1] = "自动",
				[2] = "鼠标+键盘",
				[3] = "手柄",
			},
		},
	},
}
