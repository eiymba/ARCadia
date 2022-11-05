![Arcadia HUD Splash Screen](https://i.imgur.com/rE77bRj.png)
# Arcadia HUD

 ## [Based on the popular ArcHUB3 project by nyyr](https://github.com/nyyr/ArcHUB3)!

* ✨ Health and power (mana, rage, focus, energy, runic power) for player, pet, target, and focus target
* 🔥 Player's secondary power (Holy Power, Soul Shards, Chi etc.)
* 📊 Casting/channelling progress for player, target, and focus target
* 😪 Fatigue/breath (mirror timer)
* ⚔️ Combo points (including unconsumed combo points on previous target, e.g. on dead corpses)
* ☠️ Custom (de)buff arcs: Ever wanted to keep track of the stacks and/or remaining times of some specific (de)buffs such as Evangelism, Savage Roar, Beacon of Light, Weakened Soul, etc? Then just create your own custom (de)buff arc for it!
* ⏪ Classic and classic era support included!

## Downloads

| Source          |      Link      |
|:----------------|:---------------|
| CurseForge      |       [Download](https://www.curseforge.com/wow/addons/arc-hud)      |
| WoW Interface   | [Download](https://www.wowinterface.com/downloads/info25227-ArcHUD3Classic.html) |
| WoWAce          | [Download](https://www.wowace.com/projects/archud3-classic) |
| GitHub Releases | [Download](https://github.com/eiymba/arc-hud/releases/latest) |

## What is Arc-HUD?

`Arc-HUD` displays smooth arcs around your character in the middle of the screen to inform you about the `health` and `power` (`mana`, `rage`, ...) of you, your pet, and your target. In addition, it shows casts, combo points, holy power, soul shards, and a couple of other things. It discretely fades when you are out of combat and at full health/power.

## Contributing
### Prerequisites

- [ ] You have a [GitHub account](https://github.com).
- [ ] You have a [GPG key set up to sign your commits]().

Please also read the [Contributing](./docs/CONTRIBUTING.md) document and the [Code of Conduct](./docs/CODE_OF_CONDUCT.md).

### Getting Started

>⚠️ **Note:** If you currently have **Arc-HUD** installed, it is generally recommended that you disabled it before installing the development version. Otherwise, you'll have both versions displayed in your UI at the same time.

1. Fork the repository
2. Clone your fork to your local machine, for example:
    - With SSH (recommended):
        ```sh
            git clone --recursive-submodules git@github.com:YOUR_USERNAME/arc-hud.git 
        ```
    - With HTTPS:
        ```sh
            git clone --recursive-submodules https://github.com/YOUR_USERNAME/arc-hud.git
        ```
3. Change directory to the cloned repository, for example:

    ```sh
        cd ./arc-hud
    ```
4. Open the directory with your favorite editor, for example (assuming VS Code is being used):

    ```sh
        code .
    ```

5. Build the project by running the following command:

    - Windows:
        ```sh
            .\build.ps1
        ```

    - Linux:
        ```sh
            ./build.sh
        ```

This will package the addon in the `./build` directory as a `.zip` file, and extract it in every version of WoW installed on your machine.  For more information, see the [build](./docs/BUILDING.md) document.

If compiled successfully, you should see `Arc-HUD-<version>` in your AddOns list in game. _You may need to select `Load out of date AddOns` in the `Interface Options` menu._
## Further Links

* [Changelog](./CHANGELOG.md)
* [Issues](https://github.com/eiymba/arc-hud/issues)
* [Contributing](./docs/Contributing.md)

## License

Arcadia is licensed under the [GNU General Public License v2.0](./LICENSE).

## Credits

* [rookdorf](https://github.com/rookdorf)