import 'package:get_storage/get_storage.dart';

class LocalStorageRepository {
  final _storage = GetStorage();

  static const _departureKey = 'departure';

  Future<void> init() => _storage.initStorage;

  String getDeparture() => _storage.read(_departureKey) as String? ?? '';

  Future<void> setDeparture(String departure) =>
      _storage.write(_departureKey, departure);

  void Function() listenToDepartureChanges(void Function(dynamic) listener) =>
      _storage.listenKey(_departureKey, listener);
}
