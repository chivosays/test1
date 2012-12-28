DEST = "reddit-chrome-app"
CHROME = $(shell which google-chrome)

SRCS = icon_128.png manifest.json

default:
@echo "To generate a reddit-chrome-app.zip run:"
@echo " make zipfile"
@echo "To generate a reddit-chrome-app.crx package run:"
@echo " make all"
@echo "To clean up and prepare for checkin:"
@echo " make clean"

all: reddit-chrome-app.crx

zipfile : $(SRCS)
@-rm -rf reddit-chrome-app.zip 2>/dev/null || true
@-rm -rf $(DEST) 2>/dev/null || true
@mkdir $(DEST)
@cp $(SRCS) $(DEST)
zip -r reddit-chrome-app.zip $(DEST)

reddit-chrome-app.crx : $(SRCS)
@-rm -rf reddit-chrome-app.crx 2>/dev/null || true
@-rm -rf $(DEST) 2>/dev/null || true
@mkdir $(DEST)
@cp $(SRCS) $(DEST)
ifeq ($(wildcard reddit-chrome-app.pem),)
google-chrome --pack-extension=$(DEST)
else
google-chrome --pack-extension=$(DEST) --pack-extension-key=reddit-chrome-app.pem
endif

test:
@-rm -rf $(DEST) 2>/dev/null || true
@mkdir $(DEST)
@cp $(SRCS) $(DEST)
google-chrome --enable-extensions --load-extension=$(DEST)

clean:
@-rm *.zip 2>/dev/null || true
@-rm *.crx 2>/dev/null || true
@-rm -rf $(DEST) 2>/dev/null || true

# End
