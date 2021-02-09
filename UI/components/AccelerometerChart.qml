import QtQuick 2.5
import QtCharts 2.1
import QtGraphicalEffects 1.0
import QtQml 2.2
import assets 1.0
Item {
    id: gyroHolderRect

    // Replace with actual gyro properties
    property int maxAccReadings: 24

    readonly property string xColor: "#ff8c00"
    readonly property string yColor: "#00ff7f"
    readonly property string zColor: "#800080"
    readonly property color textColor: "white"

    anchors.fill: parent

    ChartView {
        Component.onCompleted: masterController.ui_seriesStorage.setAcceleroMeterSeries(accSeriesX, accSeriesY, accSeriesZ);
        id: chartView
        anchors.fill: parent
        antialiasing: true
        backgroundColor: "transparent"
        //legend.visible: false
        margins.top: 0
        margins.right: 0

        // Hide the value axis labels; labels are drawn separately.
        ValueAxis {
            id: valueAxisX
            min: 0
            max: maxAccReadings + 1
            visible: false
        }

        ValueAxis {
            id: valueAxisY
            min: -15
            max: 15
            visible: false
        }
        SplineSeries {
            id: accSeriesX
            axisX: valueAxisX
            axisY: valueAxisY
            color: xColor
            name: "Acc X"
            useOpenGL: true
            width: 2

        }
        SplineSeries {
            id: accSeriesY
            axisX: valueAxisX
            axisY: valueAxisY
            color: yColor
            name: "Acc Y"
            useOpenGL: true
            width: 2
        }
        SplineSeries {
            id: accSeriesZ
            axisX: valueAxisX
            axisY: valueAxisY
            color: zColor
            name:"Acc Z"
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
                    text: masterController.ui_serialPort ? ((index == 0) ? masterController.ui_serialPort.accelometer_xAxis.toFixed(0) :
                                                   ((index == 1) ? masterController.ui_serialPort.accelometer_yAxis.toFixed(0) :
                                                                   masterController.ui_serialPort.accelometer_zAxis.toFixed(0))) :
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
