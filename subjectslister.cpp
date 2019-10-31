#include "subjectslister.h"
#include "subjectpath.h"

#include <QDirIterator>
#include <QDir>
#include <QDebug>

SubjectsLister::SubjectsLister(QObject *parent) :
    QObject(parent)
{

}

QStringList SubjectsLister::list()
{
    QDir dir(SubjectPath::subjectPath());
    QDirIterator iterator(dir);

    QStringList list;
    while (iterator.hasNext()) {
        QDir next = iterator.next();
        if (! (next.dirName() == ".." || next.dirName() == "."))
            list.append(next.dirName());
    }/*
    if (list.size()>0){
        qDebug() << "c++ list : " << list;
    }*/
    return list;
}

void SubjectsLister::update()
{
    emit listChanged();
}
