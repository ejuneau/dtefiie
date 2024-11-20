
  

# Does the Entity Fit in Its Enclosure?

  

This is a simple 3D game based on an idea I had in a dream. It's my first project in Godot, and my first game that I've made from scratch. All development is done by me and all sounds and visual assets are credited under Creative Commons License.

  

### "The choice you have to make is simple. The deduction may be anything but."

  

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

  
  

*  ## ~~Figure out Quaternions and make player head follow mouse Y axis~~

~~This might not actually look good even if I get it right. Currently there is a more humanoid model that is hidden in the player node, as well as some commented out lines of code to track head movement along the Y axis. Rotating the model in 3D requires an understanding of quaternions and I don't have time to look into it right now.~~

This may likely never happen. After figuring out  quaternion rotation I realised that the model's head moving does not look good at all. I'm opting for an invisible player model for now.

  

*  ## Finalise Options menu

As of right now the options menu has tabs for General, Audio, and Display settings, although Display is completely blank for now. There are some settings I'd like to add to the existing tabs, as well as new tabs altogether:

* General

* Sound

* Display

	* Fullscreen toggle ✅

	* Graphics settings
		* Brightness✅
		* Resolution
		* Graphics settings

* Controls

	* Rebind-able keys

*  ## Implement day mechanics ✅

~~The scope of the current game is to have 3 days made up of 3 or 4 entities per day. There would be a text-based menu in between days, sort of like Papers Please (introducing choices/arbitrary resources to use during these screens TBD)~~

This has been implemented, with an arbitrary choice in between entities that does not affect gameplay (but may affect a to-be-confirmed narrative)

*  ## Implement save states ✅

~~Once Days are implemented, it will become more necessary to have a save function to track the player's progress and actually manage how many correct/incorrect decisions they have made. A Godot plugin for this has already been downloaded but has not been implemented yet, although given the scope of the game this could potentially also be done by simpler means.~~

A rough version of this is now in place in the latest release. As I opted to code the save system from scratch rather than use the addon mentioned above, there will almost definitely be bugs present.

  

*  ## Controller support

More for accessibility than anything else, as well as rebinding keys.

*  ## Shaders/visual effects

I anticipate this will be the most difficult to implement seeing as I have no idea how to do this. Unfortunately, I also anticipate this to be the most engaging and interesting aspect about this game. Having Entities morph into each other when you're looking at them through a mirror, for example, requires many different visual effects that I don't even understand well enough to describe what I'm dealing with.

  

I don't know if I will be able to get this done and may have to hire a professional to have it done for me. Then again, I thought I would have to hire a developer for this project too.

  

# Credits

  

Based on a dream by Eve Juneau.
All design and development by Eve Juneau unless specified.

  

All Fonts are used under SIL Open Font License.

All other assets are used under Creative Commons License unless specified.

  

## Fonts

[VT323](https://fonts.google.com/specimen/VT323) by Peter Hull

  
  
  

## Shaders

  

[Perfect Retro Pixel Shader - Godot 4](https://godotshaders.com/shader/perfect-retro-pixel-shader-godot-4/) by ReVybes

  
  
## Models



[Deer Skull](https://sketchfab.com/3d-models/deer-skull-46aa0dc438cc4a0bb6a655a008d92fcc) by MrDumDum

[Magnapinna Squid](https://sketchfab.com/3d-models/magnapinna-squid-be2b90cc7e2f436bb7a689a45aa256c1) by dotflare

[Deer 3D Model](https://rigmodels.com/model.php?view=Deer-3d-model__KND9LH9Y6UY69VC80JWPZL2PW) by RIGModels

[deer animated](https://www.turbosquid.com/3d-models/deer-animated-1012108) by TURBOSQUID



## Sounds

  

[Forcefield Hum.wav](https://freesound.org/people/Zeraora/sounds/702631/) by Zeraora

  

[Foley_Mechanism_Light_Buzz_Short_Loop_Mono_DR05.wav](https://freesound.org/people/Nox_Sound/sounds/553075/) by Nox_Sound

  

[Electricity Sound](https://freesound.org/people/Duasun/sounds/712127/) by Duasun

  

[Fridge buzz (loop)](https://freesound.org/people/Matislav/sounds/524598/) by Matislav

  

[Heels.wav](https://pixabay.com/sound-effects/heelswav-14843/) by Pixabay



[Deer, Reeve's Muntjac Gaywood Park first 4.5.22 00.30 SF.wav](https://freesound.org/s/674574/) by genghisattenborough



[jelenie deer.wav](https://freesound.org/people/monosfera/sounds/413314/) by monosfera


[squelch under boot watermelon](https://freesound.org/people/MaddieCooper/sounds/739191/) by MaddieCooper


[Gore Rain.mp3](https://freesound.org/people/LucasDuff/sounds/555066/) by LucasDuff


[Screaming beast 1](https://freesound.org/people/Valerie-Vivegnis/sounds/761611/) by Valerie-Vivegnis


[Male Inhale scream 3](https://freesound.org/people/jorickhoofd/sounds/180302/) by jorickhoofd

[Footstep_Water_03.wav](https://freesound.org/s/270429/) by LittleRobotSoundFactory

[Footstep_Water_05.wav](https://freesound.org/s/270428/) by LittleRobotSoundFactory  

[Footstep_Water_04.wav](https://freesound.org/s/270427/) by LittleRobotSoundFactory   

[Footstep_Water_07.wav](https://freesound.org/s/270426/) by LittleRobotSoundFactory

[Footstep_Water_02.wav](https://freesound.org/s/270425/) by LittleRobotSoundFactory  

[Dưới Mặt Biển](https://freesound.org/s/484184/) by SieuAmThanh

[Underwater Movement.wav](https://freesound.org/s/484187/) by Tim_Verberne
  
  

# Support

  

This project is not open to receiving support. If you are a fan of this project feel free to [get in touch with me](https://github.com/ejuneau/dtefiie?tab=readme-ov-file#contact) to discuss it but I do not want nor expect help in any form.
