import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13
import QtQuick.Dialogs 1.3

import "qrc:/QML/Editor" as Path
import "qrc:/QML/Editor/SubjectsManager" as SubjectManagerPath

import io.monetapp.subjectlister 1.0

Rectangle {
    id: root
    anchors.fill: parent
    color: "blue"

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
            implicitHeight: 50
            Path.SubjectsManager {
                id: subjectsManager
                anchors.centerIn: parent
                subjects: subjectsLister.list
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
        y: root.height.valueOf()
        visible: false
        onFinished: {
            subjectDeleter.deletesubject(name)
            deleteSubjectSlider.close()
        }
        onCanceled: {
            deleteSubjectSlider.close()
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
        folder: shortcuts.home
        selectMultiple: false
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
//        addDocumentPanel.open()
    }
}
