import QtQuick 2.13
import QtQml.Models 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Styles 1.4

import "./AppDocumentPanel" as Path
import "qrc:/QML/generics" as GenPath

GenPath.GenericSlider {
    id: root
    width: parent.width
    height: parent.height
    color: "green"

    visible: true

    property string subject: "None"

    signal finished(var subject, var title, var description);

    onFinished: {
        subjectSlideSelector.visible = true
        fileSlideSelector.close()
    }

    Path.SubjectSlideSelector {
        id: subjectSlideSelector
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

}
