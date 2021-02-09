#ifndef MASTERCONTROLLER_H
#define MASTERCONTROLLER_H

#include <QObject>
#include "serialport.h"
#include <QScopedPointer>
#include "Navigationcontroller.h"
#include "clock.h"
#include "seriesstorage.h"
#include "dataproviderpool.h"
#include "src/bluetoothsetting.h"

class Mastercontroller : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Serialport* ui_serialPort READ serialPort CONSTANT)
    Q_PROPERTY(Navigationcontroller* ui_navigationController READ navigationController CONSTANT)
    Q_PROPERTY(Clock* ui_clock READ clock CONSTANT)
    Q_PROPERTY(SeriesStorage* ui_seriesStorage READ seriesStorage CONSTANT)
    Q_PROPERTY(BluetoothSetting* ui_bleSetting READ bleSetting CONSTANT)

public:
    explicit Mastercontroller(QObject* parent = nullptr);
    ~Mastercontroller();

    Navigationcontroller* navigationController();
    Serialport* serialPort();
    Clock* clock();
    SeriesStorage* seriesStorage();
    BluetoothSetting* bleSetting();

public slots:
    void startSerial();
    void stopSerial();

private:
    class Implementation;
    QScopedPointer<Implementation> implementation;

};

#endif // MASTERCONTROLLER_H
