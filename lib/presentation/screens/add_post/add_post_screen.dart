// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_cosmos_db/presentation/navigation/navigation_functions.dart';
import 'package:twitter_cosmos_db/presentation/providers/providers.dart';
import 'package:twitter_cosmos_db/presentation/widgets/widgets.dart';

class AddPostScreen extends ConsumerWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  borderRadius: 10,
                  urlPicture: '',
                  imageBytes: null,
                ),
              ),
              CustomTextFormField(
                //controller: addProductState.productNameController,
                label: 'post_tweet_screen_field_placeholder'.tr(),
                formatter: FormInputFormatters.text,
                errorMessage: null,
                icon: Icons.title_outlined,
                onChanged: (newValue) {},
              ),
          
              FilledButton.tonal(
                onPressed: onSubmit,
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

  void _displayPickImageDialog(WidgetRef ref, Function(XFile?) onImageChosen) {
    final context = ref.context;
    final picker = ref.read(imagePickerProvider);
    if (!context.mounted) return;
    displayPickImageDialog(
      context,
      onGalleryChosen: () async {
        await picker.selectPhoto().then((file) {
          onImageChosen(file);
          popScreen(context);
        });
      },
      onTakePicChosen: () async {
        await picker.takePhoto().then((file) {
          onImageChosen(file);
          popScreen(context);
        });
      },
    );
  }

  Future<void> _imageChosenAction(XFile? file) async {
    if (file == null) return;
    //final addProductNotifier = ref.read(addProductFormProvider.notifier);
    //final imageBytes = await file.readAsBytes();

    //addProductNotifier.imageBytesChanged(imageBytes);
    //addProductNotifier.imageFileChanged(file);
  }

  void onSubmit() {}
}
