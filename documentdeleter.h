#ifndef DOCUMENTDELETER_H
#define DOCUMENTDELETER_H

#include <QObject>

class DocumentDeleter : public QObject
{
    Q_OBJECT
//    Q_PROPERTY(bool deleted name WRITE setName NOTIFY nameChanged)

public:
    explicit DocumentDeleter(QObject *parent = nullptr);

    static bool deleteDoc(QString filePath, QString subject);

    Q_INVOKABLE bool deleteDocument(QString filePath, QString subject);

signals:
    void deleted();
};

#endif // DOCUMENTDELETER_H
