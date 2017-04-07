SED=	sed
ECHO=	echo
CHMOD=	chmod
ROMODE=	644
RM=	rm -f
alllist= for x in $(wildcard *.tex); do \
			 ${ECHO} $${x%.tex}; \
		 done
realcleanlist= for x in $(wildcard *.dvi) $(wildcard *.aux) \
		           $(wildcard *.log) $(wildcard *ps) \
				   $(wildcard *.pdf); do \
				  ${ECHO} $$x; \
		       done
cleanlist= for x in $(wildcard *.dvi) $(wildcard *.aux) \
		           $(wildcard *.log) $(wildcard *ps); do \
			   ${ECHO} $$x; \
		   done
tidylist= for x in $(wildcard *.dvi) $(wildcard *.aux) \
		           $(wildcard *.log) $(wildcard *ps); do \
			  ${ECHO} $$x; \
		  done

%.dvi : %.tex
	@latex $< > /dev/null 2>&1
	@latex $< > /dev/null 2>&1

%.ps : %.dvi
	@dvips $< > /dev/null 2>&1

%.pdf : %.ps
	@ps2pdf $< > /dev/null 2>&1

%.png : %.pdf
	convert -density 400 -background white -alpha remove $< $@ > /dev/null 2>&1

TYPES=dvi ps pdf
all :
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

realclean:
	@for item in `${realcleanlist}`; do\
		${ECHO} "Removing $$item"; \
		$(RM) $$item; \
	done

clean:
	@for item in `${cleanlist}`; do\
		${ECHO} "Removing $$item"; \
		$(RM) $$item; \
	done

tidy:
	@for item in `${tidylist}`; do\
		${ECHO} "Removing $$item"; \
		$(RM) $$item; \
	done;
