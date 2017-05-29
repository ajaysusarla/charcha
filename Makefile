.PHONY: build configure install

## Silent by default
V =
ifeq ($(strip $(V)),)
        E = @echo
        Q = @
else
        E = @\#
        Q =
endif
export E Q


include config.mk

all: .sandbox .update .install-deps configure build
        $(E) "Charcha successfully built for $(OS)."
        $(E)
        $(E) "Add 'charcha' to your path by running:"
        $(E) '  export PATH=$(PWD)/dist/build/charcha:$$PATH'
        $(E)
        $(E) "_Or_ make a symlink to the executable in ~/.cabal/bin by running:"
        $(E) '  ln -s $(PWD)/dist/build/charcha/charca $$HOME/.cabal/bin/charcha'
        $(E)


install:
	$(Q)$(CABAL) install $(CABALFLAGS)

configure:
	$(Q)$(CABAL) configure $(CONFIG_FLAGS)

build:
	$(Q)$(CABAL) build $(BUILD_FLAGS)

clean:
        $(Q) find . -name "*_flymake.hs" -delete

full-clean: clean
        $(Q) $(CABAL) clean
        $(Q) $(CABAL) sandbox delete -v0
        $(Q) rm -rf .cabal-sandbox/ dist/

.install-deps:
	$(Q)$(CABAL) install --only-dependencies

.update:
	$(Q)$(CABAL) update

.sandbox:
ifneq ($(wildcard .cabal-sandbox/),)
        $(E) "Using Existing sandbox..."
else
        $(E) "Building in a sandbox..."
        $(Q)$(CABAL) sandbox init
endif

stack-build:
        $(E) "Building Charcha using stack."
        $(Q)$(STACK) build
