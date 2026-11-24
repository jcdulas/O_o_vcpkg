# O_o C++ packages

Install the in-memory finite element libraries into a C++20 CMake project using vcpkg manifest mode.

| Port | CMake target | Interface |
| --- | --- | --- |
| `oo-model` | `oor::core` | Create, edit and query a model. |
| `oo-solver` | `oos::api` | Build a snapshot with `modelFromDeck` and run structural analyses. Installs `oo-model` as a dependency. |

Both ports build static libraries. The model-to-solver interface uses the Arrow C Data Interface within the application process. The default ports need only a C++ toolchain and platform threads. The external [OOS](https://github.com/jcdulas/O_o_OOS) and [OOH5](https://github.com/jcdulas/O_o_OOH5) adapters can link separately to the installed model core. The initial supported targets are x64 Windows (MSVC) and x64 Linux (GCC).

## Run the example

With CMake 3.25 or newer and vcpkg available, clone this registry and run:

```sh
git clone https://github.com/jcdulas/O_o_vcpkg.git
cd O_o_vcpkg
cmake -S examples/rod -B build/client -DCMAKE_TOOLCHAIN_FILE=/absolute/path/to/vcpkg/scripts/buildsystems/vcpkg.cmake -DCMAKE_BUILD_TYPE=Release
cmake --build build/client --config Release
ctest --test-dir build/client -C Release --output-on-failure
```

Use the path to your vcpkg installation in the configure command. The [example manifest and registry configuration](examples/rod) pin the published ports. CMake installs the ports at configure time. The example releases its source deck before running the solve and checks the axial displacement at node 2 against `FL/(EA) = 0.015`.

## Use in an application

Copy [vcpkg-configuration.json](examples/rod/vcpkg-configuration.json) next to your application's `vcpkg.json`. Add `oo-model` or `oo-solver` to the manifest's `dependencies`. Commit both files so subsequent builds use the same registry baseline.

```cmake
find_package(oo-solver CONFIG REQUIRED)
target_link_libraries(my_application PRIVATE oos::api)
```

For model construction and queries alone, use `find_package(oo-model CONFIG REQUIRED)` and `oor::core`. For a direct model-to-solver call, include `<oos/api/ModelFromDeck.hpp>` and `<oos/api/Analyses.hpp>`.

```cpp
const auto snapshot = oos::api::modelFromDeck(deck);
auto result = oos::api::runAnalysis(*snapshot, oos::api::Analysis::Statics, {});
```

The snapshot owns its imported buffers through Arrow release callbacks. Complete model edits before taking a snapshot and take a new snapshot after editing the model.
