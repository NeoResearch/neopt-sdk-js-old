all: jstest


GCC_FLAGS = -g -O3 -Wall --std=c++17 -fno-exceptions
EMCC_FLAGS = -g -O3 -Wall -s DISABLE_EXCEPTION_CATCHING=1 -s ALLOW_MEMORY_GROWTH=1 --std=c++17
OPENMP_FLAGS = #-fopenmp -lpthread

#-s DISABLE_EXCEPTION_CATCHING=0
# -s ALLOW_MEMORY_GROWTH=1
#EMCC_EXPORTED_FUNCTIONS = -s EXPORTED_FUNCTIONS="['_mytest', '_main']"
EMCC_EXPORTED_FUNCTIONS = -s EXPORTED_FUNCTIONS="['_mytest', '_myteststr']" -s EXTRA_EXPORTED_RUNTIME_METHODS="['ccall', 'cwrap', 'UTF8ToString', 'stringToUTF8', 'writeStringToMemory', 'getValue', 'setValue']"
####PATH_EMCC = "em++"
RESTSDK_FGLAS = #-lboost_system -lcrypto -lssl -lcpprest

BN_JS=./thirdparty/neo3-cpp-core/libs/lib/node_modules/bn.js/lib/bn.js

NEO3_SRC=./thirdparty/neo3-cpp-core/src/


jstest: ./jstest.cpp
	mkdir -p build/
	@echo "We need Emscripten to proceed (tested with 1.39.16)"
	echo
	em++ --version
	@echo " ==== Compiling 'jstest.cpp' into './build/librarytest.js' ====== "
	em++ -Ilibs/ --bind $(EMCC_EXPORTED_FUNCTIONS) $(EMCC_FLAGS) ./jstest.cpp -I$(NEO3_SRC) --js-library $(NEO3_SRC)/libcore-js/libcore_exports.js --js-library $(BN_JS) -o ./build/librarytest.js # -s MODULARIZE=1 -s 'EXPORT_NAME="Neo3CPP"' -s ASSERTIONS=1
	@echo
	@echo "======= testing 'node_test.js' ======="
	@echo
	nodejs node_test.js


vendor: update_submodules cpp_core_deps_js
	@echo "Finished 'make vendor' successfully"

cpp_core_deps_js:
	cd thirdparty/neo3-cpp-core/ && make vendor_js

update_submodules:
	git submodule update --init --recursive
	git submodule update --recursive
