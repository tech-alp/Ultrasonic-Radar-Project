import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.15
import components 1.0
import assets 1.0

Page {
    header: TabBar {
        id: tabBar
        TabButton {
            text: "Serial Com"
            Layout.fillHeight: true
            width: 200
            font.pixelSize: 18
        }
        TabButton {
            text: "Bluetooth"
            Layout.fillHeight: true
            width: 200
            font.pixelSize: 18
        }

        Material.background: Material.Grey
        Material.accent: Material.DeepOrange
    }

    StackLayout {
        id: layout
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        SerialSettingPanel {

        }

        BluetoothSettingPanel {

        }
    }

    }

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.8999999761581421;height:480;width:640}
}
##^##*/
