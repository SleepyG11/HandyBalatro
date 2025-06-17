<p align="center">
    <img src="https://github.com/user-attachments/assets/128aa4d1-55c5-401c-b144-52f640f512ff">
</p>

<p align="center">
    <b>Handy</b> - a lovely mod which adds new controls and keybinds to the game<br/>designed for faster and easier playing Vanilla and Modded <a href="https://store.steampowered.com/app/2379780/Balatro/" target="_blank">Balatro</a>
</p>

## Key features

-   **Vanilla-friendly**: no new run required; stability is priority, safe for use in base game and [Multiplayer](https://github.com/Balatro-Multiplayer/BalatroMultiplayer);
-   **Works without Steamodded**: but included supports for variety of different mods (NotJustYet, Nopeus, Cryptid);
-   **Fast hand selection**: highlight cards just by hovering them;
-   **Keybinds for all vanilla buttons and actions**: play, discard, hand sorting, cash out, shop reroll, view deck, *and more*;
-   **Game speed**: adjust game speed up to x512 in-run;
-   **Animation skip**: instant scoring and removing unnecessary animations to speedup game even further;
-   **Quick Buy/Sell/Use**: controls to buy, sell or use cards faster;
-   **Full control**: each feature can be disabled/enabled individually, each keybind can be reassigned to any keyboard or mouse button;
-   **Gamepad support**: most features can be used with gamepad aswell;
-   **Presets**: save up to 3 mod settings layouts and switch between them in-run to have more freedom with limited amount of buttons;

## Danger zone

> [!CAUTION]
> This controls designed to be speed-first, which **can cause bugs, crashes or tank performance**!<br/>
> Also, their usage can lead to accidental cards selling or removing if do it not carefully!<br/>
> Hovewer, they're really useful for dealing with huge amount of Jokers, Consumables or Skip tags.<br/>
> Must be enabled separately. Use with caution.

-   **Sell cards in bulk**: all copies or ALL cards at once;
-   **Removing**: deleting excessive jokers, consumables or __skip tags__;
-   **Max speed**: uncapped game speed and instant game animations;

> [!NOTE]
> REMOVE card or skip tag - delete without any checks, effects, triggers or money refunds.

## Installation

1. Install [lovely](https://github.com/ethangreen-dev/lovely-injector) by following instructions in repository page. Make sure your antivirus is not removing it;
2. Download [latest release](https://github.com/SleepyG11/HandyBalatro/releases/latest) of mod by selecting an archive named `Handy-[version].zip`; 
3. Put `HandyBalatro` folder from archive (NOT `Handy-[version]`) into game's `Mods` folder.<br/> 
   Can be found in `%appdata%/Balatro/Mods`. if `Mods` folder is missing, create it;
4. Start a game. If all done correctly, new button should appear in options menu;
5. Configure each feature and keybind as you want. All of them listed in mod settings;
6. Continue playing! No game restart or new run required.

## Contribute

Want new features to be implemented? Want add mod support? Found a bug?<br/>
[Create an issue](https://github.com/SleepyG11/HandyBalatro/issues/) or let me know in [Discord mod's thread](https://discord.com/channels/1116389027176787968/1270746376312979456)!

## Special thanks

- Jogla (`@jogla_the_wizard` in Discord) - Spanish localization
- [Sesebasti](https://github.com/sesebasti) - Spanish (Mexico) localization
- [Rynnya](https://github.com/Rynnya) (`@Ancowi` in Discord) - testing on gamepad
- [Aikoyori](https://github.com/Aikoyori) - testing (including MacOS)
- missingnumber (`@clickonflareblitz` in Discord) - testing on SteamDeck
- jenwalter666 (`@jenwalter` in Discord) - non-direct support with "spreading" a mod for other players

## For developers

If your mod needs to disable Handy's dangerous controls on certain conditions, you can hook check function to do so:

```lua
if Handy and Handy.is_dangerous_actions_active then
    local funcRef = Handy.is_dangerous_actions_active
    function Handy.is_dangerous_actions_active()
        return funcRef() and not MyMod.only_safe_controls
    end
end
```

Similar for cases when needed to disable mod entirely:

```lua
if Handy and Handy.is_mod_active then
    local funcRef = Handy.is_mod_active
    function Handy.is_mod_active()
        return funcRef() and not MyMod.allow_only_vanilla_controls
    end
end
```

Also, specific feature's config can be overrided:

```lua
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

When adding new buy or use buttons for jokers/consumables, you can mark them and Handy will use them when [Quick Buy/Sell] or [Quick Use] is called.
Include in button config definition field `handy_insta_action` with one of the following values:
- `sell` for mass-sell features or when [Quick buy/sell] is used (aka Shift is hold); Use for "Sell" buttons;
- `buy_or_sell` when [Quick buy/sell] is used (aka Shift is hold); Use for "Buy" buttons;
- `use` when [Quick use] is used (aka Ctrl is hold); Use for "Use" buttons or buttons unique for your cards;

*Only difference between `sell` and `buy_or_sell` is for mass-sell features, since only selling is allowed for it.*

Example:
```lua
-- Somewhere inside `G.UIDEF.buy_and_sell_buttons()` hook

{
    n=G.UIT.R,
    config={
        -- ...your button definition
        button = 'buy_my_card', func = 'can_buy_my_card', handy_insta_action = 'buy_or_sell'
    },
    nodes={
        -- ...
    }
},
```

## Some controls preview

https://github.com/user-attachments/assets/6406309f-f629-41c5-851d-90f99cb35cfa

https://github.com/user-attachments/assets/7ed89be3-a362-42c0-ac86-ccbc8fded62a

https://github.com/user-attachments/assets/2d40e4a6-9ea1-4ffa-a7fd-e0e8b9856b2b

https://github.com/user-attachments/assets/9ec9dfba-a7df-4ecf-a3e0-67dc802c310d

https://github.com/user-attachments/assets/4c958f09-74c3-4c11-88ab-48989c41dfde
