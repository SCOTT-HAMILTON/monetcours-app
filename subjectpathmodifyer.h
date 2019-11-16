#ifndef SUBJECTPATHMODIFYER_H
#define SUBJECTPATHMODIFYER_H

#include <QObject>
#include <QUrl>

class SubjectPathModifyer : public QObject
{
    Q_OBJECT

public:
    explicit SubjectPathModifyer(QObject *parent = nullptr);

    Q_INVOKABLE void modifyPath(QUrl newpath);

signals:
    void deleted();
};

#endif // SUBJECTPATHMODIFYER_H
