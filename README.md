# FPP-Pushbuttons
Example sketches and descriptions for using a push button start playlists in Falcon Pi Player (FPP), primarily used for Christmas light shows.  My script allows the buttons to function 24/7 but to play the music quieter at night, and to have a "standby" sequence without sound so that your lights can be on in the evening without playing music.

# Relevant script commands
The basic commands are as follows.  Pay attention to capitalization!! Capital -P will play a playlist once, lowercase -p will repeat it. 
- fpp -v 66 ..................Set volume to 66%
- fpp -c stop ..............Stop the show immediately
- fpp -C stop .............Stop show gracefully, at the end of the current song
- fpp -p thisPlaylistName ......Plays thisPlaylistName on repeat
- fpp -P thisPlaylistName ......Plays thisPlaylistName once
- eventScript "${MEDIADIR}/scripts/${thisScriptVariable}"   ......Runs a script.  In the case on the left it works for if you have your script name saved into a variable somewhere above, like thisScriptVariable=”PlayTheSong.sh”

# Button Wiring
I use [these buttons with an LED ring](https://www.amazon.com/gp/product/B07F9MDRWK) for mine, and this is how I wire them:
![LED Button](https://static.wixstatic.com/media/b044cb_8717a10f37fb49e987c569fa1bbac7fa~mv2.jpg/v1/fill/w_391,h_221,al_c,q_80,usm_0.66_1.00_0.01/withLED_JPG.webp)

If you have a normal button without an LED here's how you would wire it:
![Normal button](https://static.wixstatic.com/media/b044cb_fe958f7770374811b2b880458125c82e~mv2.jpg/v1/fill/w_404,h_221,al_c,q_80,usm_0.66_1.00_0.01/withoutLED_JPG.webp)
(If the pictures don't load go to the [page](https://www.jacobathompson.com/christmas-lights) on my website)

# FPP linking to GPIO
- Upload your scripts to the file manager and make/name all the necessary playlists each with a single song in it (or multiple if you want your whole multi-song show to play when a button is pressed)
- Under Status/Control go to **Events**
- Create a new event.  Event ID 1/1, Event name whatever, Effect Sequence NONE, Event Script *\<The script you uploaded\>*
- Go under Input/Output Setup and click GPIO triggers
- Toggle the pin your button is attached to.  If it will go low when you press the button then put the event on the Falling option, if it is active high then put the event on Rising. 
- Click the Reboot button by the warning it pops up after you make all the changes

# Motivation
Since my show would be outside of my apartment I didn’t want it playing all the time, but I also didn’t want it only playing every 30 minutes or something.  My solution was to set up a button that people can press to start the show, but I also wanted the lights to only constantly be on 5:00pm-11:00pm.  On the surface this seems simple, but I had to do some simple/complicated scripting to accomplish it like I wanted.  The video here and below gives a nice introduction on how to set up a pushbutton with a simple script to start a playlist.  Keep reading to find the complicated script I put together that accomplishes everything I want

# More Resources
I learned how to initially set up a button from this video:  [Triggering Show with a Button on FPP](https://www.youtube.com/watch?v=mRYyeiD5K9o)

Here's the main repo for FPP scripts:  [FPP-Scripts on GitHub](https://github.com/FalconChristmas/fpp-scripts)

Link to my website [JacobAThompson.com](https://www.jacobathompson.com/christmas-lights)
