#ifndef EXPORTER_H
#define EXPORTER_H

#include <QObject>

class Exporter : public QObject
{
    Q_OBJECT

public:
    explicit Exporter(QObject *parent = nullptr);

    Q_INVOKABLE bool exportFiles(QStringList files);
};

#endif // EXPORTER_H
