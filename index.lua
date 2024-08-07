last_clicked_card = nil

local KEYS_DX = {
    left = -1,
    right = 1
}

local CARD_SETS = {
    SHOP = {
        TARGET = {
            Joker = true,
            Enhanced = true,
            Default = true,
            Voucher = true,
            Booster = true,
        },

        BUY = {
            Joker = true,
            Enhanced = true,
            Default = true,
        },
        USE = {
            Voucher = true,
            Booster = true,
        },
        BUY_AND_USE = {

        },

        CAN_BUY = {
            Joker = true,
            Enhanced = true,
            Default = true,
        },
        CAN_OPEN = {
            Booster = true,
        },
        CAN_REDEEM = {
            Voucher = true,
        },
    },
    BOOSTER_PACK = {
        TARGET = {
            Joker = true,
            Enhanced = true,
            Default = true,
            Voucher = true,
            Booster = true,
        },
        CAN_SELECT = {
            Joker = true,
            Enhanced = true,
            Default = true,
            Voucher = true,
            Booster = true,
        },
        USE = {
            Joker = true,
            Enhanced = true,
            Default = true,
            Voucher = true,
            Booster = true,
        }
    },
    JOKERS = {
        TARGET = {
            Joker = true,
        },

        CAN_SELL = {
            Joker = true,
        },

        SELL = {
            Joker = true,
        },
    },
    CONSUMEABLES = {
        TARGET = {

        },

        CAN_SELL = {

        },

        SELL = {

        },

        USE = {

        },
    }
}

-- 

