#ifndef SERIALPORT_H
#define SERIALPORT_H

#include <QObject>
#include <QScopedPointer>
#include <QString>
#include <QDebug>
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include <QStringList>
#include <QVector>
#include "sensortagdataprovider.h"

class Serialport : public SensorTagDataProvider
{
    Q_OBJECT
    Q_PROPERTY(QStringList comboPortList READ comboPortList NOTIFY comboPortListChanged)
    Q_PROPERTY(QString Description READ Description NOTIFY descriptionChanged)
    Q_PROPERTY(QString Manufacturer READ Manufacturer NOTIFY manufacturerChanged)
    Q_PROPERTY(QString Location READ Location NOTIFY locationChanged)
    Q_PROPERTY(QString SerialNumber READ SerialNumber NOTIFY serialNumberChanged)
    Q_PROPERTY(QString VendorIdentifier READ VendorIdentifier NOTIFY vendorIdentifierChanged)
    Q_PROPERTY(QString ProductIdentifier READ ProductIdentifier NOTIFY productIdentifierChanged)
    Q_PROPERTY(QString ConnectionParameters READ connectionParameters NOTIFY changedConnectionParameters)

public:
    explicit Serialport(QObject *parent = nullptr);
    Serialport(const QSerialPortInfo& id, QObject* parent = nullptr);
    ~Serialport();

    void WriteData(const char* data);
    QString Description() const;
    QString Manufacturer() const;
    QString Location() const;
    QString SerialNumber() const;
    QString VendorIdentifier() const;
    QString ProductIdentifier() const;
    const QStringList& comboPortList() const;
    const QString& connectionParameters() const;

    Q_INVOKABLE void fillSerialPortsParameters(QString portName,QString baudRate,int stopBits, int parity, int flowControl);

    void openSerialPort();
    void closeSerialPort();

public slots:
    void ReadData();
    void showPortInfo(QString key);

signals:
    void descriptionChanged();
    void manufacturerChanged();
    void locationChanged();
    void serialNumberChanged();
    void productIdentifierChanged();
    void vendorIdentifierChanged();
    void comboPortListChanged();
    void changedConnectionParameters();
private:
    class Implementation;
    QScopedPointer<Implementation> implementation;
    QVector<unsigned char> receivingData;
};

#endif // SERIALPORT_H
