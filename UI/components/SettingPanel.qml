import QtQuick 2.0
import assets 1.0

Item {

    property alias headerText: title.text
    property alias contentComponent: contentLoader.sourceComponent

    implicitWidth: parent.width - Style.sizeShadowOffset
    implicitHeight: headerBackground.height + contentLoader.implicitHeight + 20 + Style.sizeShadowOffset
    Rectangle {
        id: shadow
        width: parent.width
        height: parent.height
        x: Style.sizeShadowOffset
        y: Style.sizeShadowOffset
        color: Style.colourShadow
    }

    Rectangle {
        id: headerBackground
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: Style.heightPanelHeader
        color: Style.colourPanelHeaderBackground
        Text {
            id: title
            anchors.fill: parent
            anchors.margins: 10
            text: qsTr("Set Me")
            color: "white"
            font.pixelSize: 26
            verticalAlignment: Qt.AlignVCenter
        }
    }

    Rectangle {
        id: contentBackground
        anchors {
            top: headerBackground.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        color: Style.colourPanelBackground

        Loader {
            id: contentLoader
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: 10
            }
        }
    }

}
