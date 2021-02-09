import QtQuick 2.0
import assets 1.0

Item {
    id: root
    width: parent.width/2
    height: parent.height/2
    property alias imageSource: iconDevice.source
    property alias descriptionDeviceName: description.text
    property alias iconDeviceScale: iconDevice.scale
    property alias iconDeviceRotation: iconDevice.rotation

    Rectangle {
        anchors.fill: root
        color: Style.showDataElementColor
        Column {
            anchors.centerIn: parent
            Text {
                id: description
                width: Style.deviceDescriptionWidth
                font.pixelSize: Style.pixelSizeDeviceDescription
                color: Style.showDataTextColor
                text: "SET ME!!"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            Image {
                id: iconDevice
                width: Style.deviceIconWidth
                height: Style.deviceIconHeight
                fillMode: Image.PreserveAspectFit
            }
        }
    }
}


