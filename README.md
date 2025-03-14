# Handy - Quality of Life controls for Balatro

Handy - a lovely mod which adds new game controls to make playing [Balatro](https://store.steampowered.com/app/2379780/Balatro/) much faster and easier.<br/>
Especially useful with mods where dealing with thousands of cards and booster packs is a common gameplay.

## Key features

-   Keybinds for common game buttons and actions:
    -   "Play", "Discard", "Sort hand by rank/suit", "Deselect hand"
    -   "Cash out", "Reroll shop", "Leave shop", "Skip Booster pack"
    -   "Skip blind", "Select blind"
    -   "Run info", "View deck", "Deck preview"
-   Highlight cards in hand by hovering them
-   In-game ability to adjust game speed up to x512
-   Controls to move highlight or cards in card areas
-   Controls to quick buy/sell/use cards
-   Other controls:
    -   Highlight entire hand
    -   Buy and immediately sell card in one click

> [!NOTE]
> Each control can be assigned to mouse button, mouse wheel or keyboard key in mod settings.<br/>
> No game or run restart required.

> [!TIP]
> For keybinds, "On press" or "On release" mode can be selected.<br/>
> For buy/sell/use controls, "On card click" or "On button press" mode can be selected.

## Specific controls for other mods

-   [Not Just Yet](https://github.com/Toneblock/balatro-NotJustYet) - keybind for "End round" button
-   [Nopeus](https://github.com/jenwalter666/JensBalatroCollection) - In-game ability to adjust "Fast-Forward" setting
-   [Cryptid](https://github.com/MathIsFun0/Cryptid) - Use code card with previously inputted value

## Danger zone

> [!CAUTION]
> This controls designed to be speed-first, which **can cause bugs or crashes**!<br/>
> Also, their usage can lead to accidental cards selling or removing if do it not carefully!<br/>
> Hovewer, they're really useful for dealing with huge amount of Jokers, Consumables or Skip tags.<br/>
> Must be enabled in mod settings.

-   Advanced sell and REMOVE controls:
    -   Sell/remove multiple cards
    -   Sell/remove queue
    -   Sell/remove all copies of card or skip tag in area
    -   Sell/remove **ALL** cards or skip in area

> [!NOTE]
> REMOVE card or skip tag - delete without any checks, effects, triggers or money refunds.

## Installation

1. Install [lovely](https://github.com/ethangreen-dev/lovely-injector) by following instructions in repository page. Make sure your antivirus is not removing it;
2. Download [latest release](https://github.com/SleepyG11/HandyBalatro/releases/latest) of mod by selecting an archive named `Handy-[version].zip`;
3. Put `HandyBalatro` folder from archive (NOT `Handy-[version]`) into game's `Mods` folder (can be found in `%appdata%/Balatro/Mods`);
4. Start a game. If all done correctly, new button should appear in options menu;
5. Configure each feature and keybind as you want. All of them listed in mod settings;
6. Continue playing! No game restart or new run required, even after settings change.

## Contribute

Want new features to be implemented? Want add mod support? Found a bug?<br/>
[Create an issue](https://github.com/SleepyG11/HandyBalatro/issues/) or let me know in [Discord mod's thread](https://discord.com/channels/1116389027176787968/1270746376312979456)!

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

## Some controls preview

https://github.com/user-attachments/assets/6406309f-f629-41c5-851d-90f99cb35cfa

https://github.com/user-attachments/assets/7ed89be3-a362-42c0-ac86-ccbc8fded62a

https://github.com/user-attachments/assets/2d40e4a6-9ea1-4ffa-a7fd-e0e8b9856b2b

https://github.com/user-attachments/assets/9ec9dfba-a7df-4ecf-a3e0-67dc802c310d

https://github.com/user-attachments/assets/4c958f09-74c3-4c11-88ab-48989c41dfde
