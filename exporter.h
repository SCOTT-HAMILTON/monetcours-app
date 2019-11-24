#ifndef EXPORTER_H
#define EXPORTER_H

#define QUAZIP_STATIC

#include <QObject>
#include <quazip5/quazip.h>

class Exporter : public QObject
{
    Q_OBJECT

public:
    explicit Exporter(QObject *parent = nullptr);

    Q_INVOKABLE bool exportPdfs(QStringList files, QString archiveFile);

    bool createTestArchive(QuaZip &zip, const QString &zipName,
                           const QStringList &fileNames,
                           QTextCodec *codec,
                           const QString &dir);
};

#endif // EXPORTER_H
