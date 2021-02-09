import QtQuick 2.0

Item {
    clip:  true
    Rectangle{
        id: circ
        width: Math.min(parent.width,parent.height)
        height: width
        y: circ.height/2
        border.width: 2
        radius:1000
        border.color: "black"
    }
    Rectangle {

    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
