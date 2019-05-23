# Flow
These scripts are set up to work in the way I wanted my show to run - you might want something different.  

Pressing the button will always do *something* - go to the next song, or go to the standby sequence.  It will do this at any time of day, and do something different depending on what song is playing.  

By default I have my show on a "standby" sequence in the evening, which uses the built-in scheduling in FPP to turn on at 5:00pm each day.  When it is after 5:00pm the script will play the playlist that has the standby sequence looping indefinitely, so that the song plays once and then the standby lights play after that.  

The scripts for multiple songs are set up so that when you press the button it will go to the next song defined for the script, or if it is currently playing the last song in the script then it will go to the standby sequence (if it is evening.  Otherwise it will just turn off the lights)

We're all programmers here so here's a tree

**Button pressed**
- If it is quiet hours (after 11:00pm or before 11:00am) set the volume to 80%.  Else set volume to 100%. 
- IF time is after 5:00pm and before 11:00pm
    - If no song is currently playing, play song 1 with standby
    - If song 1 is playing, play song 2 with standby
    - If song 2 is playing, play song 3 with standby
    - If song 3 (last song) is playing, play the standby sequence
- If time is before 5:00pm or after 11:00pm
    - Do the same stuff as above but with no standby sequence.  

# FPP Setup
In order to use these scripts you have to set up two versions of playlists for each song:  A "play once and go dark" version and a "play once and then go into standby sequence" version.  I name this "WeWillRockYou" and "WeWillRockyouStandby".  The first playlist will just have the WeWillRockYou playlist as the Lead-In sequence, nothing in Main or Lead Out.  The second playlist will have WeWillRockYou as a Lead-In and the Standby sequence as the Main that loops indefinitely.  

Once you set up these playlists it is really easy to change the first few lines of the script to switch around the order of the songs for the button.  

Hopefully this entire repo eventually becomes obselete when/if FPP pushes support for pushbuttons natively or someone writes a plugin for it.  I think there is a plugin for starting the show with a button, but I wanted more functionality than just starting it.  
