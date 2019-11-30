import QtQuick 2.12
import QtQuick.Controls 2.12

import "qrc:/QML/Deployer" as Path

Rectangle {
    anchors.fill: parent
    color: "green"

    RoundButton {
        id: publishButton
        text: qsTr("Publish")
        anchors.centerIn: parent
        onClicked: {
            //TODO popup gitPublishSlider
            gitPublishSlider.open()
        }
        font.bold: true
        font.pointSize: 20
        width: parent.width*0.3
        height: parent.height*0.1

    }

    Path.GitPublishSlider {
        id: gitPublishSlider
        visible: false
    }
}
