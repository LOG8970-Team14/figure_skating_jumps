import '../models/bluetooth_device.dart';

abstract class IBluetoothDiscoverySubscriber {
  void onBluetoothDeviceListChange(List<BluetoothDevice> devices);
}
