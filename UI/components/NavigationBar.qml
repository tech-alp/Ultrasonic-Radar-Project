import QtQuick 2.0
import assets 1.0
import SensorTag.DataProvider 1.0
import QtQuick.Controls 2.12

// child of root
Item {
    anchors {
        left: parent.left
        top: parent.top
        bottom: parent.bottom
    }
    width: Style.widthNavigationButton

    Component.onCompleted: home.checked = true


    Rectangle {
        anchors.fill: parent
        clip: true
        color: Style.colorNavigationBarBackground
    Column {
        id:  buttonColumn
        width: parent.width

        function clearAllChecks() {
            for (var i=0; i<buttonColumn.children.length; i++) {
                if (buttonColumn.children[i].toString().startsWith("NavigationButton")) {
                    buttonColumn.children[i].checked = false
                }
            }
        }

        Image {
            id: mainIcon
            width: parent.width
            height: 120
            scale: 0.60
            source: "qrc:/images/Project_Icon.svg" //"qrc:/.svg/start.svg"
            fillMode: Image.PreserveAspectFit
        }

        NavigationButton{
            id: home
            iconText: "\uf015"
            hoverColor: "#00ff00"
            descriptionText: "Home"
            colorTextDescription: "white"
            onNavigationButtonClicked: {
                masterController.ui_navigationController.goShowElementsView();
                buttonColumn.clearAllChecks()
                home.checked = true
                console.log("Home")
            }
        }

        NavigationButton{
            id: settings
            iconText: "\uf013"
            hoverColor: "#29b6f6"
            enabled: Style.state !== SensorTagData.Connected ? true : false
            descriptionText: "Settings"
//            colorTextIcon: stateSettingIcon ? "red" : "black"
            colorTextDescription: "white"
            onNavigationButtonClicked: {
                masterController.ui_navigationController.goSettingsView();
                buttonColumn.clearAllChecks()
                settings.checked = true
                console.log("Settings")
            }
        }

        NavigationButton{
            id: start
            iconText: "\uf04b"
            descriptionText: "Start"
            hoverColor: "#dc143c"
            enabled: Style.state === SensorTagData.Connected ? true : false
            colorTextIcon: "black"
            colorTextDescription: "white"
            onNavigationButtonClicked: {
                masterController.startSerial();
                //stateStart = !stateStart
                console.log("Start")
            }
        }

        NavigationButton{
            id: stop
            iconText: "\uf04d"
            colorTextIcon: "black"
            hoverColor: "#ffa500"
            enabled: !start.enabled
            descriptionText: "Stop"
            colorTextDescription: "white"
            onNavigationButtonClicked: {
                masterController.stopSerial();
                console.log("Stop")
            }
        }

        /*NavigationButton{
            id: change
            hoverColor: "#1837c5"
            transformOrigin: Item.Center
            iconText: "\uf186"//"\uf021"
            descriptionText: "Dark"
            colorTextIcon: "black"
            colorTextDescription: "white"
            onNavigationButtonClicked: {
                console.log("Change")
                iconText = changeClick ? "\uf185" : "\uf186"
                descriptionText = changeClick ? "Light" : "Dark"
                Style.colorBackground = changeClick ? "black" : "#f9f9f9"
                Style.showDataElementColor = changeClick ? "#090909" : "#ffffff"
                Style.showDataTextColor = changeClick ? "white" : "black"
                changeClick = !changeClick
            }
        }*/
    }
    Switch {
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 20
        }
        id: switch1
        text: checked ? "Dark" : "Light"
        checked: false

        onClicked: {
            Style.colorBackground = checked ? "black" : "#f9f9f9"
            Style.showDataElementColor = checked ? "#090909" : "#ffffff"
            Style.showDataTextColor = checked ? "white" : "black"
        }
    }
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:1.3300000429153442}
}
##^##*/
