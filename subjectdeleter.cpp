#include "subjectdeleter.h"
#include "subjectpath.h"

#include <QDir>
#include <QDebug>

SubjectDeleter::SubjectDeleter(QObject *parent) :
    QObject(parent)
{
}

bool SubjectDeleter::deletesubject(QString name)
{
    QDir path = SubjectPath::subjectPath()+"/"+name;
    qDebug() << "deleting subject : " << path;
    if (path.exists()){
        bool ret = path.removeRecursively();
        emit deleted(name);
        qDebug() << "deleted ? " << ret << " : " << path.absolutePath();
        return ret;
    }
    return true;
}
