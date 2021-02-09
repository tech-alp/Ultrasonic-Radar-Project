#include "clock.h"
#include <QDebug>

class Clock::Implementation {
public:
    Implementation(QTimer* _timer) : timer{_timer} {
        timer->start(100);
    }

    QTimer* timer{nullptr};
    QTime time;
    QString analogClock;
};

Clock::Clock(QObject *parent) : QObject(parent)
{
    implementation.reset(new Implementation(new QTimer));

    connect(implementation->timer,SIGNAL(timeout()),this,SLOT(analogClockTime()));
}

Clock::~Clock()
{

}

QString Clock::analogClock() const
{
    return implementation->analogClock;
}

QString Clock::currentTime() const
{
    return implementation->analogClock;
}

/*void Clock::Start()
{
    delete implementation->timer;
    implementation->timer = new QTimer;
    implementation->timer->start(100);
    connect(implementation->timer,SIGNAL(timeout()),this,SLOT(analogClockTime()));
}

void Clock::Stop()
{
    implementation->timer->stop();
}*/

void Clock::analogClockTime()
{
    implementation->time = QTime::currentTime();
    implementation->analogClock = implementation->time.toString("hh:mm:ss");
    emit analogClockChanged();
}

