#include "builder.h"
#include "subjectpath.h"

#include <QDebug>
#include <QThread>

Builder::Builder(QObject *parent) :
    QObject(parent)
{
}

Builder::~Builder()
{
}

void Builder::build()
{
    QDir dir(SubjectPath::path.subjectPath());
    qDebug() << "Building for path : " << dir;
    MonetbuildThread* thread = new MonetbuildThread(this);
    thread->setDir(dir);
    connect(thread, &MonetbuildThread::builded, this, &Builder::emitFinished);
    connect(thread, &MonetbuildThread::finished, thread, &QObject::deleteLater);
    thread->start();
}

void Builder::emitFinished()
{
    emit finished();
}
