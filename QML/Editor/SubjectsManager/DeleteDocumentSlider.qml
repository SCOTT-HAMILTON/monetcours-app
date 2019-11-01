import QtQuick 2.13
import QtQuick.Controls 2.13

import "qrc:/QML/generics" as Path

Path.GenericDeleteValidationSlider {
    id: root
    width: parent.width
    height: parent.height*0.4
    color: "#AA00FF00"
    anchors.verticalCenter: parent.verticalCenter
    max: parent.width
    slidevar: "x"

    property string docName: "None"
    property string subject: "None"

    name: docName
}
