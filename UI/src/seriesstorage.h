#ifndef SERIESSTORGE_H
#define SERIESSTORGE_H

#include <QObject>
#include <QtCharts/QtCharts>
#include <QList>
#include "sensortagdataprovider.h"
#include "dataproviderpool.h"
#include <QHash>
#include <QVector>

QT_CHARTS_USE_NAMESPACE

class SeriesStorage : public QObject
{
    Q_OBJECT
public:
    explicit SeriesStorage(QObject *parent = nullptr);

    Q_INVOKABLE void setDataProviderPool(DataProviderPool *pool);
    //Q_INVOKABLE void setTemperatureSeries(QAbstractSeries* series);
    Q_INVOKABLE void setGyroSeries(QAbstractSeries* xSeries, QAbstractSeries* ySeries,
                                          QAbstractSeries* zSeries);
    Q_INVOKABLE void setMagnetoMeterSeries(QAbstractSeries* xSeries, QAbstractSeries* ySeries,
                                           QAbstractSeries* zSeries);
    Q_INVOKABLE void setAcceleroMeterSeries(QAbstractSeries* xSeries, QAbstractSeries* ySeries,
                                           QAbstractSeries* zSeries);
    Q_INVOKABLE void setAcceleroMeterAreaSeries(QAbstractSeries* xSeries, QAbstractSeries* ySeries,
                                           QAbstractSeries* zSeries);

    Q_INVOKABLE void setTemperatureAreaSeries(QAbstractSeries* areaSeries,QLineSeries* xSeries);
    Q_INVOKABLE void setHumidityAreaSeries(QAbstractSeries* areaSeries,QLineSeries* xSeries);
    Q_INVOKABLE void setHumiditySeries(QAbstractSeries* xSeries);
    Q_INVOKABLE void setRadarScatterSeries(QAbstractSeries* series);

    void connectSensorData(SensorTagDataProvider* sensor) {
        m_dataProviderSensor = sensor;
        connect(sensor,&SensorTagDataProvider::temperatureChanged,this,&SeriesStorage::changeTemperatureSeries);
        connect(sensor,&SensorTagDataProvider::gyroscopeDegPerSecChanged,this,&SeriesStorage::changeRotationSeries);
        //connect(sensor,&SensorTagDataProvider::humidityChanged,this,&SeriesStorage::changeTemperatureSeries);
        //connect(sensor,&SensorTagDataProvider::accelometerChanged,this,&SeriesStorage::changeAccelerometerAreaSeries);
        connect(sensor,&SensorTagDataProvider::positionChanged,this,&SeriesStorage::changeRadarScaterSeries);
    }
signals:

public slots:
    void dataProviderPoolChanged();

    void changeTemperatureSeries();
    void changeMagnetoSeries();
    void changeRotationSeries();
    void changeAccelerometerSeries();
    void changeAccelerometerAreaSeries();
    void changeRadarScaterSeries();

private:
    SensorTagDataProvider* m_dataProviderSensor;
    DataProviderPool* m_providerPool;
    SensorTagDataProvider* m_temperatureProvider{0};
    SensorTagDataProvider* m_gyroProvider{0};
    SensorTagDataProvider* m_magnetoProvider{0};

    QAreaSeries* m_temperatureArea{nullptr};
    QAreaSeries* m_humidityArea{nullptr};
    QLineSeries* m_temperature{nullptr};
    QLineSeries* m_humidity{nullptr}; //
    QSplineSeries* m_gyroX{nullptr};
    QSplineSeries* m_gyroY{nullptr};
    QSplineSeries* m_gyroZ{nullptr};
    QSplineSeries* m_accX{nullptr};
    QSplineSeries* m_accY{nullptr};
    QSplineSeries* m_accZ{nullptr};
    QSplineSeries* m_magX{nullptr};
    QSplineSeries* m_magY{nullptr};
    QSplineSeries* m_magZ{nullptr};
    QLineSeries* m_accXX{nullptr};
    QLineSeries* m_accYY{nullptr};
    QLineSeries* m_accZZ{nullptr};
    QScatterSeries* m_radar{nullptr};

    QList<QPointF> m_temperatureList;
    QList<QPointF> m_humidityList; //
    QList<QPointF> m_gyroListX;
    QList<QPointF> m_gyroListY;
    QList<QPointF> m_gyroListZ;
    QList<QPointF> m_accListX;
    QList<QPointF> m_accListY;
    QList<QPointF> m_accListZ;
    QList<QPointF> m_magListX;
    QList<QPointF> m_magListY;
    QList<QPointF> m_magListZ;
    QHash<int,QPoint> m_radarList;
    QVector<QPoint> m_radarVect = QVector<QPoint>(180,QPoint(-1,0));
};

#endif // SERIESSTORGE_H
