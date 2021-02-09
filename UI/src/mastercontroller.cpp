#include "mastercontroller.h"

class Mastercontroller::Implementation {
public:
    Implementation(Mastercontroller* _masterController) : masterController{_masterController}
    {
        serialPort = new Serialport(_masterController);
        navigationController = new Navigationcontroller(_masterController);
        clock = new Clock(_masterController);
        seriesStorage = new SeriesStorage(_masterController);
        seriesStorage->connectSensorData(serialPort);
        bluetoothSetting = new BluetoothSetting(_masterController);
    }

    Mastercontroller* masterController;
    Navigationcontroller* navigationController{nullptr};
    Serialport* serialPort{nullptr};
    Clock* clock{nullptr};
    SeriesStorage* seriesStorage{nullptr};
    DataProviderPool* dataProviderPool{nullptr};
    BluetoothSetting* bluetoothSetting{nullptr};
};

Mastercontroller::Mastercontroller(QObject *parent) : QObject(parent)
{
    implementation.reset(new Implementation(this));
}

Mastercontroller::~Mastercontroller()
{

}

Navigationcontroller* Mastercontroller::navigationController()
{
    return implementation->navigationController;
}

Serialport* Mastercontroller::serialPort()
{
    return implementation->serialPort;
}

Clock* Mastercontroller::clock()
{
    return implementation->clock;
}

SeriesStorage* Mastercontroller::seriesStorage()
{
    return implementation->seriesStorage;
}

BluetoothSetting* Mastercontroller::bleSetting()
{
    return implementation->bluetoothSetting;
}

void Mastercontroller::startSerial()
{
    implementation->serialPort->openSerialPort();
}

void Mastercontroller::stopSerial()
{
    implementation->serialPort->closeSerialPort();
}
