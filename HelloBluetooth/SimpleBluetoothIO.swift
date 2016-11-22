import CoreBluetooth

protocol SimpleBluetoothIODelegate: class {
    func simpleBluetoothIO(simpleBluetoothIO: SimpleBluetoothIO, didReceiveValue value: Int8)
}

class SimpleBluetoothIO: NSObject {
    let serviceUUID: String
    weak var delegate: SimpleBluetoothIODelegate?

    var centralManager: CBCentralManager!
    var connectedPeripheral: CBPeripheral?
    var targetService: CBService?
    var writableCharacteristic: CBCharacteristic?

    init(serviceUUID: String, delegate: SimpleBluetoothIODelegate?) {
        self.serviceUUID = serviceUUID
        self.delegate = delegate

        super.init()

        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func writeValue(value: Int8) {
        guard let peripheral = connectedPeripheral, characteristic = writableCharacteristic else {
            return
        }

        let data = NSData.dataWithValue(value)
        peripheral.writeValue(data, forCharacteristic: characteristic, type: .WithResponse)
    }

}

extension SimpleBluetoothIO: CBCentralManagerDelegate {
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        peripheral.discoverServices(nil)
    }

    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        connectedPeripheral = peripheral

        if let connectedPeripheral = connectedPeripheral {
            connectedPeripheral.delegate = self
            centralManager.connectPeripheral(connectedPeripheral, options: nil)
        }
        centralManager.stopScan()
    }

    func centralManagerDidUpdateState(central: CBCentralManager) {
        if central.state == .PoweredOn {
            centralManager.scanForPeripheralsWithServices([CBUUID(string: serviceUUID)], options: nil)
        }
    }
}

extension SimpleBluetoothIO: CBPeripheralDelegate {
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        guard let services = peripheral.services else {
            return
        }

        targetService = services.first
        if let service = services.first {
            targetService = service
            peripheral.discoverCharacteristics(nil, forService: service)
        }
    }

    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        guard let characteristics = service.characteristics else {
            return
        }

        for characteristic in characteristics {
            if characteristic.properties.contains(.Write) || characteristic.properties.contains(.WriteWithoutResponse) {
                writableCharacteristic = characteristic
            }
            peripheral.setNotifyValue(true, forCharacteristic: characteristic)
        }
    }

    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        guard let data = characteristic.value, let delegate = delegate else {
            return
        }

        delegate.simpleBluetoothIO(self, didReceiveValue: data.int8Value())
    }
}