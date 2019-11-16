import QtQuick 2.12


import "qrc:/QML/generics" as Path

Path.GenericInteractiveSlider {
    id: root
    width: parent.width*0.3
    height: parent.height*0.4
    color: "#AA00FF00"
    anchors.verticalCenter: parent.verticalCenter
    max: parent.width
    min: parent.width-width
    slidevar: "x"

    property string docName: "None"
    property string subject: "None"

    Text {
        id: text
        text: qsTr("File saved !!!")
        font.bold: true
        font.pointSize: 16
        anchors.centerIn: parent
    }

    Timer {
        id: waitTimer
        repeat: false
        interval: 500
        onTriggered: {
            root.close()
        }
    }

    onOpened: {
        waitTimer.start()
    }

//    name: docName
}
