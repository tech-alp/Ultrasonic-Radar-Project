import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import assets 1.0

Item {
    width: comboBoxDescription.width+comboBox.width+row.spacing
    height: 80

    property alias model: comboBox.model
    property alias description: comboBoxDescription.text
    property var theme: comboBox.Material.foreground
    property alias currentIndex: comboBox.currentIndex
    property alias currentText: comboBox.currentText

    signal comboBoxCurrentIndexChanged()

    Rectangle {
        anchors.fill: parent
        color: "transparent"

        Row {
            id: row
            anchors.fill: parent
            spacing: 15
            Text {
                id: comboBoxDescription
                width: Style.widthDescriptionComboBox
                height: parent.height
                text: qsTr("Set Me!")
                color: "black"
                font.family: Style.fontawesome
                font.pixelSize:18
                verticalAlignment: Qt.AlignVCenter
            }

            ComboBox {
                id: comboBox
                y: (parent.height-height)/2
                width: 170
                height: 50
                editable: false
                //model: ["Custom"]
                Material.foreground: theme
                onCurrentIndexChanged: {
                    comboBoxCurrentIndexChanged()
                }
                onCurrentTextChanged: {
                    comboBoxCurrentIndexChanged()
                }
            }
        }
    }
}
