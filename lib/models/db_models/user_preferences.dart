import 'abstract_local_db_object.dart';

class UserPreferences extends AbstractLocalDbObject {
  final String _uID;
  String _deviceMacAddresses;

  UserPreferences(
      {required int id,
      required String uID,
      required String deviceMacAddresses})
      : _deviceMacAddresses = deviceMacAddresses,
        _uID = uID {
    this.id = id;
  }

  get deviceMacAddresses {
    return _deviceMacAddresses;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uID': _uID,
      'deviceMacAddresses': _deviceMacAddresses,
    };
  }

  List<String> getAddresses() {
    return _deviceMacAddresses.split('|');
  }

  void addAddress(String macAddress) {
    _deviceMacAddresses +=
        _deviceMacAddresses.trim().isEmpty ? macAddress : '|$macAddress';
  }

  @override
  String toString() {
    return 'UserPreferences{id: $id, uID: $_uID, deviceMacAddresses: $_deviceMacAddresses}';
  }
}
