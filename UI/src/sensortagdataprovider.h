#ifndef SENSORTAGDATAPROVIDER_H
#define SENSORTAGDATAPROVIDER_H

#include <QObject>
#include <QString>

class SensorTagDataProvider : public QObject
{
    Q_OBJECT
    Q_ENUMS(TagType)
    Q_ENUMS(ProviderState)
    Q_PROPERTY(ProviderState state READ state NOTIFY stateChanged)
    Q_PROPERTY(QString name MEMBER m_name CONSTANT)
    Q_PROPERTY(QString providerId MEMBER m_id CONSTANT)
    Q_PROPERTY(QString temperatureString READ getTemperatureString NOTIFY temperatureChanged)
    Q_PROPERTY(int temperature READ getTemperature NOTIFY temperatureChanged)
    Q_PROPERTY(QString humidityString READ getHumidityString NOTIFY humidityChanged)
    Q_PROPERTY(float humidity READ getHumidity NOTIFY humidityChanged)
    Q_PROPERTY(float gyroscopeX_degPerSec READ getGyroscopeX_degPerSec NOTIFY gyroscopeDegPerSecChanged)
    Q_PROPERTY(float gyroscopeY_degPerSec READ getGyroscopeY_degPerSec NOTIFY gyroscopeDegPerSecChanged)
    Q_PROPERTY(float gyroscopeZ_degPerSec READ getGyroscopeZ_degPerSec NOTIFY gyroscopeDegPerSecChanged)
    Q_PROPERTY(float accelometer_xAxis READ getAccelometer_xAxis NOTIFY accelometerChanged)
    Q_PROPERTY(float accelometer_yAxis READ getAccelometer_yAxis NOTIFY accelometerChanged)
    Q_PROPERTY(float accelometer_zAxis READ getAccelometer_zAxis NOTIFY accelometerChanged)
    Q_PROPERTY(float magnetometerMicroT_xAxis READ getMagnetometerMicroT_xAxis NOTIFY magnetometerMicroTChanged)
    Q_PROPERTY(float magnetometerMicroT_yAxis READ getMagnetometerMicroT_yAxis NOTIFY magnetometerMicroTChanged)
    Q_PROPERTY(float magnetometerMicroT_zAxis READ getMagnetometerMicroT_zAxis NOTIFY magnetometerMicroTChanged)
    Q_PROPERTY(int   position READ getPosition NOTIFY positionChanged)
    Q_PROPERTY(float distance READ getDistance NOTIFY distanceChanged)

public:
    enum ProviderState {
        NotFound = 0,
        Disconnected,
        Connectable,
        Disconnactable,
        Scanning,
        Connected,
        Error
    };

    explicit SensorTagDataProvider(QObject *parent = nullptr);
    SensorTagDataProvider(QString id, QObject *parent = 0);

    virtual int getTemperature() const;
    virtual QString getTemperatureString() const;
    virtual float getHumidity() const;
    virtual QString getHumidityString() const;
    virtual float getGyroscopeX_degPerSec() const;
    virtual float getGyroscopeY_degPerSec() const;
    virtual float getGyroscopeZ_degPerSec() const;
    virtual float getAccelometer_xAxis() const;
    virtual float getAccelometer_yAxis() const;
    virtual float getAccelometer_zAxis() const;
    virtual float getMagnetometerMicroT_xAxis() const;
    virtual float getMagnetometerMicroT_yAxis() const;
    virtual float getMagnetometerMicroT_zAxis() const;
    virtual float getPosition() const;
    virtual float getDistance() const;

    virtual QString id() const;
    ProviderState state() const;
    void setState(ProviderState state);

    virtual QString providerName() const { return m_name;}
    virtual QString sensorType() const { return QString();}
    virtual QString versionString() const{ return QString();}

signals:
    void stateChanged();
    void temperatureChanged();
    void humidityChanged();
    void gyroscopeDegPerSecChanged();
    void accelometerChanged();
    void magnetometerMicroTChanged();
    void positionChanged();
    void distanceChanged();

protected:
    int temperature;
    float humidity;
    float gyroscopeX_degPerSec;
    float gyroscopeY_degPerSec;
    float gyroscopeZ_degPerSec;
    float accelometerX;
    float accelometerY;
    float accelometerZ;
    float magnetometerMicroT_xAxis;
    float magnetometerMicroT_yAxis;
    float magnetometerMicroT_zAxis;
    uint16_t position;
    float distance;

    QString m_name;
    QString m_id;
    ProviderState m_state;
};

Q_DECLARE_METATYPE(SensorTagDataProvider::ProviderState)

#endif // SENSORTAGDATAPROVIDER_H
