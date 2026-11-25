vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
vcpkg_from_github(
    OUT_SOURCE_PATH source
    REPO jcdulas/O_o_Solver
    REF 5f4806d275378af6954782e6dc423799c5370a66
    SHA512 87689f2bf720a2a49508bedfee0915103898baed704152628308365687c900fec98185f33d640289e4595395d597408027d6de03b2fd39cd8515dcd3d19b988c
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
