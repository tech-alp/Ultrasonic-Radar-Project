#include "sensortagdataprovider.h"
#include <QDebug>
SensorTagDataProvider::SensorTagDataProvider(QObject *parent) : QObject(parent), temperature{0}, humidity{0}, gyroscopeX_degPerSec{0},
    gyroscopeY_degPerSec{0}, gyroscopeZ_degPerSec{0}, accelometerX{0},
    accelometerY{0}, accelometerZ{0}, magnetometerMicroT_xAxis{0},
    magnetometerMicroT_yAxis{0}, magnetometerMicroT_zAxis{0},
    m_name{NotFound}
{

}

SensorTagDataProvider::SensorTagDataProvider(QString id, QObject* parent)
    : QObject(parent), temperature{0}, humidity{0}, gyroscopeX_degPerSec{0},
      gyroscopeY_degPerSec{0}, gyroscopeZ_degPerSec{0}, accelometerX{0},
      accelometerY{0}, accelometerZ{0}, magnetometerMicroT_xAxis{0},
      magnetometerMicroT_yAxis{0}, magnetometerMicroT_zAxis{0},
      m_name{NotFound}, m_id{id}
{
}

int SensorTagDataProvider::getTemperature() const
{
    return temperature;
}

QString SensorTagDataProvider::getTemperatureString() const
{
    return QString::number(temperature) + QString("\u00B0C");
}

float SensorTagDataProvider::getHumidity() const
{
    return humidity;
}

QString SensorTagDataProvider::getHumidityString() const
{
    return QString::number(humidity) + QLatin1String("%");
}

float SensorTagDataProvider::getGyroscopeX_degPerSec() const
{
    return gyroscopeX_degPerSec;
}

float SensorTagDataProvider::getGyroscopeY_degPerSec() const
{
    return gyroscopeY_degPerSec;
}

float SensorTagDataProvider::getGyroscopeZ_degPerSec() const
{
    return gyroscopeZ_degPerSec;
}

float SensorTagDataProvider::getAccelometer_xAxis() const
{
    return accelometerX;
}

float SensorTagDataProvider::getAccelometer_yAxis() const
{
    return accelometerY;
}

float SensorTagDataProvider::getAccelometer_zAxis() const
{
    return accelometerZ;
}

float SensorTagDataProvider::getMagnetometerMicroT_xAxis() const
{
    return magnetometerMicroT_xAxis;
}

float SensorTagDataProvider::getMagnetometerMicroT_yAxis() const
{
    return magnetometerMicroT_yAxis;
}

float SensorTagDataProvider::getMagnetometerMicroT_zAxis() const
{
    return magnetometerMicroT_zAxis;
}

float SensorTagDataProvider::getPosition() const
{
    return position;
}

float SensorTagDataProvider::getDistance() const
{
    return distance;
}

QString SensorTagDataProvider::id() const
{
    return m_id;
}

SensorTagDataProvider::ProviderState SensorTagDataProvider::state() const
{
    return m_state;
}

void SensorTagDataProvider::setState(SensorTagDataProvider::ProviderState state)
{
    if(m_state != state) {
        m_state = state;
        emit stateChanged();
    }
}
