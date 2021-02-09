import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import assets 1.0

Item {
    anchors.fill: parent

    property var serialPortText
    property var baudrateText
    property var parityIndex
    property var dataBitsText
    property var flowControlIndex
    property var stopBitsText

    Rectangle {
        id: settingBackground
        anchors.fill: parent
        color: "transparent"

        ScrollView {
            id: scrollView
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                bottom: parent.bottom
                margins: 20//Style.sizeScreenMargin
            }
            /*
            anchors.centerIn: parent
            width: 500
            height: parent.height*/
            clip: true

            Column {

                spacing: 20//Style.sizeScreenMargin
                width: scrollView.width

                SettingPanel {
                    id: selectPanel
                    headerText: "Select Parameters"
                    contentComponent:
                        Column {
                        SettingComboBox {
                            id: baudrate
                            description: "Baudrate:"
                            model: ["9600","19200","38400","115200","Custom"]
                            theme: Material.DeepOrange
                            currentIndex: 3
                            onCurrentTextChanged: {
                                baudrateText = baudrate.currentText
                            }
                        }
                        SettingComboBox {
                            id: dataBits
                            description: "Data bits:"
                            model: [5,6,7,8]
                            currentIndex: 3
                            onCurrentTextChanged: {
                                dataBitsText = dataBits.currentText
                            }
                        }
                        SettingComboBox {
                            id: parity
                            description: "Parity:"
                            model: ["None","Even","Odd","Mark","Space"]
                            onCurrentTextChanged: {
                                parityIndex = parity.currentIndex
                            }
                        }
                        SettingComboBox {
                            id: stopBits
                            description: "Stop bits:"
                            model: [1,1.5,2]
                            onCurrentTextChanged: {
                                stopBitsText = stopBits.currentText
                            }
                        }
                        SettingComboBox {
                            id: flowControl
                            description: "Flow control:"
                            model: ["None","RTS/CTS","XON/XOFF"]
                            onCurrentTextChanged: {
                                flowControlIndex = flowControl.currentIndex
                            }
                        }
                    }
                }

                SettingPanel {
                    headerText: "Select Serial Port"
                    contentComponent:
                        Column {
                        SettingComboBox {
                            id: serialPort
                            model: masterController.ui_serialPort.comboPortList
                            description: "Serial Port:"
                            theme: Material.DeepPurple
                            onComboBoxCurrentIndexChanged: {
                                masterController.ui_serialPort.showPortInfo(currentText)
                                console.log("Working on ",currentIndex)
                                serialPortText = serialPort.currentText
                            }
                        }
                        Rectangle {
                            width: parent.width
                            height: 50
                            color: "transparent"
                            Text {
                                id: des
                                text: "Description: "+ Style.description
                                font.pixelSize: 18
                                verticalAlignment: Qt.AlignVCenter
                            }
                        }

                        Rectangle {
                            width: parent.width
                            height: 50
                            color: "transparent"
                            Text {
                                text: "Manufacturer: "+ Style.manufacturer
                                font.pixelSize: 18
                                verticalAlignment: Qt.AlignVCenter
                            }
                        }

                        Rectangle {
                            width: parent.width
                            height: 50
                            color: "transparent"
                            Text {
                                text: "Serial number: "+ Style.serialNumber
                                font.pixelSize: 18
                                verticalAlignment: Qt.AlignVCenter
                            }
                        }

                        Rectangle {
                            width: parent.width
                            height: 50
                            color: "transparent"
                            Text {
                                text: "Location: "+ Style.location
                                font.pixelSize: 18
                                verticalAlignment: Qt.AlignVCenter
                            }
                        }

                        Rectangle {
                            width: parent.width
                            height: 50
                            color: "transparent"
                            Text {
                                text: "Vendor Identifier: " + Style.vendorIdentifier
                                font.pixelSize: 18
                                verticalAlignment: Qt.AlignVCenter
                            }
                        }

                        Rectangle {
                            width: parent.width
                            height: 50
                            color: "transparent"
                            Text {
                                text: "Vendor Identifier: " + Style.productIdentifier
                                font.pixelSize: 18
                                verticalAlignment: Qt.AlignVCenter
                            }
                        }
                    }
                }

                SettingPanel {
                    id: paramPanel
                    headerText: "Set Parameters"

                    property int modelNumber: 0

                    contentComponent:
                        Column {
                        //                        property int modelNumbers: 0
                        //                        ListView {
                        //                            id: settingTime
                        //                            model:ListModel { ListElement { name: "sda"} }
                        //                            delegate: details
                        //                        }
                        //                        Component {
                        //                            id: details
                        //                            Item {
                        //                                width: parent.width
                        //                                height: 60
                        //                                Text {
                        //                                    anchors.fill: parent
                        //                                    text: masterController.ui_clock.currentTime
                        //                                    font.pixelSize: 16

                        //                                }
                        //                            }
                        //                        }

                        Repeater {
                            model: paramPanel.modelNumber
                            delegate: Rectangle {
                                width: parent.width
                                height: 80
                                color: "transparent"
                                Text {
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.right: parent.right
                                    height: 20
                                    text: masterController.ui_clock.currentTime;
                                    font.pixelSize: 15
                                    verticalAlignment: Qt.AlignVCenter
                                }
                                Text {
                                    anchors.fill: parent
                                    text: masterController.ui_serialPort.ConnectionParameters
                                    verticalAlignment: Qt.AlignVCenter
                                    font.pixelSize: 20
                                }
                            }
                        }

                        FormButton {
                            iconCharacter: "\uf067"
                            description: "Apply"
                            onFormButtonClicked: {
                                masterController.ui_serialPort.fillSerialPortsParameters(serialPortText,baudrateText,dataBitsText,
                                                                                         parityIndex,flowControlIndex)
                                paramPanel.modelNumber = paramPanel.modelNumber + 1;
                            }
                        }
                    }
                }
            }
        }
    }

}





//                        Text {
//                            id: element15
//                            width: 29
//                            height: 27
//                            text: Style.productIdentifier
//                            color: Style.showDataTextColor
//                            verticalAlignment: Text.AlignVCenter
//                            font.pixelSize: 15
//                            horizontalAlignment: Text.AlignLeft
//                        }

//                    }
//                }
//                Button {
//                    id: apply
//                    anchors.right: parent.right
//                    width: 120
//                    height: 45
//                    highlighted: true
//                    Material.background: Material.Orange

//                    text: qsTr("Apply")
//                    font.capitalization: Font.Capitalize
//                    font.pointSize: 11
//                    onClicked: {
//                        masterController.ui_serialPort.fillSerialPortsParameters(cmbSerialPort.currentText,baudrate.currentText,dataBits.currentText,
//                                                                                 parity.currentIndex,flowControl.currentIndex)
//                        element17.text = "Selected Port: "+cmbSerialPort.currentText+" Baudrate: "+baudrate.currentText+" DataBits: "+
//                                dataBits.currentText+"\nParity: "+parity.currentText+" FlowControl: "+flowControl.currentText
//                    }
//                }

//                Text {
//                    id: element17
//                    width: 250
//                    height: 40
//                    text: qsTr("")
//                    color: Style.showDataTextColor
//                    verticalAlignment: Text.AlignVCenter
//                    horizontalAlignment: Text.AlignLeft
//                    font.pixelSize: 16
//                }
//            }
//        }
//        }

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.6600000262260437;height:480;width:640}
}
##^##*/
