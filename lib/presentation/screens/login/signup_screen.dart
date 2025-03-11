// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_cosmos_db/config/constants/app_constants.dart';
import 'package:twitter_cosmos_db/config/helpers/haptic_feedback.dart';
import 'package:twitter_cosmos_db/domain/models/models.dart';
import 'package:twitter_cosmos_db/presentation/navigation/navigation_functions.dart';
import 'package:twitter_cosmos_db/presentation/providers/providers.dart';
import 'package:twitter_cosmos_db/presentation/widgets/widgets.dart';

class SignupScreen extends ConsumerWidget {
  static String name = 'SignupScreen';

  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showPassword = ref.watch(showPasswordProvider);
    final showRepeatPassword = ref.watch(showRepeatPasswordProvider);
    final authStatusNotifier = ref.watch(authStatusProvider);
    final signupFormState = ref.watch(signupFormProvider);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("login_screen_signup_title").tr(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton.filledTonal(
                tooltip: ("login_screen_signup_title").tr(),
                onPressed: () => _submitFormAction(authStatusNotifier, ref),
                icon: const Icon(Icons.check_circle_outline_outlined),
              ),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  StackedIconsOnWidgets(
                    onFirstIconTap:
                        () => _displayPickImageDialog(ref, _imageChosenAction),
                    firstIcon: Icons.edit,
                    child: RoundedBordersPicture(
                      height: 200,
                      borderRadius: 10,
                      urlPicture: '',
                      imageBytes: null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    initialValue: "",
                    autoFillHints: const [AutofillHints.name],
                    label: "login_screen_name_text".tr(),
                    formatter: FormInputFormatters.text,
                    errorMessage:
                        signupFormState.isPosting
                            ? signupFormState.name.errorMessage
                            : null,
                    icon: Icons.person,
                    onChanged: (newValue) {
                      final signupFormState = ref.read(
                        signupFormProvider.notifier,
                      );
                      signupFormState.nameChanged(newValue);
                    },
                    onSubmitForm:
                        () => _submitFormAction(authStatusNotifier, ref),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    initialValue: "",
                    autoFillHints: const [AutofillHints.familyName],
                    label: "login_screen_surname_text".tr(),
                    formatter: FormInputFormatters.text,
                    errorMessage:
                        signupFormState.isPosting
                            ? signupFormState.surname.errorMessage
                            : null,
                    icon: Icons.person,
                    onChanged: (newValue) {
                      final signupFormState = ref.read(
                        signupFormProvider.notifier,
                      );
                      signupFormState.surnameChanged(newValue);
                    },
                    onSubmitForm:
                        () => _submitFormAction(authStatusNotifier, ref),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    initialValue: "",
                    autoFillHints: const [AutofillHints.username],
                    label: "login_screen_username_text".tr(),
                    formatter: FormInputFormatters.text,
                    errorMessage:
                        signupFormState.isPosting
                            ? signupFormState.username.errorMessage
                            : null,
                    icon: Icons.person,
                    onChanged: (newValue) {
                      final signupFormState = ref.read(
                        signupFormProvider.notifier,
                      );
                      signupFormState.usernameChanged(newValue);
                    },
                    onSubmitForm:
                        () => _submitFormAction(authStatusNotifier, ref),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    initialValue: "",
                    autoFillHints: const [AutofillHints.email],
                    label: "login_screen_email_text".tr(),
                    formatter: FormInputFormatters.email,
                    errorMessage:
                        signupFormState.isPosting
                            ? signupFormState.email.errorMessage
                            : null,
                    icon: Icons.email_outlined,
                    onChanged: (newValue) {
                      final signupFormState = ref.read(
                        signupFormProvider.notifier,
                      );
                      signupFormState.emailChanged(newValue);
                    },
                    onSubmitForm:
                        () => _submitFormAction(authStatusNotifier, ref),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    initialValue: "",
                    autoFillHints: const [AutofillHints.newPassword],
                    label: "login_screen_password_text".tr(),
                    trailingIcon: IconButton(
                      onPressed: () {
                        ref.read(showPasswordProvider.notifier).state =
                            !showPassword;
                      },
                      icon: showHidePasswordIcon(showPassword),
                    ),
                    errorMessage:
                        signupFormState.isPosting
                            ? signupFormState.password.errorMessage
                            : null,
                    icon: Icons.lock,
                    obscureText: !showPassword,
                    onChanged: (newValue) {
                      final signupFormState = ref.read(
                        signupFormProvider.notifier,
                      );
                      signupFormState.passwordChanged(newValue);
                    },
                    onSubmitForm:
                        () => _submitFormAction(authStatusNotifier, ref),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    initialValue: "",
                    label: "login_screen_repeat_password_text".tr(),
                    trailingIcon: IconButton(
                      onPressed: () {
                        ref.read(showRepeatPasswordProvider.notifier).state =
                            !showRepeatPassword;
                      },
                      icon: showHidePasswordIcon(showRepeatPassword),
                    ),
                    errorMessage:
                        signupFormState.isPosting
                            ? signupFormState.repeatPassword.errorMessage
                            : null,
                    icon: Icons.lock,
                    obscureText: !showRepeatPassword,
                    onChanged: (newValue) {
                      final signupFormState = ref.read(
                        signupFormProvider.notifier,
                      );
                      signupFormState.repeatPasswordChanged(newValue);
                    },
                    onSubmitForm:
                        () => _submitFormAction(authStatusNotifier, ref),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("login_screen_have_account_text").tr(),
                      const SizedBox(width: 2),
                      TextButton(
                        onPressed: () {
                          ref
                              .read(showLoginSignupProvider.notifier)
                              .update((state) => !state);
                        },
                        child: const Text(
                          "login_screen_login_title_with_args",
                        ).tr(args: ["!"]),
                      ),
                    ],
                  ),
                  //_authMethodsRow(ref),
                  const SizedBox(height: 20),
                  FilledButton.tonal(
                    onPressed: () => _submitFormAction(authStatusNotifier, ref),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("login_screen_signup_title").tr(),
                        const SizedBox(width: 6),
                        ZoomIn(
                          child: const Icon(
                            Icons.check_circle_outline_outlined,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void>? _submitFormAction(AuthState authStatusNotifier, WidgetRef ref) {
    return authStatusNotifier.authStatus == AuthStatus.checking
        ? null
        : _signupUsingPassword(ref);
  }

  Future<void> _signupUsingPassword(WidgetRef ref) async {
    final signupFormState = ref.read(signupFormProvider);
    final signupFormNotifier = ref.read(signupFormProvider.notifier);

    signupFormNotifier.onSubmit(
      onSubmit: () async {
        final userRepo = ref.read(usersRepositoryProvider);
        final newUser = User(
          nome: signupFormState.name.value,
          cognome: signupFormState.surname.value,
          username: signupFormState.username.value,
          email: signupFormState.email.value,
          dateCreated: DateTime.now(),
          phoneNumber: '',
          profileImageUrl: '',
        );

        final userCreated = await userRepo.createNewUser(newUser);

        if (userCreated != null) {
          _updateSignedInUserProvider(ref, userCreated);
          showCustomSnackbar(
            ref.context,
            'login_screen_user_creation_success_snackbar_text'.tr(),
            backgroundColor: colorSuccess,
          );
        } else {
          hardVibration();
          showCustomSnackbar(
            ref.context,
            'login_screen_email_unexpected_error_snackbar'.tr(),
            backgroundColor: colorNotOkButton,
          );
        }
        popScreen(ref.context);
      },
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
    final addPostNotifier = ref.read(signupFormProvider.notifier);
    final imageBytes = await file.readAsBytes();

    addPostNotifier.imageBytesChanged(imageBytes);
    addPostNotifier.imageFileChanged(file);
  }

  void _updateSignedInUserProvider(WidgetRef ref, User user) {
    ref.read(signedInUserProvider.notifier).update((state) => user);
  }
}
