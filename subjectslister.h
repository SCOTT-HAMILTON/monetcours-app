#ifndef SUBJECTSLISTER_H
#define SUBJECTSLISTER_H

#include <QStringList>
#include <QObject>

class SubjectsLister : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList list READ list NOTIFY listChanged)

public:
    explicit SubjectsLister(QObject *parent = nullptr);
    static QStringList listSubjects(QString directory);
    static QStringList list();
    Q_INVOKABLE QStringList listSubjectsInDirectory(QString directory);
    Q_INVOKABLE void sync();

public slots:
    void update();

signals:
    void listChanged();
};

#endif // SUBJECTSLISTER_H
