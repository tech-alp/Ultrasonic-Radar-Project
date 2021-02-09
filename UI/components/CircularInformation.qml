import QtQuick 2.0
import assets 1.0

Item {
    property alias sensorValue: informationText.text
    property alias colourSensorValue: informationText.color
    property alias axis: informationAxis.text
    property alias name: sensorName.text
    property color textColor: Style.showDataTextColor
    width: 160
    height: width

    Text {
        id: sensorName
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: informationImage.top
        }
        //text: qsTr("Set sensor name")
        font.family: "Courier"
        color: textColor
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHCenter

    }
    Image {
        id: informationImage
        anchors.centerIn: parent
        width: 120
        height: 120
        source: "qrc:/.svg/Yellow_Circular_Boder.png"//"qrc:/.svg/circleborder.png"
    }
    Text {
        id: informationText
        anchors.centerIn: informationImage
        text: qsTr("Set")
        color: textColor
        font.pixelSize: 24
    }
    Text {
        id: informationAxis
        anchors {
            top: informationImage.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        text: qsTr("Axis")
        color: textColor
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHCenter
    }
}
