cmake_minimum_required(VERSION 3.21)
project(LumenDesktop VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
find_package(Qt6 6.4 REQUIRED COMPONENTS Quick QuickControls2)

qt_standard_project_setup(REQUIRES 6.4)

qt_add_executable(lumen-desktop
    main.cpp
)

target_link_libraries(lumen-desktop PRIVATE Qt6::Quick Qt6::QuickControls2)

qt_add_qml_module(lumen-desktop
    URI Lumen
    VERSION 1.0
    QML_FILES
        Main.qml
        GlassSurface.qml
)

install(TARGETS lumen-desktop
    BUNDLE DESTINATION .
    RUNTIME DESTINATION bin
)

install(FILES org.lumen.Desktop.desktop DESTINATION share/applications)


set(CPACK_PACKAGE_NAME "lumen-desktop")
set(CPACK_PACKAGE_VENDOR "Lumen Project")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Lumen Liquid Glass desktop preview")
set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})
set(CPACK_GENERATOR "DEB")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Lumen Project")
set(CPACK_DEBIAN_PACKAGE_DEPENDS "libqt6quick6, libqt6quickcontrols2-6, qml6-module-qtquick-controls, qml6-module-qtquick-layouts, qml6-module-qtquick-window")
include(CPack)
