vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
vcpkg_from_github(
    OUT_SOURCE_PATH source
    REPO jcdulas/O_o_Model
    REF 2a10c731b52b3ac37b6d11ca77d92131b819f5cc
    SHA512 beb56c24917cffb308a2a379557fa45774841b7d6edd49e4e760dd69d4d3a5380d812d0c6ffb06e22f514a240e9d4363d1995c8fd0ccf3c1891764ee2bf51f86
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
