#ifndef PDFMETALIST_H
#define PDFMETALIST_H

#include <QObject>
#include <QList>
#include <QVariant>

struct PdfMetaData {
    QString fileName;
    QString title;
    QString description;
};

class PdfMetaList : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ getName WRITE setName NOTIFY nameChanged)

public:
    explicit PdfMetaList(QObject *parent = nullptr);
    Q_INVOKABLE QString fileName(int index);
    Q_INVOKABLE QString description(int index);
    Q_INVOKABLE QString title(int index);
    Q_INVOKABLE int count() const;
    QList<PdfMetaData>* getList();

    QString getName();
    void setName(QString newname);

signals:
    void nameChanged(QString);

private:
    QList<PdfMetaData>* list;
    QString name;
};


#endif // PDFMETALIST_H
