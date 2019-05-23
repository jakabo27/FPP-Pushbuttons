#!/bin/sh
###########################################################
#To be run if the button is pressed.  
#You should have two playlists for each song - one with
# just the song as the "First play" and nothing in main, 
# and another with the song as first play and your standby
# sequence as the "Main" sequence.  (At least if you want 
# to do the exact thing that I'm doing)
#
#For example, if your song is Tiger Rag, you should have
# playlists "TigerRag", "TigerRagStandby", and "Standby"
#
###########################################################

# Playlists to run if it is between 6 and 11
NightSong1="Tiger4RagStandby"
NightSong2="LilJonXmasStandby"
NightSong3="HallelujahStandby"
NightSong4="DubstepStandby"
NightStandby="Standby"

# Playlists to run during the day or after 11
DaySong1="Tiger4Rag"
DaySong2="LilJonXmas"
DaySong3="Hallelujah"
DaySong4="Dubstep"
DayStandby="Standby"

#On and off times in 24-hour time.  If you want minutes, good luck
OnHour=17
OffHour=23
DayLoudStartHour=12;

#Morning volume and night volume - make it quiet when it isn't evening
EarlyMorningVolume=70;
NormalVolume=100;

###########################################################
# Guts of the script.  You probably don't need to edit    #
# anything below this block                               #
###########################################################

# Get our current status (IDLE=0, PLAYING=1, Stopping Gracefully=2)
STATUS=$(fpp -s | cut -d',' -f2)

#Get the running playlist and trim to 7 letters
PLAYLIST=$(fpp -s | cut -d',' -f4 | cut -c1-7)

#This will be "both" if it's playing a song, and "sequence" if it is standby
#used to determine if Standby sequence is running 
STANDBYSTRING=$(fpp -s | cut -d',' -f5)

#First 7 letters of names of playlists for comparison
#Just 7 letters so that "Song1Standby" and "Song1" are identical
#Okay so actually it should be first x letters and x should be the shortest song name you have
StandbyPlaylist=$(echo $NightStandby | cut -c1-7)
Song1Playlist=$(echo $NightSong1 | cut -c1-7)
Song2Playlist=$(echo $NightSong2 | cut -c1-7)
Song3Playlist=$(echo $NightSong2 | cut -c1-7)
Song4Playlist=$(echo $NightSong2 | cut -c1-7)

#Get the current hour in military time
CurrentHour=$(date +"%H")

#Print the status of some things - "echo" is like "print" in most languages
#Useful for testing if various things trimmed or calculated correctly 
#echo CurrentHour is $CurrentHour
#echo Running playlist is: $PLAYLIST
#echo Song2Playlist is: $Song2Playlist
#echo Status is: $STATUS

#Set the volume to 80% at night, 100% otherwise
#So that if I'm sleeping it isn't as loud
if [ $CurrentHour -lt $DayLoudStartHour -o $CurrentHour -ge $OffHour ]; then
	fpp -v $EarlyMorningVolume
else
	fpp -v $NormalVolume
fi


# Check that we got something meaningful
if [ -z "${STATUS}" ]; then
	echo "Error with status value" >&2
	exit 1
fi

# Act on the current status
case ${STATUS} in
	# IDLE
	0)
		#Night time - play Song1 with standby
		if [ $CurrentHour -lt $OffHour -a $CurrentHour -ge $OnHour ]; then
			fpp -c stop
			fpp -p "${NightSong1}"
		#Day time or really late - play song 1 once then turn off lights
		else
			fpp -c stop
			fpp -P "${DaySong1}"
		fi
		;;

	# PLAYING or STOPPING GRACEFULLY (graceful happens if button pressed when a scheduled playlist is ending)
	1 | 2)
		#Standby is running - this works because standby is my only non-media sequence
		if [ "$STANDBYSTRING" == "sequence" ]; then
			#Night time - play Song1 with standby
			if [ $CurrentHour -lt $OffHour -a $CurrentHour -ge $OnHour ]; then
				fpp -c stop
				fpp -p "${NightSong1}"
			#Day time or really late - play tiger rag once then turn off lights
			else
				fpp -c stop
				fpp -P "${DaySong1}"
			fi

		#To support more songs, copy this section and change "Song2Playlist" in last section to Song#Playlist
		#Song1 is running - play song 2
		elif [ "$PLAYLIST" == "$Song1Playlist" ]; then
			#Night time - play Song2 with standby
			if [ $CurrentHour -lt $OffHour -a $CurrentHour -ge $OnHour ]; then
				fpp -c stop
				fpp -p "${NightSong2}"
			#Day time or really late - play Song2 once then turn off lights
			else
				fpp -c stop
				fpp -P "${DaySong2}"
			fi

		#Song2 is running - play song 3
		elif [ "$PLAYLIST" == "$Song2Playlist" ]; then
			#Night time - play Song3 with standby
			if [ $CurrentHour -lt $OffHour -a $CurrentHour -ge $OnHour ]; then
				fpp -c stop
				fpp -p "${NightSong3}"
			#Day time or really late - play Song3 once then turn off lights
			else
				fpp -c stop
				fpp -P "${DaySong3}"
			fi

		#Song3 is running - play song 4
		elif [ "$PLAYLIST" == "$Song3Playlist" ]; then
			#Night time - play Song4 with standby
			if [ $CurrentHour -lt $OffHour -a $CurrentHour -ge $OnHour ]; then
				fpp -c stop
				fpp -p "${NightSong4}"
			#Day time or really late - play Song4 once then turn off lights
			else
				fpp -c stop
				fpp -P "${DaySong4}"
			fi

		#LAST SONG IS RUNNING - PLAY STANDBY
		elif [ "$PLAYLIST" == "$Song4Playlist" ]; then
			#Night time - play standby on loop
			if [ $CurrentHour -lt $OffHour -a $CurrentHour -ge $OnHour ]; then
				#echo Playing standby on repeat
				fpp -c stop
				fpp -p "${NightStandby}"
			#Day time or really late - play standby once
			else
				#echo Playing Standby Once
				fpp -c stop
				fpp -P "${DayStandby}"
			fi
		
		#Some other song is playing, such as from a different button - play the first song of this button
		else
			#Night time - play Song1 with standby
			if [ $CurrentHour -lt $OffHour -a $CurrentHour -ge $OnHour ]; then
				fpp -c stop
				fpp -p "${NightSong1}"
			#Day time or really late - play Song1 once then turn off lights
			else
				fpp -c stop
				fpp -P "${DaySong1}"
			fi
		fi
		;;

esac
