include ../include.mk

APPLICATION=erlips
DOC_OPTS={dir,\"../edoc\"}

all: $(EBIN_FILES)

debug:
	$(MAKE) DEBUG=-DDEBUG

clean:
	rm -rf $(EBIN_FILES)

edoc:
	$(ERL) -noshell -eval "edoc:application(${APPLICATION}, \".\", [${DOC_OPTS}]),init:stop()"

test: all
	$(ERL) -noshell -pa ../ebin -s eunit test '.' -s init stop
