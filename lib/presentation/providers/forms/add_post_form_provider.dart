import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_cosmos_db/domain/inputs_validations/inputs.dart';
import 'package:twitter_cosmos_db/presentation/providers/forms/states/add_post_state.dart';
import 'package:twitter_cosmos_db/presentation/providers/forms/states/form_status.dart';

final addPostProvider =
    StateNotifierProvider.autoDispose<AddPostFormNotifier, AddPostState>((ref) {
      final notifier = AddPostFormNotifier();
      return notifier;
    });

class AddPostFormNotifier extends StateNotifier<AddPostState> {
  AddPostFormNotifier() : super(AddPostState());

  void onSubmit({required VoidCallback onSubmit}) {
    state = state.copyWith(
      tweet: state.tweet,
      status: FormStatus.posting,
      imageBytes: state.imageBytes,
      isValid: Formz.validate([state.tweet]),
    );

    if (!state.isValid) return;

    onSubmit();
  }

  void imageBytesChanged(Uint8List value) {
    state = state.copyWith(imageBytes: value);
  }

  void tweetChanged(String value) {
    final text = GenericText.dirty(value);
    state = state.copyWith(tweet: text, isValid: Formz.validate([text]));
  }

  void imageFileChanged(XFile value) {
    state = state.copyWith(imageFile: value);
  }
}
