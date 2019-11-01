#ifndef DOCUMENTADDER_H
#define DOCUMENTADDER_H

#include <QObject>
#include <QUrl>

#include "pdfmetadata.h"

class DocumentAdder : public QObject
{
    Q_OBJECT

public:
    explicit DocumentAdder(QObject *parent = nullptr);

    static bool addDocument(PdfMetaData metapdf, QString subject);
    static bool addDocument(QUrl filePath, QString subject,
                            QString title, QString description);

    Q_INVOKABLE bool add(QUrl filePath, QString subject,
                         QString title, QString description);
};

#endif // DOCUMENTADDER_H
