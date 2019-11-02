import QtQuick 2.13
import QtQml.Models 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Styles 1.4

import "qrc:/QML/generics" as Path

Path.GenericInteractiveSlider {
    id: root
    width: parent.width
    height: parent.height
    color: "green"

    signal finished(var name);

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height*0.10
        text: "What's the name of the subject ?"
        font.bold: true
        font.pointSize:  18
    }

    TextField {
        id: nameInput
        anchors.centerIn: parent
        placeholderText: "Name"
    }

    RoundButton {
        text: "Next"
        radius: 10
        width: 100
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.width*0.05
        anchors.rightMargin: parent.width*0.1
        onClicked: {
            root.finished(nameInput.text)
        }
    }
}
