#ifndef SUBJECTPATH_H
#define SUBJECTPATH_H

#include <QString>
#include <QObject>
#include <QUrl>

class SubjectPath : public QObject
{
    Q_OBJECT

public:
    explicit SubjectPath(QObject *parent = nullptr);
    Q_INVOKABLE QString subjectPath();
    Q_INVOKABLE void modifyPath(QUrl newpath);

    QString settingsFilePath = "/settings.ini";
    static SubjectPath path;
};


#endif // SUBJECTPATH_H
