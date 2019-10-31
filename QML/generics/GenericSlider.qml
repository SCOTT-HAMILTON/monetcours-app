import QtQuick 2.13

Rectangle {
    id: root
    width: parent.width
    height: parent.height

    property int max: -1
    property string slidevar: "y"

    property var open: function(){
        visible = true
        x = max
        genslideEnterAnim.start()
    }

    property var close: function(){
        genslideExitAnim.start()
    }

    NumberAnimation {
        id: genslideEnterAnim
        target: root
        property: slidevar
        duration: 1000
        from: {
            switch (root.slidevar){
                case "x":
                    return root.x
                default:
                    return root.y
            }
        }
        to: 0
        easing.type: Easing.InOutQuad
    }

    NumberAnimation {
        id: genslideExitAnim
        target: root
        property: slidevar
        duration: 1000
        from: {
            switch (root.slidevar){
                case "x":
                    return root.x
                default:
                    return root.y
            }
        }
        to: {
            return root.max==-1?
                        ((root.slidevar==="x") ? parent.width : parent.height) :
                        root.max
        }
        easing.type: Easing.InOutQuad
        onFinished: {
            root.visible = false
        }
    }

    Component.onCompleted: {
        switch (slidevar){
            case "x":
                x = parent.width
                break
            default:
                y = parent.height
        }
    }


}
