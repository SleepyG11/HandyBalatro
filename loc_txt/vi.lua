return {
	descriptions = {
		Handy_ConfigDictionary = {
			-- [Version, Author]
			general = {
				name = "Handy v#1# bởi #2#",
				text = {},
			},

			-- []
			handy = {
				name = "Công tắc mod toàn cục",
				text = {
					"Bỏ chọn để tắt MỌI tính năng mod",
				},
				unlock = {
					"Bất kì điều khiển nào cũng có thể bật/tắt",
					"tại {C:attention}bất kì thời điểm nào{} mà không",
					"cần tải lại trận hay trò chơi",
				},
			},

			-- []
			keybinds_trigger_mode = {
				name = "Chế độ kích hoạt phím tắt",
				text = {},
			},
			-- [Auto]
			current_device = {
				name = "Thiết bị nhập liệu",
				text = { "Chuột + Bàn Phím, hoặc Gamepad" },
				unlock = {
					"Mod dùng bộ phím tắt tách biệt giữa",
					"{C:attention}Chuột + Bàn Phím{} và {C:attention}Gamepad{}",
					"chuyển đổi giữa chúng dựa trên",
					"thiết bị mà bạn đang sử dụng",
					'{C:inactive}(nếu đã chọn "#1#"){}',
				},
			},
			-- [Ctrl]
			prevent_if_debugplus = {
				name = "DebugPlus: Ngăn tương tác chéo",
				text = {},
				unlock = {
					"Không thực hiện điều khiển nào khi giữ {C:chips}#1#{}",
					"để ngăn hiện tương chồng chéo với",
					"điểu khiển của {C:attention}DebugPlus{}",
					" ",
					'Yêu cầu bật {C:attention}"CTRL for Keybinds"{}',
					"trong cài đặt của mod",
					" ",
					"Có tác dụng phụ khiến phím tắt",
					"có dùng {C:chips}#1# {C:mult}bất hoạt{}",
				},
			},

			-- []
			gamepad = {
				name = "Cài đặt Gamepad",
				text = {},
			},
			-- [Right stick, Left stick]
			swap_controller_cursor_stick = {
				name = "Gamepad: Tráo stick con trỏ",
				text = {},
				unlock = {
					"{C:chips}#1#{} mặc định sẽ kích hoạt",
					"con trỏ của trò chơi.",
					" ",
					"Cài đặt này chuyển nó sang {C:chips}#2#{}",
				},
			},
			-- []
			controller_sensitivity = {
				name = "Gamepad: Độ nhạy con trỏ",
				text = {},
			},

			-- []
			appearance = {
				name = "Hiển thị",
				text = {},
			},
			-- []
			hide_options_button = {
				name = "Ẩn nút mod trong tuỳ chọn",
				text = {},
			},
			-- []
			notifications_level = {
				name = "Thông báo",
				text = {},
			},
			-- []
			speed_multiplier_settings_toggle = {
				name = "Hệ Số Tốc Độ: Chỉnh trong cài đặt",
				text = {},
				unlock = {
					"Đặt gần cài đặt {C:attention}Tốc độ trò chơi{} của Vanilla",
				},
			},
			-- []
			animation_skip_settings_toggle = {
				name = "Bỏ Qua Hoạt Ảnh: Chỉnh trong cài đặt",
				text = {},
				unlock = {
					"Đặt gần cài đặt {C:attention}Tốc độ trò chơi{} của Vanilla",
				},
			},
			-- []
			show_custom_pip = {
				name = "Hiển thị phím tắt trên nút",
				text = {},
				unlock = {
					"Hiển thị phím tắt trên",
					"nút mà chúng sẽ kích hoạt",
					"{C:inactive}(Chơi tay bài, Bỏ bài, T.tin Trận này, Gieo lại, v.v...){}",
				},
			},

			-- []
			updater = {
				name = "Tự động cập nhật mod",
				text = { "Bố biết chú rất lười" },
			},
			-- []
			updater_target_release_type = {
				name = "Mục tiêu cập nhật",
				text = {},
			},
			-- []
			updater_notify_about_new_update = {
				name = "Thông báo về cập nhật mới",
				text = {},
				unlock = {
					"Bạn sẽ thấy thông báo khi {C:attention}khởi chạy trò chơi{}",
				},
			},
			-- []
			updater_auto_install_new_update = {
				name = "Tự động cài đặt bản cập nhật",
				text = {},
				unlock = {
					"Bản cập nhật sẽ được cài đặt khi {C:attention}khởi chạy trò chơi{}",
				},
			},
			-- []
			updater_auto_restart_game_after_update = {
				name = "Tự khởi động lại trò chơi sau cập nhật",
				text = {},
			},

			-- [@lord.ruby]
			me = {
				name = "Chào nhé, đó là tôi! Tôi sẽ theo bạn...",
				text = {
					"Ảnh vẽ bởi {C:mult}#1#{}",
				},
			},
			-- []
			me_in_mod_config = {
				name = "...trong tuỳ chọn mod",
				text = {},
			},
			-- []
			me_in_game_over = {
				name = "...trong màn hình thua cuộc",
				text = {},
			},
			-- []
			me_in_game_win = {
				name = "...trong màn hình chiến thắng",
				text = {},
			},
			-- []
			me_in_screenswipe = {
				name = "...trong lá bài dọn màn",
				text = {},
			},

			-- []
			hand_selection = {
				name = "Chọn & Bỏ Chọn Tay Bài",
				text = {
					"Vuốt để chọn, và thêm nữa",
				},
			},
			-- [Left Mouse, Hand deselection]
			hand_selection_mode = {
				name = "Phương thức chọn tay bài",
				text = {
					"Chọn mod đã dùng trước đây",
				},
				unlock = {
					"Ảnh hưởng đến sự rối rắm của cách",
					"{C:attention}chọn{} and {C:attention}bỏ chọn tay bài{} hoạt động",
					"khi dùng phím khác {C:chips}#1#{} và/hoặc",
					"{C:chips}#2#{} có cùng phím tắt:",
					" ",
					"{C:attention}Handy{} - chọn ngay, không thể bỏ chọn",
					"{C:attention}BMaG{} - chọn sau khi di chuyển, bỏ chọn khi thả",
				},
			},
			-- [Left mouse]
			hand_selection_insta_highlight = {
				name = { "Chọn tay bài nhanh" },
				text = {
					"Kéo thả, lia, vuốt, trượt để chọn",
				},
				unlock = {
					"Khi gắn vào {C:chips}#1#{},",
					"bắt đầu giữ {C:attention}BÊN NGOÀI{} lá bài",
					"rồi lia chuột lên để chọn",
					"{C:inactive}(bởi vì không làm thế sẽ túm lá bài){}",
				},
			},
			-- []
			hand_selection_insta_highlight_allow_deselect = {
				name = { "Bỏ chọn tay bài nhanh" },
				text = {},
				unlock = {
					"{C:inactive}Khi lia chuột lên lá bài:{}",
					"Nếu lá {C:attention}đầu tiên {C:mult}không được{} chọn, {C:chips}chọn{} hàng loạt",
					"Nếu lá {C:attention}đầu tiên {C:chips}đã được{} chọn, {C:mult}bỏ chọn{} hàng loạt",
				},
			},
			-- []
			hand_selection_combine_select_deselect = {
				name = { "Kết hợp chọn & bỏ chọn" },
				text = {},
				unlock = {
					"{C:inactive}Khi lia chuột lên lá bài:{}",
					"Nếu lá bài {C:mult}không được{} chọn, {C:chips}chọn{} nó",
					"Nếu là bài {C:chips}đã được{} chọn, {C:mult}bỏ chọn{} nó",
				},
			},
			-- [Right mouse]
			hand_selection_deselect_hand = {
				name = { "Bỏ chọn tay bài" },
				text = {
					"#1# của Vanilla",
				},
			},
			-- []
			hand_selection_entire_f_hand = {
				name = { "Chọn toàn bộ tay bài" },
				text = {},
				unlock = {
					"Chọn số lá {C:attention}cao nhất có thể{},",
					"từ trái sang phải",
				},
			},

			-- [None, Messages, Animations, Everything]
			animation_skip = {
				name = "Bỏ Qua Hoạt Ảnh",
				text = {
					"Loại bỏ hoạt ảnh ghi điểm và hoạt ảnh khác",
				},
				unlock = {
					"Thay thế trực tiếp tính năng tương tự",
					"của các mod như {C:attention}Talisman{}, {C:attention}Saturn{} hoặc {C:attention}Nopeus{}",
					" ",
					"Có 4 mức độ:",
					"{C:chips}#1#{} - không thay đổi",
					"{C:chips}#2#{} - loại bỏ tin nhắn {C:mult}XNhân{}, {C:attention}Lần nữa!{} và tin nhắn kích hoạt khác",
					"{C:attention}#3#{} - ghi điểm tức thì",
					"{C:attention}#4#{} - loại bỏ hầu hết hoạt ảnh; bốc bài tức thì",
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
				name = "Bỏ Qua Hoạt Ảnh: Giá trị hiện tại",
				text = {},
			},
			-- []
			animation_skip_default_value = {
				name = "Bỏ Qua Hoạt Ảnh: Giá trị khởi chạy trò chơi",
				text = {},
			},
			-- []
			animation_skip_increase = {
				name = { "Bỏ Qua Hoạt Ảnh: Tăng" },
				text = {},
			},
			-- []
			animation_skip_decrease = {
				name = { "Bỏ Qua Hoạt Ảnh: Giảm" },
				text = {},
			},
			-- []
			animation_skip_toggle_temp_disabled = {
				name = { "Bỏ Qua Hoạt Ảnh: Bật/tắt" },
				text = {},
			},
			-- [Unsafe]
			dangerous_actions_animation_skip_unsafe = {
				name = { "Bỏ Qua Hoạt Ảnh: Không An Toàn" },
				text = {},
				unlock = {
					"Cho phép chỉnh lên mức độ {C:mult}#1#{}",
					" ",
					"{C:mult}Giới hạn tuyệt đối: mọi thứ đều tức thì{}",
				},
			},

			-- [128x]
			speed_multiplier = {
				name = "Hệ Số Tốc Độ",
				text = {
					"Tăng tốc độ trò chơi",
				},
				unlock = {
					"Như cái tên đã nói, {C:attention}nhân{} tốc độ trò chơi,",
					"có nghĩa là giá trị mặc định luôn là {C:attention}1x{}",
					" ",
					"Bắt đầu từ {C:attention}#1#{}, gia tốc",
					"{C:attention}Hàng Chờ Sự Kiện{} để vượt giới hạn",
					"60 hành động mỗi giây",
				},
			},
			-- []
			speed_multiplier_current_value = {
				name = "Hệ Số Tốc Độ: Giá trị hiện tại",
				text = {},
			},
			-- []
			speed_multiplier_default_value = {
				name = "Hệ Số Tốc Độ: Giá trị khởi chạy trò chơi",
				text = {},
			},
			-- []
			speed_multiplier_multiply = {
				name = { "Hệ Số Tốc Độ: Tăng" },
				text = {},
			},
			-- []
			speed_multiplier_divide = {
				name = { "Hệ Số Tốc Độ: Giảm" },
				text = {},
			},
			-- []
			speed_multiplier_toggle_temp_disabled = {
				name = { "Hệ Số Tốc Độ: Bật/tắt" },
				text = {},
			},
			-- [x200k]
			dangerous_actions_speed_multiplier_uncap = {
				name = { "Hệ Số Tốc Độ: Không giới hạn" },
				text = {},
				unlock = {
					"Tăng giới hạn tốc độ tối đa lên {C:mult}#1#{}",
					" ",
					"{C:mult}Giá trị cao giảm mạnh hiệu suất phần cứng{}",
				},
			},

			-- []
			move_highlight = {
				name = "Chọn chính xác",
				text = {
					"Chọn & di chuyển lá bài chính xác",
				},
				unlock = {
					"Hữu dụng cho việc quản lý lá bài ở",
					"một khu vực chứa rất nhiều lá bài",
					" ",
					"{C:attention}Chọn{} một lá trong khu vực bài",
					"rồi dùng phím điều khiển được liệt kê",
				},
			},
			-- []
			move_highlight_one_left = {
				name = { "Chọn chính xác: Một ô trái" },
				text = {},
				unlock = {
					"Bạn có thể {C:attention}giữ{} phím này",
					"để tăng tốc di chuyển",
				},
			},
			-- []
			move_highlight_one_right = {
				name = { "Chọn chính xác: Một ô phải" },
				text = {},
				unlock = {
					"Bạn có thể {C:attention}giữ{} phím này",
					"để tăng tốc di chuyển",
				},
			},
			-- []
			move_highlight_swap = {
				name = { "Chọn chính xác: Di chuyển bài" },
				text = {},
				unlock = {
					"Khi {C:attention}giữ phím{}, lá bài sẽ được",
					"di chuyển thay vì đổi mục tiêu chọn",
				},
			},
			-- []
			move_highlight_to_end = {
				name = { "Chọn chính xác: Di chuyển đến cuối" },
				text = {},
				unlock = {
					"Khi {C:attention}giữ phím{}, thay vì chuyển mục tiêu chọn/di chuyển",
					"lá bài {C:attention}một ô trái/phải{}, sẽ di chuyển sang",
					"ô {C:attention}tít bên trái/phải{} tương ứng",
				},
			},

			-- []
			presets = {
				name = "Tuỳ chỉnh đặt trước",
				text = {
					"Dễ dàng thay đổi bố cục tuỳ chỉnh",
				},
			},
			-- []
			presets_load_1 = {
				name = { "Đặt trước: Tải bộ 1" },
				text = {},
			},
			-- []
			presets_load_2 = {
				name = { "Đặt trước: Tải bộ 2" },
				text = {},
			},
			-- []
			presets_load_3 = {
				name = { "Đặt trước: Tải bộ 3" },
				text = {},
			},
			-- []
			presets_load_next = {
				name = { "Đặt trước: Tải bộ tiếp theo" },
				text = { "1 -> 2 -> 3 -> 1" },
				unlock = {
					"Bỏ qua bộ trống hoặc đã tắt",
				},
			},

			-- []
			insta_actions = {
				name = "Mua/Bán/Dùng Nhanh",
				text = {
					"Bỏ qua nhấp chuột và dùng lá bài nhanh hơn",
				},
			},
			-- []
			insta_actions_trigger_mode = {
				name = "Chế độ Mua/Bán/Dùng",
				text = {},
			},
			-- [Buy/Sell/Use mode]
			insta_actions_buy_or_sell = {
				name = { "Mua/Bán nhanh lá bài" },
				text = {},
				unlock = {
					"Cách thức quyết định bởi {C:attention}#1#{}",
					" ",
					"{C:attention}Giữ{} phím tắt và {C:attention}nhấp{} lá bài",
					"để mua {C:inactive}(từ shop){}, chọn {C:inactive}(từ gói bài){}",
					"hoặc bán {C:inactive}(từ ô joker/tiêu thụ){}",
				},
			},
			-- [Buy/Sell/Use mode]
			insta_actions_buy_or_sell_alt = {
				name = { "Mua/Bán nhanh lá bài" },
				text = {},
				unlock = {
					"Cách thức quyết định bởi {C:attention}#1#{}",
					" ",
					"{C:attention}Lia/túm{} lá bài rồi {C:attention}nhấn{} phím tắt",
					"để mua {C:inactive}(từ shop){}, chọn {C:inactive}(từ gói bài){}",
					"hoặc bán {C:inactive}(từ ô joker/tiêu thụ){}",
				},
			},
			-- [Buy/Sell/Use mode]
			insta_actions_buy_n_sell = {
				name = { "Mua-và-Bán nhanh lá bài" },
				text = { "Mua rồi Bán ngay sau đó" },
				unlock = {
					"Cách thức quyết định bởi {C:attention}#1#{}",
					" ",
					"{C:attention}Giữ{} phím tắt và {C:attention}nhấp{} lá bài",
					"để mua {C:inactive}(từ shop){} hoặc chọn {C:inactive}(từ gói bài){}",
					"và {C:attention}bán ngay{} sau đó",
				},
			},
			-- [Buy/Sell/Use mode]
			insta_actions_buy_n_sell_alt = {
				name = { "Mua-và-Bán nhanh lá bài" },
				text = { "Mua rồi Bán ngay sau đó" },
				unlock = {
					"Cách thức quyết định bởi {C:attention}#1#{}",
					" ",
					"{C:attention}Lia/túm{} lá bài rồi {C:attention}nhấn{} phím tắt",
					"để mua {C:inactive}(từ shop){} hoặc chọn {C:inactive}(từ gói bài){}",
					"và {C:attention}bán ngay{} sau đó",
				},
			},
			-- [Buy/Sell/Use mode]
			insta_actions_use = {
				name = { "Dùng nhanh lá bài" },
				text = {},
				unlock = {
					"Cách thức quyết định bởi {C:attention}#1#{}",
					" ",
					"{C:attention}Giữ{} phím tắt và {C:attention}nhấp{} lá bài",
					"để dùng nó {C:inactive}(nếu có thể){}",
				},
			},
			-- [Buy/Sell/Use mode]
			insta_actions_use_alt = {
				name = { "Dùng nhanh lá bài" },
				text = {},
				unlock = {
					"Cách thức quyết định bởi {C:attention}#1#{}",
					" ",
					"{C:attention}Lia/túm{} lá bài rồi {C:attention}nhấn{} phím tắt",
					"để dùng nó {C:inactive}(nếu có thể){}",
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
				name = { "Tạm dừng tính điểm" },
				text = {},
				unlock = {
					"{C:attention}Giữ{} để tạm dừng hoạt ảnh tính điểm",
					"{C:attention}trước khi{} tính xong điểm cuối",
					" ",
					"Hữu dụng cho việc sắp xếp lại joker trước khi xong ván",
				},
			},
			-- []
			scoring_hold_any_moment = {
				name = { "Tạm dừng tính điểm: Bất kì thời điểm tính điểm nào" },
				text = {},
				unlock = {
					"{C:attention}Giữ{} để tạm dừng hoạt ảnh tính điểm",
					"ở {C:attention}bất kì thời điểm{} tính điểm nào",
				},
			},

			-- []
			regular_keybinds = {
				name = "Phím tắt Thông thường & Vanilla",
				text = {
					"Mọi điều khiển từ trò chơi gốc, và thêm nữa",
				},
			},

			-- []
			regular_keybinds_group_game = {
				name = "Trò chơi",
				text = {},
			},
			-- [R]
			regular_keybinds_restart = {
				name = { "Tạo trận mới" },
				text = { "#1# của Vanilla" },
			},
			-- [R]
			regular_keybinds_quick_restart = {
				name = { "Tạo trận mới tức thì" },
				text = { "#1# của Vanilla nhưng tức thì" },
				unlock = {
					"Cũng tác dụng lên màn hình {C:attention}Thua cuộc{}",
				},
			},
			-- []
			regular_keybinds_save_run = {
				name = { "Lưu trận" },
				text = {
					"Lưu tự động nhưng thủ công",
				},
				unlock = {
					"Trò chơi tự động lưu trận sau một số hành động",
					"{C:inactive}(như Choi tay bài, Bỏ bài, Gieo lại shop){}",
					" ",
					"Phím tắt này cho phép lưu thủ công",
				},
			},
			-- []
			regular_keybinds_reload_run = {
				name = { "Tải trận" },
				text = {
					"Menu chính -> Tiếp tục trận",
				},
				unlock = {
					"Giả lập hành vi thoát ra Menu chính",
					"rồi Tiếp tục trận nhưng với",
					"{C:attention}hoạt ảnh được bỏ qua{}",
				},
			},
			-- []
			regular_keybinds_restart_game = {
				name = "Khởi động lại Balatro",
				text = {},
			},
			-- []
			regular_keybinds_copy_log_file = {
				name = { "Sao chép log Lovely" },
				text = {},
				unlock = {
					"Do giới hạn kĩ thuật, sao chép log",
					"{C:attention}dạng văn bản{}, không phải dạng tệp",
				},
			},

			-- []
			regular_keybinds_group_hand = {
				name = "Tay bài",
				text = {},
			},
			-- []
			regular_keybinds_play = {
				name = { "Chơi tay bài" },
				text = {},
			},
			-- []
			regular_keybinds_discard = {
				name = { "Bỏ tay bài" },
				text = {},
			},
			-- []
			regular_keybinds_change_sort_rank = {
				name = { "Xếp bài theo Bậc" },
				text = {},
			},
			-- []
			regular_keybinds_change_sort_suit = {
				name = { "Xếp bài theo Chất" },
				text = {},
			},
			-- []
			regular_keybinds_toggle_sort = {
				name = { "Đổi cách xếp bài" },
				text = { "Chất > Bậc > Chất..." },
			},

			-- []
			regular_keybinds_group_round = {
				name = "Ván",
				text = {},
			},
			-- []
			regular_keybinds_start_fantoms_preview = {
				name = { "Fantom's Preview: Tính điểm" },
				text = {},
			},
			-- []
			regular_keybinds_cash_out = {
				name = { "Nhận Tiền" },
				text = {},
				unlock = {
					"{C:attention}Giữ{} phím tắt để bỏ qua Nhận Tiền",
					"ngay khi nút Nhận Tiền có sẵn",
				},
			},
			-- []
			regular_keybinds_not_just_yet_interaction = {
				name = { "NotJustYet: Kết thúc ván" },
				text = {},
			},

			-- []
			regular_keybinds_group_shop = {
				name = "Shop",
				text = {},
			},
			-- []
			regular_keybinds_skip_booster = {
				name = { "Bỏ qua Gói bài" },
				text = {},
				unlock = {
					"{C:attention}Giữ{} phím tắt để bỏ qua Gói Bài",
					"ngay khi nút bỏ qua có sẵn",
					" ",
					"{C:attention}Tiếp tục giữ{} phím tắt để bỏ qua nhiều",
					"Gói bài hơn {C:attention}liên tiếp{}",
				},
			},
			-- []
			regular_keybinds_reroll_shop = {
				name = { "Gieo lại shop" },
				text = {},
			},
			-- []
			regular_keybinds_leave_shop = {
				name = { "Rời shop" },
				text = {},
			},
			-- []
			regular_keybinds_group_blind_select = {
				name = "Mục Chọn Blind",
				text = {},
			},

			-- []
			regular_keybinds_skip_blind = {
				name = { "Bỏ Qua blind" },
				text = {},
			},
			-- []
			regular_keybinds_select_blind = {
				name = { "Chọn blind" },
				text = {},
			},
			-- []
			regular_keybinds_reroll_boss = {
				name = { "Gieo lại Boss blind" },
				text = {},
			},

			-- []
			regular_keybinds_group_menus = {
				name = "Menu",
				text = {},
			},
			-- []
			regular_keybinds_mod_settings = {
				name = { "Handy: Cài đặt mod" },
				text = {},
			},
			-- []
			regular_keybinds_show_deck_preview = {
				name = { "Xem trước bộ bài" },
				text = { "Giống hành vi lia chuột lên bộ bài" },
			},
			-- [Escape]
			regular_keybinds_options = {
				name = { "Tuỳ chọn" },
				text = { "Giống việc nhấn #1#" },
			},
			-- []
			regular_keybinds_collection = {
				name = { "Bộ sưu tập" },
				text = {},
			},

			-- []
			regular_keybinds_group_swappable_menus = {
				name = "Menu Trong Trò Chơi",
				text = {},
				unlock = {
					"Bạn có thể chuyển giữa",
					"các menu bằng phím tắt mà",
					"{C:attention}không cần đóng{} chúng",
				},
			},
			-- []
			regular_keybinds_swappable_overlays_mode = {
				name = "Chế độ Menu Trong Trò Chơi",
				text = {},
			},
			-- []
			regular_keybinds_run_info = {
				name = { "T.tin Trận này: Tay Poker" },
				text = {},
			},
			-- []
			regular_keybinds_run_info_blinds = {
				name = { "T.tin Trận này: Blind" },
				text = {},
			},
			-- []
			regular_keybinds_run_info_vouchers = {
				name = { "T.tin Trận này: Voucher" },
				text = {},
			},
			-- []
			regular_keybinds_view_deck = {
				name = { "Mở Bộ Bài" },
				text = {},
			},
			-- []
			regular_keybinds_view_lobby_info = {
				name = { "Multiplayer: T.Tin phòng" },
				text = {},
			},

			-- []
			dangerous_actions = {
				name = "Hành Động Nguy Hiểm",
				text = {
					"Khi có quá nhiều thứ để kiểm soát",
				},
			},
			-- []
			dangerous_actions_sell_one = {
				name = { "Bán tức thì" },
				text = {},
				unlock = {
					"{C:attention}Giữ{} phím tắt và bắt đầu {C:attention}lia chuột{}",
					"lên lá bài muốn bán",
					" ",
					"Khi {C:attention}giữ{}, thêm mục tiêu bị lia vào danh sách",
					"Khi {C:attention}thả{}, bán toàn bộ mục tiêu",
				},
			},
			-- []
			dangerous_actions_remove_one = {
				name = { "Loại bỏ tức thì" },
				text = { "Cũng tác dụng lên Nhãn bỏ qua" },
				unlock = {
					"{C:attention}Giữ{} phím tắt và bắt đầu {C:attention}lia chuột{}",
					"lên lá bài/nhãn bỏ qua muốn {C:mult}loại bỏ{}",
					" ",
					"Khi {C:attention}giữ{}, thêm mục tiêu bị lia vào danh sách",
					"Khi {C:attention}thả{}, {C:mult}loại bỏ{} toàn bộ mục tiêu",
					"{C:inactive}(bỏ qua kiểm tra, không hoàn tiền){}",
				},
			},
			-- [Instant sell all same, Instant REMOVE all same, Instant sell all, Instant REMOVE ALL]
			dangerous_actions_mass_sell_remove_mode = {
				name = "Chế độ Bán/Loại Bỏ hàng loạt",
				text = {},
				unlock = {
					"Áp dụng cho các điều khiển:",
					"{C:mult}#1#{}",
					"{C:mult}#2#{}",
					"{C:mult}#3#{}",
					"{C:mult}#4#{}",
				},
			},
			-- []
			dangerous_actions_sell_all_same = {
				name = { "Bán tức thì mọi bản sao" },
				text = {},
				unlock = {
					"{C:attention}Giữ{} phím tắt và {C:attention}nhấp{}",
					"lá bài muốn bán",
				},
			},
			-- []
			dangerous_actions_remove_all_same = {
				name = { "Loại bỏ tức thì mọi bản sao" },
				text = { "Cũng tác dụng lên Nhãn bỏ qua" },
				unlock = {
					"{C:attention}Giữ{} phím tắt và {C:attention}nhấp{}",
					"lá bài/nhãn bỏ qua muốn {C:mult}loại bỏ{}",
					"{C:inactive}(bỏ qua kiểm tra, không hoàn tiền){}",
				},
			},
			-- []
			dangerous_actions_sell_all = {
				name = { "Bán tức thì MỌI THỨ" },
				text = {},
				unlock = {
					"{C:attention}Giữ{} phím tắt và {C:attention}nhấp{}",
					"lá bài muốn bán",
				},
			},
			-- []
			dangerous_actions_remove_all = {
				name = { "Loại bỏ tức thì MỌI THỨ" },
				text = { "Cũng tác dụng lên Nhãn bỏ qua" },
				unlock = {
					"{C:attention}Giữ{} phím tắt và {C:attention}nhấp{}",
					"lá bài/nhãn bỏ qua muốn {C:mult}loại bỏ{}",
					"{C:inactive}(bỏ qua kiểm tra, không hoàn tiền){}",
				},
			},
			-- []
			dangerous_actions_crash = {
				name = { "Crash trò chơi" },
				text = {},
				unlock = {
					"{C:mult}Đúng nghĩa đen{}",
				},
			},
			-- []
			dangerous_actions_stack_overflow = {
				name = { "Crash trò chơi: Tràn Stack" },
				text = {},
				unlock = {
					"{C:mult}Đúng nghĩa đen{}",
					"{C:mult}Trò chơi sẽ bị đơ và/hoặc tự thoát{}",
				},
			},

			-- []
			misc = {
				name = "Khác",
				text = {},
			},

			-- []
			mp_extension = {
				name = { "Phần Mở Rộng Multiplayer" },
				text = { "Tính năng cụ thể cho Multiplayer" },
			},

			-- []
			mp_extension_current_lobby = {
				name = { "Mở Rộng MP: tuỳ chỉnh phòng hiện tại" },
				text = {},
			},
			-- [Speed multiplier, Animations skip]
			mp_extension_enabled = {
				name = "Cho phép Phần Mở Rộng Multiplayer",
				text = {},
				unlock = {
					"Khi bật cái này, {C:attention}BẠN{} cho phép",
					"sử dụng {C:mult}Phần Mở Rộng Multiplayer{} trong phòng này",
					" ",
					"Chỉ khi {C:attention}MỌI{} người chơi trong phòng đều bật,",
					"các điều khiển như {C:chips}#1#{} and {C:attention}#2#{}",
					"sẽ có sẵn cho {C:attention}MỌI{} người chơi trong phòng",
				},
			},
			-- []
			mp_extension_speed_multiplier_mode = {
				name = "Hệ Số Tốc Độ: giá trị tối đa cho phòng",
				text = {},
			},
			-- []
			mp_extension_animation_skip_mode = {
				name = "Bỏ Qua Hoạt Ảnh: giá trị tối đa cho phòng",
				text = {},
			},
			-- []
			mp_extension_dangerous_actions_mode = {
				name = "Hành Động Nguy Hiểm: chế độ phòng",
				text = {},
				unlock = {
					"Cho phép kích hoạt {C:mult}Hành Động Nguy Hiểm{}",
					"dùng cho bán hàng loạt",
				},
			},

			-- []
			mp_extension_default_values = {
				name = { "Mở Rộng MP: tuỳ chỉnh phòng mặc định" },
				text = {},
			},
			-- []
			mp_extension_speed_multiplier_mode_default_value = {
				name = "Hệ Số Tốc Độ: giá trị tối đa mặc dịnh cho phòng",
				text = {},
				unlock = {
					"Khi bạn {C:attention}tạo phòng{},",
					"đây sẽ được đặt làm giá trị mặc định",
				},
			},
			-- []
			mp_extension_animation_skip_mode_default_value = {
				name = "Bỏ Qua Hoạt Ảnh: giá trị tối đa mặc định cho phòng",
				text = {},
				unlock = {
					"Khi bạn {C:attention}tạo phòng{},",
					"đây sẽ được đặt làm giá trị mặc định",
				},
			},
			-- []
			mp_extension_dangerous_actions_mode_default_value = {
				name = "Hành Động Nguy Hiểm: chế độ phòng mặc định",
				text = {},
				unlock = {
					"Khi bạn {C:attention}tạo phòng{},",
					"đây sẽ được đặt làm giá trị mặc định",
				},
			},
			-- []
			mp_extension_enabled_default_value = {
				name = "Cho phép Phần Mở Rộng MP: giá trị mặc định",
				text = {},
				unlock = {
					"Khi bạn {C:attention}tạo hoặc vào phòng{},",
					"đây sẽ được đặt làm giá trị mặc định",
				},
			},

			-- []
			debug_things = {
				name = "Phát triển & Debug",
				text = {},
			},
			-- []
			debug_things_reload_localization = {
				name = "Phát triển: Tải lại dịch thuật",
				text = {},
				unlock = { "G:set_language();", "init_localization();" },
			},
			-- []
			debug_things_reload_prototypes = {
				name = "Phát triển: Tải lại đối tượng tiền thân",
				text = {},
				unlock = { "G:set_language();", "G:init_item_prototypes();" },
			},
		},

		Handy_Preset = {
			["default"] = {
				name = "Mặc Định",
				text = {
					"Điều khiển mặc định của mod",
				},
			},
			["better_mouse_and_gamepad"] = {
				name = "Better Mouse and Gamepad",
				text = {
					"Điều khiển tương tự mod Better Mouse and Gamepad",
				},
			},
			["full_default"] = {
				name = "Tái thiết mặc định",
				text = {
					"Trả tuỳ chỉnh toàn cục về mặc định",
				},
			},
		},
		Handy_Other = {
			overall_title = {
				text = {
					"- Vuốt để chọn bài",
					"- Phím tắt trong trò chơi",
					"- Thêm tuỳ chọn tốc độ trò chơi",
					"- Loại bỏ hoạt ảnh",
					"- Hỗ trợ Gamepad",
					" ",
					"- Điều khiển có thể được gắn vào {C:chips}bất kì tổ hợp{}",
					"  phím, chuột hay nút gamepad nào",
					"  và bật/tắt ở {C:chips}bất kì thời điểm nào{}",
					"  mà không cần khởi động lại trò chơi hay tạo trận mới",
					"- {C:chips}Không{} vô hiệu hoá Thành Tựu",
				},
			},
			missing_deps = {
				text = {
					"Điều khiển này bất hoạt cho đến khi",
					"các điều khiển sau được bật:",
				},
			},
			cant_use_in_mp = {
				text = {
					"Điều khiển này bất hoạt trong {C:mult}Multiplayer{}",
				},
			},
			cant_use_with_gamepad = {
				text = {
					"Điều khiển này bất hoạt với {C:attention}Gamepad{}",
				},
			},
			missing_req_mods = {
				text = {
					"Điều khiển này yêu cầu mod sau để hoạt động:",
				},
			},
			conflict_mods = {
				text = {
					"Điều khiển này bất hoạt do các mod sau:",
				},
			},
			mp_lobby_require_all_hint = {
				text = {
					"Mọi tuỳ chỉnh phòng chỉ có tác dụng khi",
					"{C:attention}MỌI{} thành viên phòng đã cài {C:chips}Handy v2.0{} hoặc mới hơn",
				},
			},
			better_mouse_and_gamepad_in_hand_selection = {
				text = {
					"{C:mult,s:1.5}Ooopsie...{}",
					" ",
					"Có vẻ như {C:attention}Better Mouse and Gamepad{} đã được cài đặt.",
					"Tôi có một tin {C:mult}xấu{} và 1 tin {C:green}Tốt{}.",
					" ",
					"{C:mult}Tin xấu{} là {C:attention}BMaG{} ghi đè lên cơ chế chọn tay bài",
					"của {C:chips}Handy{} và làm hỏng một số nút nhập liệu như",
					"{C:chips}[Lăn Chuột Lên/Xuống]{}, {C:chips}[Chuột 3]{}, {C:chips}[Chuột Phải]{} và hơn thế nữa.",
					" ",
					"{C:green}Tin tốt{} là {C:chips}Handy{} có {C:inactive,s:0.75}hầu như{} tất cả các điều khiển được nhập về từ nó",
					"nên bản có thể gỡ cài đặt {C:attention}BMaG{} mà không mất mát gì.",
					" ",
					"Hoặc là bạn có thể tiếp tục dùng {C:attention}cả hai mod{} mà gần như chẳng sao cả.",
					"{s:0.8}Dù tôi không thích nó lắm nhưng bạn dùng mod gì không phải quyền của tôi{}",
				},
			},
		},
	},
	misc = {
		-- You don't need to translate all of them, only necessary ones
		handy_keybinds = {
			-- No button assigned
			["None"] = "Không Có",
			-- Button which cannot be recognized
			["Unknown"] = "Không Rõ",

			-- Mouse
			["Left Mouse"] = "Chuột Trái",
			["Right Mouse"] = "Chuột Phải",
			["Middle Mouse"] = "Chuột Giữa",
			["Mouse 4"] = "Chuột 4",
			["Mouse 5"] = "Chuột 5",
			["Wheel Up"] = "Lăn Chuột Lên",
			["Wheel Down"] = "Lăn Chuột Xuống",
			-- Controls
			["Escape"] = "Esc",
			["Shift"] = nil,
			["Ctrl"] = nil,
			["Alt"] = nil,
			["GUI"] = "WinKey/CMD", -- Windows button, or CMD for Mac
			["Enter"] = nil,
			["Tab"] = nil,
			["Backspace"] = nil,
			["Num Lock"] = nil,
			["Caps Lock"] = nil,
			["Scroll Lock"] = nil,
			-- Arrow keys
			["Left"] = "Trái",
			["Right"] = "Phải",
			["Up"] = "Lên",
			["Down"] = "Xuống",
			-- Symbols
			["Backquote"] = "Nháy Ngược", -- `
			["Singlequote"] = "Nháy Đơn", -- '
			["Quote"] = "Nháy Kép", -- "
			["Left Bracket"] = "Ngoặc Vuông Mở", -- [
			["Right Bracket"] = "Ngoặc Vuông Đóng", -- ]
			-- Weird buttons
			["Printscreen"] = nil,
			["Delete"] = nil,
			["Home"] = nil,
			["Insert"] = nil,
			["End"] = nil,
			["Pause"] = nil,
			["Help"] = nil,
			["Sysreq"] = nil,
			["Menu"] = nil,
			["Undo"] = nil,
			["Mode"] = nil,
			["Page Up"] = nil,
			["Page Down"] = nil,
			-- Very weird buttons, did they exist in 21th century?
			["Www"] = nil,
			["Mail"] = nil,
			["Calculator"] = nil,
			["Computer"] = nil,
			["Appsearch"] = nil,
			["Apphome"] = nil,
			["Appback"] = nil,
			["Appforward"] = nil,
			["Apprefresh"] = nil,
			["Appbookmarks"] = nil,
			["Currencyunit"] = nil,
			["Application"] = nil,
			["Power"] = nil, -- What a heck --[[yea, I get you :/ - HuyTheKiller]]

			-- Gamepad: buttons
			["(A)"] = nil,
			["(B)"] = nil,
			["(X)"] = nil,
			["(Y)"] = nil,
			["(Back)"] = nil,
			["(Guide)"] = nil,
			["(Start)"] = nil,
			-- Gamepad: directions
			-- In Balatro, Left Stick movement treated as direction buttons
			["(Up)"] = "(Lên)",
			["(Down)"] = "(Xuống)",
			["(Left)"] = "(Trái)",
			["(Right)"] = "(Phải)",
			-- Gamepad: sticks, triggers, bumpers and paddles
			["Left Stick"] = "Stick Trái", -- Click
			["Right Stick"] = "Stick Phải", -- Click
			["Left Bumper"] = "Bumper Trái", -- LB
			["Right Bumper"] = "Bumper Phải", -- RB
			["Left Trigger"] = "Trigger Trái", -- LT
			["Right Trigger"] = "Trigger Phải", -- RT
			-- Not supported by current LOVE engine version
			["First Paddle"] = "Paddle 1", -- P1
			["Second Paddle"] = "Paddle 2", -- P2
			["Third Paddle"] = "Paddle 3", -- P3
			["Fourth Paddle"] = "Paddle 4", -- P4
			["(Misc. Button)"] = "(Nút Khác)",
			-- Gamepad: touchpad
			["Touchpad Press"] = "Nhấn Touchpad",

			-- Not listed here, but can be added if you ever need:
			-- All english letters uppercase, (Q, W, E, R, T, Y...)
			-- All numbers (1, 2, 3...0)
			-- All F keys (F1, F2, F3...)
			-- All NUM keys (NUM 0 ... NUM 9, NUM Enter, NUM +, NUM -, NUM *, NUM /, NUM .)
			-- Other symbols (. ; / \ - + etc)
		},
		handy_tabs = {
			["Overall"] = "Tổng Thể",
			["Presets"] = "Bộ Đặt trước",
			["Search"] = "Tìm Kiếm",

			["General"] = "Tổng Thể",
			["Fast hand selection"] = "Chọn tay bài",
			["Speed & Animations"] = "Tốc độ & Hoạt Ảnh",
			["Vanilla keybinds"] = "Phím tắt",
			["Quick buy/sell/use"] = "Mua, Bán & Dùng",
			["Highlight movement"] = "Chọn chính xác",
			["Misc"] = "Khác",
			["Dangerous"] = "Vùng Nguy Hiểm",
			["Debug"] = "Phát Triển & Debug",

			["Speed"] = "Tốc Độ",
			["Animations"] = "Hoạt Ảnh",
			["Hold"] = "Giữ",
			["Round"] = "Ván",
			["Hand & Round"] = "Tay Bài/Ván",
			["Shop & Blind Select"] = "Shop/Blind",
			["Game"] = "Trò chơi",
			["Menus"] = "Menu",
			["MP Extension"] = "Multiplayer",

			["Updater"] = "Cập nhật Mod",
			["Updater Settings"] = "Cài đặt",
		},
		v_dictionary = {
			Handy_version_by = "v#1# bởi #2#",
			Handy_module_keys_single = "[#1#]",
			Handy_module_keys_or = "[#1#] or [#2#]",
			Handy_items_in_queue = "[#1# trong hàng chờ]",
			Handy_temp_disabled = "[bất hoạt]",
			Handy_disabled_in_mp = "[bất hoạt bởi Multiplayer]",

			Handy_gamespeed_multiplier = "Hệ số tốc độ trò chơi: #1#",
			Handy_event_queue_retriggers_amount = "Gia tốc hàng chờ sự kiện: #1#",
			Handy_animation_skip = "Bỏ qua hoạt ảnh: #1#",

			Handy_skip_booster_pack = "Bỏ qua gói bài",

			Handy_scoring_hold = "Tạm dừng hoạt ảnh ghi điểm",
			Handy_scoring_hold_hand_score = "Điểm tay bài: [#1#]",

			Handy_hand_sorting = "Xếp tay bài: #1#",

			Handy_preset_index = "Bộ #1#",
			Handy_preset_saved = "Đã lưu bộ #1# [#2#]",
			Handy_preset_loaded = "Đã tải bộ #1# [#2#]",
			Handy_preset_empty = "Bộ #1# [#2#] trống",
			Handy_preset_disabled = "Bộ #1# [#2#] vô hiệu",
			Handy_preset_example_loaded = "Đã tải bộ làm sẵn [#1#]",
			Handy_preset_nothing_to_load = "Không có bộ để tải",

			Handy_binding_canceled = "Đã huỷ gắn",
			Handy_binding_cancel_reason_no_safe = 'Không thể gắn #1# ở đây để ngăn "softlock"',
			Handy_binding_cancel_reason_no_hold = 'Không thể gắn #1# ở đây vì không thể thực hiện "giữ"',
			Handy_binding_cancel_reason_multiple_no_hold = "Tổ hợp không thể chứa nhiều phím không giữ được",
			Handy_binding_finished = "Hoàn thành gắn: #1#",
			Handy_binding_progress = "Đang gắn: #1#",
			Handy_binding_esc_hint = "Nhấn #1# để lưu",
			Handy_binding_guide = "Nhấn phím để thêm vào tổ hợp",

			Handy_reload_run_done = "Đã tải lại trận",
			Handy_reload_run_nothing_to_load = "Không có trận để tải lại",
			Handy_load_run_done = "Đã tải trận",
			Handy_load_run_nothing_to_load = "Không có trận để tải",

			Handy_prevented_by_debugplus = "Bị ngăn bởi DebugPlus",
			Handy_log_file_copied = "Log Lovely đã sao chép vào khay nhớ tạm",

			Handy_updater_finish_success = "Hoàn thành cài đặt phiên bản",
			Handy_updater_finish_no_fetcher = "Không có sẵn API để gửi yêu cầu",
			Handy_updater_finish_no_connection = "Thiếu kết nối internet",
			Handy_updater_finish_fetcher_error = "Lỗi không mong muốn",
			Handy_updater_finish_invalid_server_response = "Phản hồi máy chủ không hợp lệ",
			Handy_updater_finish_no_release = "Không tìm thấy phiên bản",
			Handy_updater_finish_check_request_failed = "Không thể kiểm tra phiên bản có sẵn",
			Handy_updater_finish_cannot_write_zip = "Không thể lưu têp phiên bản",
			Handy_updater_finish_download_request_failed = "Không thể tải phiên bản",
			Handy_updater_finish_cannot_unzip = "Không thể giải nén tệp phiên bản",
			Handy_updater_finish_cannot_move_files = "Không thể cài đặt tệp phiên bản",
			Handy_updater_finish_no_data_to_replace = "Không có tệp phiên bản để cài đặt",
			Handy_updater_finish_description = "Khởi động lại trò chơi để áp dụng thay đổi",

			Handy_updater_progress_getting_releases = "Đang lấy phiên bản...",
			Handy_updater_progress_downloading_release = "Đang tải phiên bản...",
			Handy_updater_progress_unzipping_archive = "Đang giải nén phiên bản...",
			Handy_updater_progress_installing_files = "Đang cài đặt phiên bản...",

			Handy_new_pre_release_available = "Có sẵn phiên bản sớm",
			Handy_new_stable_available = "Có sẵn phiên bản mới",
			Handy_new_release_description = "Vào cài đặt mod để xem chi tiết và tải về",
			Handy_updater_auto_restart = "Đang khởi động lại trò chơi để áp dụng thay đổi..",
		},
		dictionary = {
			handy_or = "hoặc",
			handy_disabled = "Đã tắt",
			handy_mod_enabled = "Đã bật mod",
			handy_mod_disabled = "Đã tắt mod",

			handy_example_state_panel = "Nhiều thông báo sẽ hiển thị ở đây",

			ph_handy_premade_presets = "Bộ đặt trước làm sẵn",
			ph_handy_custom_presets = "Bộ đặt trước tuỳ chọn",

			b_handy_mp_extension = "Phần Mở Rộng Multiplayer",

			b_handy_preset_save = "Lưu",
			b_handy_preset_load = "Tải",
			b_handy_preset_clear = "Xoá",

			handy_preset_name_placeholder = "Tên bộ đặt trước",

			b_handy_notif_quick = "Hành động Handy",
			b_handy_notif_dangerous = "Hành động nguy hiểm",

			b_handy_search_placeholder = "Tìm kiếm...",
			b_handy_search = "Tìm kiếm",
			b_handy_clear = "Xoá",
			b_handy_open_github = "Mở trên GitHub",

			ph_handy_notif_quick_use = "Dùng nhanh",
			ph_handy_notif_quick_buy_or_sell = "Mua hoặc bán nhanh",
			ph_handy_notif_quick_buy_n_sell = "Mua rồi bán ngay nhanh",
			ph_handy_notif_unsafe_disabled = "Hành động không an toàn đã tắt trong cài đặt mod",
			ph_handy_notif_unsafe_disabled_by_other_mod = "Hành động không an toàn bất hoạt bởi mod khác",
			ph_handy_notif_unsafe = "[Không an toàn]",
			ph_handy_notif_insta_remove = "LOẠI BỎ tức thì",
			ph_handy_notif_insta_sell = "Bán tức thì",
			ph_handy_notif_remove_all = "LOẠI BỎ MỌI lá bài/nhãn bỏ qua trong khu vực bị nhấp",
			ph_handy_notif_sell_all = "Bán MỌI lá bài trong khu vực bị nhấp",
			ph_handy_notif_remove_all_same = "LOẠI BỎ mọi bản sao của lá/nhãn bỏ qua bị nhấp",
			ph_handy_notif_sell_all_same = "Bán mọi bản sao của lá bị nhấp",
			ph_handy_notif_animation_skip_unsafe_disabled = "Tuỳ chọn không an toàn đã tắt trong cài đặt mod",

			ph_handy_notif_misc_save_run_start = "Bắt đầu lưu trận...",
			ph_handy_notif_misc_save_run_saving = "Đang lưu trận...",
			ph_handy_notif_misc_save_run_saved = "Trận đã lưu",
			ph_handy_notif_misc_save_run_interrupt = "Không thể lưu trận ngay bây giờ",

			ph_handy_notif_reload_localization = "Debug: Đã tải lại dịch thuật",
			ph_handy_notif_reload_item_prototypes = "Debug: Đã tải lại đối tượng tiền thân",

			handy_animation_skip_levels = {
				[1] = "Không Có",
				[2] = "Tin Nhắn",
				[3] = "Hoạt Ảnh",
				[4] = "Mọi Thứ",
				[5] = "Không An Toàn",
			},

			handy_modals_start_calculation = {
				"Bắt đầu",
				"tính toán",
			},
			handy_modals_stop_calculation = {
				"Dừng",
				"tính toán",
			},
			handy_modals_preview_description = "Dùng xem trước để thấy hiệu ứng cài đặt",
			handy_modals_move_highlight_preview_description = "Dùng xem trước để thử điều khiển",

			ph_handy_dangerous_actions_sell_one = "Bán một",
			ph_handy_dangerous_actions_remove_one = "Loại bỏ một",
			ph_handy_dangerous_actions_sell_all_same = "Bán mọi bản sao",
			ph_handy_dangerous_actions_remove_all_same = "Loại bỏ mọi bản sao",
			ph_handy_dangerous_actions_sell_all = "Bán MỌI THỨ",
			ph_handy_dangerous_actions_remove_all = "Loại bỏ MỌI THỨ",

			handy_keybinds_trigger_mode_press = "Khi nhấn phím",
			handy_keybinds_trigger_mode_release = "Khi thả phím",

			handy_current_device_auto = "Tự động",
			handy_current_device_keyboard = "Chuột + Bàn Phím",
			handy_current_device_gamepad = "Gamepad",

			handy_notification_level_none = "Không có",
			handy_notification_level_dangerous = "Chỉ mục nguy hiểm",
			handy_notification_level_essential = "Mục cần thiết",
			handy_notification_level_all = "Tất cả",

			handy_buy_sell_use_mode_hold_n_click = "Giữ phím + Nhấp lá bài",
			handy_buy_sell_use_mode_hover_n_press = "Lia hoặc túm lá bài + Nhấn phím",

			handy_advanced_mode = "Chế độ nâng cao",
			handy_advanced_mode_description = "Thêm điều khiển & thông tin",

			k_handy_preview_sell = "Bán",
			k_handy_preview_buy = "Mua",
			k_handy_preview_use = "Dùng",
			k_handy_preview_buy_n_use = "Mua & Dùng",
			k_handy_preview_buy_n_sell = "Mua & Bán",
			k_handy_preview_remove = "LOẠI BỎ",

			handy_mp_speed_multiplier_mode = "Hệ Số Tốc Độ: giá trị tối đa cho phòng",
			handy_mp_animation_skip_mode = "Bỏ Qua Hoạt Ảnh: giá trị tối đa cho phòng",
			handy_mp_dangerous_actions_mode = "Hành Động Nguy Hiểm: chế độ phòng",
			handy_mp_dangerous_actions_modes = {
				"Đã tắt",
				"Bán hàng loạt",
				"Bán & loại bỏ hàng loạt",
			},

			handy_regular_keybinds_swappable_overlays_mode = {
				"Nhấn để mở",
				"Nhấn để mở / Nhấn lại để đóng",
				"Giữ để mở / Thả để đóng",
			},

			handy_dangerous_actions_mass_sell_remove_mode = {
				"Ảnh hưởng mọi lá bài",
				"Ảnh hưởng mọi lá bài trừ mục tiêu",
			},

			handy_show_custom_pip_mode = {
				"Không có",
				"Chỉ Gamepad",
				"Luôn luôn",
			},

			handy_mp_extension_status_not_initialized = "Phần Mở Rộng Multiplayer KHÔNG ĐƯỢC BẬT cho phòng này",
			handy_mp_extension_status_disabled = "Phần Mở Rộng Multiplayer đã BỊ TẮT bởi BẠN",
			handy_mp_extension_status_disabled_by_ruleset = "Phần Mở Rộng Multiplayer đã BỊ TẮT bởi LUẬT PHÒNG",
			handy_mp_extension_status_disabled_by_other_player = "Phần Mở Rộng Multiplayer đã BỊ TẮT bởi người chơi KHÁC",
			handy_mp_extension_status_enabled = "Phần Mở Rộng Multiplayer đã ĐƯỢC BẬT",

			handy_updater_no_release_found = "Không tìm thấy dữ liệu phiên bản",
			handy_updater_status_no_data = "Không có dữ liệu phiên bản",
			handy_updater_status_current_version = "Phiên bản hiện tại",
			handy_updater_status_already_installed = "Đã cài đặt - khởi động lại trò chơi",
			handy_updater_status_busy = "Vui lòng chờ...",
			handy_updater_status_ready_for_installation = "Sẵn sàng cài đặt",
			handy_updater_status_new_version_available = "Phiên bản mới có sẵn",
			b_handy_install = "Cài đặt",
			b_handy_restart_game = "Khởi động lại trò chơi",

			handy_release_type_stable = "Phiên bản mới nhất",
			handy_release_type_pre_release = "Phiên bản sớm",

			handy_smods_compat_mode = "Chế độ thu gọn: tải từ tệp nén .zip yêu cầu bản SMODS mới!",

			handy_gamepad_2step_select = "để chọn",
			handy_gamepad_2step_adjust = "để tuỳ chỉnh",
			handy_gamepad_2step_deselect = "để bỏ chọn",
		},
	},
}
