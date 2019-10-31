import QtQuick 2.13
import QtQml.Models 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Styles 1.4

import "qrc:/QML/generics" as Path

import io.monetapp.pdfmetalister 1.0
import io.monetapp.pdfmetalist 1.0

Path.GenericSlider {
    id: root
    width: parent.width
    height: parent.height
    color: "lightgrey"

    property string name: "None"
    signal canceled();

    Rectangle {
        width: grid.width +50
        height: grid.height+50
        anchors.centerIn: parent
        radius: 10
        color: "lightblue"

        ListView {
            id: grid
            property int textWidth: 300
            property int textSpacing: 10
            width: textWidth*3+2*textSpacing
            anchors.centerIn: parent

            model: ListModel {
                id: nameModel
            }
            delegate: Component {
                id: pdfDelegate
                Row {
                    padding: grid.textSpacing
                    spacing: grid.textSpacing
                    Text {
                        text: fileName
                        width: grid.textWidth
                    }

                    Text {
                        text: title
                        width: grid.textWidth
                    }
                    Text {
                        text: description
                        width: grid.textWidth
                    }

                }
            }
            implicitHeight: contentHeight
            implicitWidth: contentWidth

        }
    }

    onNameChanged: {
        console.log("\n\n\tNEW NAME\n\n"+name)
        lister.directory = name
        lister.list()
        console.log("list : ",list.description(0))
        nameModel.clear();
        for (let i = 0; i < list.count(); i++){
            nameModel.append({"fileName" : list.fileName(i),
                              "title" : list.title(i),
                              "description" : list.description(i)})
        }
    }


    PdfMetaLister {
        id: lister
        directory: name
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
}
