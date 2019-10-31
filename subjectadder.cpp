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
    QDir path = SubjectPath::subjectPath()+"/"+name;
    qDebug() << "SubjectAdder path : " << path;
    if (!path.exists()){
        bool ret = path.mkdir(path.absolutePath());
        emit added(name);
        return ret;
    }
    return true;
}
