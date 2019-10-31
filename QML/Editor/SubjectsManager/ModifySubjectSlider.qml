import QtQuick 2.13

import "qrc:/QML/generics" as Path

Path.GenericSlider {
    id: root
    width: parent.width
    height: parent.height*0.4
    color: "#AA00FF00"
    anchors.verticalCenter: parent.verticalCenter

    max: parent.width
    slidevar: "x"
}
