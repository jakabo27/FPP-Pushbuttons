#!/bin/sh
###########################################################
#To be run if the button is pressed.  
#Changes the volume to a set amount depending on the time of day
#
###########################################################


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

#Get the current hour in military time
CurrentHour=$(date +"%H")

#Set the volume to 80% at night, 100% otherwise
#So that if I'm sleeping it isn't as loud
if [ $CurrentHour -lt $DayLoudStartHour -o $CurrentHour -ge $OffHour ]; then
	fpp -v $EarlyMorningVolume
else
	fpp -v $NormalVolume
fi