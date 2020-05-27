#!/bin/bash

# -s EXPORTED_FUNCTIONS="['_mytest', '_myteststr']"
# 

#docker run --rm -v $(pwd)/../:/src trzeci/emscripten em++ --pre-js prefix-node-require.js --std=c++17 -g -O3 -Wall  -s WASM=1  -s EXTRA_EXPORTED_RUNTIME_METHODS='[\"cwrap\"]' -s DISABLE_EXCEPTION_CATCHING=1 -s ALLOW_MEMORY_GROWTH=1 -s MODULARIZE=1  -s 'EXPORT_NAME="ourtest"'  --js-library src/neo3-cpp-bindings/general-libcore_exports.js -I./thirdparty/neo3-cpp-core/src/ -I./thirdparty/neo3-cpp-core/libs/ -I./src/ -o ./fib-test-to-neopt/ourtest.js ./fib-test-to-neopt/neopt-test2.cpp

# -s EXTRA_EXPORTED_RUNTIME_METHODS='[\"cwrap\"]'

#                                                                                                -s EXTRA_EXPORTED_RUNTIME_METHODS="['ccall', 'cwrap', 'UTF8ToString', 'stringToUTF8', 'writeStringToMemory', 'getValue', 'setValue']"


docker run --rm -v $(pwd)/../:/src trzeci/emscripten em++ --pre-js prefix-node-require.js --std=c++17 -g -O3 -Wall  -s WASM=1   -s EXTRA_EXPORTED_RUNTIME_METHODS='["ccall",  "cwrap", "UTF8ToString", "stringToUTF8"]' -s DISABLE_EXCEPTION_CATCHING=1   -s ALLOW_MEMORY_GROWTH=1 -s MODULARIZE=1 -s 'EXPORT_NAME="ourtest"'  --js-library src/neo3-cpp-bindings/general-libcore_exports.js -I./thirdparty/neo3-cpp-core/src/ -I./thirdparty/neo3-cpp-core/libs/ -I./src/ -o ./fib-test-to-neopt/ourtest.js ./fib-test-to-neopt/neopt-test2.cpp