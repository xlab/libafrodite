NULL=

LIBNAME = libafrodite-1.0
TESTNAME = afrodite-test

VALAC = valac
VALA_VERSION = 0.18
LIBVALA = libvala-$(VALA_VERSION)

libafrodite_SOURCES = \
	astmerger.vala \
	astdumper.vala \
	parser.vala \
	parseresult.vala \
	symbol.vala \
	symbolresolver.vala \
	datatype.vala \
	voidtype.vala \
	sourcereference.vala \
	sourcefile.vala \
	codedom.vala \
	utils.vala \
	completionengine.vala \
	ellipsistype.vala \
	queryoptions.vala \
	queryresult.vala \
	resultitem.vala \
	constants.vala \
	sourceitem.vala \
	$(NULL)

all: libafrodite afrodite-test

libafrodite: $(libafrodite_SOURCES)
	$(VALAC) --enable-experimental \
	-X -fPIC -X -shared \
	--library $(LIBNAME) \
	-o $(LIBNAME).so \
	--header afrodite.h --vapidir ./vapi \
	--pkg gio-2.0 --pkg $(LIBVALA) --pkg utils $^
	

afrodite-test: afroditetest.vala
	$(VALAC) -X -I. -X -L. -X -lafrodite-1.0 --vapidir ./vapi --vapidir ./ --pkg $(LIBNAME) \
	--pkg gio-2.0 --pkg $(LIBVALA) --pkg utils $^

clean:
	git clean -f -d -x
	touch .tags