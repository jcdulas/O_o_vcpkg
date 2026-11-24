vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
vcpkg_from_github(
    OUT_SOURCE_PATH source
    REPO jcdulas/O_o_Solver
    REF a4dc3992a123348c62fae51f9f7e7e025d8dfa5e
    SHA512 c5b6617fa7eb84cf8f72e179e5d2b9b55459cdfebe43ae0047da43a19afa28fb81ddc3e221d4daf09e379a20db6ea1bcc413e10f407e84b3c8e4c7af19398fec
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
