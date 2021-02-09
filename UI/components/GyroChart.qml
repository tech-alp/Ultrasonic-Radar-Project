import QtQuick 2.0
import QtCharts 2.0
import QtGraphicalEffects 1.12
import assets 1.0

Item {
    id: gyroHolderItem

    // Replace with actual gyro properties
    property int maxGyroReadings: 24
    readonly property string xColor: "#15bdff"
    readonly property string yColor: "#ffff00"
    readonly property string zColor: "red"
    property real minValue: -20
    property real maxValue: 20
    property real value: masterController.ui_serialPort.gyroscopeX_degPerSec

    onValueChanged: {
        if (minValue > value)
            minValue = value;
        if (maxValue < value)
            maxValue = value;
    }

    anchors.fill: parent

    Glow {
        id:glow
        anchors.fill: chartView
        radius: 18
        samples: 37
        color: "#87CEFA"
        source: chartView
    }

    /*RadialBlur {
        anchors.fill: chartView
        source: chartView
        angle: 360
        samples: 20
    }

    ZoomBlur {
        anchors.fill: chartView
        source: chartView
        length: 24
        samples: 20
    }*/

    Row {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.topMargin: 10
        spacing: 10
        Image {
            id: gyroIcon
            width: 30
            height: 30
            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/gyroscopeIcon.svg"
        }
        Text {
            text: qsTr("Gyroscope")
            /*anchors.top: parent.top
            anchors.left: gyroIcon.right
            anchors.leftMargin: 30
            anchors.topMargin: 10*/
            font.pixelSize: 24
            color: Style.showDataTextColor
        }
    }

    ChartView {
        id: chartView
        Component.onCompleted: masterController.ui_seriesStorage.setGyroSeries(gyroSeriesX, gyroSeriesY, gyroSeriesZ);
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        //anchors.rightMargin: 10
        antialiasing: true
        backgroundColor: "transparent"
        legend.visible: false
        // Hide the value axis labels; labels are drawn separately.
        ValueAxis {
            id: valueAxisX
            min: 0
            max: maxGyroReadings + 1
            visible: false
        }

        ValueAxis {
            id: valueAxisY
            min: minValue
            max: maxValue
            visible: false
        }
        SplineSeries {
            id: gyroSeriesX
            axisX: valueAxisX
            axisY: valueAxisY
            color: xColor
            name: "Gyro X"
            useOpenGL: true
            width: 2
        }
        SplineSeries {
            id: gyroSeriesY
            axisX: valueAxisX
            axisY: valueAxisY
            color: yColor
            name: "Gyro Y"
            useOpenGL: true
            width: 2
        }
        SplineSeries {
            id: gyroSeriesZ
            axisX: valueAxisX
            axisY: valueAxisY
            color: zColor
            name: "Gyro Z"
            useOpenGL: true
            width: 2
        }
    }

    Row {
        id: xLabelRow
        anchors.fill: parent
        anchors.leftMargin: 40

        Repeater {
            model: 3

            Item {
                height: xLabelRow.height
                width: xLabelRow.width / 3

                Text {
                    id: coordText
                    text: (index == 0) ? "X" : ((index == 1) ? "Y" : "Z")
                    color: Style.showDataTextColor
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    font.pixelSize: 26
                }

                Text {
                    text: masterController.ui_serialPort ? ((index == 0) ? masterController.ui_serialPort.gyroscopeX_degPerSec.toFixed(0) :
                                                   ((index == 1) ? masterController.ui_serialPort.gyroscopeY_degPerSec.toFixed(0) :
                                                                   masterController.ui_serialPort.gyroscopeZ_degPerSec.toFixed(0))) :
                                   ""
                    color: (index == 0) ? xColor : ((index == 1) ? yColor : zColor)
                    anchors.left: coordText.right
                    anchors.leftMargin: 16
                    anchors.bottom: parent.bottom
                    font.pixelSize: 26
                }
            }
        }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
