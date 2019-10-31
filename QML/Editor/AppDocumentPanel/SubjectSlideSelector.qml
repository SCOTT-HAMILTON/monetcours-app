import QtQuick 2.13
import QtQml.Models 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Styles 1.4

import "qrc:/QML/generics" as Path

Path.GenericSlider {
    id: root
    width: parent.width
    height: parent.height
    color: "green"

    signal finished(var subject);

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height*0.10
        text: "Which subject is this document about ?"
        font.bold: true
        font.pointSize:  18
    }

    ComboBox{
        id: subjectComboBox
        anchors.centerIn: parent

        model: ["French", "Math", "English", "Biology"]
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
            root.finished(subjectComboBox.currentText)
        }
    }
}
