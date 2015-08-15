all: $(PROGS) .gitignore

CFLAGS = -std=c99 -g -Wall
INCLUDES = -I ../..
# Hack to overcome deficiency of `which` on solaris.
PYTHON = $(shell which python2.7 > /dev/null && which python2.7 || which python)

CFILES += ../../apue.3e/lib/error.c 

%: %.c
	cc $(CFLAGS) $(INCLUDES) $(CFILES) $(CFILES_$@) $< -o $@ $(LDFLAGS) $(LDFLAGS_$@)

test:
	PYTHONPATH=../.. $(PYTHON) test.py

.gitignore: $(PROGS)
	touch .gitignore
	for prog in $(PROGS); do \
	    if ! grep -sq ^$$prog .gitignore$ ; then \
		echo $$prog >> .gitignore ; \
	    fi \
	done

clean:
	rm -f $(PROGS)

.SILENT: .gitignore
