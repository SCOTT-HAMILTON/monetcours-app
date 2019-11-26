import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml.Models 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2

import "qrc:/QML/generics" as Path

Path.GenericInteractiveSlider {
    id: root
    width: parent.width
    height: parent.height
    color: "grey"
    max: parent.width
    slidevar: "x"

    signal finished(var title, var description)
    signal canceled()

    property var subjects: []
    property var checkedFilenames: []
    property var checkedSubjects: []
    property var needUpdate: false

    onOpened: {
        update()
    }

    onNeedUpdateChanged: {
        if (needUpdate)
            update()
    }

    function update(){
        needUpdate = false
        filesModel.clear()


        for (let sub in subjects) {
            let subject = subjects[sub]
            lister.directory = subject
            lister.list()
            let subjectChecked = checkedSubjects.indexOf(subject)!==-1
            filesModel.append({"heading" : subject,
                                  "fileName" : "",
                                  "isChecked": subjectChecked,
                                "insubject": ""})
            for (let i = 0; i < list.count(); ++i){
                let fileName = list.fileName(i)
                let isChecked = checkedFilenames.indexOf(sub+"/"+fileName) !== -1 || subjectChecked
                filesModel.append({"heading" : "",
                                  "fileName" : fileName,
                                  "isChecked" : isChecked,
                                  "insubject": subject})
            }
        }

    }

    function removeCheckedInSubject(subject){
        for (let i = 0; i < filesModel.count; ++i){
            let fileName = filesModel.get(i).fileName
            let insubject = filesModel.get(i).insubject

            if (insubject === subject){
                let index = checkedFilenames.indexOf(insubject+"/"+fileName)
                if (index !== -1){
                    checkedFilenames.splice(index, 1)
                }
            }

        }
    }

    Text {
        text: qsTr("Which files do you want to export ?")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.width*0.05
        font.pointSize: 20
    }

    Rectangle {
        id: blueRect
        width: root.width*0.9
        height: root.height*0.75
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.width*0.1
        y: parent.height*0.05
        radius: 10
        color: "lightblue"

        Text {
            id: fileHeading
            anchors.top: blueRect.top
            anchors.topMargin: grid.height*0.05
            anchors.horizontalCenter: grid.horizontalCenter
            anchors.horizontalCenterOffset: parent.width*0.01
            text: qsTr("File")
            font.bold: true
            font.pointSize: 15
        }

        CheckBox {
            anchors.top: blueRect.top
            anchors.topMargin: grid.height*0.01
            anchors.left: grid.left
            anchors.leftMargin: grid.textWidth*0.3
            text: qsTr("Select All")
            LayoutMirroring.enabled: true
            Layout.alignment: Qt.RightToLeft
            onCheckStateChanged: {
                checkedFilenames.splice(0)
                checkedSubjects.splice(0)
                if (checked){
                    text = qsTr("Diselect All")
                    for (let i = 0; i < filesModel.count; ++i){
                        if (filesModel.get(i).heading === ""){
                            let fileName = filesModel.get(i).fileName
                            checkedFilenames.push(filesModel.get(i).insubject+"/"+fileName)
                            console.log("CHECKED FILES : "+checkedFilenames)
                        }else {
                            checkedSubjects.push(filesModel.get(i).heading)
                        }
                    }
                }
                else
                    text = qsTr("Select All")
                root.update()
            }
        }

        ListView {
            id: grid
            clip: true
            property int textWidth: 200
            property int buttonWidth: 70
            property int textSpacing: 10
            width: textWidth*2+2*textSpacing+40
            height: 250
            anchors.centerIn: parent

            model: ListModel {
                id: filesModel
                dynamicRoles: false
            }
            delegate: Row {
                    padding: grid.textSpacing
                    spacing: grid.textSpacing
                    Text {
                        text: heading
                        width: grid.textWidth/2
                        clip: true
                        font.bold: true
                        font.pointSize: 16
                    }

                    Text {
                        text: fileName
                        width: grid.textWidth
                        clip: true
                    }

                    CheckBox {
                        width: grid.textWidth*0.5
                        visible: true

                        anchors.top: parent.top

                        checked: isChecked
                        onCheckedChanged: {
                            if(checked!=isChecked)//prevent binding loop
                                isChecked = checked

                            if (heading !== ""){
                                let index = checkedSubjects.indexOf(heading)
                                if (index !== -1){
                                    if (!checked){
                                        checkedSubjects.splice(index, 1)
                                        removeCheckedInSubject(heading)
                                        needUpdate = true
                                    }
                                }else if (checked){
                                    checkedSubjects.push(heading)
                                    needUpdate = true
                                }
                            }else {
                                let index = checkedFilenames.indexOf(insubject+"/"+fileName)
                                if (index !== -1){
                                    if (!checked)
                                        checkedFilenames.splice(index, 1)
                                }else if (checked){
                                    checkedFilenames.push(insubject+"/"+fileName)
                                }
                            }

                        }
                    }
            }

//            implicitHeight: contentHeight
//            implicitWidth: contentWidth


            ScrollBar.vertical: ScrollBar{
                active: true
                visible: true

                onActiveChanged: {
//                    active = true
                }

                onVisibleChanged: {
//                    visible = true
                }

                width: 20
            }
        }


        RoundButton {
            id: exportButton
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: parent.width*0.07
            anchors.bottomMargin: parent.height*0.05
            text: "Export"
            width: parent.width*0.15
            font.bold: true
            onClicked: {
                console.log(" files : "+checkedFilenames)
                saveDialog.open()
            }
        }
    }

    FileDialog {
        id: saveDialog
        title: "Save Dialog"
        selectExisting: false
        folder: documentsFolder
        visible: false
        nameFilters: [qsTr("Monetcours transfert file")+" (*.monet)"]
        defaultSuffix: ".monet"
        onAccepted: {
            console.log(fileUrls[0])
            exporter.exportPdfs(checkedFilenames, fileUrls[0])

        }
    }

    RoundButton {
        text: qsTr("Cancel")
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
