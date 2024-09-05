
# Does the Entity Fit in Its Enclosure?

This is a simple 3D game based on an idea I had in a dream. It's my first project in Godot, and my first game that I've made from scratch. All development is done by me and all sounds and visual assets are credited under Creative Commons License.

### "The decision you have to make is simple. Your derivation will be everything but"

The premise is very simple - you're in a room and there's something else in there with you, and you have to assess whether or not it fits in its enclosure. Once I learn how, I'm going to make the creatures do supernatural stuff to trick you into thinking they are/aren't bigger than they are but for now it's extremely straightforward and doesn't even track 'correct' guesses.
  

# To play

1. Download the latest Build from the [Releases](https://github.com/ejuneau/dtefiie/releases/tag/build) page.

2. Extract the .zip archive.

3. Run the .exe file* 

4. Enjoy! Please leave feedback if you have any.

  \* You may receive a warning about running a program downloaded from the Internet at this step. This repository shows the source code for the executable file but there is always risk when interacting with media downloaded from the Internet. Proceed at your own discretion.

# Contact

For any comments/issues you can contact me directly at [rcjuneau8@gmail.com](mailto:rcjuneau8@gmail.com). If you are reporting a bug please be as specific as possible in the steps taken to reach it and how it may be reproduced. I may not reply even if I have seen your message but it is always appreciated.

# To do

This is a list of issues I'm trying to track. I will try to update this as I make changes but many of these rely on skills/resources I don't have. This list is ordered by arbitrary ease of implementation.


* ## Figure out Quaternions and make player head follow mouse Y axis
	This might not actually look good even if I get it right. Currently there is a more humanoid model that is hidden in the player node, as well as some commented out lines of code to track head movement along the Y axis. Rotating the model in 3D requires an understanding of quaternions and I don't have time to look into it right now.

* ## Finalise Options menu
	As of right now the options menu has tabs for General, Audio, and Display settings, although Display is completely blank for now. There are some settings I'd like to add to the existing tabs, as well as new tabs altogether:
	* General
	* Sound
	* Display
		* Fullscreen toggle
		* Graphics settings
	* Controls
		* Rebind-able keys
* ## Implement day mechanics
	The scope of the current game is to have 3 days made up of 3 or 4 entities per day. There would be a text-based menu in between days, sort of like Papers Please (introducing choices/arbitrary resources to use during these screens TBD)
* ## Implement save states
	Once Days are implemented, it  will become more necessary to have a save function to track the player's progress and actually manage how many correct/incorrect decisions they have made. A Godot plugin for this has already been downloaded but has not been implemented yet, although given the scope of the game this could potentially also be done by simpler means.

* ## Controller support
	More for accessibility than anything else, as well as rebinding keys.
* ## Shaders/visual effects
	I anticipate this will be the most difficult to implement seeing as I have no idea how to do this. Unfortunately, I also anticipate this to be the most engaging and interesting aspect about this game. Having Entities morph into each other when you're looking at them through a mirror, for example, requires many different visual effects that I don't even understand well enough to describe what I'm dealing with.

	I don't know if I will be able to get this done and may have to hire a professional to have it done for me. Then again, I thought I would have to hire a developer for this project too. 

# Credits

Based on a dream by Eve Juneau.

All Fonts are used under SIL Open Font License.
All other assets are used under Creative Commons License unless specified.

## Fonts
[VT323 by Peter Hull](https://fonts.google.com/specimen/VT323)



## Shaders

[Perfect Retro Pixel Shader - Godot 4 by ReVybes](https://godotshaders.com/shader/perfect-retro-pixel-shader-godot-4/)


## Sounds

[Forcefield Hum.wav by Zeraora](https://freesound.org/people/Zeraora/sounds/702631/)

[Foley_Mechanism_Light_Buzz_Short_Loop_Mono_DR05.wav by Nox_Sound](https://freesound.org/people/Nox_Sound/sounds/553075/)

[Electricity Sound by Duasun](https://freesound.org/people/Duasun/sounds/712127/)

[Fridge buzz (loop) by Matislav](https://freesound.org/people/Matislav/sounds/524598/)

[Heels.wav by Pixabay](https://pixabay.com/sound-effects/heelswav-14843/)


# Support

If you would like to support me, no you don't
