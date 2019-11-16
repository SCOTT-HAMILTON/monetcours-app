import QtQuick 2.13
import QtQuick.Controls 2.13

import io.monetapp.monetbuilder 1.0

Rectangle {
    anchors.fill: parent
    color: "red"

    RoundButton {
        id: buildButton
        text: qsTr("Build")
        anchors.centerIn: parent
        font.bold: true
        font.pointSize: 20
        width: 100
        height: 50

        onClicked: {
            enabled = false
            builder.build()
            bar.value = 0.4
            bar.indeterminate = true
        }
    }

    ProgressBar {
        id: bar
        value: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: parent.width*0.04
    }

    MonetBuilder {
        id: builder
        onFinished: {
            buildButton.enabled = true
            bar.value = 1
            bar.indeterminate = false
        }
    }


}
