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

    property string name: "None"
    signal finished(var name);
    signal canceled();

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height*0.10
        text: "Are you sure you want to delete "+name+" ?"
        font.bold: true
        font.pointSize:  15
    }

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
            root.finished(name)
        }
    }
    RoundButton {
        text: "Cancel"
        height: 50
        radius: 10
        width: 100
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.width*0.05
        anchors.leftMargin: parent.width*0.1
        onClicked: {
            root.canceled()
        }
    }
}
