import QtQuick 2.12
import QtQuick.Controls 2.12
import QtWebEngine 1.8

import "qrc:/QML/generics" as Path

Path.GenericInteractiveSlider {
    id: root
    width: parent.width
    height: parent.height
    max: parent.width
    slidevar: "x"
    x: parent.width
    color: "grey"

    WebEngineView {
        anchors.fill: parent
        url: "https://github.com/join?source=header-home"
        smooth: false
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
            root.close()
        }
    }
}
