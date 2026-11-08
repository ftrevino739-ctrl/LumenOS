import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Lumen

ApplicationWindow {
    id: window
    width: 1180
    height: 780
    minimumWidth: 850
    minimumHeight: 620
    visible: true
    title: "Lumen"
    color: "#0b1220"

    property string selectedSection: "Inicio"
    property var systemInfo: systemActions.systemInformation()

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#101d32" }
            GradientStop { position: 0.55; color: "#0b1424" }
            GradientStop { position: 1.0; color: "#080e19" }
        }
    }

    Rectangle {
        width: 430; height: 430; radius: 215
        x: parent.width * 0.58; y: -190
        color: "#254d78"; opacity: 0.22
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

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 18
                spacing: 16

                RowLayout {
                    spacing: 10
                    Rectangle {
                        width: 38; height: 38; radius: 13
                        gradient: Gradient {
                            GradientStop { position: 0; color: "#79b9ed" }
                            GradientStop { position: 1; color: "#3978b8" }
                        }
                        Text { anchors.centerIn: parent; text: "L"; color: "white"; font.pixelSize: 23; font.bold: true }
                    }
                    Column {
                        spacing: 1
                        Text { text: "Lumen"; color: "#f4f7fc"; font.pixelSize: 18; font.bold: true }
                        Text { text: "Liquid Glass"; color: "#9fb2ca"; font.pixelSize: 11 }
                    }
                }

                Rectangle { Layout.fillWidth: true; height: 1; color: "#24ffffff" }
                Text { text: "ESCRITORIO"; color: "#7188a4"; font.pixelSize: 10; font.bold: true; font.letterSpacing: 1.5 }

                Repeater {
                    model: [
                        { label: "Inicio", glyph: "⌂" },
                        { label: "Aplicaciones", glyph: "▦" },
                        { label: "Archivos", glyph: "▤" },
                        { label: "Ajustes", glyph: "⚙" },
                        { label: "Acerca de", glyph: "◇" }
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
                        Text { text: "Lumen Desktop"; color: "#eaf2fb"; font.pixelSize: 12; font.bold: true }
                        Text { text: "Versión 0.2 · Experimental"; color: "#8ea4bd"; font.pixelSize: 10 }
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
                    anchors.rightMargin: 18
                    Text {
                        text: window.selectedSection
                        color: "#f4f7fc"
                        font.pixelSize: 17
                        font.bold: true
                        Layout.fillWidth: true
                    }
                    Button {
                        text: "Archivos"
                        onClicked: systemActions.openHomeFolder()
                    }
                    Button {
                        text: "Ajustes"
                        onClicked: systemActions.openSettings()
                    }
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
                        Layout.topMargin: 14
                        spacing: 8
                        Text {
                            text: window.selectedSection === "Inicio" ? "Un espacio más claro." : window.selectedSection
                            color: "#f4f7fc"
                            font.pixelSize: 34
                            font.weight: Font.DemiBold
                        }
                        Text {
                            text: window.selectedSection === "Inicio"
                                  ? "Bienvenido a tu escritorio Liquid Glass."
                                  : "Herramientas y accesos de tu escritorio Lumen."
                            color: "#a9bad0"
                            font.pixelSize: 14
                        }
                    }

                    GlassSurface {
                        visible: window.selectedSection === "Inicio"
                        Layout.fillWidth: true
                        implicitHeight: 190
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
                                text: "Una experiencia de escritorio experimental sobre KDE Plasma y Qt 6."
                                color: "#c0cede"; font.pixelSize: 13
                            }
                            Item { Layout.fillHeight: true }
                            RowLayout {
                                spacing: 10
                                Button {
                                    text: "Abrir archivos"
                                    onClicked: systemActions.openHomeFolder()
                                }
                                Button {
                                    text: "Ajustes del sistema"
                                    onClicked: systemActions.openSettings()
                                }
                                Button {
                                    text: "Abrir navegador"
                                    onClicked: systemActions.openBrowser()
                                }
                            }
                        }
                    }

                    GlassSurface {
                        visible: window.selectedSection === "Aplicaciones" || window.selectedSection === "Inicio"
                        Layout.fillWidth: true
                        implicitHeight: window.selectedSection === "Inicio" ? 178 : 250
                        cornerRadius: 22
                        surfaceColor: "#8f1a2a40"
                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 20
                            spacing: 12
                            Text { text: "APLICACIONES"; color: "#8fcaff"; font.pixelSize: 10; font.bold: true; font.letterSpacing: 1.5 }
                            Text { text: "Tus herramientas"; color: "#f0f5fb"; font.pixelSize: 19; font.bold: true }
                            GridLayout {
                                Layout.fillWidth: true
                                columns: width > 600 ? 3 : 1
                                columnSpacing: 12
                                rowSpacing: 10
                                Button {
                                    Layout.fillWidth: true
                                    text: "▤   Dolphin · Archivos"
                                    onClicked: systemActions.launchApplication("dolphin")
                                }
                                Button {
                                    Layout.fillWidth: true
                                    text: "⚙   Ajustes del sistema"
                                    onClicked: systemActions.openSettings()
                                }
                                Button {
                                    Layout.fillWidth: true
                                    text: ">_   Terminal"
                                    onClicked: systemActions.openTerminal()
                                }
                                Button {
                                    Layout.fillWidth: true
                                    text: "◎   Firefox"
                                    onClicked: systemActions.launchApplication("firefox")
                                }
                                Button {
                                    Layout.fillWidth: true
                                    text: "▣   Discover"
                                    onClicked: systemActions.launchApplication("plasma-discover")
                                }
                            }
                        }
                    }

                    GlassSurface {
                        visible: window.selectedSection === "Archivos"
                        Layout.fillWidth: true
                        implicitHeight: 160
                        cornerRadius: 22
                        surfaceColor: "#8f1a2a40"
                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 22
                            spacing: 12
                            Text { text: "TUS ARCHIVOS"; color: "#8fcaff"; font.pixelSize: 10; font.bold: true }
                            Text { text: "Accede a tu carpeta personal"; color: "#f0f5fb"; font.pixelSize: 19; font.bold: true }
                            Text { text: systemInfo.hostname + " · " + systemInfo.architecture; color: "#a9bad0"; font.pixelSize: 12 }
                            Button { text: "Abrir carpeta personal"; onClicked: systemActions.openHomeFolder() }
                        }
                    }

                    GlassSurface {
                        visible: window.selectedSection === "Ajustes"
                        Layout.fillWidth: true
                        implicitHeight: 190
                        cornerRadius: 22
                        surfaceColor: "#8f1a2a40"
                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 22
                            spacing: 12
                            Text { text: "PERSONALIZACIÓN"; color: "#8fcaff"; font.pixelSize: 10; font.bold: true }
                            Text { text: "Configura tu escritorio"; color: "#f0f5fb"; font.pixelSize: 19; font.bold: true }
                            Text { text: "El esquema de color Lumen se instala junto con el paquete. El estilo Plasma se puede activar desde Apariencia."; color: "#a9bad0"; font.pixelSize: 12; wrapMode: Text.WordWrap; Layout.fillWidth: true }
                            Button { text: "Abrir Ajustes del sistema"; onClicked: systemActions.openSettings() }
                        }
                    }

                    GlassSurface {
                        visible: window.selectedSection === "Acerca de" || window.selectedSection === "Inicio"
                        Layout.fillWidth: true
                        implicitHeight: 178
                        cornerRadius: 22
                        surfaceColor: "#77172538"
                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 20
                            spacing: 8
                            Text { text: "INFORMACIÓN DEL SISTEMA"; color: "#8fcaff"; font.pixelSize: 10; font.bold: true }
                            Text { text: systemInfo.prettyName; color: "#eaf2fb"; font.pixelSize: 15; font.bold: true }
                            Text { text: "Kernel: " + systemInfo.kernel; color: "#a9bad0"; font.pixelSize: 12 }
                            Text { text: "Arquitectura: " + systemInfo.architecture; color: "#a9bad0"; font.pixelSize: 12 }
                            Text { text: "Lumen 0.2 · Vista previa de escritorio. No es todavía una ISO ni reemplaza Plasma."; color: "#e8c78b"; font.pixelSize: 11; wrapMode: Text.WordWrap; Layout.fillWidth: true }
                        }
                    }
                }
            }
        }
    }
}
