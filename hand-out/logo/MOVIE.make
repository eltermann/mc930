# Makefile to process POV-Ray lab hand-in files - ANIMATIONS
# Last edited on 2011-08-12 18:52:03 by stolfi

# Large image size (e.g. still frames):
FULLWIDTH := 600
FULLHEIGHT := 400

# Medium image size (e.g. the final movie):
MEDWIDTH := 300
MEDHEIGHT := 200

# Small image size (e.g. the film strips):
SMALLWIDTH := 90
SMALLHEIGHT := 60

# ----------------------------------------------------------------------
# ----------------------------------------------------------------------
# No need to change below here

.PHONY: \
  first \
  middle \
  last \
  strip showstrip \
  fast \
  movie \
  still showstill \
  frame showframe

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Still frames

STILLWIDTH := ${FULLWIDTH}
STILLHEIGHT := ${FULLHEIGHT}
STILLRAYS := 2

# "make first" shows the first frame of the movie:
#
first: 
	${MAKE} CLOCK=0.0000 still;
	if [[ "/${SHOW}" == "/YES" ]]; then ${MAKE} CLOCK=0.0000 showstill; fi
	

# "make middle" shows the middle frame of the movie:
#
middle: 
	${MAKE} CLOCK=0.5000 still;
	if [[ "/${SHOW}" == "/YES" ]]; then ${MAKE} CLOCK=0.5000 showstill; fi

# "make last" shows the last frame of the movie:
#
last: 
	${MAKE} CLOCK=1.0000 still;
	if [[ "/${SHOW}" == "/YES" ]]; then ${MAKE} CLOCK=1.0000 showstill; fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# "make strip" creates a strip with several frames:

STRIPNAME := ${MAIN}-s

STRIPWIDTH := ${SMALLWIDTH}
STRIPHEIGHT := ${SMALLHEIGHT}
STRIPRAYS := 1

STRIPCLOCKS := \
    0.0000 0.0714 0.1429 0.2143 0.2857 \
    0.3571 0.4286 0.5000 0.5714 0.6429 \
    0.7143 0.7857 0.8571 0.9286 1.0000
    
STRIPFRAMES := ${addprefix ${STRIPNAME}-,${addsuffix .png,${STRIPCLOCKS}}}

strip: ${STRIPNAME}.png

${STRIPNAME}.png: ${MAIN}.pov ${OTHERINPUTS}
	/bin/rm -f ${STRIPNAME}.png 
	for clock in ${STRIPCLOCKS} ; do \
          ${MAKE} NAME=${STRIPNAME} CLOCK=$$clock \
            WIDTH=${STRIPWIDTH} HEIGHT=${STRIPHEIGHT} \
            NRAYS=${STRIPRAYS} SHOW='+D' BORDER=1 \
            frame; \
        done
	./tile-movie-frames.sh \
          -ncols 5 \
          ${STRIPNAME}.png \
          ${STRIPFRAMES}
	if [[ "/${SHOW}" == "/YES" ]]; then ${MAKE} showstrip; fi

showstrip:
	-if [[ -s ${STRIPNAME}.png ]]; then ${IMVIEW} ${STRIPNAME}.png ; fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# "make fast" creates a movie with 24 medium-size frames at speed × 4.

FASTNAME := ${MAIN}-f

FASTWIDTH := ${MEDWIDTH}
FASTHEIGHT := ${MEDHEIGHT}
FASTRAYS := 1

# Parameters for 24 frames, high-speed
FASTDELAY := 15
FASTCLOCKS := \
  0.0000 0.0417 0.0833 0.1250 0.1667 \
  0.2083 0.2500 0.2917 0.3333 0.3750 \
  0.4167 0.4583 0.5000 0.5417 0.5833 \
  0.6250 0.6667 0.7083 0.7500 0.7917 \
  0.8333 0.8750 0.9167 0.9583
    
FASTFRAMES := ${addprefix ${FASTNAME}-,${addsuffix .png,${FASTCLOCKS}}}

fast: ${FASTNAME}.gif

