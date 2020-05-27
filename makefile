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
OUTPUT_VANILLA=./build/neopt-lib-cpp-web/neopt-lib-cpp-web.js
OUTPUT_NODE=./build/neopt-lib-cpp-node/neopt-lib-cpp-node.js
OUTPUT_NODE_ES6=./build/neopt-lib-cpp-es6/neopt-lib-cpp-es6.mjs # uses 'import.meta', not running fine yet on browsers or webpack...

# for web browsers
build_vanilla_js: ./src/neopt-test.cpp 
	mkdir -p build/neopt-lib-cpp-web/
	@echo "We need Emscripten to proceed (tested with 1.39.16)"
	echo
	em++ --version
	@echo ""
	@echo "Building VanillaJS (for web browsers)"
	@echo ""
	@echo " ==== Compiling 'neopt-test.cpp' into '$(OUTPUT_VANILLA)' ====== "
	em++ --pre-js prefix-web-globals.js -s ENVIRONMENT='web' -s 'EXPORT_NAME="LibNeo3Cpp"' -I$(NEO3_LIBS) -g4 --bind $(EMCC_EXPORTED_FUNCTIONS) $(EMCC_FLAGS) ./src/neopt-test.cpp -I$(NEO3_SRC) $(GENERAL_JS_LIB)  -o $(OUTPUT_VANILLA) $(ASSERTIONS) $(SET_TO_WASM) $(EMCC_STRICT) $(FILESYSTEM)
	#em++ -s WASM=0 -s STRICT=1 -s MODULARIZE=1 -s EXPORT_ES6=1  -s FILESYSTEM=0 -g4 -Ithirdparty/neo3-cpp-core/libs/ --bind $(EMCC_EXPORTED_FUNCTIONS) $(EMCC_FLAGS) ./neopt-test.cpp -I$(NEO3_SRC) --js-library src/neo3-cpp-bindings/libcore_exports-new.js --js-library $(BN_JS) --js-library $(CSBN_JS) -o ./build/neopt-lib-cpp/neopt-lib.js  -s ASSERTIONS=1  # -s 'EXPORT_NAME="Neo3CPP"'  -s MODULARIZE=1 -s EXPORT_ES6=1 -s
	# -s 'EXPORT_NAME="Neo3CPP"'  -s MODULARIZE=1 -s EXPORT_ES6=1 -s
	#@echo ""
	#@echo "Building HTML version"
	#em++ -s WASM=0 -s STRICT=1 -s FILESYSTEM=0 -g4 --emrun -Ithirdparty/neo3-cpp-core/libs/ --bind $(EMCC_EXPORTED_FUNCTIONS) $(EMCC_FLAGS) ./neopt-test.cpp -I$(NEO3_SRC) --js-library $(NEO3_SRC)/libcore-js/libcore_exports.js --js-library $(BN_JS) -o ./build/output.html -s ASSERTIONS=1 # -s MODULARIZE=1 -s 'EXPORT_NAME="Neo3CPP"' -s ASSERTIONS=1

# for nodejs
build_common_js:  ./src/neopt-test.cpp 
	mkdir -p build/neopt-lib-cpp-node/
	mkdir -p build/neopt-lib-cpp-es6/
	@echo "We need Emscripten to proceed (tested with 1.39.16)"
	echo
	em++ --version
	@echo ""
	@echo "Building CommonJS (for nodejs)"
	@echo ""
	@echo " ==== Compiling 'neopt-test.cpp' into '$(OUTPUT_NODE)' ====== "
	#em++ -s WASM=0 -s STRICT=1 -s MODULARIZE=1 -s EXPORT_ES6=1  -s FILESYSTEM=0 -g4 -Ithirdparty/neo3-cpp-core/libs/ --bind $(EMCC_EXPORTED_FUNCTIONS) $(EMCC_FLAGS) ./neopt-test.cpp -I$(NEO3_SRC) --js-library src/neo3-cpp-bindings/libcore_exports-new.js --js-library $(BN_JS) --js-library $(CSBN_JS) -o ./build/neopt-lib-cpp/neopt-lib.js  -s ASSERTIONS=1  # -s 'EXPORT_NAME="Neo3CPP"'  -s MODULARIZE=1 -s EXPORT_ES6=1 -s
	#
	#em++ -s ENVIRONMENT='web' --pre-js prefix-node.js -I$(NEO3_LIBS) -g4 --bind $(EMCC_EXPORTED_FUNCTIONS) $(EMCC_FLAGS) ./neopt-test.cpp -I$(NEO3_SRC) $(GENERAL_JS_LIB)  -o $(OUTPUT_NODE) $(ASSERTIONS) $(SET_TO_WASM) $(EMCC_STRICT) $(FILESYSTEM)
	em++ --pre-js prefix-node-require.js --post-js postfix.js -s FILESYSTEM=0 -I$(NEO3_LIBS) -g4 --bind $(EMCC_EXPORTED_FUNCTIONS) $(EMCC_FLAGS) ./src/neopt-test.cpp -I$(NEO3_SRC) $(GENERAL_JS_LIB)  -o $(OUTPUT_NODE) $(ASSERTIONS) $(SET_TO_WASM) $(EMCC_STRICT) $(FILESYSTEM)  -s MODULARIZE=1 -s 'EXPORT_NAME="Neo3CppLibNode"'
	em++ --pre-js prefix-es6-import-meta.js -s ENVIRONMENT='web' --post-js postfix.js -s MODULARIZE=1 -s EXPORT_ES6=1 -s FILESYSTEM=0 -I$(NEO3_LIBS) -g4 --bind $(EMCC_EXPORTED_FUNCTIONS) $(EMCC_FLAGS) ./src/neopt-test.cpp -I$(NEO3_SRC) $(GENERAL_JS_LIB)  -o $(OUTPUT_NODE_ES6) $(ASSERTIONS) $(SET_TO_WASM) $(EMCC_STRICT) $(FILESYSTEM)
	#
	#em++ -Ilibs/ --bind $(EMCC_EXPORTED_FUNCTIONS) $(EMCC_FLAGS) ./jstest.cpp -I$(NEO3_SRC) --js-library src/libcore-js/libcore_exports.js --js-library $(BN_JS) -o ./build/librarytest.js
	#@echo "Building HTML version"
	#em++ -s WASM=0 -s STRICT=1 -s FILESYSTEM=0 -g4 --emrun -Ithirdparty/neo3-cpp-core/libs/ --bind $(EMCC_EXPORTED_FUNCTIONS) $(EMCC_FLAGS) ./neopt-test.cpp -I$(NEO3_SRC) --js-library $(NEO3_SRC)/libcore-js/libcore_exports.js --js-library $(BN_JS) -o ./build/output.html -s ASSERTIONS=1 # -s MODULARIZE=1 -s 'EXPORT_NAME="Neo3CPP"' -s ASSERTIONS=1
	@echo "creating package.json for subproject neopt-lib-cpp-node"
	cp neopt-lib-package.json build/neopt-lib-cpp-node/package.json
	@echo ""
	@echo "installing neopt-lib-cpp-node locally"
	cd src && npm install

run_js_node:
	@echo
	@echo "======= testing 'node_test.js' ======="
	@echo
	@echo ""
	@echo "REAL run now..."
	cd src && node ./neopt_test.js

dist-sdk:
	cd src && make dist

test:
	npm test

vendor: update_submodules cpp_core_deps_js
	@echo "Finished 'make vendor' successfully"

cpp_core_deps_js:
	cd thirdparty/neo3-cpp-core/ && make vendor_js

update_submodules:
	git submodule update --init --recursive
	git submodule update --recursive
