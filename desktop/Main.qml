import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import VitreOS

ApplicationWindow {
    id: window
    width: 1180
    height: 760
    minimumWidth: 900
    minimumHeight: 620
    visible: true
    title: "VitreOS"
    color: "#0b1220"

    property string selectedSection: "Inicio"

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#101d32" }
            GradientStop { position: 0.55; color: "#0b1424" }
            GradientStop { position: 1.0; color: "#080e19" }
        }
    }

    // Ambient light accents behind the translucent panels.
    Rectangle {
        width: 430; height: 430; radius: 215
        x: parent.width * 0.58; y: -190
        color: "#254d78"; opacity: 0.22
        layer.enabled: true
    }
    Rectangle {
        width: 360; height: 360; radius: 180
        x: -180; y: parent.height * 0.58
        color: "#334b83"; opacity: 0.16
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 22
        spacing: 18

        GlassSurface {
            Layout.preferredWidth: 218
            Layout.fillHeight: true
            cornerRadius: 26
            surfaceColor: "#bd17263a"
            edgeColor: "#35ffffff"

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 18
                spacing: 18

                RowLayout {
                    spacing: 10
                    Rectangle {
                        width: 38; height: 38; radius: 13
                        color: "#3978b8"
                        Text { anchors.centerIn: parent; text: "V"; color: "white"; font.pixelSize: 23; font.bold: true }
                    }
                    Column {
                        spacing: 1
                        Text { text: "VitreOS"; color: "#f4f7fc"; font.pixelSize: 18; font.bold: true }
                        Text { text: "Liquid Glass"; color: "#9fb2ca"; font.pixelSize: 11 }
                    }
                }

                Rectangle { Layout.fillWidth: true; height: 1; color: "#24ffffff" }

                Text { text: "ESPACIO"; color: "#7188a4"; font.pixelSize: 10; font.bold: true; font.letterSpacing: 1.5 }

                Repeater {
                    model: [
                        { label: "Inicio", glyph: "⌂" },
                        { label: "Aplicaciones", glyph: "▦" },
                        { label: "Archivos", glyph: "▤" },
                        { label: "Ajustes", glyph: "⚙" }
                    ]
                    delegate: Button {
                        Layout.fillWidth: true
                        implicitHeight: 44
                        text: modelData.glyph + "    " + modelData.label
                        highlighted: window.selectedSection === modelData.label
                        onClicked: window.selectedSection = modelData.label
                        background: Rectangle {
                            radius: 13
                            color: parent.highlighted ? "#344c6b" : (parent.hovered ? "#1dffffff" : "transparent")
                            border.color: parent.highlighted ? "#527eaa" : "transparent"
                        }
                        contentItem: Text {
                            text: parent.text
                            color: parent.highlighted ? "#ffffff" : "#c1cede"
                            font.pixelSize: 13
                            verticalAlignment: Text.AlignVCenter
                            leftPadding: 12
                        }
                    }
                }

                Item { Layout.fillHeight: true }

                GlassSurface {
                    Layout.fillWidth: true
                    implicitHeight: 72
                    cornerRadius: 16
                    surfaceColor: "#172b4059"
                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 13
                        spacing: 4
                        Text { text: "VitreOS Preview"; color: "#eaf2fb"; font.pixelSize: 12; font.bold: true }
                        Text { text: "Build 0.1 · Experimental"; color: "#8ea4bd"; font.pixelSize: 10 }
                    }
                }
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 18

            GlassSurface {
                Layout.fillWidth: true
                implicitHeight: 66
                cornerRadius: 22
                surfaceColor: "#a817263a"
                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 22
                    anchors.rightMargin: 22
                    Text {
                        text: window.selectedSection
                        color: "#f4f7fc"
                        font.pixelSize: 17
                        font.bold: true
                        Layout.fillWidth: true
                    }
                    Text { text: "●  Sistema de demostración"; color: "#9eb4ca"; font.pixelSize: 11 }
                }
            }

            Flickable {
                Layout.fillWidth: true
                Layout.fillHeight: true
                contentHeight: contentColumn.implicitHeight
                clip: true

                ColumnLayout {
                    id: contentColumn
                    width: parent.width
                    spacing: 18

                    Column {
                        Layout.topMargin: 16
                        spacing: 8
                        Text {
                            text: window.selectedSection === "Inicio" ? "Un espacio más claro." : window.selectedSection
                            color: "#f4f7fc"
                            font.pixelSize: 34
                            font.weight: Font.DemiBold
                        }
                        Text {
                            text: window.selectedSection === "Inicio"
                                  ? "Bienvenido a una nueva forma de usar tu escritorio."
                                  : "Esta sección es parte de la vista previa de VitreOS."
                            color: "#a9bad0"
                            font.pixelSize: 14
                        }
                    }

                    GlassSurface {
                        Layout.fillWidth: true
                        implicitHeight: 188
                        cornerRadius: 25
                        surfaceColor: "#a5233b58"
                        edgeColor: "#48ffffff"
                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 24
                            spacing: 10
                            Text { text: "DISEÑADO PARA FLUIR"; color: "#8fcaff"; font.pixelSize: 10; font.bold: true; font.letterSpacing: 1.7 }
                            Text { text: "Ligero. Elegante. Tuyo."; color: "#ffffff"; font.pixelSize: 27; font.bold: true }
                            Text {
                                text: "Una experiencia experimental construida sobre KDE Plasma y Qt 6."
                                color: "#c0cede"; font.pixelSize: 13
                            }
                            Item { Layout.fillHeight: true }
                            RowLayout {
                                spacing: 10
                                Rectangle {
                                    radius: 10; color: "#4b86bd"
                                    implicitWidth: 132; implicitHeight: 34
                                    Text { anchors.centerIn: parent; text: "Explorar VitreOS"; color: "white"; font.pixelSize: 11; font.bold: true }
                                }
                                Text { text: "Interfaz de demostración"; color: "#91a9c3"; font.pixelSize: 11 }
                            }
                        }
                    }

                    GridLayout {
                        Layout.fillWidth: true
                        columns: width > 760 ? 3 : 1
                        columnSpacing: 14
                        rowSpacing: 14

                        Repeater {
                            model: [
                                { title: "Aplicaciones", desc: "Tus herramientas en un solo lugar.", symbol: "▦" },
                                { title: "Personalización", desc: "Adapta el escritorio a tu estilo.", symbol: "✧" },
                                { title: "Privacidad", desc: "Configuración clara y transparente.", symbol: "◇" }
                            ]
                            delegate: GlassSurface {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 150
                                cornerRadius: 21
                                surfaceColor: "#8f1a2a40"
                                Column {
                                    anchors.fill: parent
                                    anchors.margins: 18
                                    spacing: 10
                                    Text { text: modelData.symbol; color: "#91caff"; font.pixelSize: 24 }
                                    Text { text: modelData.title; color: "#f0f5fb"; font.pixelSize: 14; font.bold: true }
                                    Text { text: modelData.desc; color: "#9fb2c9"; font.pixelSize: 11; wrapMode: Text.WordWrap }
                                }
                            }
                        }
                    }

                    GlassSurface {
                        Layout.fillWidth: true
                        implicitHeight: 76
                        cornerRadius: 18
                        surfaceColor: "#77172538"
                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 18
                            Text { text: "Estado del proyecto"; color: "#eaf2fb"; font.pixelSize: 12; font.bold: true; Layout.fillWidth: true }
                            Text { text: "Prototipo visual · No es una ISO"; color: "#e8c78b"; font.pixelSize: 11 }
                        }
                    }
                }
            }
        }
    }
}
