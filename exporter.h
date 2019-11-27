#ifndef EXPORTER_H
#define EXPORTER_H

#include <QObject>
#include <quazip5/quazip.h>

class Exporter : public QObject
{
    Q_OBJECT

public:
    explicit Exporter(QObject *parent = nullptr);

    Q_INVOKABLE bool exportPdfs(QStringList files, QString archiveFile);
};

#endif // EXPORTER_H
