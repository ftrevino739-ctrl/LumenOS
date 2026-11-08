import QtQuick

// Reusable translucent surface for VitreOS desktop components.
// Blur is provided by the compositor/theme layer, not by this rectangle.
Rectangle {
    id: root

    property color surfaceColor: Qt.rgba(24 / 255, 34 / 255, 50 / 255, 0.72)
    property color edgeColor: Qt.rgba(255, 255, 255, 0.18)
    property real cornerRadius: 18
    property real edgeWidth: 1

    radius: cornerRadius
    color: surfaceColor
    border.width: edgeWidth
    border.color: edgeColor
    antialiasing: true
}
