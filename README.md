# Dynamic Horror Ops

**A procedurally generated paranormal operations mission for Arma 3.**  
Created by **UselessFodder** · [Workshop Link](https://steamcommunity.com/sharedfiles/filedetails/?id=3064136265) · [Source code](https://github.com/UselessFodder/FS-DynamicHorrorOp) · [Issues & feedback](https://github.com/UselessFodder/FS-DynamicHorrorOp/issues)

> Join the **Paranormal Operations Group (POG)** and deal with spooks, anomolies, and paranormal disturbances across the world...

![Dynamic Horror Op mission artwork](https://github.com/UselessFodder/FS-DynamicHorrorOp/blob/main/Dynamic%2520Horror%2520Op.Malden/Title.jpg?raw=true)

Dynamic Horror Op generates an assortment of hostile encounters, investigation sites, and objectives across the map, using creatures and anomalies from supported Arma 3 mods. One operation might be a desperate fight against the undead; the next could send your squad searching for a strange object while something stalks the treeline.

This repository contains the **Malden** mission version and its SQF source. The project is a work in progress; this README is a temporary overview, not a complete user manual.

## Storyline:
>The Paranormal Operations Group, a secret multi-national organization, has served under various names since World War 2 to keep the world safe from (and unaware of) the cosmic horrors that threaten our existence. From zombie contagion outbreaks to anomalous beings from beyond the veil, POG stands ready to deploy, contain, and destroy the weird, the paranormal, and the horrifying, no matter where they crop up.

## What to expect

- **Randomized operations.** Mission sites and objectives are generated when the scenario starts.
- **Four objective types.** Purge an area of anomalies, recover an object, destroy a dangerous object, or hunt a powerful entity.
- **Mod-driven enemies.** Select an overall enemy theme, specify up to three preferred enemy packs, or let the mission choose from available content.
- **Adjustable challenge.** Difficulty affects the enemy spawning budget; player count can increase the number of enemies.
- **Horror encounters.** Ambient sounds and occasional threats can appear around players during an operation.
- **Helicopter insertion.** The mission commander can select a landing zone and initiate transport from the base.
- **Solo or multiplayer.** The mission contains support for single-player and multiplayer sessions, including AI teammates for solo play.

The goal is to produce a different operation each time, without requiring a mission maker to manually place every enemy and objective.

## Getting started

### Requirements

- **Arma 3**, with the **Malden** terrain available.
- **At least one compatible creature/enemy mod** that the mission can use. The mission's enemies are drawn from supported mods rather than a guaranteed vanilla-only enemy set.
- The **same applicable mods on the server and clients** for multiplayer play.

Not every optional mod listed below is necessary. Start with one supported enemy pack and select it in the mission parameters for a simpler setup.

### Install from source

1. Download this repository using **Code → Download ZIP**, or clone it.
2. Extract the mission directory into your Arma 3 missions folder.
3. Make sure the actual mission directory is named `Dynamic Horror Op.Malden` (with spaces, not `%20`). The directory in the repository archive is URL-encoded as `Dynamic%20Horror%20Op.Malden`, so rename it if needed.
4. Launch Arma 3 with your chosen supported mods and open the mission on Malden. For multiplayer hosting, place the mission in the appropriate MP missions location or package it as a PBO for your server.
5. Choose mission parameters before starting the session.

**Typical local folders (Windows):** `Documents\Arma 3\missions\` for editing/playing a mission locally and `Documents\Arma 3\mpmissions\` for locally hosted multiplayer missions. Profiles or installations may use different paths.

### Playing an operation

1. Configure the difficulty, number of mission zones, mission vibe, and enemy theme.
2. Assemble your squad at the starting base and review the generated tasks.
3. The designated **mission commander** can use the transport helicopter's **Select LZ** and **Begin Insertion** actions while the helicopter's engine is off.
4. Travel to your assigned areas, complete the objectives, and survive the unexpected encounters.
5. Once all mission zones are complete, follow the **EXFIL** task and return to safety.

In single-player, the mission can populate your group with AI teammates. The code supports multiplayer, but there are known dedicated-server issues listed below.

## Mission parameters

These are the options defined in `description.ext` in the source version reviewed here.

| Parameter | Choices | What it does |
| --- | --- | --- |
| **Difficulty** | Easy / Medium / Hard / Nightmare | Changes the enemy spawning budget; harder settings produce more threat capacity. |
| **Number of Mission Zones** | 1 / 2 / 3 / 4 / Random | Selects how many locations the operation generates. Random currently selects 1–3. |
| **Respawns** | Unlimited / No Respawn | **Not implemented as a working toggle yet.** Don't rely on this setting to enforce no-respawn play. |
| **Mission Vibe** | Spooks / Combat | Spooks reduces the enemy spawning budget relative to Combat. |
| **Mission / Enemy Theme** | Everything! / Random / Fantasy / Undead / Sci Fi / Anomalous | Controls which detected enemy packs can populate the mission. |
| **Fine Tuned Enemy Selection 1–3** | Follow Theme or a particular enemy pack | Lets you manually specify preferred supported packs. The corresponding mods must be loaded. |

**Tip:** Use **Random** to let the mission choose a theme, or **Everything!** to use all compatible detected enemy content. To focus on a particular mod, select it under the fine-tuned enemy settings.

## Supported mod integrations

The mission includes SQF definitions and/or detection logic for the following enemy packs:

- Devourer Kings
- Drongo's Spooks and Anomalies
- Webknight's zombie/creature content
- Ryan's Zombies and Demons
- Empires of Old
- Ravage
- The Corporation
- Max ALIEN
- Max Werewolf
- Foes and Allies alien content / Zetaborn Alienz

There are also integration scripts for optional atmosphere and object content, including **Horror Mod**, **Cytech**, and **TTS Emissions**.

**Compatibility note:** A file in `mods/` does not necessarily mean the mod appears as a selectable mission parameter, and some integrations are detected differently. For example, the source includes `mods/Zetaborn.sqf`, but the mission parameter menu does not offer a separately named Zetaborn selection. Refer to the code and [open issues](https://github.com/UselessFodder/FS-DynamicHorrorOp/issues) for current limitations. Mod names here are descriptive labels, not guaranteed Workshop listing titles.

## For mission makers and contributors

The mission is written in **SQF**, with functions registered through `CfgFunctions` in `description.ext`.

```text
Dynamic Horror Op.Malden/
├── description.ext          # Mission parameters and function registration
├── mission.sqm              # Eden Editor mission
├── init.sqf                 # Server-side setup and mission generation
├── initPlayerLocal.sqf      # Player-side setup
├── functions/
│   ├── Init/                # Mod checks, object pools, loadouts, diagnostics
│   ├── Zones/               # Location selection, enemies, objectives, bosses
│   ├── Spooks/              # Sounds and surprise encounters
│   └── Base/                # Helicopter insertion and landing zones
├── mods/                    # Mod-specific classname and spawn definitions
└── sounds/                  # Horror audio effects
```

### How generation works (high level)

1. Mission startup reads parameters and identifies usable mod content.
2. An enemy pool is populated from the appropriate `mods/*.sqf` definitions.
3. The generator selects mission locations and builds spawn positions near them.
4. Enemies are selected using weighted costs against a spawn budget.
5. Each location receives one of the four implemented objective types.
6. The mission runs additional ambient horror events as players approach and explore.
7. Completing the generated zones unlocks the final extraction objective.

To introduce a new enemy pack, look at the existing definitions in `mods/`, then check the detection/selection functions in `functions/Init/`. Mod integration currently involves more than adding a single classname, so test any additions with the target mod loaded.

## Known limitations

This is an evolving project. In particular:

- **Dynamic simulation:** Some creatures, especially bosses, may fail to resume simulation when players approach.
- **Transport helicopter:** After returning to base, the helicopter can fail to follow subsequent transport orders.
- **Generation edge cases:** Certain combinations of enemy availability, spawn budgets, and location generation can result in stalled initialization.
- **No-respawn parameter:** Present in the menu but not fully implemented.
- **Mod selection:** Not every existing integration has its own named selection option.

The above describes the supplied source snapshot and reported behavior; check the [issue tracker](https://github.com/UselessFodder/FS-DynamicHorrorOp/issues) for updates before assuming an issue remains unresolved.

## Bugs, ideas, and contributions

Bugs, mod compatibility reports, and suggestions are welcome in [GitHub Issues](https://github.com/UselessFodder/FS-DynamicHorrorOp/issues).

When reporting a problem, it's particularly helpful to include the mission parameters, loaded mod list, whether you played single-player / locally hosted MP / dedicated server, the steps to reproduce, and relevant `.rpt` log excerpts.

If you contribute code, please keep new functionality modular, consider multiplayer locality, and test both first-run generation and repeat operations where appropriate.

## Author

**UselessFodder**  
[GitHub](https://github.com/UselessFodder) · [Repository](https://github.com/UselessFodder/FS-DynamicHorrorOp)

*Dynamic Horror Op is an unofficial community mission for Arma 3. Third-party mods remain the work of their respective creators.*
