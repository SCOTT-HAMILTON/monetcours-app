#include "subjectadder.h"
#include "subjectpath.h"

#include <QDir>
#include <QDebug>

SubjectAdder::SubjectAdder(QObject *parent) :
    QObject(parent)
{

}

bool SubjectAdder::add(QString name)
{
    QDir path = SubjectPath::path.subjectPath()+"/"+name;
    if (!path.exists()){
        bool ret = path.mkdir(path.absolutePath());
        emit added(name);
        return ret;
    }
    return true;
}
