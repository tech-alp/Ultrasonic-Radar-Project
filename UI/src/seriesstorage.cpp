#include "seriesstorage.h"

Q_DECLARE_METATYPE(QAbstractSeries *)
Q_DECLARE_METATYPE(QAbstractAxis *)

inline void updatePoints(QList<QPointF>& list, int newIndex, float newValue, int maxItems)
{
    list.append(QPointF(newIndex, newValue));
    if(list.size() > maxItems)
        list.removeFirst();
}

SeriesStorage::SeriesStorage(QObject *parent) : QObject(parent)
{
    /*for (int i = 0; i < 30; i++) {
        m_temperatureList.append(QPointF(i, 30));
        //m_accListX.append(QPointF(i, 30));
    }*/
}

void SeriesStorage::setDataProviderPool(DataProviderPool* pool)
{
    m_providerPool = pool;
    if (!m_providerPool)
        return;
    connect(m_providerPool, &DataProviderPool::currentProviderIndexChanged, this, &SeriesStorage::dataProviderPoolChanged);
}

/*void SeriesStorage::setTemperatureSeries(QAbstractSeries* series)
{
    m_temperature = qobject_cast<QLineSeries*>(series);
}*/

void SeriesStorage::setGyroSeries(QAbstractSeries* xSeries, QAbstractSeries* ySeries, QAbstractSeries* zSeries)
{
    m_gyroX = qobject_cast<QSplineSeries*>(xSeries);
    m_gyroY = qobject_cast<QSplineSeries*>(ySeries);
    m_gyroZ = qobject_cast<QSplineSeries*>(zSeries);
}

void SeriesStorage::setMagnetoMeterSeries(QAbstractSeries* xSeries, QAbstractSeries* ySeries, QAbstractSeries* zSeries)
{
    m_magX = qobject_cast<QSplineSeries*>(xSeries);
    m_magY = qobject_cast<QSplineSeries*>(ySeries);
    m_magZ = qobject_cast<QSplineSeries*>(zSeries);
}

void SeriesStorage::setAcceleroMeterSeries(QAbstractSeries* xSeries, QAbstractSeries* ySeries, QAbstractSeries* zSeries)
{
    m_accX = qobject_cast<QSplineSeries*>(xSeries);
    m_accY = qobject_cast<QSplineSeries*>(ySeries);
    m_accZ = qobject_cast<QSplineSeries*>(zSeries);
}

void SeriesStorage::setAcceleroMeterAreaSeries(QAbstractSeries* xSeries, QAbstractSeries* ySeries, QAbstractSeries* zSeries)
{
    m_accXX = qobject_cast<QLineSeries*>(xSeries);
    m_accYY = qobject_cast<QLineSeries*>(ySeries);
    m_accZZ = qobject_cast<QLineSeries*>(zSeries);
}

void SeriesStorage::setTemperatureAreaSeries(QAbstractSeries* areaSeries,QLineSeries* xSeries)
{
    m_temperatureArea = qobject_cast<QAreaSeries*>(areaSeries);
    m_temperatureArea->setUpperSeries(xSeries);
    m_temperature = qobject_cast<QLineSeries*>(xSeries);
}

void SeriesStorage::setHumidityAreaSeries(QAbstractSeries* areaSeries,QLineSeries* xSeries)
{
    m_humidityArea = qobject_cast<QAreaSeries*>(areaSeries);
    m_humidityArea->setLowerSeries(xSeries);
    m_humidity = qobject_cast<QLineSeries*>(xSeries);
}

void SeriesStorage::setHumiditySeries(QAbstractSeries* xSeries)
{
    m_humidity = qobject_cast<QLineSeries*>(xSeries);
}

void SeriesStorage::setRadarScatterSeries(QAbstractSeries* series)
{
    m_radar = qobject_cast<QScatterSeries*>(series);
    m_radar->clear();
}

void SeriesStorage::dataProviderPoolChanged()
{
    m_gyroProvider = m_providerPool->currentProvider();
    if (m_gyroProvider)
        connect(m_gyroProvider, &SensorTagDataProvider::gyroscopeDegPerSecChanged,
                this, &SeriesStorage::changeRotationSeries, Qt::UniqueConnection);

    m_magnetoProvider = m_providerPool->currentProvider();
    if (m_magnetoProvider)
        connect(m_magnetoProvider, &SensorTagDataProvider::magnetometerMicroTChanged,
                this, &SeriesStorage::changeMagnetoSeries, Qt::UniqueConnection);

    m_temperatureProvider = m_providerPool->currentProvider();
    if (m_temperatureProvider)
        connect(m_temperatureProvider, &SensorTagDataProvider::temperatureChanged,
                this, &SeriesStorage::changeTemperatureSeries, Qt::UniqueConnection);
}

