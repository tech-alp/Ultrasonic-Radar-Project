#include "serialport.h"
#include <QVariant>
#include <QMap>

static QString blankString = QStringLiteral("N/A");

inline float make32b(QVector<unsigned char>* _buffer, int offset)
{
    float* f;
    unsigned char buffer[4] = "";
    for(int i = offset, j = 0; i < offset+4; i++, j++) {
        buffer[j] += _buffer->at(i);
    }
    f = reinterpret_cast<float*>(buffer);
    //qDebug() << *f;
    return *f;
}

class Serialport::Implementation {
public:
    Implementation(QSerialPort* _serial) : m_serial{_serial} {
        fillPortsInfo();
    }

    void fillPortsInfo() {
        const auto infos = QSerialPortInfo::availablePorts();
        for(const QSerialPortInfo& info : infos) {
            QStringList list;
            portName = info.portName();
            description = info.description();
            manufacturer = info.manufacturer();
            serialNumber = info.serialNumber();
            list << (!description.isEmpty() ? description : blankString)
                 << (!manufacturer.isEmpty() ? manufacturer : blankString)
                 << (!serialNumber.isEmpty() ? serialNumber : blankString)
                 << info.systemLocation()
                 << (info.vendorIdentifier() ? QString::number(info.vendorIdentifier(), 16) : blankString)
                 << (info.productIdentifier() ? QString::number(info.productIdentifier(), 16) : blankString);
            comboPortList.append(portName);
            portInfoMap.insert(portName,list);
        }
        comboPortList.append("Custom");
    }

    void fillPortsParameters(QString& _portName,QString& _baudRate,int _dataBits,
                             int _parity, int _flowControl)
    {
        portName = _portName;
        baudRate = static_cast<QSerialPort::BaudRate>(_baudRate.toULong());
        dataBits = static_cast<QSerialPort::DataBits>(_dataBits);
        parity = static_cast<QSerialPort::Parity>(_parity);
        flowControl = static_cast<QSerialPort::FlowControl>(_flowControl);
        if(params.size() != 0)
            params.clear();
        params += "Connecting to " + portName;
    }

    QSerialPort* m_serial = nullptr;
    qint32 baudRate;
    QSerialPort::DataBits dataBits;
    QSerialPort::Parity parity;
    QSerialPort::StopBits stopBits;
    QSerialPort::FlowControl flowControl;

    QString description;
    QString manufacturer;
    QString serialNumber;
    QString location;
    QString vendorIdentifier;
    QString productIdentifier;
    QString params;

    QStringList comboPortList;
    QString portName;
    QMap<QString,QStringList> portInfoMap;
};


Serialport::Serialport(QObject *parent) : SensorTagDataProvider(parent)
{
    implementation.reset(new Implementation(new QSerialPort));
    connect(implementation->m_serial,&QSerialPort::readyRead,this,&Serialport::ReadData);
    setState(ProviderState::Disconnected);
}

Serialport::Serialport(const QSerialPortInfo& id, QObject* parent)
    : SensorTagDataProvider(id.portName(),parent)
{
    implementation.reset(new Implementation(new QSerialPort));
    connect(implementation->m_serial,&QSerialPort::readyRead,this,&Serialport::ReadData);
}

Serialport::~Serialport() {

}

void Serialport::ReadData()
{
    qint64 byte = implementation->m_serial->bytesAvailable();
    if(byte>0)
        implementation->m_serial->flush();
    implementation->m_serial->waitForBytesWritten(1000);
    WriteData("a");
    byte = implementation->m_serial->bytesAvailable();
    QVector<unsigned char> vectorData;
    vectorData.resize(byte);
    implementation->m_serial->read((char*)vectorData.constData(),vectorData.size());
    if(vectorData.size() == 34) {
        temperature = vectorData[0];
        humidity = make32b(&vectorData,1);
        accelometerX = make32b(&vectorData,5);
        accelometerY = make32b(&vectorData,9);
        accelometerZ = make32b(&vectorData,13);
        gyroscopeX_degPerSec = make32b(&vectorData,17);
        gyroscopeY_degPerSec = make32b(&vectorData,21);
        gyroscopeZ_degPerSec = make32b(&vectorData,25);
        position = vectorData[29];
        distance = make32b(&vectorData,30);

        emit temperatureChanged();
        emit humidityChanged();
        emit gyroscopeDegPerSecChanged();
        emit accelometerChanged();
//        if(position%5==0)
            emit distanceChanged();
        emit positionChanged();
    }
}

void Serialport::showPortInfo(QString key)
{
    auto list = implementation->portInfoMap[key];

    qDebug() << key << list.size();
    implementation->description =  list.size() > 0 ?  list.at(0) : blankString;
    implementation->manufacturer = list.size() > 1 ?  list.at(1) : blankString;
    implementation->serialNumber = list.size() > 2 ?  list.at(2) : blankString;
    implementation->location = list.size() > 3 ?  list.at(3) : blankString;
    implementation->vendorIdentifier = list.size() > 4 ?  list.at(4) : blankString;
    implementation->productIdentifier = list.size() > 5 ?  list.at(5) : blankString;

    emit descriptionChanged();
    emit manufacturerChanged();
    emit locationChanged();
    emit serialNumberChanged();
    emit productIdentifierChanged();
    emit vendorIdentifierChanged();
}

void Serialport::WriteData(const char* data)
{
    implementation->m_serial->write(data);
    implementation->m_serial->waitForBytesWritten(10);
}

QString Serialport::Description() const
{
    return implementation->description;
}

QString Serialport::Manufacturer() const
{
    return implementation->manufacturer;
}

QString Serialport::Location() const
{
    return implementation->location;
}

QString Serialport::SerialNumber() const
{
    return implementation->serialNumber;
}

QString Serialport::VendorIdentifier() const
{
    return implementation->vendorIdentifier;
}

QString Serialport::ProductIdentifier() const
{
    QVariant var = implementation->productIdentifier;
    return var.toString();
}

const QStringList& Serialport::comboPortList() const
{
    return implementation->comboPortList;
}

void Serialport::fillSerialPortsParameters(QString portName,QString baudRate,int stopBits, int parity, int flowControl)
{
    if(portName != "Custom") {
        setState(ProviderState::Connected);
        qDebug() << "State:" << m_state;
        implementation->fillPortsParameters(portName,baudRate,stopBits,parity,flowControl);
    }
    else {
        qWarning() << "Please select existing port then apply!";
        setState(ProviderState::Error);
        implementation->params.clear();
        implementation->params = "Port did not sellected!";
    }
}

const QString& Serialport::connectionParameters() const {
    return implementation->params;
}

void Serialport::openSerialPort()
{
    if(m_state == Connected) {
        if(implementation->m_serial->isOpen())
            return;
        implementation->m_serial->setPortName(implementation->portName);
        implementation->m_serial->setBaudRate(QSerialPort::Baud115200);
        implementation->m_serial->setDataBits(QSerialPort::Data8);
        implementation->m_serial->setParity(QSerialPort::NoParity);
        implementation->m_serial->setStopBits(QSerialPort::OneStop);
        implementation->m_serial->setFlowControl(QSerialPort::NoFlowControl);
        if(implementation->m_serial->open(QIODevice::ReadWrite)) {
            qDebug() << "Serial port is opened!";
        }
        setState(ProviderState::Disconnactable);
    }
    else {
        qDebug() << "Fisrtly you should aplly configuration";
    }
}

void Serialport::closeSerialPort()
{
    if(implementation->m_serial->isOpen())
        implementation->m_serial->close();
    setState(ProviderState::Connectable); //Change
}