function handy_move_highlight_in_area(key)
    if not last_clicked_card then return end
    local area = last_clicked_card.area
    if area and (area == G.consumeables or area == G.jokers) then
        local dx = KEYS_DX[key]
        if not dx then return end
        local current_card = area.highlighted[1];
        if current_card then
            for current_index = #area.cards, 1, -1 do
                if area.cards[current_index] == current_card then
                    local next_index = ((#area.cards + current_index + dx - 1) % #area.cards) + 1
                    if current_index == next_index then return end
                    local next_card = area.cards[next_index]

                    area:remove_from_highlighted(current_card)
                    area:add_to_highlighted(next_card)
                    return
                end
            end
        end
    end
end

-- 

function fake_check_card_event(func, card)
    local fake_event = {
        UIBox = {},
        config = {
            ref_table = card,
            button = nil
        }
    }
    func(fake_event)
    return fake_event.config.button ~= nil
end

function handy_check_shop_insta_actions(card)
    local area = card.area
    if not area then return false end
    if area ~= G.shop_jokers and area ~= G.shop_booster and area ~= G.shop_vouchers then return false end

    local is_shift_pressed = love.keyboard.isDown("lshift")
    local is_ctrl_pressed = love.keyboard.isDown("lctrl")

    if CARD_SETS.SHOP.TARGET[card.ability.set] or card.ability.consumeable then
        local can_process = false
        local can_use_consumeable = false
        if card.ability.consumeable then
            if is_ctrl_pressed then
                can_process = fake_check_card_event(G.FUNCS.can_buy, card) and card:can_use_consumeable()
                can_use_consumeable = can_process
            elseif is_shift_pressed then
                can_process = fake_check_card_event(G.FUNCS.can_buy, card)
            end
        elseif CARD_SETS.SHOP.CAN_BUY[card.ability.set] or card.ability.consumeable then
            can_process = is_shift_pressed and fake_check_card_event(G.FUNCS.can_buy, card)
        elseif CARD_SETS.SHOP.CAN_REDEEM[card.ability.set] then
            can_process = is_shift_pressed and fake_check_card_event(G.FUNCS.can_redeem, card)
        elseif CARD_SETS.SHOP.CAN_OPEN[card.ability.set] then
            can_process = is_shift_pressed and fake_check_card_event(G.FUNCS.can_open, card)
        end

        if not can_process then return false end

        local result = false
        if CARD_SETS.SHOP.BUY_AND_USE[card.ability.set] or (card.ability.consumeable and can_use_consumeable) then
            result = G.FUNCS.buy_from_shop({
                UIBox = {},
                config = {
                    ref_table = card,
                    id = "buy_and_use"
                }
            })
        elseif CARD_SETS.SHOP.USE[card.ability.set] then
            result = G.FUNCS.use_card({
                UIBox = {},
                config = {
                    ref_table = card
                }
            })
        elseif CARD_SETS.SHOP.BUY[card.ability.set] or (card.ability.consumeable and not can_use_consumeable) then
            result = G.FUNCS.buy_from_shop({
                UIBox = {},
                config = {
                    ref_table = card,
                    id = "buy_from_shop"
                }
            })
        end
        return true
    end
    return false
end

function handy_check_booster_insta_actions(card)
    local area = card.area
    if not area then return false end
    if area ~= G.pack_cards then return false end

    local is_shift_pressed = love.keyboard.isDown("lshift")
    local is_ctrl_pressed = love.keyboard.isDown("lctrl")

    if CARD_SETS.BOOSTER_PACK.TARGET[card.ability.set] or card.ability.consumeable then
        local can_process = false
        local can_use_consumeable = false
        if CARD_SETS.BOOSTER_PACK.CAN_SELECT[card.ability.set] then
            can_process = is_shift_pressed and fake_check_card_event(G.FUNCS.can_select_card, card)
        elseif card.ability.consumeable then
            can_process = is_ctrl_pressed and card:can_use_consumeable()
            can_use_consumeable = can_process
        end

        if not can_process then return false end

        local result = false
        if CARD_SETS.BOOSTER_PACK.USE[card.ability.set] or (card.ability.consumeable and can_use_consumeable) then
            result = G.FUNCS.use_card({
                UIBox = {},
                config = {
                    ref_table = card
                }
            })
        end
        return true
    end
end

function handy_check_jokers_insta_actions(card)
    local area = card.area
    if not area then return false end
    if area ~= G.jokers then return false end

    local is_shift_pressed = love.keyboard.isDown("lshift")
    local is_ctrl_pressed = love.keyboard.isDown("lctrl")

    if CARD_SETS.JOKERS.TARGET[card.ability.set] then
        local can_process = false
        if CARD_SETS.JOKERS.CAN_SELL[card.ability.set] then
            can_process = is_shift_pressed and card:can_sell_card()
        end

        if not can_process then return false end

        local result = false
        if CARD_SETS.JOKERS.SELL[card.ability.set] then
            result = card:sell_card()
        end
        return true
    end
end

function handy_check_consumeables_insta_actions(card)
    local area = card.area
    if not area then return false end
    if area ~= G.consumeables then return false end

    local is_shift_pressed = love.keyboard.isDown("lshift")
    local is_ctrl_pressed = love.keyboard.isDown("lctrl")

    if CARD_SETS.CONSUMEABLES.TARGET[card.ability.set] or card.ability.consumeable then
        local can_process = false
        local can_use_consumeable = false
        if CARD_SETS.CONSUMEABLES.CAN_SELL[card.ability.set] or card.ability.consumeable then
            can_process = is_shift_pressed and card:can_sell_card()
            if card.ability.consumeable and is_ctrl_pressed then
                can_process = card:can_use_consumeable()
                can_use_consumeable = can_process
            end
        end

        if not can_process then return false end

        local result = false
        if CARD_SETS.CONSUMEABLES.USE[card.ability.set] or (card.ability.consumeable and can_use_consumeable) then
            result = G.FUNCS.use_card({
                UIBox = {},
                config = {
                    ref_table = card
                }
            })
        elseif CARD_SETS.CONSUMEABLES.SELL[card.ability.set] or (card.ability.consumeable and not can_use_consumeable) then
            result = card:sell_card()
        end
        return true
    end
end