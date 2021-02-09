import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtCharts 2.3
import components 1.0
import assets 1.0

Window {
    id: masterView
    visible: true
    width: 1400
    height: 850
    title: qsTr("Radar Project")
    color: Style.colorBackground

    Timer {
        running: true
        interval: 1500
        onTriggered: {
            contentFrame.replace("qrc:/views/DashboardView.qml")
        }
    }

//    Component.onCompleted: {
//        contentFrame.replace("qrc:/views/DashboardView.qml")
//    }

    NavigationBar {
        id: navigationBar
    }

    Connections {
        target: masterController.ui_navigationController
        function onGoSettingsView() {
            contentFrame.replace("qrc:/views/SettingsView.qml")
        }
        function onGoShowElementsView() {
            contentFrame.replace("qrc:/views/DashboardView.qml")
        }
    }

    StackView {
        id: contentFrame
        anchors {
            left: navigationBar.right
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }
        initialItem: "qrc:/views/SplashView.qml"
        clip: true
    }

}
