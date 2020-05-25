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


jstest: ./neopt-test.cpp
	mkdir -p build/neopt-lib-cpp/
	@echo "We need Emscripten to proceed (tested with 1.39.16)"
	echo
	em++ --version
	@echo " ==== Compiling 'neopt-test.cpp' into './build/neopt-lib-cpp/neopt-lib.js' ====== "
	em++ -Ithirdparty/neo3-cpp-core/libs/ --bind $(EMCC_EXPORTED_FUNCTIONS) $(EMCC_FLAGS) ./neopt-test.cpp -I$(NEO3_SRC) --js-library $(NEO3_SRC)/libcore-js/libcore_exports.js --js-library $(BN_JS) -o ./build/neopt-lib-cpp/neopt-lib.js # -s MODULARIZE=1 -s 'EXPORT_NAME="Neo3CPP"' -s ASSERTIONS=1


run:
	@echo
	@echo "======= testing 'node_test.js' ======="
	@echo
	@echo "creating package.json for subproject neopt-lib-cpp"
	cp neopt-lib-package.json build/neopt-lib-cpp/package.json
	@echo ""
	@echo "installng neopt-lib-cpp locally"
	npm install
	@echo ""
	@echo "REAL run now..."
	node neopt_test.js

dist:
	@echo "We may need to comment the following line 96 in './build/neopt-lib-cpp/neopt-lib.js'"
	@echo "//if (!nodeFS) nodeFS = require('fs');"
	npm run build

test:
	npm test

.PHONY: dist

vendor: update_submodules cpp_core_deps_js
	@echo "Finished 'make vendor' successfully"

cpp_core_deps_js:
	cd thirdparty/neo3-cpp-core/ && make vendor_js

update_submodules:
	git submodule update --init --recursive
	git submodule update --recursive
