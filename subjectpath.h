#ifndef SUBJECTPATH_H
#define SUBJECTPATH_H

#include <QString>

class SubjectPath
{
public:
    QString subjectPath();
    void modifyPath(QString newpath);

    QString settingsFilePath = "/settings.ini";
    static SubjectPath path;
};


#endif // SUBJECTPATH_H
