// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import 'package:twitter_cosmos_db/domain/inputs_validations/inputs.dart';
import 'package:twitter_cosmos_db/presentation/providers/forms/states/form_status.dart';

class AddPostState {
  final FormStatus status;
  final GenericText tweet;
  final Uint8List? imageBytes;
  final String? imageUrl;
  final XFile? imageFile;
  final bool isValid;

  AddPostState({
    this.status = FormStatus.invalid,
    this.tweet = const GenericText.pure(),
    this.imageBytes,
    this.imageUrl,
    this.imageFile,
    this.isValid = false,
  });

  bool get isPosting => status == FormStatus.posting;

  


  @override
  bool operator ==(covariant AddPostState other) {
    if (identical(this, other)) return true;
  
    return 
      other.status == status &&
      other.tweet == tweet &&
      other.imageBytes == imageBytes &&
      other.imageUrl == imageUrl &&
      other.imageFile == imageFile &&
      other.isValid == isValid;
  }

  @override
  int get hashCode {
    return status.hashCode ^
      tweet.hashCode ^
      imageBytes.hashCode ^
      imageUrl.hashCode ^
      imageFile.hashCode ^
      isValid.hashCode;
  }

  AddPostState copyWith({
    FormStatus? status,
    GenericText? tweet,
    Uint8List? imageBytes,
    String? imageUrl,
    XFile? imageFile,
    bool? isValid,
  }) {
    return AddPostState(
      status: status ?? this.status,
      tweet: tweet ?? this.tweet,
      imageBytes: imageBytes ?? this.imageBytes,
      imageUrl: imageUrl ?? this.imageUrl,
      imageFile: imageFile ?? this.imageFile,
      isValid: isValid ?? this.isValid,
    );
  }
}
