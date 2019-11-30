#ifndef GITSTATUSCHECKER_H
#define GITSTATUSCHECKER_H

#include <QObject>

class GitStatusChecker : public QObject
{
    Q_OBJECT
//    Q_PROPERTY(bool deleted name WRITE setName NOTIFY nameChanged)

public:
    explicit GitStatusChecker(QObject *parent = nullptr);
    ~GitStatusChecker();

    Q_INVOKABLE bool checkDirectory(QString directory);

    Q_INVOKABLE bool check();

signals:
    void deleted();
};

#endif // GITSTATUSCHECKER_H
