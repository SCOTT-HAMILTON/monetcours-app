import QtQuick 2.12
import QtQml.Models 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4

import "./AppDocumentPanel" as Path
import "qrc:/QML/generics" as GenPath

GenPath.GenericInteractiveSlider {
    id: root
    width: parent.width
    height: parent.height
    color: "green"

    visible: true

    property string subject: "None"

    signal finished(var subject, var title, var description);
    signal canceled();

    onFinished: {
        subjectSlideSelector.visible = true
        fileSlideSelector.close()
    }

    Path.SubjectSlideSelector {
        id: subjectSlideSelector
        subjects: subjectsLister.list

        onFinished: {
            subjectSlideSelector.visible = false
            fileSlideSelector.open()
            root.subject = subject
        }
        visible: true

        Component.onCompleted: {
            visible = true
            y = 0
        }
    }

    Path.FileSlideDescriptor {
        id: fileSlideSelector
        y: root.height.valueOf()
        onFinished: {
            root.finished(subject, title, description)
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
