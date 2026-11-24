vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
vcpkg_from_github(
    OUT_SOURCE_PATH source
    REPO jcdulas/O_o_Solver
    REF f7212a730343d41d18a764d123a341c957181f12
    SHA512 fa08f54b9408367cb977ac3091711f11bf94029872b1fed1310a2055891f8e71d9a82a0e2a4f4b260aaf344ce92933a5886bb377ecd63a5062fe7569c8974df6
    HEAD_REF main
)
vcpkg_cmake_configure(
    SOURCE_PATH "${source}"
    OPTIONS
        -DOOS_WITH_MODEL=ON
)
vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/oo-solver)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
vcpkg_install_copyright(FILE_LIST "${source}/LICENSE")
