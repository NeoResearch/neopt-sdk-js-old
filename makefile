all: build_vanilla_js build_common_js


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

CSBN_JS=./thirdparty/csbiginteger.js
#CSBN_JS=./node_modules/csbiginteger/index.js

NEO3_SRC=./thirdparty/neo3-cpp-core/src/

SET_TO_WASM=-s WASM=1
EMCC_STRICT=-s STRICT=1
NEO3_LIBS=thirdparty/neo3-cpp-core/libs/
GENERAL_JS_LIB=--js-library src/neo3-cpp-bindings/general-libcore_exports.js
ASSERTIONS=-s ASSERTIONS=1 
FILESYSTEM=-s FILESYSTEM=0

# for web browsers
build_vanilla_js: ./neopt-test.cpp 
	mkdir -p build/neopt-lib-cpp/
	@echo "We need Emscripten to proceed (tested with 1.39.16)"
	echo
	em++ --version
	@echo ""
	@echo "Building VanillaJS (for web browsers)"
	@echo ""
	@echo " ==== Compiling 'neopt-test.cpp' into './build/neopt-lib-cpp/neopt-lib-cpp.js' ====== "
	#em++ -s WASM=0 -s STRICT=1 -s MODULARIZE=1 -s EXPORT_ES6=1  -s FILESYSTEM=0 -g4 -Ithirdparty/neo3-cpp-core/libs/ --bind $(EMCC_EXPORTED_FUNCTIONS) $(EMCC_FLAGS) ./neopt-test.cpp -I$(NEO3_SRC) --js-library src/neo3-cpp-bindings/libcore_exports-new.js --js-library $(BN_JS) --js-library $(CSBN_JS) -o ./build/neopt-lib-cpp/neopt-lib.js  -s ASSERTIONS=1  # -s 'EXPORT_NAME="Neo3CPP"'  -s MODULARIZE=1 -s EXPORT_ES6=1 -s
	em++ --pre-js prefix-web.js -I$(NEO3_LIBS) -g4 --bind $(EMCC_EXPORTED_FUNCTIONS) $(EMCC_FLAGS) ./neopt-test.cpp -I$(NEO3_SRC) $(GENERAL_JS_LIB)  -o ./build/neopt-lib-cpp/neopt-lib-cpp.js $(ASSERTIONS) $(SET_TO_WASM) $(EMCC_STRICT) $(FILESYSTEM)
	# -s 'EXPORT_NAME="Neo3CPP"'  -s MODULARIZE=1 -s EXPORT_ES6=1 -s
	#@echo ""
	#@echo "Building HTML version"
	#em++ -s WASM=0 -s STRICT=1 -s FILESYSTEM=0 -g4 --emrun -Ithirdparty/neo3-cpp-core/libs/ --bind $(EMCC_EXPORTED_FUNCTIONS) $(EMCC_FLAGS) ./neopt-test.cpp -I$(NEO3_SRC) --js-library $(NEO3_SRC)/libcore-js/libcore_exports.js --js-library $(BN_JS) -o ./build/output.html -s ASSERTIONS=1 # -s MODULARIZE=1 -s 'EXPORT_NAME="Neo3CPP"' -s ASSERTIONS=1

# for nodejs
build_common_js:  ./neopt-test.cpp 
	mkdir -p build/neopt-lib-node-cpp/
	@echo "We need Emscripten to proceed (tested with 1.39.16)"
	echo
	em++ --version
	@echo ""
	@echo "Building CommonJS (for nodejs)"
	@echo ""
	@echo " ==== Compiling 'neopt-test.cpp' into './build/neopt-lib-node-cpp/neopt-lib-cpp.js' ====== "
	#em++ -s WASM=0 -s STRICT=1 -s MODULARIZE=1 -s EXPORT_ES6=1  -s FILESYSTEM=0 -g4 -Ithirdparty/neo3-cpp-core/libs/ --bind $(EMCC_EXPORTED_FUNCTIONS) $(EMCC_FLAGS) ./neopt-test.cpp -I$(NEO3_SRC) --js-library src/neo3-cpp-bindings/libcore_exports-new.js --js-library $(BN_JS) --js-library $(CSBN_JS) -o ./build/neopt-lib-cpp/neopt-lib.js  -s ASSERTIONS=1  # -s 'EXPORT_NAME="Neo3CPP"'  -s MODULARIZE=1 -s EXPORT_ES6=1 -s
	em++ -s ENVIRONMENT='web' --pre-js prefix-node.js -I$(NEO3_LIBS) -g4 --bind $(EMCC_EXPORTED_FUNCTIONS) $(EMCC_FLAGS) ./neopt-test.cpp -I$(NEO3_SRC) $(GENERAL_JS_LIB)  -o ./build/neopt-lib-node-cpp/neopt-lib-cpp.js $(ASSERTIONS) $(SET_TO_WASM) $(EMCC_STRICT) $(FILESYSTEM)
	#em++ -Ilibs/ --bind $(EMCC_EXPORTED_FUNCTIONS) $(EMCC_FLAGS) ./jstest.cpp -I$(NEO3_SRC) --js-library src/libcore-js/libcore_exports.js --js-library $(BN_JS) -o ./build/librarytest.js
	#@echo "Building HTML version"
	#em++ -s WASM=0 -s STRICT=1 -s FILESYSTEM=0 -g4 --emrun -Ithirdparty/neo3-cpp-core/libs/ --bind $(EMCC_EXPORTED_FUNCTIONS) $(EMCC_FLAGS) ./neopt-test.cpp -I$(NEO3_SRC) --js-library $(NEO3_SRC)/libcore-js/libcore_exports.js --js-library $(BN_JS) -o ./build/output.html -s ASSERTIONS=1 # -s MODULARIZE=1 -s 'EXPORT_NAME="Neo3CPP"' -s ASSERTIONS=1


run_js_node:
	@echo
	@echo "======= testing 'node_test.js' ======="
	@echo
	@echo "creating package.json for subproject neopt-lib-cpp"
	cp neopt-lib-package.json build/neopt-lib-node-cpp/package.json
	@echo ""
	@echo "installng neopt-lib-node-cpp locally"
	npm install
	@echo ""
	@echo "REAL run now..."
	node neopt_test.js

dist:
	@echo "We may need to comment the following line 96 in './build/neopt-lib-node-cpp/neopt-lib.js'"
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