void SeriesStorage::changeTemperatureSeries()
{
    if(!m_temperature && !m_humidity)
        return;
//    constexpr static const int maxTemperatureReadings = 30;
//    static int temperatureSeriesIndex = 0;
//    static int axisMin = 0;
//    static int axisMax = maxTemperatureReadings + 1;
//    static const int defaultAvgValue = 25;
    static int temperatureSeriesIndex = 0;
    constexpr static const int maxTemperatureReadings = 30;
    static int axisMin = 0;
    static int axisMax = maxTemperatureReadings + 1;
    static int tempValue = 0;
    static float humValue = 0;
    if(m_dataProviderSensor->getTemperature() != tempValue || m_dataProviderSensor->getHumidity() != humValue) {
        tempValue = m_dataProviderSensor->getTemperature();
        humValue = m_dataProviderSensor->getHumidity();
        updatePoints(m_temperatureList, temperatureSeriesIndex, tempValue, maxTemperatureReadings);
        updatePoints(m_humidityList, temperatureSeriesIndex, humValue, maxTemperatureReadings);
//        m_humidity->setBrush()
        m_temperature->replace(m_temperatureList);
        m_humidity->replace(m_humidityList);

        if (temperatureSeriesIndex >= maxTemperatureReadings) {
            QAbstractAxis *axis = m_temperatureArea->attachedAxes().at(0);
            axisMin++;
            axisMax++;
            axis->setRange(axisMin, axisMax);
        }
        temperatureSeriesIndex++;
    }
    //    //m_temperatureList.removeLast();
//    m_temperatureList.append(QPointF(temperatureSeriesIndex,(float)m_dataProviderSensor->getTemperature()));
//    //m_temperatureList.append(QPointF(temperatureSeriesIndex, defaultAvgValue));

//    if(m_temperatureList.size() >= maxTemperatureReadings)
//        m_temperatureList.removeFirst();
//    if(temperatureSeriesIndex >= maxTemperatureReadings) {
//        QAbstractAxis* axis = m_temperature->attachedAxes().at(0);
//        axisMin++;
//        axisMax++;
//        axis->setRange(axisMin,axisMax);
//    }
//    m_temperature->replace(m_temperatureList);
//    temperatureSeriesIndex++;
}

void SeriesStorage::changeMagnetoSeries()
{

}

void SeriesStorage::changeRotationSeries()
{
    if (!m_gyroX || !m_gyroY || !m_gyroZ)
        return;

    static int gyroSeriesIndex = 0;
    constexpr static const int maxGyroReadings = 24;
    static int axisMin = 0;
    static int axisMax = maxGyroReadings + 1;

    updatePoints(m_gyroListX, gyroSeriesIndex, m_dataProviderSensor->getGyroscopeX_degPerSec(), maxGyroReadings);
    m_gyroX->replace(m_gyroListX);
    updatePoints(m_gyroListY, gyroSeriesIndex, m_dataProviderSensor->getGyroscopeY_degPerSec(), maxGyroReadings);
    m_gyroY->replace(m_gyroListY);
    updatePoints(m_gyroListZ, gyroSeriesIndex, m_dataProviderSensor->getGyroscopeZ_degPerSec(), maxGyroReadings);
    m_gyroZ->replace(m_gyroListZ);

    if (gyroSeriesIndex >= maxGyroReadings) {
        QAbstractAxis *axis = m_gyroX->attachedAxes().at(0);
        axisMin++;
        axisMax++;
        axis->setRange(axisMin, axisMax);
    }
    gyroSeriesIndex++;
}

void SeriesStorage::changeAccelerometerSeries()
{
    if (!m_accX || !m_accY || !m_accZ)
        return;

    static int accSeriesIndex = 0;
    constexpr static const int maxAccReadings = 24;
    static int axisMin = 0;
    static int axisMax = maxAccReadings + 1;

    updatePoints(m_accListX, accSeriesIndex, m_dataProviderSensor->getAccelometer_xAxis(), maxAccReadings);
    m_accX->replace(m_accListX);
    updatePoints(m_accListY, accSeriesIndex, m_dataProviderSensor->getAccelometer_yAxis(), maxAccReadings);
    m_accY->replace(m_accListY);
    updatePoints(m_accListZ, accSeriesIndex, m_dataProviderSensor->getAccelometer_zAxis(), maxAccReadings);
    m_accZ->replace(m_accListZ);

    if (accSeriesIndex >= maxAccReadings) {
        QAbstractAxis *axis = m_accX->attachedAxes().at(0);
        axisMin++;
        axisMax++;
        axis->setRange(axisMin, axisMax);
    }
    accSeriesIndex++;
}

void SeriesStorage::changeAccelerometerAreaSeries()
{
    if (!m_accXX || !m_accYY || !m_accZZ)
        return;

    constexpr static const int maxTemperatureReadings = 30;
    static int temperatureSeriesIndex = maxTemperatureReadings;
    static int axisMin = 0;
    static int axisMax = maxTemperatureReadings - 1;

    m_accListX.removeLast();
    m_accListX.append(QPointF(temperatureSeriesIndex-1,(float)m_dataProviderSensor->getAccelometer_xAxis()));
    m_accListX.append(QPointF(temperatureSeriesIndex-1,(float)m_dataProviderSensor->getAccelometer_xAxis()));
    if(m_accListX.size() >= maxTemperatureReadings)
        m_accListX.removeFirst();
    if(temperatureSeriesIndex >= maxTemperatureReadings) {
        QAbstractAxis* axis = m_accXX->attachedAxes().at(0);
        axisMin++;
        axisMax++;
        axis->setRange(axisMin,axisMax);
    }
    m_accXX->replace(m_accListX);
    temperatureSeriesIndex++;
}

void SeriesStorage::changeRadarScaterSeries()
{
    if(!m_radar)
        return;

    float distance = m_dataProviderSensor->getDistance();
    int pos = m_dataProviderSensor->getPosition();

    if(m_radar->at(pos) != QPointF(0,0)) {
         if(distance>0 && distance<95) {
//             m_radar->replace(m_radar->at(pos),QPointF(pos,distance));
             m_radar->remove(m_radar->at(pos));
             m_radar->append(QPointF(pos,distance));
         }
         else {
             m_radar->remove(m_radar->at(pos));
         }
    }
    else {
        if(distance>0 && distance<95) {
            m_radar->append(QPointF(pos,distance));
        }
    }
}
