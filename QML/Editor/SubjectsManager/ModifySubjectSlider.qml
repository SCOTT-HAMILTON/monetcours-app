import QtQuick 2.13
import QtQuick.Controls 2.13

import "qrc:/QML/generics" as Path

Path.GenericSlider {
    id: root
    width: parent.width
    height: parent.height*0.4
    color: "#AA00FF00"
    anchors.verticalCenter: parent.verticalCenter
    max: parent.width
    slidevar: "x"

    property string docName: "None"
    property string subject: "None"

    signal finished();

    RoundButton {
        text: "Delete"
        height: 50
        background: Rectangle {
            anchors.fill: parent
            radius: 10
            color: "red"
        }

        radius: 10
        width: 100
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.width*0.05
        anchors.rightMargin: parent.width*0.1
        onClicked: {
            deleteDocumentSlider.name = docName
            deleteDocumentSlider.open()
            root.finished()
        }
    }
}
