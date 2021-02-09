import QtQuick 2.0
import QtGraphicalEffects 1.12
import assets 1.0
import components 1.0
import QtCharts 2.3

Item {
    id: root

    DataShowBar {
        id: dataShowBar
    }

    Rectangle {
        id: background
        anchors {
            left: parent.left
            right: parent.right
            top: dataShowBar.bottom
            bottom: parent.bottom
        }

        color: Style.colorBackground
        Column {
            id: mainColumn
            anchors {
                fill: parent
                leftMargin: 30
                rightMargin: 30
                bottomMargin: 10
                topMargin: 2
            }
            spacing: 20

            Row {
                id:grid
                spacing: 20
                z: 1
                readonly property real garbageWidth: spacing*2
                readonly property real garbageHeight: spacing*2 + column.spacing
                readonly property real _width: (mainColumn.width-grid.garbageWidth)/3
                readonly property real _height: (mainColumn.height-grid.garbageHeight)/5*3

                Rectangle {
                    id: rectangle1
                    width: grid._width
                    height: grid._height
                    color: Style.showDataElementColor//"#32cd32"
                    radius:10
                    z:1
                    //                    layer.enabled: true
                    //                    layer.effect: DropShadow {
                    //                        transparentBorder: true
                    //                        color: "#c7c7c7"
                    //                    }

                    RadarScanning {
                        id: radarScanning
//                        visible: false
//                        opacity: 0.4
                        onImageClicked: [
                            NumberAnimation {
                                target: radarScanning
                                properties: "width,height"
                                to: {
                                    (radarScanning.expand===true)?background.width  : rectangle1.width;
                                    (radarScanning.expand===true)?background.height : rectangle1.height
                                }
                                duration: 2000
                                easing.type: Easing.InOutQuad
                            },
                            NumberAnimation {
                                target: radarScanning
                                property: "opacity"
                                to:  (radarScanning.expand===true) ? 0.6 : 1
                                duration: 2000
                                easing.type: Easing.InOutQuad
                            },
                            NumberAnimation {
                                target: radarScanning
                                property: "x"
                                to:  (radarScanning.expand===true)?(background.width-background.height)/2-10:rectangle1.x //TODO: max-min/2
                                duration: 2000
                                easing.type: Easing.InOutQuad
                            }
                        ]
                    }
                }
                Column {
                    id: column
                    spacing: 10
                    Rectangle {
                        id: rectangle2
                        width: grid._width
                        height: grid._height/2-column.spacing/2
                        color: Style.showDataElementColor
                        radius:10
                        layer.enabled: true
                        layer.effect: DropShadow {
                            transparentBorder: true
                            color: "#c7c7c7"
                        }

                        Image {
                            id: temperatureImg
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width/3
                            height: parent.height/3*2
                            source: "qrc:/images/thermometer.svg"
                        }
                        Column {
                            anchors {
                                left: temperatureImg.right
                                right: parent.right
                                top: parent.top
                                topMargin: 30
                            }
                            spacing: 20
                            Text {
                                id: textTemperature
                                text: qsTr("Temperature")
                                font.pixelSize: 15
                                color: Style.showDataTextColor
                            }
                            Text {
                                id: tempData
                                text: Style.temperature //masterController.ui_serialPort.Temperature
                                font.pixelSize: 45
                                font.bold: true
                                color: Style.showDataTextColor
                            }
                        }
                    }
                        Rectangle {
                            id: rectangle3
                            width: grid._width
                            height: grid._height/2-column.spacing/2
                            color: Style.showDataElementColor
                            radius:10
                            layer.enabled: true
                            layer.effect: DropShadow {
                                transparentBorder: true
                                color: "#c7c7c7"
                            }

                            Image {
                                id: humidityImg
                                anchors.verticalCenter: parent.verticalCenter
                                width: parent.width/3
                                height: parent.height/3*2
                                source: "qrc:/images/humidity.svg"
                            }
                            Column {
                                anchors {
                                    left: humidityImg.right
                                    right: parent.right
                                    top: parent.top
                                    topMargin: 30
                                }
                                spacing: 20
                                Text {
                                    id: textHumidity
                                    text: qsTr("Humidity")
                                    font.pixelSize: 15
                                    color: Style.showDataTextColor
                                }
                                Text {
                                    id: humidityData
                                    text: Style.humidty
                                    font.pixelSize: 45
                                    font.bold: true
                                    color: Style.showDataTextColor
                                }
                            }

                        }
                    }
                    Rectangle {
                        id: rectangle4
                        width: grid._width
                        height: grid._height
                        color: Style.showDataElementColor
                        radius:10
                        layer.enabled: true
                        layer.effect: DropShadow {
                            transparentBorder: true
                            color: "#c7c7c7"
                        }


                        Text {
                            id: textDevice
                            anchors {
                                top: parent.top
                                left: parent.left
                                right: parent.right
                                topMargin: 10
                            }
                            color: Style.showDataTextColor
                            text: "My Devices"
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 20
                            font.bold: true
                        }
                        Grid {
                            anchors {
                                top: textDevice.bottom
                                bottom: parent.bottom
                                left: parent.left
                                right: parent.right
                                topMargin: 10
                            }
                            columns: 2
                            rows: 2
                            clip: true
                            MyDevice {
                                imageSource: "qrc:/images/ArduinoUno.svg"
                                descriptionDeviceName: "Arduino"
                            }
                            MyDevice {
                                imageSource: "qrc:/images/dht11.svg"
                                descriptionDeviceName: "Dht11"
                                iconDeviceScale: 0.6
                            }
                            MyDevice {
                                imageSource: "qrc:/images/ultrasonicSensor.svg"
                                descriptionDeviceName: "Ultrasonic Sensor"
                                iconDeviceScale: 1.2
                            }
                            MyDevice {
                                imageSource: "qrc:/images/bno.png"
                                descriptionDeviceName: "Imu Sensor"
                                iconDeviceRotation: 90
                                iconDeviceScale: 0.8
                            }
                        }
                    }
                    }
                Row {
                    spacing: 20
                    Rectangle {
                        id:rectangle5
                        width: grid._width*2 + grid.spacing
                        height: grid._height*2/3
                        color: Style.showDataElementColor
                        radius:10
                        layer.enabled: true
                        layer.effect: DropShadow {
                            transparentBorder: true
                            color: "#c7c7c7"
                        }

                        TemperatureChart {

                        }

                        /*AccelerometerChart{
                    }*/

                    }
                    Rectangle {
                        id: rectangle6
                        width: grid._width
                        height: grid._height*2/3
                        color: Style.showDataElementColor
                        radius:10
                        layer.enabled: true
                        layer.effect: DropShadow {
                            transparentBorder: true
                            color: "#c7c7c7"
                        }

                        GyroChart {
                        }

                    }
                }
            }
        }
}

    /*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:4;height:480;width:640}
}
##^##*/
