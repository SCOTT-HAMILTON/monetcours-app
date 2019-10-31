#include "directorymaker.h"
#include "subjectpath.h"

#include <QDir>
#include <QDebug>


void DirectoryMaker::makedir()
{
    QDir path = SubjectPath::subjectPath();
    if (!path.exists()){
        path.mkdir(path.absolutePath());
    }
}

