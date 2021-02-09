import QtQuick 2.3
import QtGraphicalEffects 1.0
import assets 1.0
import QtCharts 2.3

Item {
    id: root
    //anchors.fill: parent
    width: parent.width
    height: parent.height   

    property bool expand: true
    property bool visiblePolarChart: false
    property color colourMarkerDefault: "red"
    signal imageClicked()

    property var pos
    property var dis

    PolarChartView {
        anchors.fill: parent
        legend.visible: false
        antialiasing: true
        z: 1
        margins {
            left: 0; right: 0; top:0; bottom: 0
        }
        Component.onCompleted: masterController.ui_seriesStorage.setRadarScatterSeries(scatterSeries)
        plotAreaColor: "transparent"
        backgroundColor: "transparent"

        ValueAxis {
            id: axisAngular
            min: 0
            visible: visiblePolarChart
            max: 360
            tickCount: 9
        }

        ValueAxis {
            id: axisRadial
            visible: visiblePolarChart
            min: 0
            max: 100
        }
        ScatterSeries {
            id: scatterSeries
            axisAngular: axisAngular
            axisRadial: axisRadial
            color: colourMarkerDefault
            borderColor: "black"
            markerSize: 10
            onPressed: {
                root.state = "hover"
                root.pos =  point.x
                root.dis = point.y
            }
            onReleased: root.state = ""
        }
    }

    states: [
        State {
            name: "hover"
            PropertyChanges {
                target: targetRec
                textDesc: "Position: " + root.pos +"\nDistance: " + root.dis
                visible: true
                x: 0
                y: 15
            }
        },
        State {
            name: "expanded"
            PropertyChanges {
                target: topLayer
                visible: false
            }
            PropertyChanges {
                target: ustKatman
                visible: false
            }
        }
    ]

    Image {
        anchors.centerIn: parent
        id: topLayer
        width: Math.min(parent.width,parent.height)
        height: width
        source: "qrc:/images/altKatman.png"
        fillMode: Image.PreserveAspectFit
        rotation: Style.radarAngle
    }

    Image {
        id: ustKatman
        anchors.centerIn: parent
        width: Math.min(parent.width,parent.height)
        height: width
        source: "qrc:/images/üstKatman.png"
        fillMode: Image.PreserveAspectFit
    }

    Rectangle {
        anchors {
            left: parent.left
            top: parent.top
        }
        z:5
        color: "transparent"
        width: 30
        height: 30
        clip: true
        Text {
            anchors.fill: parent
            font {
                family: Style.fontawesome
                pixelSize: 25
            }
            color: Style.showDataTextColor
            text: expand ? "\uf065" : "\uf066" //"\uf0b2"
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
        }
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                imageClicked()
                expand = !expand
            }
        }
    }

    Rectangle {
        id: targetRec
        width: 120
        height: 50
        color: "#102b33"
        radius: 10
        border.color: "#140e0e"
        border.width: 1
        opacity: 0.7
        visible: false
        property alias textDesc: targetIdentity.text
        Text {
            id: targetIdentity
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color:"white"
            font.pixelSize: 18
        }
    }


    /*Image {
        id: targetImage
        //scale: 0.6
        sourceSize.width: 50
        sourceSize.height: 50
        source: "qrc:/images/geridekalannokta.png"
        x: parent.width/2 + Math.cos(masterController.position)*masterController.distance
        y: parent.height/2 + Math.sin(masterController.position)*masterController.distance
        fillMode: Image.PreserveAspectFit
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            anchors.margins: 12
            cursorShape: Qt.CrossCursor
            hoverEnabled: true
            onEntered: {
                root.state = "hover"
                console.log(mouseX.toFixed(2),mouseY.toFixed(2))
            }
            onExited: root.state = ""
        }
    }


    Rectangle {
        id: targetRec
        width: 120
        height: 50
        color: "#0f6d86"
        radius: 10
        border.color: "#140e0e"
        border.width: 1
        opacity: 0.7
        visible: false
        property alias textDesc: targetIdentity.text
        Text {
            id: targetIdentity
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color:"white"
            font.pixelSize: 18
        }
    }*/

    /* Timer {
        repeat: true
        running: true
        interval: rotationSpeed
        onTriggered: topLayer.rotation++
    }*/



    /*
    Rectangle {
        id: radar
        property color radarColor: "#30840c"
        anchors.centerIn: parent
        radius: Math.max(parent.width,parent.height)*0.5
        width: Math.min(parent.width,parent.height)
        height: width
        color: "#30840c"
        //"#00000000"
        border.width: 2
        border.color: Style.showDataTextColor //"#ffffff"

        /*Timer {
            repeat: true
            running: true
            interval: rotationSpeed
            onTriggered: handle.angle++
        }*/
    /*
        Repeater {
            id: rp
            model: [10,8,6,4,2,0]
            Rectangle {
                anchors.centerIn: radar
                width: Math.min((parent.width/10)*modelData,(parent.height/10)*modelData)
                height: width
                radius: 1000//width*0.5
                color: radar.radarColor//parent.color
                border.width: parent.border.width
                border.color: parent.border.color
            }
        }

        Rectangle {
            anchors.fill: parent
            color: radar.radarColor//parent.border.color
            radius: parent.radius
            opacity: 0.15
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.border.width
            height: parent.height
            color: parent.border.color
        }

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            height: parent.border.width
            width: parent.width
            color: parent.border.color
        }

        ConicalGradient {
            id: handle
            anchors.fill: parent
            angle: Style.radarAngle
            source: Rectangle {
                width: handle.width
                height: handle.height
                radius: Math.max(width,height)
            }
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#00000000" }
                GradientStop { position: 0.86; color: "#00000000" }
                GradientStop { position: 1.0; color: "#e01b1b" }
            }
        }

        Repeater {
            Rectangle {
                x: model.x
                y: model.y
                width: 10
                height: width
                radius: width*0.5
            }
            model: device
        }

        ListModel {
            id: device
        }

        //Method to show any pop up dots inside radar

        function showDevice(value) {
            var angle = -1, index = -1
            var centerX, centerY, posX, posY

            for(var i = 0; i < device.count; i++) {
                var smac = device.get(i).mac
                if(smac === mac) {
                    index = i
                    angle = device.get(i).a
                    break
                }
            }

            if(angle < 0)
                angle = Math.random()*360
            centerX = radar.radius
            centerY = radar.radius
            if(value < 0) {
                posX = -1*value
            }
            else {
                posX = value
            }

            //100 consider as max value
            posX = (100-posX)
            var radius = centerX - (centerX * (posX/100))
            posX = centerX + radius * Math.cos(angle)
            posY = centerY + radius * Math.sin(angle)

            if(index >= 0) {
                device.setProperty(index, "value", value)
                device.setProperty(index, "x", posX)
                device.setProperty(index, "y", posY)
                return
            }
            device.append({ "name": name, "mac": mac, "value": value, "x": posX, "y": posY, "a": angle })
        }
    }*/
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}
}
##^##*/
