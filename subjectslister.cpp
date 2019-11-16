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
    QDir dir(SubjectPath::path.subjectPath());
    QDirIterator iterator(dir);

    QStringList list;
    while (iterator.hasNext()) {
        QDir next = iterator.next();
        if (QDir(next).exists()){
            if (! (next.dirName() == ".." || next.dirName() == "."))
                list.append(next.dirName());
        }
    }/*
    if (list.size()>0){
        qDebug() << "c++ list : " << list;
    }*/
    return list;
}

void SubjectsLister::sync()
{
    update();
}

void SubjectsLister::update()
{
    emit listChanged();
}
