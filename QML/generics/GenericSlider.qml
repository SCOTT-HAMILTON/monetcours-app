import QtQuick 2.13

Rectangle {
    id: root
    width: parent.width
    height: parent.height

    property int parentheight: -1

    property var open: function(){
        visible = true
        genslideEnterAnim.start()

    }

    property var close: function(){
        genslideExitAnim.start()
    }

    NumberAnimation {
        id: genslideEnterAnim
        target: root
        property: "y"
        duration: 1000
        from: y
        to: 0
        easing.type: Easing.InOutQuad
        onStarted: {
            console.log("started!!!")
        }
    }

    NumberAnimation {
        id: genslideExitAnim
        target: root
        property: "y"
        duration: 1000
        from: y
        to: {
            if (parentheight !== -1)console.log("PARENT HEIGHT : "+parentheight)
            return parentheight==-1?parent.height : parentheight
        }
        easing.type: Easing.InOutQuad
        onFinished: {
            root.visible = false
            console.log("finished!!!!!!!!!!!!!!!")
        }
    }

    Component.onCompleted: {
        y = parent.height
    }


}
