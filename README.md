# neopt-js-sdk
neopt-js SDK

instructions: `make` and `make run` (for very simple testing)

It will use `emscripten` (it can be from docker), output will be on `build` folder (a `.js` and `.wasm`).

## How to use

### Install on browser

```html
<script src="https://unpkg.com/neopt-sdk/dist/neopt-sdk.js"></script>
```


## Practical Development Workflow

### Run tests
`make test` (instead of `npm test`)

### Build Webpack
`make dist` (instead of `npm run build`)

### Increase minor version (typically)
`npm version minor`

### Push and Publish (with new version)
`git push origin master --tags`

`npm publish` (requires `npm login` before)

### Versioning Logic

We adopt semantic versioning, but plan to keep alpha `0.x` for a long time... 
when community feels it is somewhat complete, we may plan some `1.0`.

## License

This project is released under `MIT License`.

The [neo3-cpp-core](https://github.com/neoresearch/neo3-cpp-core) dependencies are all built into a single library (binary) to be merged with this project (connected via `.wasm`).

NeoResearch 2020