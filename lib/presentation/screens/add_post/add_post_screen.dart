// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_cosmos_db/config/constants/app_constants.dart';
import 'package:twitter_cosmos_db/config/helpers/haptic_feedback.dart';
import 'package:twitter_cosmos_db/domain/models/models.dart';
import 'package:twitter_cosmos_db/presentation/navigation/navigation_functions.dart';
import 'package:twitter_cosmos_db/presentation/providers/forms/add_post_form_provider.dart';
import 'package:twitter_cosmos_db/presentation/providers/providers.dart';
import 'package:twitter_cosmos_db/presentation/widgets/widgets.dart';

class AddPostScreen extends ConsumerWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addPostState = ref.watch(addPostProvider);
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Center(
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              StackedIconsOnWidgets(
                onFirstIconTap:
                    () => _displayPickImageDialog(ref, _imageChosenAction),
                firstIcon: Icons.edit,
                child: RoundedBordersPicture(
                  width: size.width * 0.8,
                  height: 200,
                  borderRadius: 10,
                  urlPicture: addPostState.imageUrl ?? '',
                  imageBytes: addPostState.imageBytes,
                ),
              ),
              CustomTextFormField(
                //controller: addProductState.productNameController,
                label: 'post_tweet_screen_field_placeholder'.tr(),
                formatter: FormInputFormatters.text,
                errorMessage: addPostState.tweet.errorMessage,
                icon: Icons.title_outlined,
                onChanged: (newValue) {
                  final appPostNotifier = ref.read(addPostProvider.notifier);
                  appPostNotifier.tweetChanged(newValue);
                },
              ),

              FilledButton.tonal(
                onPressed: () => addPostState.isPosting ? null : onSubmit(ref),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.upload_outlined, size: 18),
                    const Text(
                      'post_tweet_screen_upload_btn_txt',
                      style: TextStyle(fontSize: 12),
                    ).tr(args: ['🐥']),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _displayPickImageDialog(
    WidgetRef ref,
    Function(XFile?, WidgetRef) onImageChosen,
  ) {
    final context = ref.context;
    final picker = ref.read(imagePickerProvider);
    if (!context.mounted) return;
    displayPickImageDialog(
      context,
      onGalleryChosen: () async {
        await picker.selectPhoto().then((file) {
          onImageChosen(file, ref);
          popScreen(context);
        });
      },
      onTakePicChosen: () async {
        await picker.takePhoto().then((file) {
          onImageChosen(file, ref);
          popScreen(context);
        });
      },
    );
  }

  Future<void> _imageChosenAction(XFile? file, WidgetRef ref) async {
    if (file == null) return;
    final addPostNotifier = ref.read(addPostProvider.notifier);
    final imageBytes = await file.readAsBytes();

    addPostNotifier.imageBytesChanged(imageBytes);
    addPostNotifier.imageFileChanged(file);
  }

  void onSubmit(WidgetRef ref) {
    final postState = ref.read(addPostProvider);
    final postStateNotifier = ref.read(addPostProvider.notifier);
    final signedInUser = ref.read(signedInUserProvider);
    if (signedInUser == null) return;

    if (!postState.isValid) {
      hardVibration();
      return;
    }

    postStateNotifier.onSubmit(
      onSubmit: () async {
        final loadPost = ref.read(loadPostsProvider.notifier);
        final post = Post(
          body: postState.tweet.value,
          userId: signedInUser.username,
          urlImage: '',
        );
        final newPost = await loadPost.addPost(post);

        if (newPost != null) {
          smallVibration();
          showCustomSnackbar(
            ref.context,
            'post_tweet_screen_upload_success_snackbar_txt'.tr(),
            backgroundColor: colorSuccess,
          );
        } else {
          hardVibration();
          showCustomSnackbar(
            ref.context,
            'post_tweet_screen_upload_error_snackbar_txt'.tr(),
            backgroundColor: colorNotOkButton,
          );
        }

        popScreen(ref.context);
      },
    );
  }
}
