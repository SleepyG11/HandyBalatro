<p align="center">
    <img width="480" height="270" alt="Card" src="https://github.com/user-attachments/assets/bc39db76-377f-4cef-a6c5-986892583999" />
</p>

<p align="center">
    <b>Handy</b> - a <a href="https://store.steampowered.com/app/2379780/Balatro/" target="_blank">Balatro</a> mod which adds keybinds and new controls to the game<br/>designed for faster, easier and more comfortable Vanilla and Modded gameplay
</p>

## Key features

- **Keybinds for all vanilla actions**: play, discard, hand sorting, cash out, shop reroll, view deck, _and more_;
- **Fast hand selection**: select cards just by hovering them [(showcase)](https://www.youtube.com/watch?v=wPoW-uVKMt0);
- **Quick Buy/Sell/Use**: buy, sell or use cards in one button press [(showcase)](https://www.youtube.com/watch?v=s1YnNI0W27k);
- **Faster game speed**: adjust game speed up to x512;
- **Animations skip**: instant scoring and cards drawing, removing unnecessary animations [(showcase)](https://www.youtube.com/watch?v=CRxGXIhjW3s);
- **Precise selecting**: easier management of large amount of jokers or consumables [(showcase)](https://www.youtube.com/watch?v=E0wz5qP22CA);
- **Mass Sell and Remove**: solutions for bulk selling and removing jokers for your Cryptid runs [(showcase)](https://www.youtube.com/watch?v=mE1R6xTKcaE);
- **...And much more**: up to 100 controls to try and play around!

## Quality & Accessibility

- **Lovely mod**: no SMODS required; all controls always available; doesn't disable achievements;
- **Stability is priority**: safe for use in Vanilla, [Multiplayer](https://github.com/Balatro-Multiplayer/BalatroMultiplayer) and with any other mods;
- **Full control**: each feature can be disabled/enabled individually;
- **Full freedom**: any keybind can be assigned to _any combination_ of mouse, keyboard or gamepad buttons;
- **Instant effect**: all config changes applied immediately, no run or game restart required;
- **Presets**: save up to 3 config layouts to switch between in any moment;
- **Built-in mod updater**: install once, update mod in-game automatically;
- **Full gamepad support**

## Installation

1. Install [lovely](https://github.com/ethangreen-dev/lovely-injector) by following instructions in repository page. Make sure your antivirus is not removing it;
2. Download [latest release](https://github.com/SleepyG11/HandyBalatro/releases/latest) of mod by selecting an archive named `Handy-[version].zip`;
3. Put `HandyBalatro` folder **from archive** (NOT `Handy-[version]`) into `Mods` folder.
4. Start a game, go to "Options". if you see new blue button, all done correctly;
5. Configure each feature and keybind as you want. Explore and go wild!
6. Continue playing! No game restart or new run required.

## Contribute

Want new features to be implemented? Want add mod support? Found a bug?<br/>
[Create an issue](https://github.com/SleepyG11/HandyBalatro/issues/) or let me know in [Discord mod's thread](https://discord.com/channels/1116389027176787968/1270746376312979456)!

## Special thanks

- Jogla (`@jogla_the_wizard` in Discord) - old Spanish localization
- [Sesebasti](https://github.com/sesebasti) - old Spanish (Mexico) localization
- [shxiaj](https://github.com/shxiaj) - Simplified Chinese localization
- [Rynnya](https://github.com/Rynnya) (`@Ancowi` in Discord) - testing on gamepad
- [Aikoyori](https://github.com/Aikoyori) - testing (including MacOS)
- missingnumber (`@clickonflareblitz` in Discord) - testing (including SteamDeck)
- jenwalter666 (`@jenwalter` in Discord) - non-direct support with "spreading" a mod for other players
- LocalThunk - for making such outstanding and groundbreaking game we all LÖVE
- ...and everyone who report bugs, make suggestions, and playing with my mod!

## For developers

When adding new buy or use buttons for jokers/consumables via `G.UIDEF.buy_and_sell_buttons()`, you can mark them and Handy will use them when [Quick Buy/Sell] or [Quick Use] controls is called.
Include in button config definition field `handy_insta_action` with one of the following values:

- `sell`: when card needs to be sold, used by [Quick Buy/Sell]
- `buy`: when card needs to be bought, used by [Quick Buy/Sell]
- `use`: when card needs to be used, used by [Quick Use]

```lua
-- Somewhere inside `G.UIDEF.buy_and_sell_buttons()` hook

{
    n = G.UIT.R,
    config = {
        button = 'buy_my_card', func = 'can_buy_my_card',
        handy_insta_action = 'buy',
        -- ...your button definition
    },
    nodes = { ... }
},
```

<hr/>

Mod and/or specific controls can be partially or fully disabled conditionally.

```lua
-- Disable controls such as mass sell, mass remove and crashing the game
if Handy and Handy.is_dangerous_actions_active then
    local funcRef = Handy.is_dangerous_actions_active
    function Handy.is_dangerous_actions_active()
        return not MyMod.only_safe_controls and funcRef()
    end
end
```

```lua
-- Disable mod entirely
if Handy and Handy.is_mod_active then
    local funcRef = Handy.is_mod_active
    function Handy.is_mod_active()
        return not MyMod.allow_only_vanilla_controls and funcRef()
    end
end
```

```lua
-- Disable specific control (in this example: [Speed Multiplier])
if Handy and Handy.get_module_override then
    local funcRef = Handy.get_module_override
    function Handy.get_module_override(module)
        if module == Handy.cc.speed_multiplier and not MyMod.allow_change_game_speed then
            return {
                enabled = false
            }
        end
        return funcRef(module)
    end
end
```
