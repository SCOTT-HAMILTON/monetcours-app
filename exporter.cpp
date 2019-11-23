#include "exporter.h"

#include <QDebug>

Exporter::Exporter(QObject *parent) :
    QObject(parent)
{

}

bool Exporter::exportFiles(QStringList files)
{
    qDebug() << "exporting those files : " << files;
    return true;
}
