import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_cosmos_db/config/plugins/plugins.dart';

final connectivityStreamProvider = StreamProvider<bool>((ref) async* {
  try {
    final stream = ConnectionStatusSingleton.getInstance().connectionChange;
    await for (final event in stream) {
      yield event;
    }
  } catch (e) {
    throw Exception('Error getting last connection result: $e');
  }
  return;
});

final connectivityProvider = StateProvider<bool>((ref) {
  return true;
});
