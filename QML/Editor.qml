import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.1

import "qrc:/QML/Editor" as Path
import "qrc:/QML/Editor/SubjectsManager" as SubjectManagerPath

import io.monetapp.subjectlister 1.0
import io.monetapp.pdfmetalister 1.0
import io.monetapp.pdfmetalist 1.0

Rectangle {
    id: root
    anchors.fill: parent
    color: "blue"

    RoundButton {
        id: subjectsPathButton
        text: qsTr("Where are the subjects ?")
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: parent.height*0.02
        anchors.rightMargin: parent.width*0.01


        onClicked: {
            folderDialog.open()
        }

    }

    RoundButton {
        id: importExportButton
        text: qsTr("Import/Export")
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: parent.height*0.02
        anchors.leftMargin: parent.width*0.01

        Menu {
            id: importExportMenu
            MenuItem {
                text: "Import"
                onTriggered: {
                    importSlide.open()
                }
            }
            MenuItem {
                text: "Export"
                onTriggered: {
                    exportSlide.open()
                }
            }
        }

        onClicked: {
            importExportMenu.open()
        }

    }

    PdfMetaLister {
        id: lister
        directory: "None"
        metaList: PdfMetaList {
            id: list
            name: "Victor"
        }
    }

    ColumnLayout {
        anchors.fill: parent
        Button{
            id: addDocButton
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Add a document...")

            onClicked: {
                fileDialog.open()
            }
        }
        Text{
            Layout.fillWidth: true
            text: qsTr("Subjects :")
            font.bold: true
            font.pointSize: 17
            horizontalAlignment: Qt.AlignHCenter
        }

        Item {
            Layout.fillWidth: true
            implicitHeight: parent.height*0.001
        }
        Text {
            id: noSubjectsText
            Layout.fillWidth: true
            visible: false
            text: qsTr("There is no subjects right now.")
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
        nameFilters: [qsTr("Pdf document")+" (*.pdf)"]
        onAccepted: {
            console.log("You chose: " + fileDialog.file)
            addDocumentPanel.open(fileDialog.fileUrls)
            addDocButton.visible = false
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
        visible: false
        onFinished: {
            console.log("File to add : "+subject+", "+title+", "+description)
            addDocumentPanel.close()
            addDocButton.visible = true
            subjectsManager.visible = true
            console.log("fileChoosen : "+fileDialog.file)
            documentAdder.add(fileDialog.file, subject, title, description);
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

    Path.ExportSlide {
        id: exportSlide
        visible: false
        onFinished: {
            close()
        }

        onCanceled: {
            close()
        }

        subjects: subjectsLister.list
    }

    Path.ImportSlide {
        id: importSlide
        visible: false
        onFinished: {
            close()
        }

        onCanceled: {
            close()
        }
    }

    FolderDialog {
        id: folderDialog
        title: "Please choose a folder"
        options: FolderDialog.ShowDirsOnly
//        folder:
        onAccepted: {
            console.log("You chose: " + folderDialog.folder)
            subjectPath.modifyPath(folder)
            subjectsLister.sync()
            console.log("file :"+folderDialog.folder)
            if (subjectsLister.list.length>0)noSubjectsText.visible = false
            else noSubjectsText.visible = true
        }
        onRejected: {
            console.log("Canceled")
        }
        Component.onCompleted: {
            visible = false
        }
    }
    Component.onCompleted: {
        if (subjectsLister.list.length === 0) {
            noSubjectsText.visible = true;
        }
    }
}
