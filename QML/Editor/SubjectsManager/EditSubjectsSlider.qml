import QtQuick 2.12
import QtQml.Models 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4

import "qrc:/QML/Editor/SubjectsManager" as Path
import "qrc:/QML/generics" as GenPath

import io.monetapp.pdfmetalister 1.0
import io.monetapp.pdfmetalist 1.0
import io.monetapp.documentdeleter 1.0

GenPath.GenericInteractiveSlider {
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
        width: root.width*0.9
        height: root.height*0.75
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.width*0.01
//        anchors.centerIn: parent
        y: parent.height*0.05
        radius: 10
        color: "lightblue"

        Row {
            anchors.bottomMargin: grid.height*0.2
            anchors.bottom: grid.top
            anchors.left: grid.left
            anchors.leftMargin: grid.width*0.4
            spacing: grid.width*0.15
            Text{
                text: "Title"
                font.bold: true
                font.pointSize: 15
            }
            Text{
                text: "Description"
                font.bold: true
                font.pointSize: 15
            }
        }

        ListView {
            id: grid
            property int textWidth: 200
            property int buttonWidth: 70
            property int textSpacing: 10
            width: textWidth*3+4*textSpacing+buttonWidth*2
            height: 250
            anchors.bottom: blueRect.bottom
            anchors.left: parent.left

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
                        readOnly: true
                    }

                    TextField {
                        id: titleInput
                        text: title
                        width: grid.textWidth
                        clip: true
                        placeholderText: "Title"
                    }
                    TextField {
                        id: descInput
                        text: description
                        width: grid.textWidth
                        clip: true
                        placeholderText: "Description"
                    }

                    RoundButton{
                        text: "delete"
                        background: Rectangle {
                            color: "red"
                            radius: 10
                        }

                        width: grid.buttonWidth
                        onClicked: {
                            deleteDocumentSlider.docName = fileName
                            deleteDocumentSlider.open()
                        }
                    }

                    RoundButton{
                        text: "save"
                        background: Rectangle {
                            color: "lightgrey"
                            radius: 10
                        }

                        width: grid.buttonWidth
                        onClicked: {
//                             TODO MAKE SAVE Slider Pop only when documentSaver
//                             emits signal successed or something like so
                            documentSaver.save(fileName, subject,
                                               titleInput.text,
                                               descInput.text)
                            saveDocumentSlider.open()
                        }
                    }

                }
            }
            implicitHeight: contentHeight
            implicitWidth: contentWidth
            ScrollBar.vertical: ScrollBar{
                active: true
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

    Path.DeleteDocumentSlider {
        id: deleteDocumentSlider

        subject: root.subject

        onDeleted: {
            console.log("deleting : "+docName+", "+subject)
            close()
            documentDeleter.deleteDocument(docName, subject)
        }

        onCanceled: {
            close()
        }

        visible: false
    }

    Path.SaveDocumentSlider {
        id: saveDocumentSlider
        visible: false
    }
}
