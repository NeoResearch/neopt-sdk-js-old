


vendor: update_submodules cpp_core_deps_js
	@echo "Finished 'make vendor' successfully"

cpp_core_deps_js:
	cd lib/neo3-cpp-core/ && make vendor_js

update_submodules:
	git submodule update --init --recursive
	git submodule update --recursive

