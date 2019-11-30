import QtQuick 2.12
import QtQuick.Controls 2.12
import QtWebEngine 1.9

import "qrc:/QML/generics" as Path

import "qrc:/QML/Deployer" as DeployerPath


Path.GenericInteractiveSlider {
    width: parent.width
    height: parent.height
    max: parent.width
    slidevar: "x"
    x: parent.width
    color: "grey"

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        y: parent.height*0.1
        text: qsTr("Github Username")
        font.bold: true
        font.pointSize: 15
        width: parent.width*0.4

    }

    TextField {
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height*0.16
        id: usernameInput
        placeholderText: qsTr("Username")
        width: parent.width*0.4
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        y: parent.height*0.4
        font.bold: true
        font.pointSize: 15
        text: qsTr("Github Password")
        width: parent.width*0.4
    }

    TextField {
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height*0.45
        id: passwordInput
        placeholderText: qsTr("Password")
        width: parent.width*0.4
        passwordCharacter: '*'
        passwordMaskDelay: 500
        echoMode: TextInput.Password
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        y: parent.height*0.65
        font.bold: true
        font.pointSize: 15
        text: qsTr("Comment")
        width: parent.width*0.4
    }

    TextField {
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height*0.7
        id: commentInput
        placeholderText: qsTr("Comment")
        width: parent.width*0.4
    }

    RoundButton {
        id: commitAndPushButton
        text: qsTr("Push")
        font.bold: true
        font.pointSize: 13
        width: commentInput.width*0.4
        anchors.top: commentInput.bottom
        anchors.topMargin: commentInput.height*0.5
        anchors.right: commentInput.right

        onClicked: {
            console.log("pushing...")
            let return_val = gitStatusChecker.check();
            console.log("return val : "+return_val);
        }
    }

    RoundButton {
        id: createAccountButton
        text: qsTr("Sign Up")
        font.bold: true
        font.pointSize: 13
        width: commentInput.width*0.4
        anchors.top: commentInput.bottom
        anchors.topMargin: commentInput.height*0.5
        anchors.left: commentInput.left
        onClicked: {
            gitHubSignUpSlider.open()
        }
    }

    DeployerPath.GitHubSignUpSlider {
        id: gitHubSignUpSlider
        visible: false
    }
}
