import QtQuick
import QtQuick.Controls

Button {
    id: control

    implicitHeight: 42
    leftPadding: 14
    rightPadding: 14
    font.pixelSize: 12

    background: Rectangle {
        radius: 13
        gradient: Gradient {
            GradientStop {
                position: 0
                color: control.down ? "#365d83" : (control.hovered ? "#294764" : "#20364f")
            }
            GradientStop {
                position: 1
                color: control.down ? "#294968" : (control.hovered ? "#203b57" : "#172a40")
            }
        }
        border.width: control.activeFocus ? 2 : 1
        border.color: control.activeFocus ? "#a8dcff" : "#477092"
        opacity: control.enabled ? 1.0 : 0.48
    }

    contentItem: Text {
        text: control.text
        color: control.enabled ? "#f1f7ff" : "#9aabba"
        font: control.font
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
}
