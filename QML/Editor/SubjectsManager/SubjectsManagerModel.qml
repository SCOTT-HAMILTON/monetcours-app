import QtQuick 2.0
import QtQml.Models 2.12

ListModel {
    id: model
    property var subjects: []


    property var update: function() {
        clear()
        for (let i = 0; i < subjects.length; i++ ) {
            append({"name" : subjects[i]})
        }
        append({"name" : "+"})
    }

    onSubjectsChanged: {
        update()
    }

    Component.onCompleted: {
        update()
    }

}
