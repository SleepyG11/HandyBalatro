return {
	descriptions = {
		Handy_ConfigDictionary = {
			general = {
				name = "Handy v#1#，作者 #2#",
				text = {},
			},
			handy = {
				name = "全局模组开关",
				text = {
					"关闭此项将会停用所有模组功能",
				},
				unlock = {
					"各项功能都可以{C:attention}随时{}开启/关闭",
					"无需重启游戏",
					"也无需重新加载对局",
				},
			},
			keybinds_trigger_mode = {
				name = "快捷键触发时机",
				text = {},
				unlock = {
					"适用于大多数控制项",
				},
			},
			current_device = {
				name = "当前输入设备",
				text = {},
				unlock = {
					"模组会为{C:attention}鼠标+键盘{}和{C:attention}手柄{}",
					"分别保存独立的快捷键布局",
					"并根据你当前使用的设备",
					"自动在两套布局之间切换",
					"{C:inactive}(当选择“#1#”时){}",
				},
			},
			prevent_if_debugplus = {
				name = "DebugPlus：防止冲突",
				text = {},
				unlock = {
					"当按住{C:chips}#1#{}时，",
					"不执行任何控制，避免与",
					"DebugPlus 的控制产生冲突",
					" ",
					"需要在 DebugPlus 设置中启用",
					"{C:attention}“CTRL for Keybinds”{}",
					" ",
					"{C:attention}副作用{}：会使带有",
					"{C:chips}#1#{}的快捷键{C:mult}无法使用{}",
				},
			},
			gamepad = {
				name = "手柄设置",
				text = {},
			},
			swap_controller_cursor_stick = {
				name = "交换摇杆",
				text = {},
			},
			controller_sensitivity = {
				name = "手柄光标灵敏度",
				text = {},
			},
			appearance = {
				name = "外观",
				text = {},
			},
			hide_options_button = {
				name = "在选项菜单中隐藏模组按钮",
				text = {},
				unlock = {
					"仅在存在 {C:attention}SMODS{} 时生效",
				},
			},
			notifications_level = {
				name = "提示级别",
				text = {},
			},
			speed_multiplier_settings_toggle = {
				name = "速度倍率：设置中显示开关",
				text = {},
				unlock = {
					"位于原版{C:attention}游戏速度{}设置附近",
				},
			},
			animation_skip_settings_toggle = {
				name = "动画跳过：设置中显示开关",
				text = {},
				unlock = {
					"位于原版{C:attention}游戏速度{}设置附近",
				},
			},
			show_custom_pip = {
				name = "在按钮上不显示绑定的按键",
				text = {},
				unlock = {
					"在对应的按钮上会显示其绑定的按键，",
					"启用时",
					"{C:inactive}(出牌、对局信息、重置等等){}",
				},
			},
			updater = {
				name = "模组自动更新",
				text = {
					"我懂，Balatro 玩家多半都懒得手动更新",
				},
			},
			updater_target_release_type = {
				name = "目标版本类型",
				text = {},
			},
			updater_notify_about_new_update = {
				name = "发现新更新时通知",
				text = {},
				unlock = {
					"你会在{C:attention}游戏启动时{}收到通知",
				},
			},
			updater_auto_install_new_update = {
				name = "自动安装新更新",
				text = {},
				unlock = {
					"更新会在{C:attention}游戏启动时{}自动安装",
				},
			},
			updater_auto_restart_game_after_update = {
				name = "更新后自动重启游戏",
				text = {},
			},
			me = {
				name = "你好呀，是我！接下来我会一直跟着你……",
				text = {
					"立绘作者：{C:mult}#1#{}",
				},
			},
			me_in_mod_config = {
				name = "……出现在模组设置里",
				text = {
					"这地方可是我亲手搭出来的！",
				},
			},
			me_in_game_over = {
				name = "……出现在游戏结束画面",
				text = {
					"输掉这一把不怪你！",
				},
			},
			me_in_game_win = {
				name = "……出现在胜利画面",
				text = {
					"来，一起庆祝这场胜利吧！",
				},
			},
			me_in_handy_tag = {
				name = "……也许会出现在别处！",
				text = {
					"我还没想好该把自己放在哪……",
				},
			},
			me_in_screenswipe = {
				name = "……出现在转场卡牌中",
				text = {
					"我现在也是一张小丑牌啦！",
				},
			},
			hand_selection = {
				name = "选牌与取消选牌",
				text = {},
			},
			hand_selection_mode = {
				name = "选牌实现方式",
				text = {},
				unlock = {
					"会影响",
					"{C:attention}选牌{}和{C:attention}取消选牌{}的部分细节",
					"{C:inactive}(用于兼容其他模组的实现方式){}",
				},
			},
			hand_selection_insta_highlight = {
				name = {
					"快速选牌",
				},
				text = {
					"拖动、悬停、划过都能选牌",
				},
				unlock = {
					"若绑定到{C:chips}[鼠标左键]{}，",
					"请先在{C:attention}卡牌外部{}按住鼠标，",
					"再把光标划过卡牌进行选中",
					"{C:inactive}(否则会直接选中一张卡牌){}",
				},
			},
			hand_selection_insta_highlight_allow_deselect = {
				name = {
					"快速取消选牌",
				},
				text = {},
				unlock = {
					"若第一张牌{C:attention}未{}被选中，就会{C:attention}选中{}",
					"若第一张牌{C:attention}已{}被选中，就会{C:attention}取消选中{}",
				},
			},
			hand_selection_combine_select_deselect = {
				name = {
					"合并选牌/取消选牌",
				},
				text = {},
				unlock = {
					"若卡牌{C:attention}未{}被选中，则会{C:attention}选中{}",
					"若卡牌{C:attention}已{}被选中，则会{C:attention}取消选中{}",
					"{C:inactive}(同一次操作可同时处理两种情况){}",
				},
			},
			hand_selection_deselect_hand = {
				name = {
					"取消手牌选中",
				},
				text = {},
				unlock = {
					"可{C:attention}替代{}原版的",
					"{C:chips}#1#{}，用法完全一致",
					" ",
					"若与{C:chips}#2#{}共用同一快捷键，",
					"只会在{C:attention}未悬停{}卡牌时触发",
				},
			},
			hand_selection_entire_f_hand = {
				name = {
					"选满手牌",
				},
				text = {},
				unlock = {
					"从左到右",
					"选中{C:attention}尽可能多{}的卡牌",
				},
			},
			animation_skip = {
				name = "动画跳过",
				text = {
					"跳过计分和其他游戏动画",
				},
				unlock = {
					"可直接替代 {C:attention}Talisman{}、{C:attention}Saturn{}",
					"或 {C:attention}Nopeus{} 中的同类功能",
					" ",
					"共有 4 个等级：",
					"{C:chips}无{} - 不做改动",
					"{C:chips}提示{} - 不显示 {C:mult}XMult{}、{C:attention}Again!{} 等触发提示",
					"{C:attention}动画{} - 立即结算得分",
					"{C:attention}全部{} - 移除大部分动画；抽牌也会立即完成",
				},
			},
			animation_skip_default_value = {
				name = "动画跳过：游戏初始值",
				text = {},
			},
			animation_skip_increase = {
				name = {
					"动画跳过：调高一级",
				},
				text = {},
			},
			animation_skip_decrease = {
				name = {
					"动画跳过：调低一级",
				},
				text = {},
			},
			animation_skip_toggle_temp_disabled = {
				name = {
					"动画跳过：临时关闭",
				},
				text = {},
				unlock = {
					"可作为{C:attention}临时开关{}来使用",
					"这样就不必每次都手动",
					"调高/调低等级",
				},
			},
			dangerous_actions_animation_skip_unsafe = {
				name = {
					"动画跳过：不安全",
				},
				text = {},
				unlock = {
					"允许将 {C:attention}#1#{} 调到 {C:mult}#2#{}",
					" ",
					"{C:mult}游戏的极限：一切都会立刻完成{}",
				},
			},
			speed_multiplier = {
				name = "速度倍率",
				text = {
					"提高游戏速度",
				},
				unlock = {
					"顾名思义，就是把游戏速度{C:attention}乘上倍率{}，",
					"所以默认值始终是 {C:attention}1x{}",
					" ",
					"从 {C:attention}128x{} 开始，还会加速",
					"{C:attention}事件队列{}，以突破",
					"每秒 60 次动作的限制",
				},
			},
			speed_multiplier_default_value = {
				name = "速度倍率：游戏初始默认值",
				text = {},
			},
			speed_multiplier_multiply = {
				name = {
					"速度倍率：调高倍率",
				},
				text = {},
			},
			speed_multiplier_divide = {
				name = {
					"速度倍率：调低倍率",
				},
				text = {},
			},
			speed_multiplier_toggle_temp_disabled = {
				name = {
					"速度倍率：临时关闭",
				},
				text = {},
				unlock = {
					"可作为{C:attention}临时开关{}来使用",
					"这样就不必每次都手动",
					"调高/调低倍率",
				},
			},
			dangerous_actions_speed_multiplier_uncap = {
				name = {
					"速度倍率：取消上限",
				},
				text = {},
				unlock = {
					"提高最大值 {C:chips}#1#{} 的上限",
					" ",
					"{C:mult}极高数值会严重拖垮性能{}",
				},
			},
			move_highlight = {
				name = "切换选中项",
				text = {
					"在大量卡牌中更精确地选牌",
				},
				unlock = {
					"当同一牌区里的牌",
					"多到难以操作时特别有用",
					" ",
					"先在牌区中{C:attention}选中{}卡牌，",
					"再使用下列操作",
				},
			},
			move_highlight_one_left = {
				name = {
					"切换选中项：左移一张",
				},
				text = {},
				unlock = {
					"你可以{C:attention}按住{}此快捷键持续移动",
				},
			},
			move_highlight_one_right = {
				name = {
					"切换选中项：右移一张",
				},
				text = {},
				unlock = {
					"你可以{C:attention}按住{}此快捷键持续移动",
				},
			},
			move_highlight_swap = {
				name = {
					"切换选中项：改为移牌",
				},
				text = {},
				unlock = {
					"{C:attention}按住时{}，",
					"移动的会是卡牌本身，而不是选中位置",
					"{C:inactive}(并非在所有牌区都有效){}",
				},
			},
			move_highlight_to_end = {
				name = {
					"切换选中项：移到最左/最右",
				},
				text = {},
				unlock = {
					"{C:attention}按住时{}，不再只是把选中项/卡牌",
					"向左一张/向右一张移动，",
					"而是直接移到最左/最右端",
				},
			},
			presets = {
				name = "配置预设",
				text = {
					"可随时切换的整套配置方案",
				},
			},
			presets_load_1 = {
				name = {
					"预设：加载预设 1",
				},
				text = {},
			},
			presets_load_2 = {
				name = {
					"预设：加载预设 2",
				},
				text = {},
			},
			presets_load_3 = {
				name = {
					"预设：加载预设 3",
				},
				text = {},
			},
			presets_load_next = {
				name = {
					"预设：加载下一个预设",
				},
				text = {},
				unlock = {
					"顺序：{C:attention}1{} -> {C:attention}2{} -> {C:attention}3{} -> {C:attention}1{}",
					"会跳过空预设或已禁用的预设",
				},
			},
			insta_actions = {
				name = "快速买/卖/用牌",
				text = {
					"减少点击，让买牌、卖牌和使用卡牌都更方便",
				},
			},
			insta_actions_trigger_mode = {
				name = "买/卖/用牌模式",
				text = {},
			},
			insta_actions_buy_or_sell = {
				name = {
					"快速买/卖卡牌",
				},
				text = {},
				unlock = {
					"具体行为取决于 {C:attention}#1#{}",
					" ",
					"{C:attention}按住{}快捷键并{C:attention}点击{}卡牌，",
					"可购买{C:inactive}(商店){}、选择{C:inactive}(补充包){}",
					"或出售{C:inactive}(小丑/消耗品槽位){}",
				},
			},
			insta_actions_buy_or_sell_alt = {
				name = {
					"快速买/卖卡牌",
				},
				text = {},
				unlock = {
					"具体行为取决于 {C:attention}#1#{}",
					" ",
					"把光标悬停在卡牌上，或先选中卡牌后{C:attention}按下{}快捷键，",
					"可购买{C:inactive}(商店){}、选择{C:inactive}(补充包){}",
					"或出售{C:inactive}(小丑/消耗品槽位){}",
				},
			},
			insta_actions_buy_n_sell = {
				name = {
					"即买即卖",
				},
				text = {
					"买下后立刻卖出",
				},
				unlock = {
					"具体行为取决于 {C:attention}#1#{}",
					" ",
					"{C:attention}按住{}快捷键并{C:attention}点击{}卡牌，",
					"可购买{C:inactive}(商店){}或选择{C:inactive}(补充包){}",
					"然后立刻卖出",
				},
			},
			insta_actions_buy_n_sell_alt = {
				name = {
					"即买即卖",
				},
				text = {
					"买下后立刻卖出",
				},
				unlock = {
					"具体行为取决于 {C:attention}#1#{}",
					" ",
					"把光标悬停在卡牌上，或先选中卡牌后{C:attention}按下{}快捷键，",
					"可购买{C:inactive}(商店){}或选择{C:inactive}(补充包){}",
					"然后立刻卖出",
				},
			},
			insta_actions_use = {
				name = {
					"快速使用卡牌",
				},
				text = {},
				unlock = {
					"具体行为取决于 {C:attention}#1#{}",
					" ",
					"{C:attention}按住{}快捷键并{C:attention}点击{}卡牌，",
					"可使用消耗牌{C:inactive}(若可用){}",
				},
			},
			insta_actions_use_alt = {
				name = {
					"快速使用卡牌",
				},
				text = {},
				unlock = {
					"具体行为取决于 {C:attention}#1#{}",
					" ",
					"把光标悬停在卡牌上，或先选中卡牌后{C:attention}按下{}快捷键，",
					"可使用消耗牌{C:inactive}(若可用){}",
				},
			},
			scoring_hold = {
				name = {
					"暂停计分",
				},
				text = {},
				unlock = {
					"允许在{C:attention}最终手牌得分{}",
					"结算出来{C:attention}之前{}暂停动画",
					" ",
					"方便在回合结束前调整小丑顺序",
				},
			},
			scoring_hold_any_moment = {
				name = {
					"暂停计分：任意时刻",
				},
				text = {},
				unlock = {
					"允许在计分的",
					"{C:attention}任意时刻{}暂停动画",
				},
			},
			regular_keybinds = {
				name = "常规与原版快捷键",
				text = {
					"包含所有原版操作，及更多扩展功能",
				},
			},
			regular_keybinds_group_game = {
				name = "游戏",
				text = {},
			},
			regular_keybinds_restart = {
				name = {
					"重开对局",
				},
				text = {},
				unlock = {
					"可{C:attention}替代{}原版",
					"{C:chips}#1#{}，效果完全一致",
					"{C:inactive}(仍需按住快捷键){}",
				},
			},
			regular_keybinds_quick_restart = {
				name = {
					"立即重开对局",
				},
				text = {},
				unlock = {
					"和原版重开一样，",
					"但会{C:attention}跳过动画{}",
					"并且立即触发",
					"{C:inactive}(无需长按){}",
					" ",
					"在{C:attention}游戏结束{}画面同样可用",
				},
			},
			regular_keybinds_save_run = {
				name = {
					"保存对局",
				},
				text = {
					"就像自动存档，但能手动触发",
				},
				unlock = {
					"游戏会在某些操作后自动保存",
					"{C:inactive}(如出牌、弃牌、商店刷新){}",
					" ",
					"此快捷键允许你手动执行保存",
				},
			},
			regular_keybinds_reload_run = {
				name = {
					"载入/重载对局",
				},
				text = {
					"主菜单 -> 继续对局",
				},
				unlock = {
					"模拟退出到主菜单",
					"{C:inactive}(若当前不在主菜单){}",
					"然后继续对局，",
					"并{C:attention}跳过动画{}",
				},
			},
			regular_keybinds_restart_game = {
				name = "重启游戏",
				text = {},
			},
			regular_keybinds_copy_log_file = {
				name = {
					"复制 Lovely 日志",
				},
				text = {},
				unlock = {
					"由于技术限制，日志会",
					"以{C:attention}文本{}形式复制，而不是文件",
				},
			},
			regular_keybinds_group_hand = {
				name = "手牌",
				text = {},
			},
			regular_keybinds_play = {
				name = {
					"出牌",
				},
				text = {},
			},
			regular_keybinds_discard = {
				name = {
					"弃牌",
				},
				text = {},
			},
			regular_keybinds_change_sort_rank = {
				name = {
					"按点数排序手牌",
				},
				text = {},
			},
			regular_keybinds_change_sort_suit = {
				name = {
					"按花色排序手牌",
				},
				text = {},
			},
			regular_keybinds_toggle_sort = {
				name = {
					"切换手牌排序",
				},
				text = {
					"花色 > 点数 > 花色……",
				},
			},
			regular_keybinds_group_round = {
				name = "回合",
				text = {},
			},
			regular_keybinds_start_fantoms_preview = {
				name = {
					"Fantom's Preview：计算分数",
				},
				text = {},
			},
			regular_keybinds_cash_out = {
				name = {
					"结算",
				},
				text = {},
				unlock = {
					"你可以提前{C:attention}按住{}快捷键，",
					"一到可结算时就会",
					"{C:attention}立刻{}跳过结算阶段",
				},
			},
			regular_keybinds_not_just_yet_interaction = {
				name = {
					"NotJustYet：结束回合",
				},
				text = {},
			},
			regular_keybinds_group_shop = {
				name = "商店",
				text = {},
			},
			regular_keybinds_skip_booster = {
				name = {
					"跳过补充包",
				},
				text = {},
				unlock = {
					"你可以通过{C:attention}按住{}快捷键，",
					"在可跳过时{C:attention}立刻{}跳过补充包",
					" ",
					"{C:attention}持续按住{}快捷键，还能连续跳过",
					"接连出现的多个{C:attention}补充包{}",
				},
			},
			regular_keybinds_reroll_shop = {
				name = {
					"刷新商店",
				},
				text = {},
			},
			regular_keybinds_leave_shop = {
				name = {
					"离开商店",
				},
				text = {},
			},
			regular_keybinds_group_blind_select = {
				name = "盲注选择",
				text = {},
			},
			regular_keybinds_skip_blind = {
				name = {
					"跳过盲注",
				},
				text = {},
			},
			regular_keybinds_select_blind = {
				name = {
					"选择盲注",
				},
				text = {},
			},
			regular_keybinds_reroll_boss = {
				name = {
					"重掷 Boss 盲注",
				},
				text = {},
			},
			regular_keybinds_group_menus = {
				name = "菜单",
				text = {},
			},
			regular_keybinds_mod_settings = {
				name = {
					"Handy：模组设置",
				},
				text = {},
			},
			regular_keybinds_show_deck_preview = {
				name = {
					"牌组预览",
				},
				text = {},
				unlock = {
					"效果和把鼠标悬停在牌组上时一样",
				},
			},
			regular_keybinds_options = {
				name = {
					"选项",
				},
				text = {},
				unlock = {
					"与 {C:chips}[Escape]{} 键相同",
				},
			},
			regular_keybinds_collection = {
				name = {
					"收藏",
				},
				text = {},
			},
			regular_keybinds_group_swappable_menus = {
				name = "可切换菜单",
				text = {},
				unlock = {
					"你可以使用快捷键",
					"在这些菜单间直接切换，",
					"{C:attention}无需先关闭{}当前菜单",
				},
			},
			regular_keybinds_swappable_overlays_mode = {
				name = "可切换菜单模式",
				text = {},
			},
			regular_keybinds_run_info = {
				name = {
					"对局信息：牌型",
				},
				text = {},
			},
			regular_keybinds_run_info_blinds = {
				name = {
					"对局信息：盲注",
				},
				text = {},
			},
			regular_keybinds_view_deck = {
				name = {
					"查看牌组",
				},
				text = {},
			},
			regular_keybinds_view_lobby_info = {
				name = {
					"多人：房间信息",
				},
				text = {},
			},
			dangerous_actions = {
				name = "危险操作",
				text = {
					"东西太多、手动处理太麻烦时",
				},
			},
			dangerous_actions_sell_one = {
				name = {
					"立即出售",
				},
				text = {},
				unlock = {
					"{C:attention}按住{}快捷键，并开始{C:attention}划过{}",
					"你想出售的卡牌",
					" ",
					"{C:attention}按住{}期间，被划过的项目",
					"都会加入队列",
					"在{C:attention}松开{}快捷键后，会统一出售",
				},
			},
			dangerous_actions_remove_one = {
				name = {
					"立即移除",
				},
				text = {
					"对跳过标签同样有效",
				},
				unlock = {
					"{C:attention}按住{}快捷键，并开始{C:attention}划过{}",
					"你想{C:mult}移除{}的卡牌/跳过标签",
					" ",
					"{C:attention}按住{}期间，被划过的项目",
					"都会加入队列",
					"在{C:attention}松开{}快捷键后，会统一{C:mult}移除{}",
					"{C:inactive}(绕过所有检查，且不返还金钱){}",
				},
			},
			dangerous_actions_mass_sell_remove_mode = {
				name = "批量出售/移除模式",
				text = {},
				unlock = {
					"适用于以下功能：",
					"{C:mult}[立即出售/移除所有同名]{}",
					"以及 {C:mult}[立即出售/移除全部]{}",
				},
			},
			dangerous_actions_sell_all_same = {
				name = {
					"立即出售所有同名",
				},
				text = {},
				unlock = {
					"{C:attention}按住{}快捷键并{C:attention}点击{}",
					"你想出售的卡牌",
				},
			},
			dangerous_actions_remove_all_same = {
				name = {
					"立即移除所有同名",
				},
				text = {
					"对跳过标签同样有效",
				},
				unlock = {
					"{C:attention}按住{}快捷键并{C:attention}点击{}",
					"你想{C:mult}移除{}的卡牌/跳过标签",
					"{C:inactive}(绕过所有检查，且不返还金钱){}",
				},
			},
			dangerous_actions_sell_all = {
				name = {
					"立即出售全部",
				},
				text = {},
				unlock = {
					"{C:attention}按住{}快捷键并{C:attention}点击{}",
					"你想出售的卡牌",
				},
			},
			dangerous_actions_remove_all = {
				name = {
					"立即移除全部",
				},
				text = {
					"对跳过标签同样有效",
				},
				unlock = {
					"{C:attention}按住{}快捷键并{C:attention}点击{}",
					"你想{C:mult}移除{}的卡牌/跳过标签",
					"{C:inactive}(绕过所有检查，且不返还金钱){}",
				},
			},
			dangerous_actions_crash = {
				name = {
					"让游戏崩溃",
				},
				text = {},
				unlock = {
					"{C:mult}就是字面意思{}",
				},
			},
			dangerous_actions_stack_overflow = {
				name = {
					"让游戏崩溃：栈溢出",
				},
				text = {},
				unlock = {
					"{C:mult}就是字面意思{}",
					"{C:mult}游戏会卡死并/或自行退出{}",
				},
			},
			misc = {
				name = "杂项",
				text = {},
			},
			mp_extension = {
				name = {
					"多人扩展",
				},
				text = {
					"Handy × Multiplayer 联动扩展",
				},
			},
			mp_extension_current_lobby = {
				name = {
					"多人扩展：当前房间设置",
				},
				text = {},
			},
			mp_extension_enabled = {
				name = "允许多人扩展",
				text = {},
				unlock = {
					"勾选此项后，{C:attention}你{}便同意",
					"在当前房间启用 {C:mult}多人扩展{}",
					" ",
					"只有房间内{C:attention}所有{}玩家都启用后，",
					"像 {C:chips}#1#{} 和 {C:attention}#2#{} 这样的功能",
					"才会对房间内{C:attention}所有{}玩家生效",
				},
			},
			mp_extension_speed_multiplier_mode = {
				name = "速度倍率：房间最大值",
				text = {},
				unlock = {
					"你仍需{C:attention}手动{}把数值调高",
					"{C:inactive}(通过快捷键或设置中的开关/选项){}",
					" ",
					"房间只会限制{C:attention}上限{}",
				},
			},
			mp_extension_animation_skip_mode = {
				name = "动画跳过：房间最大值",
				text = {},
				unlock = {
					"你仍需{C:attention}手动{}把数值调高",
					"{C:inactive}(通过快捷键或设置中的开关/选项){}",
					" ",
					"房间只会限制{C:attention}上限{}",
				},
			},
			mp_extension_dangerous_actions_mode = {
				name = "危险操作：房间模式",
				text = {},
				unlock = {
					"允许启用部分{C:mult}危险操作{}",
				},
			},
			mp_extension_default_values = {
				name = {
					"多人扩展：默认房间设置",
				},
				text = {},
			},
			mp_extension_speed_multiplier_mode_default_value = {
				name = "速度倍率：房间默认最大值",
				text = {},
				unlock = {
					"当你{C:attention}创建房间{}时，",
					"此值会作为默认值设置",
				},
			},
			mp_extension_animation_skip_mode_default_value = {
				name = "动画跳过：房间默认最大值",
				text = {},
				unlock = {
					"当你{C:attention}创建房间{}时，",
					"此值会作为默认值设置",
				},
			},
			mp_extension_dangerous_actions_mode_default_value = {
				name = "危险操作：房间默认模式",
				text = {},
				unlock = {
					"当你{C:attention}创建房间{}时，",
					"此值会作为默认值设置",
				},
			},
			mp_extension_enabled_default_value = {
				name = "允许多人扩展：默认值",
				text = {},
				unlock = {
					"当你{C:attention}创建或加入房间{}时，",
					"会默认采用此值，以决定你是否要",
					"在当前房间启用{C:mult}多人扩展{}",
				},
			},
		},
		Handy_Preset = {
			["default"] = {
				name = "默认",
				text = {
					"模组默认配置",
				},
			},
			["better_mouse_and_gamepad"] = {
				name = "Better Mouse and Gamepad",
				text = {
					"更接近Mod Better Mouse and Gamepad 的控制方案",
				},
			},
			["full_default"] = {
				name = "重置为默认",
				text = {
					"完全重置为默认配置",
				},
			},
		},
		Handy_Other = {
			overall_title = {
				text = {
					"- 滑过即可选牌",
					"- 游戏内快捷键",
					"- 更高的游戏速度",
					"- 移除多余动画",
					"- 更完善的手柄支持",
					" ",
					"- 所有操作都可绑定到{C:chips}任意组合{}",
					"  的键盘、鼠标或手柄按键上",
					"  还能{C:chips}随时{}开启/关闭",
					"  无需重启游戏或重新载入对局",
					"- {C:chips}不会{}禁用成就",
				},
			},
			missing_deps = {
				text = {
					"需先启用以下功能，",
					"此项才会生效：",
				},
			},
			cant_use_in_mp = {
				text = {
					"{C:mult}此项在多人模式中不可用{}",
				},
			},
			cant_use_with_gamepad = {
				text = {
					"{C:mult}此项在{}{C:attention}手柄{}上不可用",
				},
			},
			missing_req_mods = {
				text = {
					"此项需要以下模组才能使用：",
				},
			},
			conflict_mods = {
				text = {
					"此项因与以下模组冲突而无法启用：",
				},
			},
			mp_lobby_require_all_hint = {
				text = {
					"以下所有房间设置仅在",
					"{C:attention}全部{}房间成员都安装了 {C:chips}Handy v2.0{} 或更新版本时生效",
				},
			},
			better_mouse_and_gamepad_in_hand_selection = {
				text = {
					"{C:mult,s:1.5}哎呀……{}",
					" ",
					"看来你装了 {C:attention}Better Mouse and Gamepad{}。",
					"我这边有一个{C:mult}坏消息{}和一个{C:green}好消息{}。",
					" ",
					"{C:mult}坏消息{}是，{C:attention}BMaG{} 会完全接管 {C:chips}Handy{} 的选牌逻辑，",
					"还会让一些按键输入失效，例如",
					"{C:chips}[滚轮上/下]{}、{C:chips}[鼠标 3]{}、{C:chips}[鼠标右键]{} 等。",
					" ",
					"{C:green}好消息{}是，{C:chips}Handy{} 已经把它的功能做得{C:inactive,s:0.75}差不多{}了",
					"所以你就算卸载 {C:attention}BMaG{}，也几乎不会损失什么。",
					" ",
					"当然，你也可以继续{C:attention}两个模组一起用{}，大多数情况下也不会出问题。",
					"{s:0.8}虽然我个人不太喜欢这种搭配，但用什么模组，还是你说了算。{}",
				},
			},
		},
	},
	misc = {
		handy_keybinds = {
			None = "无",
			Unknown = "未知",
			["Left Mouse"] = "鼠标左键",
			["Right Mouse"] = "鼠标右键",
			["Middle Mouse"] = "鼠标中键",
			["Mouse 4"] = "鼠标侧键1",
			["Mouse 5"] = "鼠标侧键2",
			["Wheel Up"] = "滚轮上",
			["Wheel Down"] = "滚轮下",
			Escape = "Esc",
			Shift = "Shift",
			Ctrl = "Ctrl",
			Alt = "Alt",
			GUI = "Win/Cmd",
			Enter = "回车",
			Tab = "Tab",
			Backspace = "退格",
			["Num Lock"] = "数字锁",
			["Caps Lock"] = "大写锁",
			["Scroll Lock"] = "滚动锁",
			Left = "←",
			Right = "→",
			Up = "↑",
			Down = "↓",
			Backquote = "`",
			Singlequote = "'",
			Quote = "\"",
			["Left Bracket"] = "[",
			["Right Bracket"] = "]",
			Printscreen = "PrintScreen",
			Delete = "Delete",
			Home = "Home",
			Insert = "Insert",
			End = "End",
			Pause = "Pause",
			Help = "Help",
			Sysreq = "SysRq",
			Menu = "Menu",
			Undo = "Undo",
			Mode = "Mode",
			["Page Up"] = "PgUp",
			["Page Down"] = "PgDn",
			Www = "WWW",
			Mail = "邮件",
			Calculator = "计算器",
			Computer = "电脑",
			Appsearch = "应用搜索",
			Apphome = "应用首页",
			Appback = "应用后退",
			Appforward = "应用前进",
			Apprefresh = "应用刷新",
			Appbookmarks = "应用书签",
			Currencyunit = "货币符号",
			Application = "应用",
			Power = "电源",
			["(A)"] = "(A)",
			["(B)"] = "(B)",
			["(X)"] = "(X)",
			["(Y)"] = "(Y)",
			["(Back)"] = "(返回)",
			["(Guide)"] = "(导航)",
			["(Start)"] = "(开始)",
			["(Up)"] = "(上)",
			["(Down)"] = "(下)",
			["(Left)"] = "(左)",
			["(Right)"] = "(右)",
			["Left Stick"] = "左摇杆按下",
			["Right Stick"] = "右摇杆按下",
			["Left Bumper"] = "LB",
			["Right Bumper"] = "RB",
			["Left Trigger"] = "LT",
			["Right Trigger"] = "RT",
			["First Paddle"] = "拨片1",
			["Second Paddle"] = "拨片2",
			["Third Paddle"] = "拨片3",
			["Fourth Paddle"] = "拨片4",
			["(Misc. Button)"] = "杂项键",
			["Touchpad Press"] = "触摸板点击",
		},
		handy_tabs = {
			Overall = "总览",
			Presets = "预设",
			Search = "搜索",
			General = "通用",
			["Fast hand selection"] = "快速选牌",
			["Speed & Animations"] = "速度与动画",
			["Vanilla keybinds"] = "原版快捷键",
			["Quick buy/sell/use"] = "快速买/卖/用牌",
			["Highlight movement"] = "切换选中项",
			Misc = "杂项",
			Dangerous = "危险区",
			Speed = "速度",
			Animations = "动画",
			Hold = "暂停",
			Round = "回合",
			["Hand & Round"] = "手牌/回合",
			["Shop & Blind Select"] = "商店/盲注",
			Game = "游戏",
			Menus = "菜单",
			["MP Extension"] = "多人扩展",
			Updater = "模组更新",
			["Updater Settings"] = "设置",
		},
		v_dictionary = {
			Handy_version_by = "v#1#，作者 #2#",
			Handy_module_keys_single = "[#1#]",
			Handy_module_keys_or = "[#1#] 或 [#2#]",
			Handy_items_in_queue = "[队列中：#1#]",
			Handy_temp_disabled = "[已禁用]",
			Handy_disabled_in_mp = "[已被多人模式禁用]",
			Handy_gamespeed_multiplier = "游戏速度倍率：#1#",
			Handy_event_queue_retriggers_amount = "事件队列加速：#1#",
			Handy_animation_skip = "动画跳过：#1#",
			Handy_skip_booster_pack = "跳过补充包",
			Handy_scoring_hold = "暂停计分动画",
			Handy_scoring_hold_hand_score = "手牌得分：[#1#]",
			Handy_hand_sorting = "手牌排序：#1#",
			Handy_preset_index = "预设 #1#",
			Handy_preset_saved = "预设 #1# [#2#] 已保存",
			Handy_preset_loaded = "已加载预设 #1# [#2#]",
			Handy_preset_empty = "预设 #1# [#2#] 为空",
			Handy_preset_disabled = "预设 #1# [#2#] 已禁用",
			Handy_preset_example_loaded = "已加载官方预设 [#1#]",
			Handy_preset_nothing_to_load = "没有可加载的预设",
			Handy_binding_canceled = "绑定已取消",
			Handy_binding_cancel_reason_no_safe = "此处不能绑定 #1#，以防止“软锁”",
			Handy_binding_cancel_reason_no_hold = "此处不能绑定 #1#，因为它不支持长按",
			Handy_binding_cancel_reason_multiple_no_hold = "组合中不能包含多个不支持长按的按键",
			Handy_binding_finished = "绑定完成：#1#",
			Handy_binding_progress = "绑定中：#1#",
			Handy_binding_esc_hint = "按下 #1# 保存",
			Handy_binding_guide = "按下按键即可将其加入组合",
			Handy_reload_run_done = "对局已重新载入",
			Handy_reload_run_nothing_to_load = "没有可重载的对局",
			Handy_load_run_done = "对局已载入",
			Handy_load_run_nothing_to_load = "没有可载入的对局",
			Handy_prevented_by_debugplus = "已被 DebugPlus 阻止",
			Handy_log_file_copied = "Lovely 日志已复制到剪贴板",
			Handy_updater_finish_success = "版本安装成功",
			Handy_updater_finish_no_fetcher = "没有可用的请求 API",
			Handy_updater_finish_no_connection = "网络连接不可用",
			Handy_updater_finish_invalid_server_response = "服务器响应无效",
			Handy_updater_finish_no_release = "未找到可用版本",
			Handy_updater_finish_check_request_failed = "无法检查可用版本",
			Handy_updater_finish_cannot_write_zip = "无法保存版本文件",
			Handy_updater_finish_download_request_failed = "无法下载版本",
			Handy_updater_finish_cannot_unzip = "无法解压版本文件",
			Handy_updater_finish_cannot_move_files = "无法安装版本文件",
			Handy_updater_finish_no_data_to_replace = "没有可安装的版本文件",
			Handy_updater_finish_description = "请重启游戏以应用更改",
			Handy_updater_progress_getting_releases = "正在获取版本列表……",
			Handy_updater_progress_downloading_release = "正在下载版本……",
			Handy_updater_progress_unzipping_archive = "正在解压版本……",
			Handy_updater_progress_installing_files = "正在安装版本……",
			Handy_new_pre_release_available = "有新的预发布版本可用",
			Handy_new_stable_available = "有新的稳定版可用",
			Handy_new_release_description = "前往模组设置查看详情并下载",
			Handy_updater_auto_restart = "正在重启游戏以应用更改……",
		},
		dictionary = {
			handy_or = "或",
			handy_disabled = "已禁用",
			handy_mod_enabled = "模组已启用",
			handy_mod_disabled = "模组已禁用",
			handy_example_state_panel = "这里会显示各种提示",
			ph_handy_premade_presets = "官方预设",
			ph_handy_custom_presets = "自定义预设",
			b_handy_preset_save = "保存",
			b_handy_preset_load = "加载",
			b_handy_preset_clear = "清空",
			handy_preset_name_placeholder = "预设名称",
			b_handy_notif_quick = "Handy 操作",
			b_handy_notif_dangerous = "危险操作",
			b_handy_search_placeholder = "搜索…",
			b_handy_search = "搜索",
			b_handy_clear = "清除",
			ph_handy_notif_quick_use = "快速用牌",
			ph_handy_notif_quick_buy_or_sell = "快速买/卖卡牌",
			ph_handy_notif_quick_buy_n_sell = "即买即卖",
			ph_handy_notif_unsafe_disabled = "模组设置中已禁用不安全操作",
			ph_handy_notif_unsafe_disabled_by_other_mod = "其他模组已禁用不安全操作",
			ph_handy_notif_unsafe = "[不安全] 可能会出现 Bug！",
			ph_handy_notif_insta_remove = "立即移除",
			ph_handy_notif_insta_sell = "立即出售",
			ph_handy_notif_remove_all = "移除所点区域内的全部卡牌/标签",
			ph_handy_notif_sell_all = "出售所点区域内的全部卡牌",
			ph_handy_notif_remove_all_same = "移除所点卡牌/标签的全部副本",
			ph_handy_notif_sell_all_same = "出售所点卡牌的全部副本",
			ph_handy_notif_nopeus_unsafe_disabled = "模组设置中已禁用不安全操作",
			ph_handy_notif_animation_skip_unsafe_disabled = "模组设置中已禁用不安全操作",
			ph_handy_notif_misc_save_run_start = "开始保存对局…",
			ph_handy_notif_misc_save_run_saving = "正在保存对局…",
			ph_handy_notif_misc_save_run_saved = "对局已保存",
			ph_handy_notif_misc_save_run_interrupt = "当前无法保存对局",
			handy_animation_skip_levels = {
				["1"] = "无",
				["2"] = "提示",
				["3"] = "动画",
				["4"] = "所有",
				["5"] = "不安全",
			},
			handy_modals_start_calculation = {
				"开始",
				"计算",
			},
			handy_modals_stop_calculation = {
				"停止",
				"计算",
			},
			handy_modals_preview_description = "可通过预览查看设置效果",
			handy_modals_move_highlight_preview_description = "可通过预览测试这些操作",
			ph_handy_dangerous_actions_sell_one = "卖一张",
			ph_handy_dangerous_actions_remove_one = "移除一张",
			ph_handy_dangerous_actions_sell_all_same = "卖掉所有同名",
			ph_handy_dangerous_actions_remove_all_same = "移除所有同名",
			ph_handy_dangerous_actions_sell_all = "全部卖掉",
			ph_handy_dangerous_actions_remove_all = "全部移除",
			handy_keybinds_trigger_mode_press = "按下时触发",
			handy_keybinds_trigger_mode_release = "松开时触发",
			handy_current_device_auto = "自动",
			handy_current_device_keyboard = "鼠标 + 键盘",
			handy_current_device_gamepad = "手柄",
			handy_notification_level_none = "无",
			handy_notification_level_dangerous = "仅危险操作",
			handy_notification_level_essential = "重要提示",
			handy_notification_level_all = "全部提示",
			handy_buy_sell_use_mode_hold_n_click = "按住快捷键 + 点击卡牌",
			handy_buy_sell_use_mode_hover_n_press = "悬停/选中卡牌 + 按下快捷键",
			handy_advanced_mode = "高级模式",
			handy_advanced_mode_description = "更多控制与信息",
			k_handy_preview_sell = "出售",
			k_handy_preview_buy = "购买",
			k_handy_preview_use = "使用",
			k_handy_preview_buy_n_use = "购买并使用",
			k_handy_preview_buy_n_sell = "即买即卖",
			k_handy_preview_remove = "移除",
			handy_mp_speed_multiplier_mode = "速度倍率：房间最大值",
			handy_mp_animation_skip_mode = "动画跳过：房间最大值",
			handy_mp_dangerous_actions_mode = "危险操作：房间模式",
			handy_mp_dangerous_actions_modes = {
				"已禁用",
				"仅批量出售",
				"批量出售与移除",
			},
			handy_regular_keybinds_swappable_overlays_mode = {
				"按下打开",
				"按下打开 / 再按一次关闭",
				"按住打开 / 松开关闭",
			},
			handy_dangerous_actions_mass_sell_remove_mode = {
				"作用于全部卡牌",
				"作用于除目标卡外的所有卡牌",
			},

			handy_show_custom_pip_mode = {
				"无",
				"仅手柄",
				"总是",
			},
			handy_mp_extension_status_not_initialized = "此房间中的多人扩展尚未加载",
			handy_mp_extension_status_disabled = "此房间中的多人扩展已被你禁用",
			handy_mp_extension_status_disabled_by_ruleset = "此房间中的多人扩展已被规则集禁用",
			handy_mp_extension_status_disabled_by_other_player = "此房间中的多人扩展已被其他玩家禁用",
			handy_mp_extension_status_enabled = "此房间中的多人扩展已启用",
			handy_updater_no_release_found = "未找到版本数据",
			handy_updater_status_no_data = "没有版本数据",
			handy_updater_status_current_version = "当前版本",
			handy_updater_status_already_installed = "已安装 - 重启游戏生效",
			handy_updater_status_busy = "请稍候……",
			handy_updater_status_ready_for_installation = "可开始安装",
			handy_updater_status_new_version_available = "有新版本可用",
			b_handy_install = "安装",
			b_handy_restart_game = "重启游戏",
			handy_release_type_stable = "稳定版",
			handy_release_type_pre_release = "预发布版",
			handy_smods_compat_mode = "兼容模式：从 .zip 压缩包加载需要较新的 SMODS！",
		},
	},
}
