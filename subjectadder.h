#ifndef SUBJECTADDER_H
#define SUBJECTADDER_H

#include <QObject>

class SubjectAdder : public QObject
{
    Q_OBJECT

public:
    explicit SubjectAdder(QObject *parent = nullptr);
    Q_INVOKABLE bool add(QString name);

signals:
    void added(QString);
};

#endif // SUBJECTADDER_H
