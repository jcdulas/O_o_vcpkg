vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
vcpkg_from_github(
    OUT_SOURCE_PATH source
    REPO jcdulas/O_o_Solver
    REF 243993f55b299dc9b662c7b026ab4e73c33bbf94
    SHA512 3742125435b0a5e90e55d48fe04f2ba4d8897c475a7c483cd5498409b7c54ec24a5087fa27e3b398bd299d5f9df8d58e91d0aaed7462dd5529337cd4249f7456
    HEAD_REF main
)
vcpkg_cmake_configure(
    SOURCE_PATH "${source}"
    OPTIONS
        -DOOS_WITH_MODEL=ON
        -DOOS_WARNINGS_AS_ERRORS=OFF
)
vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/oo-solver)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
vcpkg_install_copyright(FILE_LIST "${source}/LICENSE")
