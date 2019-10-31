#include "subjectpath.h"

#include <QCoreApplication>

QString SubjectPath::subjectPath()
{
    return QCoreApplication::applicationDirPath()+"/Sub";
}
