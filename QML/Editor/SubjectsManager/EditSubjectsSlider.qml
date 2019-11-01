import QtQuick 2.13
import QtQml.Models 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Styles 1.4

import "qrc:/QML/Editor/SubjectsManager" as Path
import "qrc:/QML/generics" as GenPath

import io.monetapp.pdfmetalister 1.0
import io.monetapp.pdfmetalist 1.0
import io.monetapp.documentdeleter 1.0

GenPath.GenericSlider {
    id: root
    width: parent.width
    height: parent.height
    color: "lightgrey"

    property string subject: "None"
    signal canceled();

    onOpening: {
        update()
    }

    function update(){
        lister.directory = subject
        lister.list()
        nameModel.clear()
        for (let i = 0; i < list.count(); i++){
            nameModel.append({"fileName" : list.fileName(i),
                              "title" : list.title(i),
                              "description" : list.description(i)})
        }
    }

    Rectangle {
        id: blueRect
        width: grid.width*1.2
        height: grid.height*1.4
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height*0.05
        radius: 10
        color: "lightblue"        

        ListView {
            id: grid
            property int textWidth: 200
            property int buttonWidth: 70
            property int textSpacing: 10
            width: textWidth*3+3*textSpacing+buttonWidth
            height: 300
            anchors.centerIn: parent

            model: ListModel {
                id: nameModel
            }
            delegate: Component {
                id: pdfDelegate
                Row {
                    padding: grid.textSpacing
                    spacing: grid.textSpacing
                    TextInput {
                        text: fileName
                        width: grid.textWidth
                        clip: true
                    }

                    TextInput {
                        text: title
                        width: grid.textWidth
                        clip: true
                    }
                    TextInput {
                        text: description
                        width: grid.textWidth
                        clip: true
                    }

                    RoundButton{
                        text: "modify"
                        width: grid.buttonWidth
                        objectName: {
                            return fileName+"modifyButton"
                        }
                        onClicked: {
                            modifySubjectSlider.docName = fileName
                            modifySubjectSlider.open()
                        }
                    }

                }
            }
            implicitHeight: contentHeight
            implicitWidth: contentWidth
            ScrollBar.vertical: ScrollBar{
                width: 20
                anchors.rightMargin: -50
                anchors.right: grid.right
            }
        }
    }

    onSubjectChanged: {
        update();
    }




    PdfMetaLister {
        id: lister
        directory: subject
        metaList: PdfMetaList {
            id: list
            name: "Victor"
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

    DocumentDeleter {
        id: documentDeleter
        onDeleted: {
            update();
        }
    }

    Path.ModifySubjectSlider {
        id: modifySubjectSlider

        subject: subject

        onFinished: {
            close()
        }

        visible: false
    }

    Path.DeleteDocumentSlider {
        id: deleteDocumentSlider
        onDeleted: {
            close()
            documentDeleter.deleteDocument(name, subject)
        }
        visible: false
    }
}
