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
    if (path.exists()){
        bool ret = path.rmdir(path.absolutePath());
        emit deleted(name);
        return ret;
    }
    return true;
}
