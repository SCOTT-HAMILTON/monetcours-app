import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQml.Models 2.13
import Qt.labs.platform 1.0

import "qrc:/QML/Editor/SubjectsManager" as Path

Item {
    id: root
    property int buttonSize: 100
    property var subjects: []

    width: model.count*buttonSize
    height: 50
//    color: "white"

    ListView {
        id: listView

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
                        //TODO slide EditSubjectPanel
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
        implicitHeight: contentHeight
        implicitWidth: contentWidth
        orientation: Qt.LeftToRight
    }
}

