#include "subjectpath.h"

#include <QSettings>
#include <QCoreApplication>
#include <QDebug>

SubjectPath SubjectPath::path;

QString SubjectPath::subjectPath()
{
    QSettings settings(QCoreApplication::applicationDirPath()+settingsFilePath, QSettings::NativeFormat);

    auto var = settings.value("subjects_path");
    QString subjects_path = var.toString();
    if (var.isNull()) {
        subjects_path = QCoreApplication::applicationDirPath()+"/Sub";
        settings.setValue("subjects_path", subjects_path);
    }

    return subjects_path;
}

void SubjectPath::modifyPath(QString newpath)
{
    QSettings settings(QCoreApplication::applicationDirPath()+settingsFilePath, QSettings::NativeFormat);
    settings.setValue("R", newpath);
}
