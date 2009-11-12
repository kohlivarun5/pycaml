OCAMLMAKEFILE = /usr/include/OCamlMakefile
PYTHON_INCLUDE_PATH = "/usr/include/python${PYVER}"
PYTHON_LIBRARY_PATH = "/usr/$(get_libdir)/python${PYVER}"

CLIBS=$(PYCAML_CLIBS) "pthread" "dl" $(UTIL_CLIBS) "m" "c"

PACKS=unix str

SOURCES=pycaml.ml pycaml.mli pycaml_stubs.c
RESULT=pycaml
THREADS=yes
LDFLAGS = -lpython${PYVER}
CFLAGS  = -g -O2 -fPIC -Wall -Werror
OCAMLFLAGS = -pp "camlp4o Camlp4MacroParser.cmo -D PYMAJOR`echo ${PYVER} | sed -e 's/\\..*//'`"
OCAMLDEP = ocamldep ${OCAMLFLAGS}

INCDIRS=$(PYTHON_INCLUDE_PATH)
LIBDIRS=$(PYTHON_LIBRARY_PATH)

all: pycaml_stubs.h native-code-library byte-code-library

mrproper: clean
	rm -rf *~ *.cmi *.cmo *.a *.cma *.cmxa doc *.so deps

deps: META pycaml.ml pycaml.mli pycaml_stubs.c pycaml_stubs.h
	touch deps

.PHONY: mrproper

include $(OCAMLMAKEFILE)
