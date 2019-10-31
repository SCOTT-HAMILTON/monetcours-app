#include "directorymaker.h"
#include "subjectpath.h"

#include <QDir>
#include <QDebug>


void DirectoryMaker::makedir()
{
    QDir path = SubjectPath::subjectPath();
    qDebug() << "path : " << path;
    if (!path.exists()){
        path.mkdir(path.absolutePath());
    }

    QDir path2 = SubjectPath::subjectPath()+"/French";
    qDebug() << "path2 : " << path2;
    if (!path2.exists()){
//        path2.mkdir(path2.absolutePath());
    }
}

