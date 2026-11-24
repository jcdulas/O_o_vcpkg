cmake_minimum_required(VERSION 3.25)
find_package(Git REQUIRED)
set(root "${CMAKE_CURRENT_LIST_DIR}/..")
execute_process(COMMAND "${GIT_EXECUTABLE}" -C "${root}" rev-parse HEAD
    OUTPUT_VARIABLE registry_revision OUTPUT_STRIP_TRAILING_WHITESPACE COMMAND_ERROR_IS_FATAL ANY)
set(example "${root}/build/rod")
file(MAKE_DIRECTORY "${example}")
file(COPY "${root}/examples/rod/" DESTINATION "${example}")
configure_file("${root}/examples/vcpkg-configuration.json.in" "${example}/vcpkg-configuration.json" @ONLY)
