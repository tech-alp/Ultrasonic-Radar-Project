import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import assets 1.0
import QtQuick.Layouts 1.0

Item {
    anchors.fill: parent
    id: scanPage

       property int inputFontSize : 14

       function clearList()
       {
           device.clearDeviceList();
       }

       /*
       Text
       {
           id: label
           anchors.centerIn: parent
           color: "white"
           text: qsTr("Display Size: ") + Screen.width + "x" + Screen.height + " Orientation: " + orientationStatus;
       }
       */

       Rectangle
       {
           id:conteinerList
           width: parent.width * 0.95
           height: parent.height * 0.7
           anchors.top: parent.top
           anchors.horizontalCenter: parent.horizontalCenter
           color: "transparent"
           //border.width: 1
           //border.color: "white"
           //radius: 3

           Component
           {
               id: delegate
               Rectangle
               {
                   id: rectContainer
                   width: parent.width * 0.95
                   height: 60
                   color: "transparent"
                   anchors.horizontalCenter: parent.horizontalCenter
                   radius: 4

                   Rectangle
                   {
                       id: backgroundFill
                       anchors.fill: parent
                       color:"white"
                       opacity: 0.08
                       radius: 4
                   }

                   Text    // Device Name
                   {
                       id: txtDeviceName
                       anchors.left: parent.left
                       anchors.leftMargin: 10
                       anchors.top: parent.top
                       anchors.topMargin: 3
                       text: modelData.deviceName
                       font.pointSize: 15
                       color: "lightgreen"
                   }

                   Text    // Device address
                   {
                       id: txtDeviceAddress
                       anchors.left: parent.left
                       anchors.leftMargin: 10
                       anchors.bottom: parent.bottom
                       anchors.bottomMargin: 3
                       text: modelData.deviceAddress
                       font.pointSize: 12
                       color: "black"
                   }

                   MouseArea
                   {
                       anchors.fill: parent
                       onClicked:
                       {
                           masterController.ui_bleSetting.startConnect(modelData.deviceAddress);
                           masterController.ui_bleSetting.update = " "
                           rootPage.reqDataPage();
                       }
                   }
               }
           }

           ListView
           {
               id:devicesList
               anchors.fill: parent
               model: masterController.ui_bleSetting.devicesList
               delegate: delegate
               spacing: 2
           }
       }

       Text
       {
           id: rowMessage
           anchors.horizontalCenter: parent.horizontalCenter
           anchors.bottom: btnStartDiscover.top
           anchors.bottomMargin: 10
           text: masterController.ui_bleSetting.update
           color: "black"
           font.pointSize: 12
       }

       Rectangle
       {
           id: btnStartDiscover
           width: 100
           height: 40
           anchors.horizontalCenter: parent.horizontalCenter
           anchors.bottom: parent.bottom
           anchors.bottomMargin: 20
           color: "transparent"
           border.width: 1
           border.color: "gray"
           radius: 8

           Text
           {
               id: name
               anchors.centerIn: parent
               text: qsTr("SCAN")
               color: "black"
               font.pointSize: 12
           }

           MouseArea
           {
               anchors.fill: parent
               onPressed:
               {
                   btnStartDiscover.color = "gray";
                   masterController.ui_bleSetting.startScan();
               }
               onReleased:
               {
                   btnStartDiscover.color = "black";
               }

           }
       }
   }

//Item {
//    anchors.fill: parent

//    Rectangle {
//        anchors.fill: parent
//        color: "transparent"

//        ScrollView {
//            id:scrollView
//            anchors {
//                left: parent.left
//                right: parent.right
//                top: parent.top
//                bottom: parent.bottom
//                margins: 20//Style.sizeScreenMargin
//            }
//            clip: true
//            Column {
//                spacing: 20//Style.sizeScreenMargin
//                width: scrollView.width
//                SettingPanel {
//                    headerText: "Bluetooth Setting"
//                    contentComponent:

//                        Column {
//                        spacing: 20
//                        SettingComboBox {
//                            x: 30; y: 10
//                            description: "Devices"
//                            model: masterController.ui_bleSetting.devicesList
//                            theme: Material.Purple
//                        }

//                        FormButton {
//                            iconCharacter: "\uf002"
//                            description: "Scan"
//                            onFormButtonClicked: {
//                                masterController.ui_bleSetting.startScan();
//                                console.log("Scaning...")
//                            }
//                        }

//                        FormButton {
//                            iconCharacter: "\uf0ac"
//                            description: "On"
//                        }

//                        FormButton {
//                            iconCharacter: "\uf00d"
//                            description: "Off"
//                        }

//                    }
//                }
//            }
//        }
//    }
//}
