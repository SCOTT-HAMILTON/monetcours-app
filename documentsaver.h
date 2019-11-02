#ifndef DOCUMENTSAVER_H
#define DOCUMENTSAVER_H

#include <QObject>
#include <QUrl>

#include "pdfmetadata.h"

class DocumentSaver : public QObject
{
    Q_OBJECT

public:
    explicit DocumentSaver(QObject *parent = nullptr);

    static bool saveDocument(PdfMetaData metapdf, QString subject);
    static bool saveDocument(QUrl filePath, QString subject,
                            QString title, QString description);

    Q_INVOKABLE bool save(QUrl filePath, QString subject,
                         QString title, QString description);
};

#endif // DOCUMENTSAVER_H
