# Makefile to process POV-Ray lab hand-in files - STATIC IMAGES
# Last edited on 2011-08-12 18:52:35 by stolfi

# ----------------------------------------------------------------------
# No need to change below here

.PHONY: \
  large-portrait \
  large-landscape \
  medium-portrait \
  medium-landscape \
  small-portrait \
  small-landscape

large-portrait: 
	${MAKE} WIDTH=600 HEIGHT=800 image

large-landscape: 
	${MAKE} WIDTH=800 HEIGHT=600 image

medium-portrait: 
	${MAKE} WIDTH=360 HEIGHT=480 image

medium-landscape: 
	${MAKE} WIDTH=480 HEIGHT=360 image

small-portrait: 
	${MAKE} WIDTH=240 HEIGHT=320 image

small-landscape: 
	${MAKE} WIDTH=320 HEIGHT=240 image

ifneq "/${WIDTH}" "/"
ifneq "/${HEIGHT}" "/"
#=======================================================================

image: ${NAME}.png 

${NAME}.png: ${NAME}.pov ${INC_IMG_FILES}
	-/bin/rm -f ${NAME}.png
	${POVRAY} +K0.5000 \
            +FN +Q9 \
            +W${WIDTH} +H${HEIGHT} \
            +AM1 +A0.0 +R${NRAYS} \
            +D +SP32 +EP4 \
            +L${POVINC} \
            +L${POVTTF} \
	    +I${NAME}.pov \
	    +O${NAME}.png \
          2>&1 | ./povray-output-filter.gawk
	if [[ "/${SHOW}" == "/YES" ]]; then \
          if [[ -s ${NAME}.png ]]; then \
            ${IMVIEW} ${NAME}.png ; \
          fi \
        fi

endif
endif
