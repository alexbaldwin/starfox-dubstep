# Set the folder so that MSDOS can access it
FOL='Z:\\Sites\\starfoxdubstep\\tracks\\temp\\'
for f in *.wav
do
  # f is the filename
  # s returns the total number of samples
  s="$(soxi -s "$f")"
  # converts to 16-bit and splits track into each channel
  sox "$f" -b 16 temp/right-"$f" remix 2
  sox "$f" -b 16 temp/left-"$f" remix 1
  # print a line to copy and paste into MSDOS
  echo "&" "dspadpcm.exe -E" "$FOL"right-"$f" "-l0-""$s" "$FOL"right-"${f%%.*}"".dsp" "&" "dspadpcm -E" "$FOL"left-"$f" "-l0-""$s" "$FOL"left-"${f%%.*}"".dsp" "&" "dkdsp.exe" "$FOL"right-"${f%%.*}"".dsp" "-s" "$FOL"left-"${f%%.*}"".dsp" "$FOL"'final\\'"${f%%.*}"".dsp" 'header.dsp'
done

