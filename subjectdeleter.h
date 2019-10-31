#ifndef SUBJECTDELETER_H
#define SUBJECTDELETER_H

#include <QObject>

class SubjectDeleter : public QObject
{
    Q_OBJECT

public:
    explicit SubjectDeleter(QObject *parent = nullptr);
    Q_INVOKABLE bool deletesubject(QString name);

signals:
    void deleted(QString);
};

#endif // SUBJECTDELETER_H
