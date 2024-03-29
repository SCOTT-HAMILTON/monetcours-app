import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml.Models 2.12
import Qt.labs.platform 1.0

import "qrc:/QML/Editor/SubjectsManager" as Path

Item {
    id: root
    property int buttonSize: 100
    property var subjects: []
    height: 100
    width: parent.width
//    color: "white"

    ListView {
        id: listView

        width: (model.count*buttonSize<root.width*0.6)?model.count*buttonSize:root.width*0.6
        implicitWidth: model.count*buttonSize
        anchors.centerIn: parent
        height: 50
        model: Path.SubjectsManagerModel{
            id: model
            subjects: root.subjects
        }

        Component {
            id: nameDelegate
            RoundButton {
                id: button
                text: name;
                property string subName: name
                width: buttonSize
                height: 50

                onClicked: {
                    if (name === "+"){
                        addSubjectSlider.open()
                    }else{
                        buttonMenu.open()
                    }

                }

                Menu {
                    id: buttonMenu
                    MenuItem {
                      text: qsTr("Edit")
                      shortcut: StandardKey.ZoomIn
                      onTriggered: {
                          editSubjectSlider.subject = button.subName
                          editSubjectSlider.open()
                      }
                    }

                    MenuItem {
                      text: qsTr("Delete")
                      shortcut: StandardKey.ZoomOut
                      onTriggered:{
                        deleteSubjectSlider.name = button.subName
                        deleteSubjectSlider.open()
                      }
                    }
                }
            }
        }
        delegate: nameDelegate

        orientation: Qt.LeftToRight
        ScrollBar.horizontal: ScrollBar{
            active: true
            height: 20
        }
    }
}

