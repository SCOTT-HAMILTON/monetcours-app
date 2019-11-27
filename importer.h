#ifndef IMPORTER_H
#define IMPORTER_H

#include <QObject>
#include <quazip5/quazip.h>

class Importer : public QObject
{
    Q_OBJECT

public:
    explicit Importer(QObject *parent = nullptr);

    Q_INVOKABLE QString extractPdfs(QString archiveUrl);
    Q_INVOKABLE bool importPdfs(QStringList files, QString directory);

signals:
    void filesImported();
};


#endif // IMPORTER_H
