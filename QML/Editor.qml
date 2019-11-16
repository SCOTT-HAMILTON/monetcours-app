import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13
import QtQuick.Dialogs 1.3
import Qt.labs.platform 1.1

import "qrc:/QML/Editor" as Path
import "qrc:/QML/Editor/SubjectsManager" as SubjectManagerPath

import io.monetapp.subjectlister 1.0

Rectangle {
    id: root
    anchors.fill: parent
    color: "blue"

    RoundButton {
        id: subjectsPathButton
        text: "Where are the subjects ?"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: parent.height*0.02
        anchors.rightMargin: parent.width*0.01


        onClicked: {
            folderDialog.open()
        }

    }

    ColumnLayout {
        anchors.fill: parent
        Button{
            id: addDocButton
            Layout.alignment: Qt.AlignHCenter
            text: "Add a document..."

            onClicked: {
                fileDialog.open()
            }
        }
        Text{
            Layout.fillWidth: true
            text: "Subjects :"
            font.bold: true
            font.pointSize: 17
            horizontalAlignment: Qt.AlignHCenter
        }

        Item {
            Layout.fillWidth: true
            implicitHeight: parent.height*0.001
        }
        Text {
            Layout.fillWidth: true
            id: noSubjectsText
            visible: false
            text: "There is no subjects right now."
            font.bold: true
            font.pointSize: 17
            horizontalAlignment: Qt.AlignHCenter
        }

        Item {
            Layout.fillWidth: true
            implicitHeight: parent.height*0.05
        }

        Item {
            Layout.fillWidth: true
            implicitHeight: 100
            Path.SubjectsManager {
                id: subjectsManager
                subjects: subjectsLister.list
                anchors.centerIn: parent
            }

        }
        Item {
            Layout.fillWidth: true
            implicitHeight: parent.height*0.15
        }

    }

    SubjectManagerPath.AddSubjectSlider {
        id: addSubjectSlider
        visible: false
        onFinished: {
            subjectAdder.add(name)
            addSubjectSlider.close()
        }
    }

    SubjectManagerPath.DeleteSubjectSlider  {
        id: deleteSubjectSlider
        visible: false
        onDeleted: {
            console.log("SUbject to delete : "+deleteSubjectSlider.name)
            subjectDeleter.deletesubject(deleteSubjectSlider.name)
            deleteSubjectSlider.close()
        }
        onCanceled: {
            deleteSubjectSlider.close()
        }

        Component.onCompleted: {
            y = parent.height
        }
    }

    SubjectManagerPath.EditSubjectsSlider  {
        id: editSubjectSlider
        visible: false
        onCanceled: {
            editSubjectSlider.close()
        }
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        defaultSuffix: "pdf"
        nameFilters: ["Pdf files (*.pdf)"]
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
            addDocumentPanel.open(fileDialog.fileUrls)
            addDocButton.visible = false
            console.log("file :"+fileUrl)
        }
        onRejected: {
            console.log("Canceled")
        }
        Component.onCompleted: {
            visible = false
        }
    }

    Path.AddDocumentPanel {
        id: addDocumentPanel
        y: root.height.valueOf()
        visible: false
        onFinished: {
            console.log("File to add : "+subject+", "+title+", "+description)
            addDocumentPanel.close()
            addDocButton.visible = true
            subjectsManager.visible = true
            documentAdder.add(fileDialog.fileUrl, subject, title, description);
        }
        onCanceled: {
            addDocumentPanel.close()
            addDocumentPanel.visible = true
            subjectsManager.visible = true
        }

        onOpened: {
            subjectsManager.visible = false
        }

    }


    Component.onCompleted: {
        if (subjectsLister.list.length === 0) {
            noSubjectsText.visible = true;
        }
    }

    FolderDialog {
        id: folderDialog
        title: "Please choose a folder"
        options: FolderDialog.ShowDirsOnly
//        folder:
        onAccepted: {
            console.log("You chose: " + folderDialog.folder)
            pathModifyer.modifyPath(folder)
            subjectsLister.sync()
            console.log("file :"+folderDialog.folder)
        }
        onRejected: {
            console.log("Canceled")
        }
        Component.onCompleted: {
            visible = false
        }
    }
}
