SED=	sed
ECHO=	echo
CHMOD=	chmod
ROMODE=	644
RM=	rm -f
alllist= for x in $(wildcard *.gp); do \
			 ${ECHO} $${x%.gp}; \
		 done
pnglist= for x in $(wildcard *.png); do \
			   ${ECHO} $$x; \
		   done

%.png : %.gp
	@gnuplot $< > /dev/null 2>&1

TYPES=png
all:
	@for item in `${alllist}`; \
	do  \
		export TARGET=$$item; \
		echo "Making $${TARGET}"; \
		PREREQ=''; \
		for type in ${TYPES}; \
		do \
			PREREQ="$${PREREQ} $${item}.$${type}"; \
			make -s "$${TARGET}.$${type}"; \
		done; \
	done

${TARGET} : ${PREREQ}

clean:
	@for item in `${pnglist}`; do \
		${ECHO} "Removing $$item"; \
		$(RM) $$item; \
	done

install: all
	@for item in `${pnglist}`; do \
		${ECHO} "Installing $$item"; \
		cp $$item ../../reveal.js/figures/gnuplot; \
	done
