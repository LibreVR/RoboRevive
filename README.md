# RoboRevive

This is a Robo Recall mod that adds native Vive support. It's called RoboRevive, but it doesn't actually use the Revive compatibility layer itself. Instead it uses the native SteamVR plugin from the Unreal Engine.

# Installation

## Oculus Home

The full version of the game is [available from Oculus Home](https://www.oculus.com/experiences/rift/1081190428622821/).

1. Download the installer from the [releases page](https://github.com/LibreVR/RoboRevive/releases).
2. Run the installation, the directory for Robo Recall will be automatically detected.
3. At the end of the installation, Robo Recall will prompt you to install the RoboRevive mod.
4. Accept the installation and click "Play Now" to start playing Robo Recall on the Vive.

Do **not** start Robo Recall through the Revive Dashboard, if you do it will use the Oculus support instead of the native Vive support. Either start Robo Recall through the shortcut on your desktop or start `Robo Recall (RoboRevive)` from your Steam Library while SteamVR is running.

## Robo Recall Editor

If you want to use the Robo Recall Mod Kit on your Vive follow these instructions. The Mod Kit only contains the first mission, so it does **not** contain the full game.

1. Download the Robo Recall Editor through the Epic Games Launcher.
2. [Download this repository](https://github.com/LibreVR/RoboRevive/archive/master.zip) as a zip file.
3. Go to the directory where the Robo Recall Editor is installed, by default this is `C:\Program Files\Epic Games\RoboRecallModKit`.
4. Extract the contents of the zip file into the directory, be sure to merge it with the existing folders.
5. Start the Robo Recall Editor.

# FAQ

## How do I turn the sticky grip button mode on/off?

By default RoboRevive will use a hybrid sticky grip that will toggle the grip if the button is released within a 500ms window. You can customize this behaviour by installing [OpenVR-AdvancedSettings](https://github.com/matzman666/OpenVR-AdvancedSettings/).

## Can I still participate in the leaderboards and play the story mode while using this mod?

Yes you can! RoboRevive is a code-only mod and does not need to be enabled through the mod menu like other content mods. Therefore you can participate in the leadboards and the story mode like normal.

## Why do I still see Oculus Touch controllers sometimes?

Unfortunately it's not possible to change these models in a code-only mod like RoboRevive.
