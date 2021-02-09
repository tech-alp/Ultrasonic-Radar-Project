import QtQuick 2.7
import QtCharts 2.1
import QtGraphicalEffects 1.0
import assets 1.0

Item {
    id: tempHolderRect

    property int maxNumOfTempReadings: 30
    property real minimum: 0
    property real maximum: 100

    property real defaultAvgValue: (maximum + minimum) / 2
    property real minValue: defaultAvgValue
    property real maxValue: defaultAvgValue
    property real value: masterController.ui_serialPort.temperature

    readonly property color tempColor: "red"//"#ff4500"//"#ec4920"
    readonly property color humColor:  "#c0f5f9"

    onValueChanged: {
        if (minValue > value)
            minValue = value;
        if (maxValue < value)
            maxValue = value;
    }
    anchors.fill: parent

    Component.onCompleted: {
        masterController.ui_seriesStorage.setTemperatureAreaSeries(avgTempSeries,tempLine)
        masterController.ui_seriesStorage.setHumidityAreaSeries(avgHumSeries,humLine)
    }

    ChartView {
        id: chartView
        anchors { fill: parent; margins: -15; }
        margins { right: 10; bottom: 10; left: 10; top: 0 }
        antialiasing: true
        backgroundColor: "transparent"
        legend.visible: true
        titleColor: Style.showDataTextColor
        legend.markerShape: Legend.MarkerShapeCircle
        legend.font.pixelSize: 20
        //plotArea: Qt.rect(10, 10, parent.width-20, parent.height-20)
        // Hide the value axis labels; labels are drawn separately.
        ValueAxis {
            id: valueAxisX
            //visible: false
            min: 0
            max: maxNumOfTempReadings - 1
            labelFormat: "%.0f"
        }

        ValueAxis {
            id: valueAxisY
            //visible: false
            min: minimum
            max: maximum
            labelFormat: "%.0f"
        }

        AreaSeries {
            id: avgTempSeries
            axisX: valueAxisX
            axisY: valueAxisY
            name: "Temperature"
            color: tempColor
            //            borderColor: "black"
            opacity: 0.6
            useOpenGL: true
            upperSeries: LineSeries {
                id: tempLine
                width: 2
            }
        }

        AreaSeries {
            id: avgHumSeries
            axisX: valueAxisX
            axisY: valueAxisY
            name: "Humidty"
            opacity: 0.7
            color: humColor
            useOpenGL: true
            upperSeries: tempLine
            lowerSeries: LineSeries {
                id: humLine
                width: 2
            }
        }
    }

//    Row {
//        id: rowElem
//        anchors.bottom: parent.bottom
//        anchors.right: parent.right
//        anchors.left: parent.left
//        anchors.leftMargin: 16
//        height: 30
//        Repeater {
//            model: 2
//            Item {
//                height: rowElem.height
//                width: 200
//                Text {
//                    id: textDescription
//                    text: (index == 0) ? "Temperature: " : "Humidity: "
//                    color: Style.showDataTextColor
//                    font.pixelSize: 20
//                    horizontalAlignment: Qt.AlignHCenter
//                    verticalAlignment: Qt.AlignVCenter
//                }
//                Rectangle  {
//                    anchors.left: textDescription.right
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    anchors.leftMargin: 10
//                    width: 20
//                    height: 20
//                    color: (index == 0) ? tempColor : humColor
//                }

//                /*Text {
//                    text: (index == 0) ? masterController.ui_serialPort.temperatureString : masterController.ui_serialPort.humidityString
//                    color: (index == 0) ? tempColor : humColor
//                    font.pixelSize: 20
//                    horizontalAlignment: Qt.AlignHCenter
//                    verticalAlignment: Qt.AlignVCenter
//                    anchors.left: textDescription.right
//                    anchors.leftMargin: 10
//                }*/
//            }
//        }
//    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.75;height:480;width:640}
}
##^##*/
