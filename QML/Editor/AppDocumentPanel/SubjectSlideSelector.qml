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

    property var subjects: []

    signal finished(var subject);

    function updateModel(){
        subjectsModel.clear()
        for (let i = 0; i < subjects.length; ++i){
            subjectsModel.append({"name" : subjects[i]})
        }
    }

    onSubjectsChanged: updateModel()

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
        model: ListModel{
            id: subjectsModel
        }

        Component.onCompleted: {
            root.updateModel();
        }
    }

    RoundButton {
        text: "Next"
        height: 50
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