${FASTNAME}.gif: ${MAIN}.pov ${OTHERINPUTS}
	/bin/rm -f ${FASTNAME}.gif
	for clock in ${FASTCLOCKS} ; do \
          ${MAKE} NAME=${FASTNAME} CLOCK=$$clock \
            WIDTH=${FASTWIDTH} HEIGHT=${FASTHEIGHT} \
            NRAYS=${FASTRAYS} SHOW='-D' \
            frame; \
        done
	./animate-movie-frames.sh \
          -delay ${FASTDELAY} \
          ${FASTNAME}.gif \
          ${FASTFRAMES}
	@-echo "----------------------------------------------------------------------"
	@-echo "To watch the movie, open ${FASTNAME}.gif with a browser."
	@-echo "----------------------------------------------------------------------"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# "make movie" creates a movie with many frames, normal speed.

MOVIEWIDTH := ${FULLWIDTH}
MOVIEHEIGHT := ${FULLHEIGHT}
MOVIERAYS := 2

MOVIENAME := ${MAIN}-m

# Parameters for 50 frames:
# MOVIEDELAY := 10
# MOVIECLOCKS := \
#   0.0000 0.0200 0.0400 0.0600 0.0800 \
#   0.1000 0.1200 0.1400 0.1600 0.1800 \
#   0.2000 0.2200 0.2400 0.2600 0.2800 \
#   0.3000 0.3200 0.3400 0.3600 0.3800 \
#   0.4000 0.4200 0.4400 0.4600 0.4800 \
#   0.5000 0.5200 0.5400 0.5600 0.5800 \
#   0.6000 0.6200 0.6400 0.6600 0.6800 \
#   0.7000 0.7200 0.7400 0.7600 0.7800 \
#   0.8000 0.8200 0.8400 0.8600 0.8800 \
#   0.9000 0.9200 0.9400 0.9600 0.9800
  
# Parameters for 80 frames:
# MOVIEDELAY := 6
# MOVIECLOCKS := \
#   0.0000 0.0125 0.0250 0.0375 0.0500 0.0625 0.0750 0.0875 \
#   0.1000 0.1125 0.1250 0.1375 0.1500 0.1625 0.1750 0.1875 \
#   0.2000 0.2125 0.2250 0.2375 0.2500 0.2625 0.2750 0.2875 \
#   0.3000 0.3125 0.3250 0.3375 0.3500 0.3625 0.3750 0.3875 \
#   0.4000 0.4125 0.4250 0.4375 0.4500 0.4625 0.4750 0.4875 \
#   0.5000 0.5125 0.5250 0.5375 0.5500 0.5625 0.5750 0.5875 \
#   0.6000 0.6125 0.6250 0.6375 0.6500 0.6625 0.6750 0.6875 \
#   0.7000 0.7125 0.7250 0.7375 0.7500 0.7625 0.7750 0.7875 \
#   0.8000 0.8125 0.8250 0.8375 0.8500 0.8625 0.8750 0.8875 \
#   0.9000 0.9125 0.9250 0.9375 0.9500 0.9625 0.9750 0.9875

# Parameters for 100 frames:
MOVIEDELAY := 3
MOVIECLOCKS := \
  0.0000 0.0100 0.0200 0.0300 0.0400 0.0500 0.0600 0.0700 0.0800 0.0900 \
  0.1000 0.1100 0.1200 0.1300 0.1400 0.1500 0.1600 0.1700 0.1800 0.1900 \
  0.2000 0.2100 0.2200 0.2300 0.2400 0.2500 0.2600 0.2700 0.2800 0.2900 \
  0.3000 0.3100 0.3200 0.3300 0.3400 0.3500 0.3600 0.3700 0.3800 0.3900 \
  0.4000 0.4100 0.4200 0.4300 0.4400 0.4500 0.4600 0.4700 0.4800 0.4900 \
  0.5000 0.5100 0.5200 0.5300 0.5400 0.5500 0.5600 0.5700 0.5800 0.5900 \
  0.6000 0.6100 0.6200 0.6300 0.6400 0.6500 0.6600 0.6700 0.6800 0.6900 \
  0.7000 0.7100 0.7200 0.7300 0.7400 0.7500 0.7600 0.7700 0.7800 0.7900 \
  0.8000 0.8100 0.8200 0.8300 0.8400 0.8500 0.8600 0.8700 0.8800 0.8900 \
  0.9000 0.9100 0.9200 0.9300 0.9400 0.9500 0.9600 0.9700 0.9800 0.9900

MOVIEFRAMES := ${addprefix ${MOVIENAME}-,${addsuffix .png,${MOVIECLOCKS}}}

movie: ${MOVIENAME}.gif

