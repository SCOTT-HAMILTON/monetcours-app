import QtQuick 2.12

Rectangle {
    id: root
    width: parent.width
    height: parent.height

    property bool isSlider: true

    property int max: -1
    property int min: 0
    property string slidevar: "y"

    signal opened();
    signal closed();
    signal opening();
    signal closing();

    property var open: function(){
        for (var i = 0; i < parent.children.length; ++i) {
            if (!parent.children[i].isSlider){
                parent.children[i].enabled = false
            }
        }
        visible = true
        x = max
        genslideEnterAnim.stop()
        genslideEnterAnim.start()
        opening()
    }

    property var close: function(){
        for (var i = 0; i < parent.children.length; ++i) {
            if (!parent.children[i].isSlider){
                parent.children[i].enabled = true
            }
        }
        genslideExitAnim.start()
        closing()
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
        to: min
        easing.type: Easing.InOutQuad
        onFinished: root.opened()
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
            root.closed()
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
