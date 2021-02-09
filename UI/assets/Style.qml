pragma Singleton

import QtQuick 2.0
//"#667eea"
//"#764ba2"

Item {
    readonly property alias fontawesome: fontawesomeLoader.name

    property color colorNavigationBarFont: "black"
    property color colorBackground: "#f9f9f9"
    property color showDataBarColor: colorBackground
    property color colorNavigationBarBackground: "#667eea"
    property color showDataElementColor: "#ffffff"
    property color showDataTextColor: "black"
    property color colorNavigationBarFontActive: "red"

    readonly property int pixelSizeNavigationBarIcon: 40
    readonly property int pixelSizeNavigationBarDescription: 24
    readonly property real widthNavigationButtonIcon: 80
    readonly property real heightNavigationButtonIcon: widthNavigationButtonIcon
    readonly property real widthNavigationButtonDescription: 100
    readonly property real heightNavigationButtonDescription: heightNavigationButtonIcon
    readonly property real widthNavigationButton: widthNavigationButtonIcon + widthNavigationButtonDescription
    readonly property real heightNavigationButton: Math.max(heightNavigationButtonIcon,heightNavigationButtonDescription)


    // SensorTagData Provider
    readonly property string temperature: masterController.ui_serialPort.temperatureString
    readonly property string humidty: masterController.ui_serialPort.humidityString
    readonly property string description: masterController.ui_serialPort.Description
    readonly property string manufacturer: masterController.ui_serialPort.Manufacturer
    readonly property string serialNumber: masterController.ui_serialPort.SerialNumber
    readonly property string location: masterController.ui_serialPort.Location
    readonly property string vendorIdentifier: masterController.ui_serialPort.VendorIdentifier
    readonly property string productIdentifier: masterController.ui_serialPort.ProductIdentifier
    readonly property var state: masterController.ui_serialPort.state
    readonly property real radarAngle: masterController.ui_serialPort.position

    readonly property int deviceIconWidth: 120
    readonly property int deviceIconHeight: deviceIconWidth
    readonly property int deviceDescriptionWidth: deviceIconWidth
    readonly property int pixelSizeDeviceDescription: 15
    readonly property int widthDeviceComponent: deviceIconWidth + pixelSizeDeviceDescription


    readonly property color colourPanelBackground: "#ffffff"
    readonly property color colourPanelBackgroundHover: "#ececec"
    readonly property color colourPanelHeaderBackground: "#131313"
    readonly property color colourPanelHeaderFont: "#ffffff"
    readonly property color colourPanelFont: "#131313"
    readonly property int pixelSizePanelHeader: 18
    readonly property real heightPanelHeader: 40
    readonly property real sizeShadowOffset: 5
    readonly property color colourShadow: "#dedede"

    //SettingComboBox
    readonly property real widthDescriptionComboBox: 100

    //FormButton
    readonly property real widthFormButton: 240
    readonly property real heightFormButton: 60
    readonly property color colourFormButtonBackground: "#f36f24"
    readonly property color colourFormButtonFont: "#ffffff"
    readonly property int pixelSizeFormButtonIcon: 32
    readonly property int pixelSizeFormButtonText: 22
    readonly property int sizeFormButtonRadius: 5

    FontLoader {
        id: fontawesomeLoader
        source: "qrc:/assets/fontawesome1.ttf"
    }
}
