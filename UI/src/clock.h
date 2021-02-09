#ifndef CLOCK_H
#define CLOCK_H

#include <QObject>
#include <QDateTime>
#include <QTimer>
#include <QScopedPointer>

class Clock : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString analogClock READ analogClock NOTIFY analogClockChanged)
    Q_PROPERTY(QString currentTime READ analogClock CONSTANT)

public:
    explicit Clock(QObject *parent = nullptr);
    ~Clock();
    QString analogClock() const;
    QString currentTime() const;
    void Start();
    void Stop();

public slots:
    void analogClockTime();
signals:
    void analogClockChanged();
private:
    class Implementation;
    QScopedPointer<Implementation> implementation;
};

#endif // CLOCK_H
