# RoboRevive

This is proof-of-concept Robo Recall mod that adds native Vive support. It's called RoboRevive, but it doesn't actually use the Revive compatibility layer. Instead it uses the native SteamVR plugin from the Unreal Engine.

Contributions to improve the control scheme and other kinds of Vive customizations are more than welcome. I'd like to see people use this as a base to create a completely native version of Robo Recall.

# Installation

## Oculus Home

1. Download Robo Recall from Oculus Home.
2. Download OpenVR.zip and Revive.robo from the [releases page](https://github.com/LibreVR/RoboRevive/releases).
3. Go to the directory where Robo Recall is installed, by default this is `C:\Program Files\Oculus\Software\Software\epic-games-odin`.
4. Extract the `Engine` folder from OpenVR.zip in this directory, make sure you merge it with the existing folder.
5. Go to `RoboRecall\Binaries\Win64` and drag Revive.robo onto the `RoboRecallModInstaller.exe` (or just double-click Revive.robo if it's already associated).
6. Press 'Yes' to install the mod.
7. Click 'Play Now' after installation or just run `RoboRecall-Win64-Shipping.exe` directly.

## Robo Recall Editor

1. Download the Robo Recall Editor through the Epic Games Launcher.
2. [Download this repository](https://github.com/LibreVR/RoboRevive/archive/master.zip) as a zip file.
3. Go to the directory where the Robo Recall Editor is installed, by default this is `C:\Program Files\Epic Games\RoboRecallModKit`.
4. Extract the contents of the zip file into the directory, be sure to merge it with the existing folders.
5. Start the Robo Recall Editor, it may ask to rebuild a few modules, click 'Yes' to recompile them.
6. Now go add Vive Controller render models and submit your contribution as a Pull Request.
