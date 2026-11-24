vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
vcpkg_from_github(
    OUT_SOURCE_PATH source
    REPO jcdulas/O_o_Model
    REF 184b2ce79ad1a8dbc0aeb220b36aba62556dbdc4
    SHA512 5ade382b20b7051e56b95ea4f921226320b8738c75b8c53cfff9a47ebac62a3d07645f16d42d47bf2afaa7b949c378f34d9fbc0d95beabaa1c29ca43ed3cf08a
    HEAD_REF main
)
vcpkg_cmake_configure(
    SOURCE_PATH "${source}"
    OPTIONS
        -DOOR_FORMATS=
        -DOOR_BUILD_TESTS=OFF
)
vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/oo-model)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
vcpkg_install_copyright(FILE_LIST "${source}/LICENSE")
