import QtQuick 2.0
import QtQuick.Controls.Material 2.12
import assets 1.0
Item {
    id: root
    width: parent.width
    height: 80

    property alias iconText: textIcon.text
    property alias descriptionText: textDescription.text
    property alias colorTextIcon: textIcon.color
    property alias colorTextDescription: textDescription.color
    property color hoverColor: Style.colorNavigationBarBackground

    property bool checked: false

    signal navigationButtonClicked();

    states: [
        State {
            name: "hover"
            PropertyChanges {
                target: background
                color: hoverColor
            }
        }
    ]

    Rectangle {
        id: currentItem
        z: 5
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }
        radius:2
        height: 50
        width: 5
        visible: root.checked
        color: Style.colorNavigationBarFontActive
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: Style.colorNavigationBarBackground
        //radius: 40
        Row {
            Text {
                id: textIcon
                width: Style.widthNavigationButtonIcon
                height: Style.heightNavigationButtonIcon
                font {
                    family: Style.fontawesome
                    pixelSize: Style.pixelSizeNavigationBarIcon
                }
                text: "\uf11a"
                color: root.checked  ? Style.colorNavigationBarFontActive : Style.colorNavigationBarFont  //TODO:: Style.colourHighligthNavigationButton
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            Text {
                id: textDescription
                text: "SET MEE!!"
                width: Style.widthNavigationButtonDescription
                height: Style.heightNavigationButtonDescription
                font.pixelSize: Style.pixelSizeNavigationBarDescription
                color: Style.colorNavigationBarFont
                verticalAlignment: Text.AlignVCenter
            }
        }
        MouseArea {
            id: mouseArea
            hoverEnabled: true
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onEntered: root.state = "hover"
            onExited: root.state = ""
            onClicked: navigationButtonClicked()
        }
    }

}


