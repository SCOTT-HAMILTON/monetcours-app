#include "subjectpath.h"

#include <QSettings>
#include <QCoreApplication>
#include <QDebug>
#include <QFile>
#include <QStandardPaths>

SubjectPath SubjectPath::path;

SubjectPath::SubjectPath(QObject *parent) :
    QObject(parent)
{

}

QString SubjectPath::subjectPath()
{
    QString settings_file_path = QStandardPaths::writableLocation(QStandardPaths::ConfigLocation)+"/settings.ini";
    QSettings settings(settings_file_path, QSettings::IniFormat);

    auto var = settings.value("subjects_path");
    QString subjects_path = var.toString();
    if (var.isNull()) {
        subjects_path = QCoreApplication::applicationDirPath()+"/Sub";
        settings.setValue("subjects_path", subjects_path);
    }

    return subjects_path;
}

void SubjectPath::modifyPath(QUrl url)
{
    QString newpath = url.path();
    #ifdef Q_OS_WINDOWS
        newpath.remove(0,1);
    #endif
    QString settings_file_path = QStandardPaths::writableLocation(QStandardPaths::ConfigLocation)+"/settings.ini";
    qDebug() << "settings file path : " << settings_file_path;
    if (!QFile::exists(settings_file_path)){
        QFile f(settings_file_path);
        f.open(QIODevice::NewOnly);
        f.close();
    }
    QSettings settings(settings_file_path, QSettings::IniFormat);

//    QSettings settings(settings_file_path, QSettings::NativeFormat);
    settings.setValue("subjects_path", newpath);
    settings.sync();
    qDebug() << "settings : " << settings.status();
}
