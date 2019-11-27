#include "subjectslister.h"
#include "subjectpath.h"

#include <QDirIterator>
#include <QDir>
#include <QDebug>

SubjectsLister::SubjectsLister(QObject *parent) :
    QObject(parent)
{

}

QStringList SubjectsLister::listSubjects(QString directory)
{
    QDir dir(directory);

    QDirIterator iterator(dir);

    QStringList list;
    while (iterator.hasNext()) {
        QDir next = iterator.next();
        if (QDir(next).exists()){
            if (! (next.dirName() == ".." || next.dirName() == "."))
                list.append(next.dirName());
        }
    }
    return list;

}

QStringList SubjectsLister::list()
{
    return listSubjects(SubjectPath::path.subjectPath());

}

QStringList SubjectsLister::listSubjectsInDirectory(QString directory)
{
    return listSubjects(directory);
}

void SubjectsLister::sync()
{
    update();
}

void SubjectsLister::update()
{
    emit listChanged();
}
