import QtQuick 2.0
import assets 1.0
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0

Item {
    Rectangle {
        anchors.fill: parent
        color: "black"//Style.colorBackground

        /*Image {
            anchors.fill: parent
            source: "qrc:/assets/plain-colourful-backgrounds-8.jpg"
        }*/

        /*Image {
            id: logo
            anchors.centerIn: parent
            source: "qrc:/images/spalshscreen.png"
            fillMode: Image.PreserveAspectFit
        }*/
        Column {
            anchors.centerIn: parent
            spacing: 10
            Image {
                id: logo
                anchors.horizontalCenter: parent.horizontalCenter
                width: 200
                height: width
                source: "qrc:/images/Project_Icon.svg"
                fillMode: Image.PreserveAspectFit
            }
            Text {
                text: qsTr("The Radar Project")
                font.pixelSize: 35
                color: "orange"
                font.bold: true
                horizontalAlignment: Qt.AlignHCenter
            }
            BusyIndicator {
                anchors.horizontalCenter: parent.horizontalCenter
                running: true
                Material.accent: "orange"
            }
        }
    }
}





/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
