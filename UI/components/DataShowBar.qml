import QtQuick 2.0
import QtQuick.Controls 2.12
import assets 1.0

Item {
    id: element
    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
    }
    height: 170

    Rectangle {
        id: barRec
        anchors.fill: parent
        color: Style.colorBackground

        Column {
            anchors {
                top: parent.top
                bottom: parent.bottom
                right: parent.right
                rightMargin: 100
            }
            Text {
                id: textTime
                y: barRec.height/2-20
                font.pixelSize: 14
                text: "Current Time"
                color: Style.showDataTextColor
                verticalAlignment: Text.AlignVCenter
            }
            Text {
                id: currentTime
                y: textTime.y + currentTime.height-10
                font.pixelSize: 30
                color: "#5d5def"
                text: masterController.ui_clock.analogClock;
                font.bold: true
            }
        }

    }
}


/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}
}
##^##*/
