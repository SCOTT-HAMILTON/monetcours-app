#include "gitstatuschecker.h"
#include "subjectpath.h"
#include <git2.h>

#include <QDebug>


GitStatusChecker::GitStatusChecker(QObject *parent) :
    QObject(parent)
{
    git_libgit2_init();
}

GitStatusChecker::~GitStatusChecker()
{
    git_libgit2_shutdown();
}

bool GitStatusChecker::checkDirectory(QString directory)
{
    qDebug() << "Checking integrity of directory : " << directory;


    if (int error = git_repository_open_ext(
            NULL, directory.toStdString().c_str(), GIT_REPOSITORY_OPEN_NO_SEARCH, NULL) != 0) {
        qDebug() << "directory is not fine, error code : " << error;
    }


    return true;
}

bool GitStatusChecker::check()
{
    return checkDirectory(SubjectPath::path.subjectPath());
}
