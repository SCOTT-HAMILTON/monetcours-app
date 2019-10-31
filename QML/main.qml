import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13

import "qrc:/QML" as Path

ApplicationWindow {
    visible: true
    width: 1000
    height: 600
    title: qsTr("Scroll")

    TabBar {
        id: bar
        width: parent.width
        TabButton {
            text: qsTr("Editor")
        }
        TabButton {
            text: qsTr("Builder")
        }
    }

    StackLayout {
        width: parent.width
        height: parent.height-bar.height
        y: bar.height
        currentIndex: bar.currentIndex
        Item {
            id: editorTab

            Path.Editor{}
        }
        Item {
            id: builderTab
            Path.Builder{}
        }
    }
}
