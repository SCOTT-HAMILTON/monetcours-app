import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Qt.labs.platform 1.1

import "qrc:/QML" as Path

ApplicationWindow {
    id: window
    visible: true
    width: 1000
    height: 600
    title: qsTr("Scroll")


    property string documentsFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)

    TabBar {
        id: bar
        width: parent.width
        TabButton {
            text: qsTr("Editor")
        }
        TabButton {
            text: qsTr("Builder")
        }
        TabButton {
            text: qsTr("Deployer")
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
        Item {
            id: deployerTab
            Path.Deployer{}
        }
    }


}