${MOVIENAME}.gif: ${MAIN}.pov ${OTHERINPUTS}
	/bin/rm -f ${MOVIENAME}.gif
	for clock in ${MOVIECLOCKS} ; do \
          ${MAKE} NAME=${MOVIENAME} CLOCK=$$clock \
            WIDTH=${MOVIEWIDTH} HEIGHT=${MOVIEHEIGHT} \
            NRAYS=${MOVIERAYS} SHOW='-D' \
            frame; \
        done
	./animate-movie-frames.sh \
          -delay ${MOVIEDELAY} \
          ${MOVIENAME}.gif \
          ${MOVIEFRAMES}
	@-echo "----------------------------------------------------------------------"
	@-echo "To watch the movie, open ${MOVIENAME}.gif with a browser."
	@-echo "----------------------------------------------------------------------"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# "make clean" removes all created files
# Take care not to remove "*-orig.*"

clean::
	-/bin/rm -f ${MAIN}.log ${MAIN}-*.log
	-/bin/rm -f ${MAIN}-[01].[0-9][0-9][0-9][0-9].png
	-/bin/rm -f ${STRIPNAME}.png ${STRIPNAME}-[01].[0-9][0-9][0-9][0-9].png
	-/bin/rm -f ${FASTNAME}.gif ${FASTNAME}-[01].[0-9][0-9][0-9][0-9].png
	-/bin/rm -f ${MOVIENAME}.gif ${MOVIENAME}-[01].[0-9][0-9][0-9][0-9].png
	-/bin/rm -f ${MAIN}-i.png ${MAIN}-*-i.png

######################################################################
# Commands for a specific frame:
# Caller must define ${CLOCK}.
#

CLOCK := CLOCK.IS.UNDEFINED
ifneq "${CLOCK}" "CLOCK.IS.UNDEFINED"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# "make still CLOCK=N.NNNN" creates a frame with specified clock value:
#
STILLNAME := ${MAIN}

still: 
	${MAKE} NAME=${STILLNAME} CLOCK=`printf "%6.4f" ${CLOCK}`  \
          WIDTH=${STILLWIDTH} HEIGHT=${STILLHEIGHT} \
          NRAYS=${STILLRAYS} SHOW='+D' \
          frame

showstill:
	${MAKE} NAME=${STILLNAME} CLOCK=`printf "%6.4f" ${CLOCK}` \
          WIDTH=${STILLWIDTH} HEIGHT=${STILLHEIGHT} \
          NRAYS=${STILLRAYS} SHOW='+D' \
          showframe

######################################################################
# General-purpose commands used by the above:
# Caller must define ${CLOCK}, ${NAME}, ${WIDTH}, ${HEIGHT}, ${NRAYS}.
#
NAME := NAME.IS.UNDEFINED
ifneq "${NAME}" "NAME.IS.UNDEFINED"
WIDTH := WIDTH.IS.UNDEFINED
ifneq "${WIDTH}" "WIDTH.IS.UNDEFINED"
HEIGHT := HEIGHT.IS.UNDEFINED
ifneq "${HEIGHT}" "HEIGHT.IS.UNDEFINED"
NRAYS := NRAYS.IS.UNDEFINED
ifneq "${NRAYS}" "NRAYS.IS.UNDEFINED"

FRAME := ${NAME}-${CLOCK}
FRAMEBORDER := 0

frame: ${FRAME}.png

showframe: 
	-if [[ -s ${FRAME}.png ]]; then ${IMVIEW} ${FRAME}.png ; fi

${FRAME}.png: ${MAIN}.pov ${OTHERINPUTS}
	@echo "OTHERINPUTS = ${OTHERINPUTS}"
	-/bin/rm -f ${FRAME}.png
	${POVRAY} +K${CLOCK} \
            +FN +Q9 +MB1 \
            +W${WIDTH} +H${HEIGHT} \
            +AM1 +A0.0 +R${NRAYS} \
            ${SHOW} +SP32 +EP4 \
            +L${POVINC} \
            +L${POVTTF} \
	    +I${MAIN}.pov \
	    +O${FRAME}.png \
          2>&1 | ./povray-output-filter.gawk

endif
endif
endif
endif
# End ${NAME}, ${WIDTH}, ${HEIGHT}, ${NRAYS} section
######################################################################

endif
# End ${CLOCK} section
######################################################################


