 #ifndef PDFMETALISTER_H
#define PDFMETALISTER_H

#include <QStringList>
#include <QObject>
#include <QPair>
#include <pdfmetalist.h>
#include <QVariant>

class PdfMetaLister : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString directory READ getDirectory WRITE setDirectory NOTIFY directoryChanged)
    Q_PROPERTY(PdfMetaList* metaList READ getMetaList WRITE setMetaList NOTIFY metaListChanged)

public:
    explicit PdfMetaLister(QObject *parent = nullptr);

    Q_INVOKABLE void list();
    Q_INVOKABLE QStringList listInPath(QString path);

    QString getDirectory() const;
    void setDirectory(QString newdir);
    static QStringList listPdfsInPath(QString path);
    static QStringList listpdfs(QString directory);

    static QPair<QString, QString> load_config(QString directory, QString fileName);
    PdfMetaList* getMetaList();
    void setMetaList(PdfMetaList* list);

signals:
    void directoryChanged();
    void metaListChanged();

private:
    QString directory;
    PdfMetaList *metalist;
};

#endif // PDFMETALISTER_H
