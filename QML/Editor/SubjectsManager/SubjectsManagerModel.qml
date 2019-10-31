import QtQuick 2.0
import QtQml.Models 2.13

ListModel {
    id: model
    property var subjects: []


    property var update: function() {
        clear()
        console.log("subjects from model : ")
        for (let i = 0; i < subjects.length; i++ ) {
            console.log("model sub : "+subjects[i])
            append({"name" : subjects[i]})
        }
        append({"name" : "+"})
    }

    onSubjectsChanged: {
        console.log("MODEL subjects changed")
        update()
    }

    Component.onCompleted: {
        update()
    }

}
