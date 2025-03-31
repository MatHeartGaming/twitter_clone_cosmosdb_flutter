import 'package:flutter_riverpod/flutter_riverpod.dart';

final commentsProvider = StateProvider.autoDispose
    .family<List<String>, List<String>>((ref, comments) {
  return comments;
});
