import QtQuick 2.12
import QtQml.Models 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4

import "qrc:/QML/generics" as Path

Path.GenericInteractiveSlider {
    id: root
    width: parent.width
    height: parent.height
    color: "green"

    signal finished(var title, var description);

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height*0.10
        text: "What's the title for this file?"
        font.bold: true
        font.pointSize:  16
    }

    TextField {
        id: titleInput
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height*0.25
        width: parent.width*0.3
        placeholderText: "title"
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height*0.55
        text: "What's the title for this file?"
        font.bold: true
        font.pointSize:  16
    }

    TextField {
        id: descriptionInput
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height*0.70
        width: parent.width*0.5
        placeholderText: "description"
    }

    RoundButton {
        text: "Add"
        radius: 10
        width: 100
        height: 50
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.width*0.05
        anchors.rightMargin: parent.width*0.1
        onClicked: {
            root.finished(titleInput.text, descriptionInput.text)
        }
    }
}
