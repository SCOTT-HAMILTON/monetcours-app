#include "subjectpathmodifyer.h"
#include "subjectpath.h"

#include <QDebug>


SubjectPathModifyer::SubjectPathModifyer(QObject *parent) :
    QObject(parent)
{

}

void SubjectPathModifyer::modifyPath(QUrl folderPath)
{
    SubjectPath::path.modifyPath(folderPath.path());
    qDebug() << "new path : " << folderPath;
}
