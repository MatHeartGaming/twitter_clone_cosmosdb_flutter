import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_cosmos_db/config/plugins/camera_gallery_service_impl.dart';
import 'package:twitter_cosmos_db/config/plugins/interfaces/camera_gallery_service.dart';

final imagePickerProvider = Provider<CameraGalleryService>(
  (ref) {
    return CameraGalleryServiceImplementation();
  },
);
